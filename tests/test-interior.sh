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

  # The front matter, in Tuwhiri's running order (Ramsey, 2026-09-30): the
  # half-title on i, the title on iii with the imprint on its back, the
  # dedication on v, the contents on vii. None of the seven shows a folio. The
  # dedication is the author's (2026-09-28), opening "For" at Tuwhiri's
  # request, set whole on page v and centred on the page's text block, which on
  # a recto runs from 25mm to 132mm.
  local -r ded_page=5
  local -r dedication='For Paul Stange, Irfan Kortschak, Peter Kropotkin, David Graeber, Pa Kettle, '\
'Robert Sapolsky, Stephen Batchelor, Elfie Klinger and Rupert Bozeat; and Sukinah and the women '\
'of Kendeng; for their inspiration, and for their ideas which have been brought together in this work.'
  local -- text front off_centre
  text=$(page_text "$ded_page" | tr -s ' \n' ' ') || die 1 "could not read page $ded_page"
  text=${text# }
  [[ ${text% } == "$dedication" ]] \
    && ok 'page v carries the dedication, word for word, and nothing else' \
    || bad "page v reads: ${text:0:160}"
  off_centre=$("$CHECK" baselines --page "$ded_page" -- "$PDF" \
    | jq -r '[.lines[] | ((.x0_mm + .x1_mm) / 2 - 78.5) | fabs] | max') \
    || die 1 'could not measure the dedication'
  awk -v d="$off_centre" 'BEGIN{exit !(d < 0.3)}' \
    && ok 'every line of the dedication is centred' \
    || bad "a line of the dedication stands ${off_centre}mm off the centre of the page"
  # No name is divided between two lines.
  local -- ded_lines name split=''
  ded_lines=$("$CHECK" baselines --page "$ded_page" -- "$PDF" | jq -r '.lines[].text') \
    || die 1 'could not read the lines of the dedication'
  for name in 'Paul Stange' 'Irfan Kortschak' 'Peter Kropotkin' 'David Graeber' 'Pa Kettle' \
              'Robert Sapolsky' 'Stephen Batchelor' 'Elfie Klinger' 'Rupert Bozeat' 'of Kendeng'; do
    [[ $ded_lines == *"$name"* ]] || split+="${split:+, }$name"
  done
  [[ -z $split ]] && ok 'every name in the dedication stands whole on one line' \
    || bad "divided between lines: $split"
  # Nor does it end on a line of one word.
  [[ ${ded_lines##*$'\n'} == *' '* ]] && ok 'the last line of the dedication holds more than one word' \
    || bad "the dedication ends on a line of one word: ${ded_lines##*$'\n'}"
  front=$(pdftotext -f 1 -l 8 -- "$PDF" -) || die 1 'could not read the front matter'
  [[ $front != *'concise and compelling'* ]] \
    && ok 'the endorsement is no longer in the front matter; it stands on the cover' \
    || bad 'the front matter still carries the endorsement'
  expect_on 'the half-title is on page i, "in search of" over "DHARMA"' 1 'in search of DHARMA'
  expect_at 'page i folio' 1 "$FOLIO_Y" ''
  expect_blank 'page ii is blank' 2
  expect_on 'the title page is on page iii' 3 'What holds a life'
  expect_on 'the title page sets "in search of" over "DHARMA"' 3 'in search of DHARMA'
  expect_at 'page iii folio' 3 "$FOLIO_Y" ''
  expect_on 'the imprint is on page iv, the back of the title' 4 'ISBN 979-8-9980676-0-0'
  expect_at 'page iv folio' 4 "$FOLIO_Y" ''
  # Tuwhiri's copy of 2026-09-30.
  expect_on 'the imprint names Tuwhiri without "USA"' 4 'Tuwhiri, a 501c3 nonprofit'
  expect_on 'the imprint carries the Library of Congress number' 4 \
    'Library of Congress Control Number: 2026925543'
  expect_on 'the imprint credits the cover image' 4 \
    'Cover image by Honey Yanibel Minaya Cruz on Unsplash'
  expect_at 'page v folio' "$ded_page" "$FOLIO_Y" ''
  expect_blank 'page vi is blank' 6
  expect_on 'the contents are on page vii' 7 'Contents'
  expect_at 'contents folio' 7 "$FOLIO_Y" ''

  # The Preface follows in roman, and Part 1 opens the arabic sequence.
  local -i preface part1
  # Searched by words after each opener's lead-in, which is set in small
  # capitals and comes back from the file in mixed case.
  preface=$(page_of 'that refer to the word') || die 1 'could not search for the Preface'
  part1=$(page_of 'yoga studio in nearly every city') || die 1 'could not search for Part 1'
  # The Preface opens on viii, the verso of the contents, with its number and
  # without a running head; its recto heads name it, its versos the book.
  expect 'the Preface opens on PDF page' "$preface" 8
  ((preface && part1)) || die 1 'the Preface or Part 1 was not found, so their folios cannot be read'
  expect_at 'Preface opener folio' "$preface" "$FOLIO_Y" 'viii'
  expect_at 'Preface opener head' "$preface" "$HEAD_Y" ''
  expect_at 'Preface recto head' $((preface + 1)) "$HEAD_Y" 'Preface'
  expect_at 'Preface verso head' $((preface + 2)) "$HEAD_Y" 'In search of dharma'
  ((part1 % 2)) && ok "Part 1 opens on a recto (PDF page $part1)" \
    || bad "Part 1 opens on PDF page $part1, which is not a recto"
  expect_at 'Part 1 opener folio' "$part1" "$FOLIO_Y" '1'
  expect_at 'Part 1 second page folio' $((part1 + 1)) "$FOLIO_Y" '2'
  text=$(page_text 7 | tr -s ' .' ' ') || die 1 'could not read page 7'
  [[ $text == *'Preface viii'* && $text == *'1: Defining dharma 1'* ]] \
    && ok 'the contents give the Preface as viii and Part 1 as 1' \
    || bad "the contents give other numbers: $(grep -E -- 'Preface|1: ' <<<"$text" | tr '\n' ' ')"

  # The signature that closes the Preface: flush left, which on a verso is the
  # 20mm outer margin and on a recto the 25mm gutter, and a line space below
  # the text, so two linefeeds of 5.64mm under the line before it. It opens on
  # the name, in bold, whose box is reported as a line of its own.
  local -- signed above
  local -i signed_pg=0 n
  for ((n = preface; n < part1; n+=1)); do
    signed=$("$CHECK" baselines --page "$n" -- "$PDF" \
      | jq -c '([.lines[] | select(.text | test("^Biksu Okusi"))][0]) as $name
          | ([.lines[] | select(.text | test("August 2026, Bali"))][0]) as $rest
          | if $name == null or $rest == null then empty
            else {at: $name, rest: $rest, above: ([.lines[] | select(.y_mm < $rest.y_mm - 1.5)] | last)} end') \
      || die 1 "could not read page $n for the signature"
    [[ -z $signed ]] || { signed_pg=$n; break; }
  done
  if ((signed_pg)); then
    jq -e --argjson left "$(( signed_pg % 2 ? 25 : 20 ))" \
      '(.at.x0_mm - $left | fabs) < 0.3' <<<"$signed" >/dev/null \
      && ok 'the signature stands flush left' \
      || bad "the signature stands at $(jq -r .at.x0_mm <<<"$signed")mm"
    # Measured from the words in italic that follow the name: the bold of the
    # name is another face, whose box ends a little higher.
    above=$(jq -r '.rest.y_mm - .above.y_mm | . * 100 | round / 100' <<<"$signed") \
      || die 1 'could not measure the space above the signature'
    awk -v d="$above" 'BEGIN{exit !(d > 10.9 && d < 11.7)}' \
      && ok "a line space stands above the signature (${above}mm from the line before)" \
      || bad "the signature stands ${above}mm under the line before it, want two linefeeds"
    # The name upright, the author's choice of the two Tuwhiri offered
    # (2026-09-28): no italic of the bold face stands on the page. mutool
    # shortens that face's name to "Work-Sans-Semi-Bold-Ital".
    local -- sig_faces
    sig_faces=$("$CHECK" faces --page "$signed_pg" -- "$PDF" | jq -r '[.faces[].font] | join(" ")') \
      || die 1 'could not read the faces of the signature page'
    [[ $sig_faces != *Semi-Bold-Ital* ]] && ok 'the name in the signature stands upright' \
      || bad 'the name in the signature is set in italic'
  else
    bad 'the signature was not found in the Preface'
  fi

  # Blank versos: those of the text carry the running head and their number.
  local -- blank_text
  local -i blanks=0 numbered=0 pages
  pages=$(pdfinfo -- "$PDF" | awk '/^Pages:/{print $2}') || die 1 "could not count the pages of ${PDF@Q}"
  for ((n = part1 + 1; n < pages - 1; n+=1)); do
    blank_text=$(page_text "$n" | tr -s ' \n' ' ') || die 1 "could not read page $n"
    [[ $blank_text =~ ^\ ?In\ search\ of\ dharma\ ([0-9]+)\ ?$ ]] || continue
    blanks+=1
    ((BASH_REMATCH[1] == n - part1 + 1)) && numbered+=1 ||:  # counted below
  done
  ((blanks > 0 && blanks == numbered)) \
    && ok "the $blanks blank versos of the text carry the running head and their own number" \
    || bad "$numbered of $blanks blank versos carry the running head and their own number"

  # Divided words: none that already has a hyphen, no fragment ending a
  # paragraph, and not the name Tuwhiri marked. Capitalised words may divide.
  local -- divided
  # stderr dropped: the checker sums up there what its report already holds.
  divided=$("$CHECK" breaks -- "$PDF" 2>/dev/null) || die 1 "could not look for divided words in ${PDF@Q}"
  jq -e '[.breaks[] | select(.kind != "capital" or (.word | test("Abra")))] == []' <<<"$divided" >/dev/null \
    && ok 'no compound is divided, no paragraph ends on a fragment, and Abrahamic is whole' \
    || bad "divided against house style: $(jq -c '[.breaks[] | select(.kind != "capital"
         or (.word | test("Abra"))) | [.page, .kind, .word]] | .[0:8]' <<<"$divided")"

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
             "$ROOT"/print-dedication.md "$ROOT"/fonts "$ROOT"/images "$ROOT"/lib; do
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
