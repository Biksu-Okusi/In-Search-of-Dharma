#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-interior.sh - the print interior as built: the whole book through
# mk-print.sh, into a temporary file, and then read back.
#
# The other tests measure fixtures. This one reads the book itself, for what
# only the real build can show: the front matter in its order, the folios where
# the sequence changes, and the Research notes as set. It costs one full build.
#
# Several checks pass on an empty answer: a page with no folio, a blank page.
# So every reading of the file is taken and checked before it is compared. A
# reading that fails stops the test, and is never taken for an empty page.
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
declare -r NOTES_LINE='Research notes used in this book are published on GitHub:'
declare -r NOTES_URL=' *https://github\.com/Biksu-Okusi/In-Search-of-Dharma'
declare -i FAILED=0
declare -- TMP='' PDF=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# page_text N : the page's text, without the form feed pdftotext ends it with.
page_text() { pdftotext -f "$1" -l "$1" -layout -- "$PDF" - | tr -d '\f'; }

# at_y N Y : the text standing at height Y on page N, "" where there is none.
# The finished file is read, whose baselines Ghostscript leaves up to 0.7mm
# low (see lib/print-style.sh), so the window is wider than a fixture's.
at_y() {
  "$CHECK" baselines --page "$1" -- "$PDF" \
    | jq -r --argjson y "$2" '[.lines[] | select((.y_mm - $y | fabs) < 1.2) | .text] | join(" ")'
}

# expect NAME GOT WANT
expect() {
  [[ $2 == "$3" ]] && ok "$1: ${3:-(none)}" || bad "$1: got ${2:-(none)}, want ${3:-(none)}"
}

# expect_at NAME N Y WANT : the text at height Y on page N is WANT.
expect_at() {
  local -- got
  got=$(at_y "$2" "$3") || die 1 "could not read page $2 for ${1@Q}"
  expect "$1" "$got" "$4"
}

# expect_blank NAME N : page N carries no text at all.
expect_blank() {
  local -- got
  got=$(page_text "$2") || die 1 "could not read page $2 for ${1@Q}"
  expect "$1" "${got//[[:space:]]/}" ''
}

# expect_on NAME N TEXT : page N carries TEXT, however its lines fall.
expect_on() {
  local -- got
  got=$(page_text "$2" | tr -s ' \n' ' ') || die 1 "could not read page $2 for ${1@Q}"
  [[ $got == *"$3"* ]] && ok "$1" || bad "$1: not so"
}

# page_of TEXT : the first page carrying TEXT, 0 if none does.
page_of() {
  local -i n pages
  pages=$(pdfinfo -- "$PDF" | awk '/^Pages:/{print $2}') || die 1 "could not count the pages of ${PDF@Q}"
  for ((n = 1; n <= pages; n+=1)); do
    if page_text "$n" | grep -q -F -- "$1"; then echo "$n"; return; fi
  done
  echo 0
}

main() {
  local -- tool
  for tool in pdftotext pdfinfo jq; do
    command -v "$tool" >/dev/null || die 18 "required: ${tool@Q}"
  done

  echo '== the interior as built =='
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'
  PDF=$TMP/interior.pdf
  local -- log=$TMP/build.log bystander=$TMP/bystander.txt fresh=$TMP/fresh strays
  # The build stages its file beside the destination before renaming it into
  # place. A link standing at a name the build could be guessed to use must
  # not be written through: it points here at a file that is none of its
  # business.
  printf 'untouched\n' >"$bystander" || die 5 "failed to write ${bystander@Q}"
  ln -s -- "$bystander" "$PDF".part || die 5 "failed to plant a link at ${PDF@Q}.part"
  : >"$fresh" || die 5 "failed to write ${fresh@Q}"
  "$ROOT"/mk-print.sh --quiet --output "$PDF" &>"$log" \
    || die 1 "the build failed: $(tail -n 3 -- "$log" | tr '\n' ' ')"
  [[ -s $PDF ]] && ok 'mk-print.sh --output writes the named file' \
    || die 1 "the build did not write ${PDF@Q}"
  [[ $(<"$bystander") == untouched ]] \
    && ok 'a link planted beside the destination is not written through' \
    || bad 'the build wrote through a link planted beside its destination'
  [[ ! -L $PDF ]] && ok 'the interior is a file of its own, not a link' \
    || bad 'the interior is a link to another file'
  strays=$(find -- "$TMP" -maxdepth 1 -name 'interior.pdf.*' ! -name 'interior.pdf.part' -print) \
    || die 1 "could not search ${TMP@Q}"
  [[ -z $strays ]] && ok 'no staging file is left beside the interior' \
    || bad "a staging file was left behind: ${strays@Q}"
  [[ $(stat -c %a -- "$PDF") == "$(stat -c %a -- "$fresh")" ]] \
    && ok 'the interior has the permissions of any newly made file' \
    || bad "the interior's permissions are $(stat -c %a -- "$PDF"), a new file's $(stat -c %a -- "$fresh")"

  # The front matter, in order: the endorsements on i, the half-title on iii,
  # the title on v with the imprint on its back, the contents on vii. None of
  # the first four printed pages shows a folio.
  #
  # The endorsements are the cover's words, to the letter. SC1112: the
  # typographic apostrophe in them is the text being matched, not a slip.
  #shellcheck disable=SC1112  # the apostrophe is part of the text matched
  local -r back='is a wonderful example of how secular dharma should evolve; not by finessing '\
'the words of a founding figure into an orthodoxy but by taking the enquiry further into new '\
'areas unanticipated by one’s predecessors.'
  #shellcheck disable=SC1112  # the apostrophe is part of the text matched
  local -r credit='co-author of Living life on life’s terms: turning the wheel of secular dharma'
  local -- text
  text=$(page_text 1 | tr -s ' \n' ' ') || die 1 'could not read page 1'
  [[ $text == *'Brilliant, very well written and researched, concise and compelling'* ]] \
    && ok 'page i carries the endorsement from the front cover' \
    || bad "page i does not carry the front-cover endorsement: ${text:0:80}"
  [[ $text == *"$back"* ]] \
    && ok 'page i carries the endorsement from the back cover, word for word' \
    || bad 'page i does not carry the back-cover endorsement word for word'
  [[ $text == *"$credit"* ]] \
    && ok 'page i credits Stephen Batchelor as the cover does' \
    || bad 'page i does not carry the credit as the cover words it'
  # The second endorsement ends where the cover's does. Compared in lower
  # case: the name is set in small capitals, which come back from the file in
  # whatever case the face maps them to.
  [[ ${text,,} == *'predecessors. – stephen batchelor'* ]] \
    && ok 'the second endorsement ends where the cover'"'"'s does' \
    || bad 'the second endorsement runs on past the words the cover carries'
  expect_at 'page i folio' 1 "$FOLIO_Y" ''
  expect_blank 'page ii is blank' 2
  expect_on 'the half-title is on page iii' 3 'in search of dharma'
  expect_at 'page iii folio' 3 "$FOLIO_Y" ''
  expect_blank 'page iv is blank' 4
  expect_on 'the title page is on page v' 5 'What holds a life'
  expect_on 'the imprint is on page vi, the back of the title' 6 'ISBN 979-8-9980676-0-0'
  expect_on 'the contents are on page vii' 7 'Contents'
  expect_at 'contents folio' 7 "$FOLIO_Y" 'vii'

  # The Preface follows in roman, and Part 1 opens the arabic sequence.
  local -i preface part1
  # Searched by words after each opener's lead-in, which is set in small
  # capitals and comes back from the file in mixed case.
  preface=$(page_of 'that refer to the word') || die 1 'could not search for the Preface'
  part1=$(page_of 'yoga studio in nearly every city') || die 1 'could not search for Part 1'
  expect 'the Preface opens on PDF page' "$preface" 9
  ((preface && part1)) || die 1 'the Preface or Part 1 was not found, so their folios cannot be read'
  expect_at 'Preface opener folio' "$preface" "$FOLIO_Y" 'ix'
  expect_at 'Preface verso head' $((preface + 1)) "$HEAD_Y" 'in search of dharma'
  expect_at 'Preface recto head' $((preface + 2)) "$HEAD_Y" 'Preface'
  ((part1 % 2)) && ok "Part 1 opens on a recto (PDF page $part1)" \
    || bad "Part 1 opens on PDF page $part1, which is not a recto"
  expect_at 'Part 1 opener folio' "$part1" "$FOLIO_Y" '1'
  expect_at 'Part 1 second page folio' $((part1 + 1)) "$FOLIO_Y" '2'
  text=$(page_text 7 | tr -s ' .' ' ') || die 1 'could not read page 7'
  [[ $text == *'Preface ix'* && $text == *'1: Defining dharma 1'* ]] \
    && ok 'the contents give the Preface as ix and Part 1 as 1' \
    || bad "the contents give other numbers: $(grep -E -- 'Preface|1: ' <<<"$text" | tr '\n' ' ')"

  # Research notes: the two lines as Ramsey wrote them, in the Preface and all
  # eight Parts.
  local -- whole
  local -i notes
  whole=$(pdftotext -layout -- "$PDF" -) || die 1 "could not read ${PDF@Q}"
  # grep exits 1 when it counts nothing, which here is an answer, not a failure.
  notes=$(grep -A1 -F -- "$NOTES_LINE" <<<"$whole" | grep -c -x -E -- "$NOTES_URL") ||:
  expect 'openings of Research notes that read as the two lines' "$notes" 9

  # A build that fails its preflight leaves the file at --output as it found
  # it. Tried in a tree of links to the book beside a copy of the script, where
  # the checker is a stand-in that measures as the real one does and fails
  # every check.
  echo '== a build that fails its preflight =='
  local -- box=$TMP/box src kept=$TMP/kept.pdf left
  mkdir -- "$box" || die 5 'failed to create the build tree'
  for src in "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$ROOT"/print-imprint.md \
             "$ROOT"/print-endorsements.md "$ROOT"/fonts "$ROOT"/images "$ROOT"/lib; do
    [[ -e $src ]] || die 3 "nothing at ${src@Q}"
    cp -Rs -- "$src" "$box"/ || die 5 "failed to link ${src@Q}"
  done
  cp -- "$ROOT"/mk-print.sh "$box"/ || die 5 'failed to copy mk-print.sh'
  rm -- "$box"/lib/pdfcheck.py || die 5 'failed to unlink the checker'
  cat >"$box"/lib/pdfcheck.py <<STUB || die 5 'failed to write the stand-in checker'
#!/bin/bash
[[ \${1:-} != check ]] || { >&2 echo '✗ forced: this build fails its preflight'; exit 1; }
exec "$CHECK" "\$@"
STUB
  chmod -- +x "$box"/lib/pdfcheck.py || die 5 'failed to mark the stand-in checker executable'
  printf 'the proof that was here before\n' >"$kept" || die 5 "failed to write ${kept@Q}"
  local -i rc=0
  "$box"/mk-print.sh --quiet --output "$kept" &>"$log" || rc=$?
  ((rc == 1)) && grep -q -F -- 'preflight failed' "$log" \
    && ok 'the build stops with exit 1 and says its preflight failed' \
    || bad "the build did not fail as set up: exit $rc, $(tail -n 2 -- "$log" | tr '\n' ' ')"
  [[ -f $kept && $(<"$kept") == 'the proof that was here before' ]] \
    && ok 'the file at --output is as it was' \
    || bad 'the failed build wrote over, or removed, the file at --output'
  left=$(find -- "$box" -maxdepth 1 -name '*.pdf' -print -quit) || die 1 "could not search ${box@Q}"
  [[ -z $left ]] && ok 'and no interior is left beside the script' \
    || bad "the failed build left an interior behind: ${left@Q}"

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
