#!/bin/bash
# mk-audiobook.sh - Build the single-file "in search of dharma" audiobook, as
# an MP3 and as an M4B.
#
#   ./mk-audiobook.sh [-g SECONDS] [-G FILE]
#
# Concatenates the spoken cover plus chapters 0..9 (one TTS-narrated MP3 each,
# read straight from the garydean.id web-root) into one audiobook, embeds the
# lettered cover art, tags it with the book's bibliographic metadata, and
# writes chapter markers so podcast and audiobook players can list and jump to
# sections. Two containers are built from the same playlist, cover and markers:
#   .mp3  ID3v2 front-cover picture and CHAP frames; plays everywhere.
#   .m4b  MP4 audiobook (cover atom, chapter track, media type "audiobook"):
#         the format Apple Books and dedicated audiobook players expect, with
#         resume-position and sleep-timer support that a bare MP3 lacks.
# Chapter titles come from the first H1 of each essay's Markdown source
# alongside this script; each marker starts on the first sample of its
# narration (the preceding gap/chime belongs to the chapter before it).
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
# so the MP3 audiobook is stream-copied (-c:a copy) — a bit-perfect join with
# no re-encode. The ffmpeg mp3 muxer rewrites the Xing header on close, so the
# joined file reports the correct total duration. The M4B cannot be copied:
# players that take the format expect AAC inside it, so it is encoded from the
# same playlist (AAC-LC, 24 kHz mono, M4B_BITRATE). The build is atomic: both
# outputs are assembled in temp files and moved into place only once both have
# succeeded, so the pair on the web-root always comes from one run.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (ffmpeg, ffprobe) must resolve from system
# locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION=1.5.0
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='in search of dharma'
declare -r AUTHOR='Biksu Okusi'
declare -r PUB_YEAR=2026

declare -r AUDIO_SRC_DIR=/var/www/vhosts/garydean.id/html/audio
declare -r AUDIO_STEM=in-search-of-dharma
declare -r COVER_IMAGE=$SCRIPT_DIR/images/defining-dharma-cover-title.png
declare -r OUTPUT_BASE=$AUDIO_SRC_DIR/In-Search-of-Dharma_Biksu-Okusi_${PUB_YEAR}_audiobook
declare -r OUTPUT_MP3=$OUTPUT_BASE.mp3 OUTPUT_M4B=$OUTPUT_BASE.m4b
# The M4B is a second lossy generation over the ~32 kbps MP3 sources, so it is
# given headroom rather than a matching bitrate, to keep the two encodes from
# compounding their artefacts.
declare -r M4B_BITRATE=48k

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
$SCRIPT_NAME $VERSION - build the '$TITLE' audiobook (MP3 and M4B)

Usage: $SCRIPT_NAME [OPTIONS]

Joins ${#SOURCES[@]} chapter MP3s from $AUDIO_SRC_DIR
into $OUTPUT_MP3
 and $OUTPUT_M4B
each with embedded cover art, tags, and per-section chapter markers.

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

# Duration of an audio file in integer milliseconds, on stdout. ffprobe
# reports seconds with a decimal fraction; split and rejoin in bash to avoid
# floating point.
duration_ms() {
  local -- dur sec frac
  dur=$(ffprobe -v error -show_entries format=duration \
    -of default=noprint_wrappers=1:nokey=1 -- "$1") || return 1
  sec=${dur%%.*}
  frac=${dur#"$sec"}
  frac=${frac#.}000
  printf '%d' $((10#$sec * 1000 + 10#${frac:0:3}))
}

# Chapter title for essay n: the first H1 of $SCRIPT_DIR/n-*.md (e.g.
# "1: Defining Dharma"), falling back to "Chapter n" if no essay is found.
chapter_title() {
  local -i n=$1
  local -- md title=''
  for md in "$SCRIPT_DIR/$n-"*.md; do
    [[ -f $md ]] || break
    title=$(grep -m1 '^# ' -- "$md") || title=''
    title=${title#\# }
    break
  done
  printf '%s' "${title:-Chapter $n}"
}

# Walk PLAYLIST accumulating item durations and emit an ffmetadata file with
# one [CHAPTER] per source track. Spacers (minted in WORK_DIR) are not
# chapters — each extends the chapter before it, so a marker lands on the
# first spoken sample. The first chapter is pinned to 0 so the opening
# bookend belongs to the cover. Prints the metadata file path.
write_chapters_meta() {
  local -- meta=$WORK_DIR/chapters.ffmeta item title
  local -a starts=() titles=()
  local -i pos=0 ms track=0 i
  for item in "${PLAYLIST[@]}"; do
    ms=$(duration_ms "$item") || die 1 "ffprobe failed on ${item@Q}"
    if [[ $item != "$WORK_DIR"/* ]]; then
      starts+=("$pos")
      if ((track == 0)); then
        titles+=('Cover')
      else
        titles+=("$(chapter_title $((track - 1)))")
      fi
      track+=1
    fi
    ((pos += ms))
  done
  starts[0]=0
  {
    printf ';FFMETADATA1\n'
    for ((i = 0; i < ${#starts[@]}; i+=1)); do
      # ffmetadata escaping: backslash first, then its special characters
      title=${titles[i]}
      title=${title//\\/\\\\}
      title=${title//=/\\=}
      title=${title//;/\\;}
      title=${title//#/\\#}
      printf '[CHAPTER]\nTIMEBASE=1/1000\nSTART=%d\nEND=%d\ntitle=%s\n' \
        "${starts[i]}" "${starts[i + 1]:-$pos}" "$title"
    done
  } > "$meta"
  printf '%s' "$meta"
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

# Move a finished temp file into the web-root, group-readable by the server.
install_output() {
  local -- tmp=$1 out=$2
  mv -- "$tmp" "$out" || die 1 "failed to install ${out@Q}"
  chgrp www-data -- "$out" || die 1 "failed to set group on ${out@Q}"
  chmod 664 -- "$out" || die 1 "failed to set mode on ${out@Q}"
}

build_audiobook() {
  local -- list chapters gap_desc='no gap'
  local -- tmp_mp3=$WORK_DIR/audiobook.mp3 tmp_m4b=$WORK_DIR/audiobook.m4b
  if [[ -n $GONG ]]; then
    gap_desc="${GAP}s gong gaps, gong bookends"
  elif ((GAP > 0)); then
    gap_desc="${GAP}s silence gaps"
  fi
  make_playlist
  list=$(write_concat_list "${PLAYLIST[@]}") || die 1 'failed to build concat list'
  chapters=$(write_chapters_meta) || die 1 'failed to build chapter metadata'

  # Shared by both containers, so their audio timeline, cover and chapter
  # markers cannot drift apart. Input 0 is the joined audio, 1 the cover,
  # 2 the chapter markers.
  local -a inputs=(
    -f concat -safe 0 -i "$list"
    -i "$COVER_IMAGE"
    -f ffmetadata -i "$chapters"
    -map 0:a -map 1:v
    -map_chapters 2
  )
  local -a tags=(
    -metadata title="$TITLE"
    -metadata artist="$AUTHOR"
    -metadata album_artist="$AUTHOR"
    -metadata album="$TITLE"
    -metadata date="$PUB_YEAR"
    -metadata genre=Audiobook
  )

  info "joining ${#SOURCES[@]} tracks (stream copy, $gap_desc) into the MP3, with cover and chapter markers"
  ffmpeg -hide_banner -loglevel error -y \
    "${inputs[@]}" \
    -c:a copy -c:v copy \
    -disposition:v attached_pic \
    -id3v2_version 3 \
    "${tags[@]}" \
    -metadata:s:v title='Album cover' \
    -metadata:s:v comment='Cover (front)' \
    "$tmp_mp3" || die 1 'ffmpeg MP3 join failed'

  # The .m4b extension selects ffmpeg's ipod muxer, which writes the cover atom
  # and both chapter forms (Nero chpl and the QuickTime chapter track Apple
  # Books reads). media_type=2 is the iTunes "audiobook" kind; +faststart moves
  # the index to the front of the file so it plays while still downloading.
  info "encoding the same playlist into the M4B (AAC $M4B_BITRATE)"
  ffmpeg -hide_banner -loglevel error -y \
    "${inputs[@]}" \
    -c:a aac -b:a "$M4B_BITRATE" -c:v copy \
    -disposition:v attached_pic \
    -movflags +faststart \
    "${tags[@]}" \
    -metadata media_type=2 \
    "$tmp_m4b" || die 1 'ffmpeg M4B encode failed'

  install_output "$tmp_mp3" "$OUTPUT_MP3"
  install_output "$tmp_m4b" "$OUTPUT_M4B"
}

# Verify and describe one finished output: its chapter-marker count must match
# the number of source tracks, whichever container carries them.
report() {
  local -- output=$1 duration size hms
  local -i seconds nchapters
  duration=$(ffprobe -v error -show_entries format=duration \
    -of default=noprint_wrappers=1:nokey=1 -- "$output") \
    || die 1 "ffprobe failed on ${output@Q}"
  seconds=${duration%.*}
  nchapters=$(ffprobe -v error -show_chapters -of csv=p=0 -- "$output" \
    | grep -c .) || die 1 "chapter probe failed on ${output@Q}"
  ((nchapters == ${#SOURCES[@]})) \
    || die 1 "expected ${#SOURCES[@]} chapter markers in ${output@Q}, found $nchapters"
  # stat, not du: on delayed-allocation filesystems du under-reports a file
  # written moments ago.
  size=$(stat -c %s -- "$output" | numfmt --to=iec) \
    || die 1 "failed to stat ${output@Q}"
  printf -v hms '%dh%02dm%02ds' \
    $((seconds / 3600)) $(((seconds % 3600) / 60)) $((seconds % 60))
  success "built ${output@Q}"
  info "  duration $hms, size $size, $nchapters chapter markers"
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
  report "$OUTPUT_MP3"
  report "$OUTPUT_M4B"
}

main "$@"
#fin
