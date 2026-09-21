#!/bin/bash
# tests/test-mkprint-cli.sh - mk-print.sh's command line, without a full build.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r MKPRINT=$ROOT/mk-print.sh
declare -i FAILED=0
declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

main() {
  echo '== mk-print command line =='
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'

  # A file whose name begins with a dash must reach the checker as a file. It
  # is not a PDF, so the checker rejects it -- but as a file it could not read,
  # not as an option it did not recognise.
  printf 'not a pdf\n' >"$TMP"/-x.pdf || die 5 'failed to write the fixture'
  local -- out
  local -i rc=0
  out=$(cd -- "$TMP" && "$MKPRINT" --preflight -x.pdf 2>&1) || rc=$?
  if ((rc == 0)); then
    bad '--preflight accepted a file that is not a PDF'
  elif [[ $out == *usage:* ]]; then
    bad "--preflight read a dash-led filename as an option: ${out%%$'\n'*}"
  else
    ok '--preflight takes a dash-led filename as a file, not an option'
  fi

  # A bad value stops the build at the command line with exit 22 and names the
  # option, rather than reaching the stylesheet or dying inside a library.
  local -- opt
  for opt in --size --lead --fonts; do
    rc=0
    out=$("$MKPRINT" "$opt" 'x;}' 2>&1) || rc=$?
    if ((rc == 22)) && [[ $out == *"$opt"* ]]; then
      ok "$opt rejects an invalid value with exit 22"
    else
      bad "$opt with an invalid value: exit $rc, output: ${out%%$'\n'*}"
    fi
  done

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
