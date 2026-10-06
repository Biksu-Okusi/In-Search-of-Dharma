#!/bin/bash
#shellcheck disable=SC2015  # pass() only prints, so A && pass || fail is safe here
# tests/test-takedown.sh - lib/takedown.py wraps the words named in a rules
# file, each by the phrase round it, and stops when a phrase is not found
# exactly once: the line ends Tuwhiri marked on 2026-10-06 are answered one by
# one, and a rule that no longer fits the text is an error, not a guess.
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r TD=$ROOT/lib/takedown.py
declare -r OPEN='<span class="td">' SHUT='</span>'
declare -i FAILED=0
declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; FAILED+=1; }

command -v python3 >/dev/null || { >&2 printf '  ✗ required: python3\n'; exit 18; }
TMP=$(mktemp -d) || { >&2 printf '  ✗ could not make a temporary directory\n'; exit 1; }

# gives NAME RULES INPUT WANT : with RULES in a file, the filter turns INPUT
# into exactly WANT.
gives() {
  local -- got
  printf '%s\n' "$2" >"$TMP"/rules
  got=$(printf '%s' "$3" | "$TD" "$TMP"/rules 2>"$TMP"/err) \
    || { fail "$1: the filter failed: $(<"$TMP"/err)"; return; }
  [[ $got == "$4" ]] && pass "$1" || fail "$1"$'\n'"      want: $4"$'\n'"      got:  $got"
}

# refuses NAME RULES INPUT MESSAGE : the filter exits 1, writes nothing on
# stdout, and says MESSAGE on stderr.
refuses() {
  local -- got err
  local -i rc=0
  printf '%s\n' "$2" >"$TMP"/rules
  got=$(printf '%s' "$3" | "$TD" "$TMP"/rules 2>"$TMP"/err) || rc=$?
  err=$(<"$TMP"/err)
  if ((rc == 1)) && [[ -z $got && $err == *"$4"* ]]; then
    pass "$1"
  else
    fail "$1: exit $rc, stdout ${got:0:60}, stderr ${err:0:120}"
  fi
}

echo '== take down: filter =='

gives 'the bracketed word is wrapped where the phrase stands' \
  'the slow quiet [sabotage] of people' \
  '<p>misunderstanding, the slow quiet sabotage of people who</p>' \
  "<p>misunderstanding, the slow quiet ${OPEN}sabotage${SHUT} of people who</p>"

gives 'two words kept together are wrapped as one' \
  'authority [he cannot] revoke' \
  '<p>it is authority he cannot revoke. There</p>' \
  "<p>it is authority ${OPEN}he cannot${SHUT} revoke. There</p>"

gives 'only the one occurrence inside the phrase is touched' \
  'the [argument] it carries' \
  '<p>the argument runs on. The proverb is Nguni; the argument it carries runs</p>' \
  "<p>the argument runs on. The proverb is Nguni; the ${OPEN}argument${SHUT} it carries runs</p>"

gives 'comments and blank lines are ignored' \
  $'# p. 54\n\nthe slow quiet [sabotage] of people\n' \
  '<p>the slow quiet sabotage of people</p>' \
  "<p>the slow quiet ${OPEN}sabotage${SHUT} of people</p>"

gives 'several rules apply in one pass' \
  $'[immobilised] in the capital\nnot about [bindingness]' \
  '<p>immobilised in the capital</p><p>not about bindingness</p>' \
  "<p>${OPEN}immobilised${SHUT} in the capital</p><p>not about ${OPEN}bindingness${SHUT}</p>"

# pandoc wraps its HTML over lines, so a phrase may hold a newline in the text.
gives 'a phrase wrapped over lines by pandoc is still found' \
  'fixed by kinship in [advance]' \
  $'<p>were fixed by kinship\nin advance. Mourning</p>' \
  $'<p>were fixed by kinship\nin '"${OPEN}advance${SHUT}"'. Mourning</p>'

gives 'words kept together may be wrapped over lines themselves' \
  'authority [he cannot] revoke' \
  $'<p>authority he\ncannot revoke</p>' \
  $'<p>authority '"$OPEN"$'he\ncannot'"$SHUT"' revoke</p>'

gives 'text inside tags is never matched' \
  'the [capital]' \
  '<p id="the capital">the capital</p>' \
  "<p id=\"the capital\">the ${OPEN}capital${SHUT}</p>"

refuses 'a phrase that is not in the text stops the run' \
  'the slow quiet [sabotage] of people' \
  '<p>nothing of the kind</p>' \
  '0 matches'

refuses 'a phrase found twice stops the run' \
  'the [argument]' \
  '<p>the argument here, and the argument there</p>' \
  '2 matches'

refuses 'a phrase that crosses a tag is not found' \
  'the restless, [rootless], screen-lit' \
  '<p>the restless, rootless, <span class="nb">screen-lit</span> city</p>' \
  '0 matches'

refuses 'a rule without brackets is malformed' \
  'the slow quiet sabotage of people' \
  '<p>the slow quiet sabotage of people</p>' \
  'bracketed'

echo '== take down: the book'"'"'s own rules =='
# Every rule in print-takedowns.txt must be well formed; whether each is found
# once is the build's test, since only the whole typeset text can say so.
if [[ -f $ROOT/print-takedowns.txt ]]; then
  if "$TD" "$ROOT"/print-takedowns.txt </dev/null >/dev/null 2>"$TMP"/err; then
    fail 'an empty text should fail every rule'
  elif grep -q -- bracketed "$TMP"/err; then
    fail "a rule in print-takedowns.txt is malformed: $(grep -- bracketed "$TMP"/err)"
  else
    pass "every rule in print-takedowns.txt is well formed ($(grep -c -- matches "$TMP"/err) rules)"
  fi
else
  fail 'print-takedowns.txt is missing'
fi

((FAILED == 0)) || { printf '✗ take down: %d failed\n' "$FAILED"; exit 1; }
printf '✓ take down: all passed\n'
exit 0
#fin
