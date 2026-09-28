#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
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
  printf 'not a pdf\n' >"$TMP"/-x.pdf || die 5 "failed to write ${TMP@Q}/-x.pdf"
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

  # --output names the file to write, so a test or a proof never has to be
  # built over the interior itself. It needs a value, and the help lists it.
  rc=0
  out=$("$MKPRINT" --output 2>&1) || rc=$?
  if ((rc == 2)) && [[ $out == *'--output needs'* ]]; then
    ok '--output with no value stops with exit 2'
  else
    bad "--output with no value: exit $rc, output: ${out%%$'\n'*}"
  fi
  [[ $("$MKPRINT" --help) == *'--output FILE'* ]] && ok 'the help lists --output' \
    || bad 'the help does not list --output'
  # The interior is a PDF and is written as one: a name of any other kind is
  # most likely a slip, and could be one of the book's own sources.
  printf 'a source\n' >"$TMP"/part.md || die 5 "failed to write ${TMP@Q}/part.md"
  rc=0
  out=$("$MKPRINT" --quiet --output "$TMP"/part.md 2>&1) || rc=$?
  if ((rc == 22)) && [[ $out == *'.pdf'* ]]; then
    ok '--output refuses a name that does not end .pdf'
  else
    bad "--output with a .md name: exit $rc, output: ${out%%$'\n'*}"
  fi
  [[ $(<"$TMP"/part.md) == 'a source' ]] && ok 'and leaves the file of that name as it was' \
    || bad '--output wrote over a file that is not a PDF'

  # xml_escape writes titles into raw HTML. It is tried on its own, lifted from
  # the script, since nothing in the book yet holds a character it must escape:
  # the day a title gains a quotation mark is no day to find out.
  local -- fn escaped
  fn=$(sed -n -e '/^xml_escape() {$/,/^}$/p' -- "$MKPRINT") || die 1 "cannot read ${MKPRINT@Q}"
  [[ -n $fn ]] || die 3 "xml_escape not found in ${MKPRINT@Q}"
  escaped=$(bash -c "$fn"$'\n''xml_escape "$1"' _ 'Tom & Jerry <b> "q" it'"'"'s') \
    || die 1 'xml_escape failed'
  [[ $escaped == 'Tom &amp; Jerry &lt;b&gt; &quot;q&quot; it&#39;s' ]] \
    && ok 'xml_escape escapes all five XML metacharacters' \
    || bad "xml_escape gave: $escaped"

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
