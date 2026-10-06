#!/bin/bash
# tools/presend-check.sh - the book's check on an attachment about to be mailed.
#
#   tools/presend-check.sh FILE
#
# A print interior (*_interior_*.pdf) must be of the book as it now stands --
# newer than every source it is built from -- and must pass
# mk-print.sh --preflight. Its copy with crop marks (*_cropmarks.pdf, from
# mk-print.sh --marks) is judged by the interior beside it. Anything else
# passes. The persona skill's
# mailsend.py runs this once per attachment (ATTACH_CHECK in the project's
# binding) and refuses the send on a non-zero exit.
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_NAME=${SCRIPT_PATH##*/} ROOT=${SCRIPT_PATH%/tools/*}

_msg()  { >&2 printf "$SCRIPT_NAME: $1 %s\n" "${@:2}"; }
error() { _msg '✗' "$@"; }
die()   { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }

main() {
  (($# == 1)) || die 2 'usage: presend-check.sh FILE'
  local -- file=$1 src
  [[ -f $file ]] || die 3 "no such file ${file@Q}"
  local -- base=${file##*/} plain=$file plain_base
  [[ $base == *_interior_*.pdf ]] || return 0
  # A copy with crop marks cannot pass the preflight, which refuses marks as
  # the printer does. It answers for itself through the interior it was made
  # from: that file must lie beside it, be no newer than it, and pass.
  if [[ $base == *_cropmarks.pdf ]]; then
    plain=${file%_cropmarks.pdf}.pdf
    [[ -f $plain ]] \
      || die 3 "${base@Q} has no interior beside it (${plain##*/}): build both with mk-print.sh --marks"
    [[ ! $plain -nt $file ]] \
      || die 1 "${base@Q} is older than the interior beside it: rebuild with mk-print.sh --marks"
  fi
  plain_base=${plain##*/}
  # What the print interior is built from. A PDF older than any of these is a
  # proof of a book that has since changed.
  local -a sources=("$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$ROOT"/mk-print.sh
                    "$ROOT"/lib/*.sh "$ROOT"/lib/*.py
                    "$ROOT"/print-imprint.md "$ROOT"/print-dedication.md
                    "$ROOT"/print-takedowns.txt)
  # The imprint, the dedication and the take-downs are optional. A file that
  # is not there is never newer than the interior, so it needs no test of its
  # own.
  for src in "${sources[@]}"; do
    [[ ! $src -nt $plain ]] \
      || die 1 "${plain_base@Q} is older than ${src#"$ROOT"/}: rebuild with mk-print.sh before sending"
  done
  "$ROOT"/mk-print.sh --preflight "$plain" || die 1 "${plain_base@Q} fails mk-print.sh --preflight"
}

main "$@"
#fin
