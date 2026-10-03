#!/bin/bash
# mk-audio-tuwhiri.sh - narrate the three tracks only Tuwhiri's audiobook
# carries, then build that audiobook.
#
#   ./mk-audio-tuwhiri.sh [-f] [-B]
#
# Tuwhiri's edition wraps the ten published narrations (Preface, Parts 1-8,
# Coda: mk-audio-all.sh) in the publisher's opening and credits, and reads the
# appendix, which the author's own audiobook does not:
#   00_Tuwhiri-Presents.mp3  audio-tuwhiri/00-tuwhiri-presents.md
#   11_Appendix.mp3          the-better-ones.md, as far as its Sources
#   99_Final-Credits.mp3     audio-tuwhiri/99-final-credits.md
# The appendix is the one file three surfaces share, so it takes no audio
# frontmatter of its own: a narration copy is written beside the other two
# scripts (where audio-tuwhiri/tts_lexicon.json applies to all three), with
# the frontmatter the Parts carry and the text cut where theirs stops being
# read, before "Sources & further reading".
#
# A track is narrated only when it is missing or older than its script (gentts
# -T stamps each MP3 with its script's mtime); --force narrates all three.
# The audiobook is then built by ./mk-audiobook.sh --edition tuwhiri.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (gentts included) must resolve from system
# locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r SRC_DIR=$SCRIPT_DIR/audio-tuwhiri
declare -r TRACK_DIR=$SRC_DIR/tracks
declare -r APPENDIX=$SCRIPT_DIR/the-better-ones.md
declare -r APPENDIX_SCRIPT=$SRC_DIR/11-appendix.md
declare -r SOURCES_HEADING='## Sources & further reading'

declare -i FORCE=0 BUILD=1

info() { >&2 printf '%s: ◉ %s\n' "$SCRIPT_NAME" "$*"; }
error() { >&2 printf '%s: ✗ %s\n' "$SCRIPT_NAME" "$*"; }
die() { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }

usage() {
  cat <<USAGE
$SCRIPT_NAME - narrate Tuwhiri's three audiobook tracks, then build the audiobook

Usage: $SCRIPT_NAME [OPTIONS]

Options:
  -f|--force     narrate all three tracks, even those newer than their scripts
  -B|--no-build  narrate only; do not run mk-audiobook.sh --edition tuwhiri
  -h|--help      show this help
USAGE
}

# The appendix as the voice reads it: the Parts' audio frontmatter, then the
# text up to the Sources heading, less the rule and page-break comment that
# close the last section. Stamped with the appendix's mtime, so the narration
# is redone when the appendix changes and not otherwise.
write_appendix_script() {
  local -i cut
  cut=$(grep -n -m1 -F -x -- "$SOURCES_HEADING" "$APPENDIX" | cut -d: -f1) \
    || die 1 "no ${SOURCES_HEADING@Q} heading in ${APPENDIX@Q}"
  {
    cat <<'FRONTMATTER'
---
title: "Dharmas: the better ones"
language: en
audio:
  title: "In Search of Dharma"
  subtitle: "Appendix: Dharmas, the better ones"
  strip_h1: true
  provider: google
  voice: en-AU-Chirp3-HD-Charon
  lang_code: en-AU
  output: 11_Appendix.mp3
---

FRONTMATTER
    head -n $((cut - 1)) -- "$APPENDIX" | grep -v -x -e '---' -e '<!--\\newpage-->'
  } > "$APPENDIX_SCRIPT" || die 1 "failed to write ${APPENDIX_SCRIPT@Q}"
  touch -r "$APPENDIX" -- "$APPENDIX_SCRIPT"
}

main() {
  while (($#)); do
    case $1 in
      -f|--force)    FORCE=1 ;;
      -B|--no-build) BUILD=0 ;;
      -h|--help)     usage; exit 0 ;;
      -[fBh]?*)      set -- "${1:0:2}" "-${1:2}" "${@:2}"; continue ;;
      *)             die 22 "unknown argument ${1@Q} (try --help)" ;;
    esac
    shift
  done
  readonly FORCE BUILD

  command -v gentts >/dev/null || die 18 'required tool gentts not found'
  [[ -f $APPENDIX ]] || die 3 "appendix source not found: ${APPENDIX@Q}"
  mkdir -p -- "$TRACK_DIR"
  write_appendix_script

  local -- script track
  local -a stale=()
  local -A tracks=(
    ["$SRC_DIR"/00-tuwhiri-presents.md]=00_Tuwhiri-Presents.mp3
    ["$APPENDIX_SCRIPT"]=11_Appendix.mp3
    ["$SRC_DIR"/99-final-credits.md]=99_Final-Credits.mp3
  )
  for script in "${!tracks[@]}"; do
    [[ -f $script ]] || die 3 "script not found: ${script@Q}"
    track=$TRACK_DIR/${tracks[$script]}
    if ((FORCE)) || [[ ! -f $track || $script -nt $track ]]; then
      stale+=("$script")
    fi
  done
  if ((${#stale[@]})); then
    info "narrating ${#stale[@]} track(s)"
    gentts -T -O "$TRACK_DIR" -- "${stale[@]}"
  else
    info 'the three tracks are up to date'
  fi

  ((BUILD)) || return 0
  "$SCRIPT_DIR"/mk-audiobook.sh --edition tuwhiri -g 0 \
    -G "$SCRIPT_DIR"/audio-assets/dharmic-ai.mp3
}

main "$@"
#fin
