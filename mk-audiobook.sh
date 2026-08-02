#!/bin/bash
# mk-audiobook.sh - Build the single-file "In Search of Dharma" audiobook MP3.
#
#   ./mk-audiobook.sh [-g SECONDS] [-G FILE]
#
# Concatenates the spoken cover plus chapters 0..9 (one TTS-narrated MP3 each,
# read straight from the garydean.id web-root) into one audiobook MP3, embeds
# the lettered cover art as ID3v2 front-cover picture, and tags it with the
# book's bibliographic metadata.
#
# A spacer is inserted between sections: --gap seconds of silence (default 4,
# 0 disables). With --gong FILE the gap's silence is followed by the chime,
# which strikes at the end of the pause and rings into the next section's
# opening — so each break runs gap + chime length. --gong also bookends the
# whole audiobook: the chime opens the file (chime, then gap, then the spoken
# cover) and closes it (gap, then chime, ringing out).
# The bundled audio-assets/gong-bowl.mp3 is a singing-bowl strike synthesized
# from inharmonic bell partials (fundamental 196 Hz; ratios 1/2.77/5.18/8.16):
#   ffmpeg -f lavfi -i "aevalsrc=0.45*(1-exp(-t*180))*(0.5*exp(-t*0.9)\
#     *(0.92+0.08*sin(2*PI*2.6*t))*sin(2*PI*196*t)\
#     +0.28*exp(-t*1.3)*sin(2*PI*543*t)+0.14*exp(-t*2.0)*sin(2*PI*1015*t)\
#     +0.07*exp(-t*2.8)*sin(2*PI*1600*t)):s=24000:d=4" \
#     -af afade=t=out:st=3.4:d=0.6 -c:a libmp3lame -b:a 32k gong-bowl.mp3
#
# All source MP3s come from the same TTS pipeline (MP3, 24 kHz mono, ~32 kbps),
# so the audio is stream-copied (-c:a copy) — a bit-perfect join with no
# re-encode. The ffmpeg mp3 muxer rewrites the Xing header on close, so the
# joined file reports the correct total duration. The build is atomic: output
# is assembled in a temp file and moved into place only on success.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (ffmpeg, ffprobe) must resolve from system
# locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION=1.3.0
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='In Search of Dharma'
declare -r AUTHOR='Biksu Okusi'
declare -r PUB_YEAR=2026

declare -r AUDIO_SRC_DIR=/var/www/vhosts/garydean.id/html/audio
declare -r AUDIO_STEM=in-search-of-dharma
declare -r COVER_IMAGE=$SCRIPT_DIR/images/defining-dharma-cover-title.png
declare -r OUTPUT=$AUDIO_SRC_DIR/In-Search-of-Dharma_Biksu-Okusi_${PUB_YEAR}_audiobook.mp3

# Track order: spoken cover first, then chapters 0..9.
declare -a SOURCES=("$AUDIO_SRC_DIR/In-Search-of-Dharma_cover.mp3")
declare -i CHAPTER
for CHAPTER in {0..9}; do
  SOURCES+=("$AUDIO_SRC_DIR/$CHAPTER-$AUDIO_STEM.mp3")
done
unset -v CHAPTER
declare -r -a SOURCES

declare -i VERBOSE=1
declare -i GAP=4
declare -- GONG=''
declare -- WORK_DIR=''
declare -a PLAYLIST=()

# ----------------------------------------------------------------------------
info() { ((VERBOSE)) || return 0; >&2 printf '%s: ◉ %s\n' "$SCRIPT_NAME" "$*"; }
success() { ((VERBOSE)) || return 0; >&2 printf '%s: ✓ %s\n' "$SCRIPT_NAME" "$*"; }
error() { >&2 printf '%s: ✗ %s\n' "$SCRIPT_NAME" "$*"; }
die() { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }

cleanup() {
  local -i rc=${1:-$?}
  trap - SIGINT SIGTERM EXIT
  [[ -z $WORK_DIR ]] || rm -rf -- "$WORK_DIR"
  exit "$rc"
}
trap 'cleanup $?' SIGINT SIGTERM EXIT

usage() {
  cat <<USAGE
$SCRIPT_NAME $VERSION - build the '$TITLE' audiobook MP3

Usage: $SCRIPT_NAME [OPTIONS]

Joins ${#SOURCES[@]} chapter MP3s from $AUDIO_SRC_DIR
into $OUTPUT
with embedded cover art and ID3v2 tags.

Options:
  -g|--gap SECONDS   silence inserted between sections (default $GAP; 0 disables
                     the silence — with --gong the chime still sounds)
  -G|--gong FILE     sound this chime at the end of each gap, just before the
                     next section starts (each break runs gap + chime length),
                     and bookend the audiobook: chime + gap before the opening
                     cover, gap + chime after the closing section
  -v|--verbose       progress messages (default on)
  -q|--quiet         suppress progress messages
  -h|--help          show this help
  -V|--version       show version
USAGE
}

check_prerequisites() {
  local -- tool src
  for tool in ffmpeg ffprobe; do
    command -v "$tool" >/dev/null || die 18 "required tool ${tool@Q} not found"
  done
  [[ -f $COVER_IMAGE ]] || die 3 "cover image missing ${COVER_IMAGE@Q}"
  for src in "${SOURCES[@]}"; do
    [[ -f $src ]] || die 3 "source audio missing ${src@Q}"
  done
}

# Encode a spacer to the exact source format (24 kHz mono 32 kbps MP3) so it
# stream-copies cleanly into the join. $1 selects the shape:
#   silence    GAP seconds of silence (no gong)
#   gong-after GAP seconds of silence, then the chime — used between sections
#              and as the closing bookend, so the chime rings out last
#   gong-first the chime, then GAP seconds of silence — the opening bookend,
#              so the chime settles before the spoken cover begins
make_spacer() {
  local -- shape=$1 spacer=$WORK_DIR/spacer-$1.mp3
  case $shape in
    silence)
      ffmpeg -hide_banner -loglevel error -y \
        -f lavfi -i anullsrc=r=24000:cl=mono -t "$GAP" \
        -c:a libmp3lame -b:a 32k \
        "$spacer" || die 1 'failed to generate silence spacer'
      ;;
    gong-after)
      ffmpeg -hide_banner -loglevel error -y -i "$GONG" \
        -af "adelay=$((GAP * 1000)):all=1" -ar 24000 -ac 1 \
        -c:a libmp3lame -b:a 32k \
        "$spacer" || die 1 "failed to prepare gong spacer from ${GONG@Q}"
      ;;
    gong-first)
      ffmpeg -hide_banner -loglevel error -y -i "$GONG" \
        -af "apad=pad_dur=$GAP" -ar 24000 -ac 1 \
        -c:a libmp3lame -b:a 32k \
        "$spacer" || die 1 "failed to prepare gong intro from ${GONG@Q}"
      ;;
    *) die 22 "internal: unknown spacer shape ${shape@Q}" ;;
  esac
  printf '%s' "$spacer"
}

# The concat demuxer needs a list file; single quotes in entries are escaped
# per its quoting rules (none occur in these fixed paths, but escape anyway).
# Args are the playlist in final order — sources and spacers already
# interleaved by the caller.
write_concat_list() {
  local -a playlist=("$@")
  local -- list=$WORK_DIR/concat.txt item
  {
    for item in "${playlist[@]}"; do
      # static format: 'file ' + literal ' + %s + literal ' + newline
      printf 'file '\''%s'\''\n' "${item//\'/\'\\\'\'}"
    done
  } > "$list"
  printf '%s' "$list"
}

# Assemble PLAYLIST: optional opening chime, then the sources with a spacer
# between each pair, then the optional closing chime. The closing bookend
# reuses the between-sections spacer — both are gap-then-chime. Fills a global
# rather than echoing, so a make_spacer failure can die in this shell.
make_playlist() {
  local -- spacer='' intro='' src
  local -i idx=0
  PLAYLIST=()
  if [[ -n $GONG ]]; then
    intro=$(make_spacer gong-first) || die 1 'failed to create opening chime'
    spacer=$(make_spacer gong-after) || die 1 'failed to create gong spacer'
    PLAYLIST+=("$intro")
  elif ((GAP > 0)); then
    spacer=$(make_spacer silence) || die 1 'failed to create silence spacer'
  fi
  for src in "${SOURCES[@]}"; do
    ((idx == 0)) || [[ -z $spacer ]] || PLAYLIST+=("$spacer")
    PLAYLIST+=("$src")
    idx+=1
  done
  [[ -z $GONG ]] || PLAYLIST+=("$spacer")
}

build_audiobook() {
  local -- list gap_desc='no gap' tmp_out=$WORK_DIR/audiobook.mp3
  if [[ -n $GONG ]]; then
    gap_desc="${GAP}s gong gaps, gong bookends"
  elif ((GAP > 0)); then
    gap_desc="${GAP}s silence gaps"
  fi
  make_playlist
  list=$(write_concat_list "${PLAYLIST[@]}") || die 1 'failed to build concat list'

  info "joining ${#SOURCES[@]} tracks (stream copy, $gap_desc) with embedded cover"
  ffmpeg -hide_banner -loglevel error -y \
    -f concat -safe 0 -i "$list" \
    -i "$COVER_IMAGE" \
    -map 0:a -map 1:v \
    -c:a copy -c:v copy \
    -disposition:v attached_pic \
    -id3v2_version 3 \
    -metadata title="$TITLE" \
    -metadata artist="$AUTHOR" \
    -metadata album_artist="$AUTHOR" \
    -metadata album="$TITLE" \
    -metadata date="$PUB_YEAR" \
    -metadata genre=Audiobook \
    -metadata:s:v title='Album cover' \
    -metadata:s:v comment='Cover (front)' \
    "$tmp_out" || die 1 'ffmpeg join failed'

  mv -- "$tmp_out" "$OUTPUT" || die 1 "failed to install ${OUTPUT@Q}"
  chgrp www-data -- "$OUTPUT" || die 1 "failed to set group on ${OUTPUT@Q}"
  chmod 664 -- "$OUTPUT" || die 1 "failed to set mode on ${OUTPUT@Q}"
}

report() {
  local -- duration size hms
  local -i seconds
  duration=$(ffprobe -v error -show_entries format=duration \
    -of default=noprint_wrappers=1:nokey=1 -- "$OUTPUT") \
    || die 1 "ffprobe failed on ${OUTPUT@Q}"
  seconds=${duration%.*}
  # stat, not du: on delayed-allocation filesystems du under-reports a file
  # written moments ago.
  size=$(stat -c %s -- "$OUTPUT" | numfmt --to=iec) \
    || die 1 "failed to stat ${OUTPUT@Q}"
  printf -v hms '%dh%02dm%02ds' \
    $((seconds / 3600)) $(((seconds % 3600) / 60)) $((seconds % 60))
  success "built ${OUTPUT@Q}"
  info "  duration $hms, size $size"
}

main() {
  # optarg: option arguments land here first — "${2@Q}" would trip nounset
  # when an option is given no argument at all.
  local -- optarg
  while (($#)); do
    case $1 in
      -g|--gap)     optarg=${2:-}
                    [[ $optarg =~ ^[0-9]+$ ]] \
                      || die 22 "--gap needs a whole number of seconds, got ${optarg@Q}"
                    GAP=$optarg; shift ;;
      -G|--gong)    optarg=${2:-}
                    [[ -f $optarg ]] \
                      || die 3 "gong file missing ${optarg@Q}"
                    GONG=$optarg; shift ;;
      -v|--verbose) VERBOSE=1 ;;
      -q|--quiet)   VERBOSE=0 ;;
      -h|--help)    usage; exit 0 ;;
      -V|--version) printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; exit 0 ;;
      *)            die 22 "unknown argument ${1@Q} (try --help)" ;;
    esac
    shift
  done
  readonly VERBOSE GAP GONG

  check_prerequisites
  WORK_DIR=$(mktemp -d) || die 1 'failed to create work directory'
  build_audiobook
  report
}

main "$@"
#fin
