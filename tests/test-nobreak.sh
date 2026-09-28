#!/bin/bash
#shellcheck disable=SC2015  # pass() only prints, so A && pass || fail is safe here
# tests/test-nobreak.sh - lib/nobreak.py keeps a line from dividing the words
# Tuwhiri's house style would not divide: a word that already has a hyphen,
# the last word of a paragraph, and the words named one by one.
#
# From Ramsey's marks of 2026-09-28, eleven of them "take down": half-con/
# scious, three-quar/ters, in/fra-politics, a paragraph ending oth/er., and
# one name, Abra/hamic. He let a good many other capitalised words be divided
# on pages he was marking, so capitals as such are not protected.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r NB=$ROOT/lib/nobreak.py
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -r OPEN='<span class="nb">' SHUT='</span>'
declare -i FAILED=0 K
declare -- TMP='' TOOL='' FOUND='' PARAS='' WORDS=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; FAILED+=1; }

# stop WHAT : a fixture could not be made or read, so what it would have shown
# is not known. The test ends there, and says why on stderr.
stop() { >&2 printf '  ✗ %s\n' "$1"; exit 1; }

# gives NAME INPUT WANT : the filter turns INPUT into exactly WANT.
gives() {
  local -- got
  got=$(printf '%s' "$2" | "$NB") || { fail "$1: the filter failed"; return; }
  [[ $got == "$3" ]] && pass "$1" || fail "$1"$'\n'"      want: $3"$'\n'"      got:  $got"
}

for TOOL in python3 weasyprint jq; do
  command -v "$TOOL" >/dev/null || { >&2 printf '  ✗ required: %s\n' "$TOOL"; exit 18; }
done

echo '== no break: filter =='
gives 'a word that has a hyphen is kept whole, and the last word too' \
  '<p>a half-conscious creed of a kind</p>' \
  "<p>a ${OPEN}half-conscious$SHUT creed of a ${OPEN}kind$SHUT</p>"
gives 'the last word keeps the full stop that follows it outside' \
  '<p>each half deaf to the other.</p>' \
  "<p>each half deaf to the ${OPEN}other$SHUT.</p>"
gives 'the last word is found inside the emphasis that closes a paragraph' \
  '<p>it was never <em>the dharma</em>.</p>' \
  "<p>it was never <em>the ${OPEN}dharma$SHUT</em>.</p>"
gives 'a named word is kept whole' \
  '<p>So the Abrahamic covenant comes last, as it must.</p>' \
  "<p>So the ${OPEN}Abrahamic$SHUT covenant comes last, as it ${OPEN}must$SHUT.</p>"
gives 'a capital alone does not protect a word' \
  '<p>In New Zealand and in Indonesia both.</p>' \
  "<p>In New Zealand and in Indonesia ${OPEN}both$SHUT.</p>"
gives 'a list entry ends as a paragraph does' \
  '<li>Kane, History of Dharmashastra.</li>' \
  "<li>Kane, History of ${OPEN}Dharmashastra$SHUT.</li>"
gives 'a tag and its attributes are left alone' \
  '<p><a href="https://example.org/a-b">the self-same place</a></p>' \
  "<p><a href=\"https://example.org/a-b\">the ${OPEN}self-same$SHUT ${OPEN}place$SHUT</a></p>"
gives 'a heading is left alone' \
  '<h2 id="x">A self-made thing</h2>' \
  '<h2 id="x">A self-made thing</h2>'
gives 'a dash between words is not a hyphen in a word' \
  '<p>the rule – one of three – holds</p>' \
  "<p>the rule – one of three – ${OPEN}holds$SHUT</p>"
gives 'a paragraph that wraps over lines is read as one' \
  '<p>a creed that is
half-conscious and
old</p>' \
  "<p>a creed that is
${OPEN}half-conscious$SHUT and
${OPEN}old$SHUT</p>"

echo '== no break: as printed =='
TMP=$(mktemp -d) || stop 'could not make a temporary directory'
#shellcheck source=SCRIPTDIR/../lib/fonts.sh
source -- "$ROOT"/lib/fonts.sh
font_set_load bonanova-worksans "$ROOT"/fonts
#shellcheck source=SCRIPTDIR/../lib/print-style.sh
source -- "$ROOT"/lib/print-style.sh
print_geom_load
{ font_faces_css pdf && print_page_css; } >"$TMP"/print.css || stop 'could not write the stylesheet'
# A chapter of paragraphs built to tempt the renderer: long compounds and
# long last words, set in the book's measure, where unprotected they divide.
for ((K = 0; K < 40; K+=1)); do
  printf -v WORDS '%*s' "$K" ''
  PARAS+="<p>${WORDS// /a }A paragraph set to show that a creed held half-consciously, "
  PARAS+='in self-understanding of a public-constitutional and parochial-altruistic kind, is '
  PARAS+='not divided where the line ends, whatever the line, nor in its last word, '
  PARAS+='incomprehensibilities.</p>'
done
FOUND=$(printf '<section class="chapter"><h1>One</h1>%s</section>' "$PARAS" | "$NB") \
  || stop 'the filter failed on the fixture'
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8">'
  printf '<link rel="stylesheet" href="print.css"></head><body>%s</body></html>\n' "$FOUND"
} >"$TMP"/nb.html || stop 'could not write the fixture'
# stderr dropped: the renderer's font and anchor warnings are noise in a test
# log. A failed render is not dropped: it stops the test and says so.
weasyprint -- "$TMP"/nb.html "$TMP"/nb.pdf 2>/dev/null || stop 'weasyprint failed on the fixture'
# stderr dropped: the checker sums up there what its report already holds.
FOUND=$("$CHECK" breaks -- "$TMP"/nb.pdf 2>/dev/null) || stop 'could not read the printed fixture'
jq -e '.breaks == []' <<<"$FOUND" >/dev/null \
  && pass 'printed: no compound and no last word is divided' \
  || fail "printed: divided all the same: $(jq -c '[.breaks[] | [.kind, .word]] | .[0:6]' <<<"$FOUND")"

((FAILED == 0)) || exit 1
#fin
