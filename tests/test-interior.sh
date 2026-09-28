#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-interior.sh - the print interior as built: the whole book through
# mk-print.sh, into a temporary file, and then read back.
#
# The other tests measure fixtures. This one reads the book itself, for what
# only the real build can show: the front matter in its order, the folios where
# the sequence changes, and the Research notes as set. It costs one full build.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -r FOLIO_Y=214.38 HEAD_Y=16.80
declare -i FAILED=0
declare -- TMP='' PDF=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# page_text N : the page's text, without the form feed pdftotext ends it with.
page_text() { pdftotext -f "$1" -l "$1" -layout "$PDF" - | tr -d '\f'; }
# at_y N Y : the text standing at height Y on page N, "" where there is none.
# The finished file is read, whose baselines Ghostscript leaves up to 0.7mm
# low (see lib/print-style.sh), so the window is wider than a fixture's.
at_y() {
  "$CHECK" baselines "$PDF" --page "$1" \
    | jq -r --argjson y "$2" '[.lines[] | select((.y_mm - $y | fabs) < 1.2) | .text] | join(" ")'
}
# expect NAME GOT WANT
expect() {
  [[ $2 == "$3" ]] && ok "$1: ${3:-(none)}" || bad "$1: got ${2:-(none)}, want ${3:-(none)}"
}
# page_of TEXT : the first page carrying TEXT, 0 if none does.
page_of() {
  local -i n pages
  pages=$(pdfinfo "$PDF" | awk '/^Pages:/{print $2}')
  for ((n = 1; n <= pages; n+=1)); do
    if page_text "$n" | grep -q -F -- "$1"; then echo "$n"; return; fi
  done
  echo 0
}

main() {
  echo '== the interior as built =='
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'
  PDF=$TMP/interior.pdf
  local -- log=$TMP/build.log
  "$ROOT"/mk-print.sh --quiet --output "$PDF" >"$log" 2>&1 \
    || die 1 "the build failed: $(tail -n 3 "$log" | tr '\n' ' ')"
  [[ -s $PDF ]] && ok 'mk-print.sh --output writes the named file' \
    || die 1 'the build wrote no file'

  # The front matter, in order: the endorsements on i, the half-title on iii,
  # the title on v with the imprint on its back, the contents on vii. None of
  # the first four printed pages shows a folio.
  local -- text
  text=$(page_text 1 | tr -s ' \n' ' ')
  [[ $text == *'Brilliant, very well written and researched, concise and compelling'* ]] \
    && ok 'page i carries the endorsement from the front cover' \
    || bad "page i does not carry the front-cover endorsement: ${text:0:80}"
  [[ $text == *"is a wonderful example of how secular dharma should evolve; not by finessing the words of a founding figure into an orthodoxy but by taking the enquiry further into new areas unanticipated by one’s predecessors."* ]] \
    && ok 'page i carries the endorsement from the back cover, word for word' \
    || bad 'page i does not carry the back-cover endorsement word for word'
  [[ $text == *"co-author of Living life on life’s terms: turning the wheel of secular dharma"* ]] \
    && ok 'page i credits Stephen Batchelor as the cover does' \
    || bad 'page i does not carry the credit as the cover words it'
  # The second endorsement ends where the cover's does. Compared in lower
  # case: the name is set in small capitals, which come back from the file in
  # whatever case the face maps them to.
  [[ ${text,,} == *"unanticipated by one’s predecessors. – stephen batchelor"* ]] \
    && ok 'the second endorsement ends where the cover'"'"'s does' \
    || bad 'the second endorsement runs on past the words the cover carries'
  expect 'page i folio' "$(at_y 1 "$FOLIO_Y")" ''
  expect 'page ii is blank' "$(page_text 2 | tr -d ' \n')" ''
  [[ $(page_text 3 | tr -s ' \n' ' ') == *'in search of dharma'* ]] \
    && ok 'the half-title is on page iii' || bad 'the half-title is not on page iii'
  expect 'page iii folio' "$(at_y 3 "$FOLIO_Y")" ''
  expect 'page iv is blank' "$(page_text 4 | tr -d ' \n')" ''
  [[ $(page_text 5) == *'What holds a life'* ]] \
    && ok 'the title page is on page v' || bad 'the title page is not on page v'
  [[ $(page_text 6) == *'ISBN 979-8-9980676-0-0'* ]] \
    && ok 'the imprint is on page vi, the back of the title' || bad 'the imprint is not on page vi'
  [[ $(page_text 7) == *'Contents'* ]] \
    && ok 'the contents are on page vii' || bad 'the contents are not on page vii'
  expect 'contents folio' "$(at_y 7 "$FOLIO_Y")" 'vii'

  # The Preface follows in roman, and Part 1 opens the arabic sequence.
  local -i preface part1
  # Searched by words after each opener's lead-in, which is set in small
  # capitals and comes back from the file in mixed case.
  preface=$(page_of 'that refer to the word') part1=$(page_of 'yoga studio in nearly every city')
  expect 'the Preface opens on PDF page' "$preface" 9
  ((preface && part1)) || die 1 'the Preface or Part 1 was not found, so their folios cannot be read'
  expect 'Preface opener folio' "$(at_y "$preface" "$FOLIO_Y")" 'ix'
  expect 'Preface verso head' "$(at_y $((preface + 1)) "$HEAD_Y")" 'in search of dharma'
  expect 'Preface recto head' "$(at_y $((preface + 2)) "$HEAD_Y")" 'Preface'
  ((part1 % 2)) && ok "Part 1 opens on a recto (PDF page $part1)" \
    || bad "Part 1 opens on PDF page $part1, which is not a recto"
  expect 'Part 1 opener folio' "$(at_y "$part1" "$FOLIO_Y")" '1'
  expect 'Part 1 second page folio' "$(at_y $((part1 + 1)) "$FOLIO_Y")" '2'
  text=$(page_text 7 | tr -s ' .' ' ')
  [[ $text == *'Preface ix'* && $text == *'1: Defining dharma 1'* ]] \
    && ok 'the contents give the Preface as ix and Part 1 as 1' \
    || bad "the contents give other numbers: $(grep -E 'Preface|1: ' <<<"$text" | tr '\n' ' ')"

  # Research notes: the two lines as Ramsey wrote them, in all nine chapters
  # that carry them.
  local -i notes
  notes=$(pdftotext -layout "$PDF" - | grep -A1 -F 'Research notes used in this book are published on GitHub:' \
    | grep -c -x -E ' *https://github\.com/Biksu-Okusi/In-Search-of-Dharma' || true)
  expect 'chapters whose Research notes open with the two lines' "$notes" 9

  # A build that fails its preflight leaves the file at --output as it found
  # it. Tried in a tree of links to the book beside a copy of the script, where
  # the checker is a stand-in that measures as the real one does and fails
  # every check.
  echo '== a build that fails its preflight =='
  local -- box=$TMP/box src kept=$TMP/kept.pdf
  mkdir -- "$box" || die 5 'failed to create the build tree'
  for src in "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$ROOT"/print-imprint.md \
             "$ROOT"/print-endorsements.md "$ROOT"/fonts "$ROOT"/images "$ROOT"/lib; do
    cp -Rs -- "$src" "$box"/ || die 5 "failed to link ${src@Q}"
  done
  cp -- "$ROOT"/mk-print.sh "$box"/ || die 5 'failed to copy mk-print.sh'
  rm -- "$box"/lib/pdfcheck.py || die 5 'failed to unlink the checker'
  cat >"$box"/lib/pdfcheck.py <<STUB || die 5 'failed to write the stand-in checker'
#!/bin/bash
[[ \${1:-} != check ]] || { >&2 echo '✗ forced: this build fails its preflight'; exit 1; }
exec "$CHECK" "\$@"
STUB
  chmod +x -- "$box"/lib/pdfcheck.py || die 5 'failed to mark the stand-in checker executable'
  printf 'the proof that was here before\n' >"$kept" || die 5 'failed to write the fixture'
  local -i rc=0
  "$box"/mk-print.sh --quiet --output "$kept" >"$log" 2>&1 || rc=$?
  ((rc == 1)) && grep -q -F 'preflight failed' "$log" \
    && ok 'the build stops with exit 1 and says its preflight failed' \
    || bad "the build did not fail as set up: exit $rc, $(tail -n 2 "$log" | tr '\n' ' ')"
  [[ -f $kept && $(<"$kept") == 'the proof that was here before' ]] \
    && ok 'the file at --output is as it was' \
    || bad 'the failed build wrote over, or removed, the file at --output'
  [[ -z $(find "$box" -maxdepth 1 -name '*.pdf' -print -quit) ]] \
    && ok 'and no interior is left beside the script' || bad 'the failed build left an interior behind'

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
