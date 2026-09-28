#!/bin/bash
#shellcheck disable=SC2015  # the measure check only printf+append; A&&B||C is safe here
# tests/test-print-style.sh - the print stylesheet puts every baseline on the
# grid measured from Tuwhiri's The secular path to well-being.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

# Resolved, never relative: lib/fonts.sh binds the faces as file://PATH URLs, and
# a relative PATH (tests/../fonts) reads as a host name, so the faces silently
# fail to load and the geometry is measured in a fallback font instead.
#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -i FAILED=0
declare -r TOL=0.1

# Target baselines in mm from the trim top, measured from the model book --
# except the opener, which the publisher set: two line spaces under the title,
# so three 5.644mm linefeeds below its 87.59 baseline.
#
# The folio, as Ramsey asked (2026-09-28) after Tuwhiri's What is this?: on the
# left of every page, beside a 5mm hairline that stands 10mm in from the text's
# left edge, the paragraph indent -- 30mm from the trim on a verso, 35mm on a
# recto. The numeral keeps its baseline. The rule rises 1.24mm above the top of
# a lining figure and runs 1.9mm below the baseline, the proportions of What is
# this? (1.2-1.5mm and 2.0-2.2mm there, measured at 600dpi).
declare -rA TARGET=(
  [title]=87.59 [opener]=104.52 [head]=16.80 [first]=29.53 [folio]=214.38
  [rule_verso_x]=30.00 [rule_recto_x]=35.00 [rule_len]=5.00 [rule_top]=210.54
)

declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

# stop WHAT : a fixture could not be made or read, so what it would have shown
# is not known. The test ends there, and says why.
stop() { >&2 printf '  ✗ %s\n' "$1"; exit 1; }

# render NAME : typeset $TMP/NAME.html as $TMP/NAME.pdf.
# stderr dropped: the renderer's font and anchor warnings are noise in a test
# log. A failed render is not dropped: it stops the test and says which file.
render() {
  weasyprint -- "$TMP/$1".html "$TMP/$1".pdf 2>/dev/null || stop "weasyprint failed on $1.html"
}

# page_lines NAME N : the lines of page N of $TMP/NAME.pdf, as pdfcheck.py
# reports them.
page_lines() { "$CHECK" baselines --page "$2" -- "$TMP/$1".pdf; }

# page_rules NAME N : the hairline rules on page N of $TMP/NAME.pdf.
page_rules() { "$CHECK" rules --page "$2" -- "$TMP/$1".pdf; }

# depth_of NAME : how far each page of $TMP/NAME.pdf falls short of 31 lines.
# stderr dropped: the checker sums up there what its report already holds.
depth_of() {
  "$CHECK" lines --top "$PRINT_TOP_MM" --lead "$PRINT_LEAD_PT" -- "$TMP/$1".pdf 2>/dev/null
}

# fixture_lines N : the lines of page N of the first fixture.
fixture_lines() { page_lines fixture "$1"; }

assert_near() {
  local -- name=$1 got=$2 want=${TARGET[$1]}
  if awk -v g="$got" -v w="$want" -v t="$TOL" 'BEGIN{exit !(g-w<t && w-g<t)}'; then
    printf '  ✓ %-7s %8s (want %s)\n' "$name" "$got" "$want"
  else
    printf '  ✗ %-7s %8s (want %s)\n' "$name" "$got" "$want"; FAILED+=1
  fi
}

# The folio's rule is the one in the foot; an opener also carries a 71mm rule
# above its title.
foot_rule() { page_rules fixture "$1" | jq -c '[.rules[] | select(.y0_mm > 200)][0]'; }

# ink_foot BOX : the foot of the ink inside BOX on the fixture's first page,
# "none" where the box holds no ink.
ink_foot() { "$CHECK" ink --page 1 --box "$1" -- "$TMP"/cap.pdf | jq -r '.ink.y1_mm // "none"'; }

# at_y N Y : the text at height Y on page N, "" where there is none.
at_y() {
  page_lines roman "$1" \
    | jq -r --argjson y "$2" '[.lines[] | select((.y_mm - $y | fabs) < 0.5) | .text] | join(" ")'
}

# page_of TEXT : the first page whose text includes TEXT, 0 if none does.
page_of() {
  local -i n
  for ((n = 1; n <= roman_pages; n+=1)); do
    if pdftotext -f "$n" -l "$n" -- "$TMP"/roman.pdf - | grep -q -F -- "$1"; then
      echo "$n"; return
    fi
  done
  echo 0
}

# expect NAME GOT WANT
expect() {
  [[ $2 == "$3" ]] && printf '  ✓ %s: %s\n' "$1" "${3:-(none)}" \
    || { printf '  ✗ %s: got %s, want %s\n' "$1" "${2:-(none)}" "${3:-(none)}"; FAILED+=1; }
}

# expect_at NAME N Y WANT : the text at height Y on page N is WANT. Several
# of these pass on an empty answer, a page with no folio or no running head,
# so the page is read and the reading checked before it is compared: a reading
# that fails stops the test, and is never taken for an empty page.
expect_at() {
  local -- got
  got=$(at_y "$2" "$3") || stop "could not read page $2 for ${1@Q}"
  expect "$1" "$got" "$4"
}

# faces_of NAME N [FACE] : the faces and sizes of the type on page N of
# $TMP/NAME.pdf, smallest first, as "face size|face size"; with FACE, those
# whose name holds it.
faces_of() {
  "$CHECK" faces --page "$2" -- "$TMP/$1".pdf \
    | jq -r --arg f "${3:-}" '[.faces[] | select(.font | contains($f)) | "\(.font) \(.size | round)"] | join("|")'
}

# expect_no_rule NAME N : page N of the roman fixture carries no hairline.
expect_no_rule() {
  local -- n
  n=$(page_rules roman "$2" | jq '.rules | length') || stop "could not look for rules on page $2"
  expect "$1" "$n" 0
}

# rule_in SHEET REGEX : the first thing in a stylesheet that matches, for a
# failure's message; 'no such rule' where nothing does.
rule_in() {
  if [[ $1 =~ $2 ]]; then printf '%s' "${BASH_REMATCH[0]}"; else printf 'no such rule'; fi
}

# The libraries are sourced here, at file scope, not from main(): they declare
# their globals with plain `declare`, which inside a function would make them
# local to it.
#shellcheck source=SCRIPTDIR/../lib/fonts.sh
source -- "$ROOT"/lib/fonts.sh
font_set_load bonanova-worksans "$ROOT"/fonts
#shellcheck source=SCRIPTDIR/../lib/print-style.sh
source -- "$ROOT"/lib/print-style.sh
print_geom_load

main() {
  local -- tool
  local -i i_
  for tool in weasyprint jq pdffonts pdfinfo pdftotext; do
    command -v "$tool" >/dev/null || { >&2 printf '  ✗ required: %s\n' "$tool"; exit 18; }
  done
  TMP=$(mktemp -d) || stop 'could not make a temporary directory'

  { font_faces_css pdf && print_page_css; } >"$TMP"/print.css || stop 'could not write the stylesheet'

  cat > "$TMP"/fixture.html <<'HTML' || stop 'could not write fixture.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>Preface</h1>
<p class="op"><span class="dc">M</span><span class="sc">ost books</span> that refer to the word 'dharma'
come from one of two places: a monastery or a university, or somewhere in their vicinity. A teacher
hands down a lineage received from their own teacher, or a scholar maps the
territory from a careful distance. This one comes from neither. It was written
by a lifelong anarchist, raised on the remote western rim of Australia: a
naturalised Indonesian now, writing from the island of Bali.</p>
<p>A preface is normally a throat-clearing, the part most sensible readers skip
on the way to Part 1. I would ask you not to skip this one; I have made it
longer than is fashionable on purpose, and the eight parts that follow make
fairly bold assertions about where our worldviews and ethics come from.</p>
<p>A third paragraph, present so the fixture runs onto a second page and the
running head and folio have somewhere to appear for measurement purposes, with
enough text to guarantee the overflow under any reasonable setting whatsoever.
A third paragraph, present so the fixture runs onto a second page and the
running head and folio have somewhere to appear for measurement purposes.</p>
<p>A fourth paragraph, because the book's own faces set tighter than a fallback
font would: it carries the fixture well past the foot of the first page, so
the second page opens with a full line of text beneath its running head, and
its folio sits where every other verso folio in the book sits. A fourth
paragraph, because the book's own faces set tighter than a fallback font would,
and a page that ends early measures nothing at all.</p>
</section></body></html>
HTML

  render fixture

  # The measurements mean something only in the book's own faces. If a face
  # fails to load, WeasyPrint falls back to another font without an error.
  local -- embedded
  embedded=$(pdffonts -- "$TMP"/fixture.pdf) || stop 'could not list the fonts of the fixture'
  if [[ $embedded == *Bona-Nova* && $embedded == *Work-Sans* ]]; then
    printf '  ✓ the fixture is set in Bona Nova and Work Sans\n'
  else
    printf '  ✗ the fixture is not set in the book'"'"'s faces: %s\n' \
      "$(awk 'NR>2{printf "%s ", $1}' <<<"$embedded")"; FAILED+=1
  fi

  echo '== print geometry =='
  assert_near title  "$(fixture_lines 1 | jq -r '.lines[] | select(.text=="Preface") | .y_mm')"
  # The opening line is found by its small-caps lead-in, which lib/dropcap.py
  # emits as <span class="dc">M</span><span class="sc">ost books</span>. The
  # floated drop cap sits on its own baseline, so the line to measure is the one
  # carrying the lead-in text, not the cap.
  assert_near opener "$(fixture_lines 1 | jq -r '[.lines[] | select(.text|startswith("ost books"))][0].y_mm')"
  assert_near head   "$(fixture_lines 2 | jq -r '.lines[0].y_mm')"
  assert_near first  "$(fixture_lines 2 | jq -r '.lines[1].y_mm')"
  assert_near folio  "$(fixture_lines 2 | jq -r '.lines[-1].y_mm')"

  echo '== folio =='
  local -- rule folio_x side
  local -i pg
  for side in verso recto; do
    if [[ $side == verso ]]; then pg=2; else pg=1; fi
    rule=$(foot_rule "$pg") || stop "could not look for the folio rule on page $pg"
    if [[ $rule == null ]]; then
      printf '  ✗ %s: no rule beside the folio\n' "$side"; FAILED+=1; continue
    fi
    assert_near "rule_${side}_x" "$(jq -r .x0_mm <<<"$rule")"
    assert_near rule_len "$(jq -r .len_mm <<<"$rule")"
    assert_near rule_top "$(jq -r .y0_mm <<<"$rule")"
    # The numeral stands just after the rule: 0.65mm of padding, and What is
    # this? shows 0.8mm of white between rule and figure.
    folio_x=$(fixture_lines "$pg" | jq -r '.lines[-1].x0_mm') || stop "could not find the folio on page $pg"
    awk -v f="$folio_x" -v r="$(jq -r .x1_mm <<<"$rule")" 'BEGIN{d=f-r; exit !(d>0.5 && d<1.0)}' \
      && printf '  ✓ %s: the numeral stands just after the rule (%s)\n' "$side" "$folio_x" \
      || { printf '  ✗ %s: the numeral at %s is not just after the rule %s\n' "$side" "$folio_x" "$rule"; FAILED+=1; }
  done
  # Regular, not bold: the folio is the fixture's only Work Sans Regular text.
  if grep -E -q -- '^[A-Z]{6}\+Work-Sans(-Regular)? ' <<<"$embedded"; then
    printf '  ✓ the folio is set in Work Sans Regular\n'
  else
    printf '  ✗ no Work Sans Regular in the fixture: the folio is not regular weight\n'; FAILED+=1
  fi

  echo '== drop cap =='
  # Ramsey (2026-09-28): the cap stands on the baseline of the second line. The
  # two are compared by their ink, not by pdftotext's boxes, whose feet lie a
  # descent below the baseline and so further below for 32pt type than for 10pt.
  # The fixture's lines hold no letter with a descender and no comma, so the
  # foot of a line's ink is its baseline.
  cat > "$TMP"/cap.html <<'HTML' || stop 'could not write cap.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>Coda</h1>
<p class="op"><span class="dc">M</span><span class="sc">ost books</span> hold more than one creed in them. A
teacher hands down a course laid out before him: old rules bound into old
books. Another hand takes them on and alters what it finds there. The old rules
bend a little in each mind which holds them. Hills wear down: rivers move: a
creed does no less. No book can hold it still.</p>
</section></body></html>
HTML
  render cap
  local -- cap_lines cap_w l1 l2 l3 cap_foot l2_foot
  local -- beside cap_box l2_box
  cap_lines=$(page_lines cap 1) || stop 'could not read the drop-cap fixture'
  cap_w=$(jq -c '[.lines[] | select(.text == "M")][0]' <<<"$cap_lines") || stop 'could not find the cap'
  # The three lines beside and below the cap, in order, the cap's own excluded:
  # one object to a line, its white space taken out so that read can split them.
  beside=$(jq -r '[.lines[] | select(.text != "M" and .text != "Coda" and .y_mm < 200)]
    | .[0:3] | map(tojson) | join(" ")' <<<"$cap_lines" | tr -d ' ' | sed 's/}{/} {/g') \
    || stop 'could not find the lines beside the cap'
  read -r l1 l2 l3 <<<"$beside"

  cap_box=$(jq -r --argjson l1 "$l1" --argjson l2 "$l2" \
    '"\(.x0_mm - 0.3),\($l1.y_mm - 9),\(.x1_mm),\($l2.y_mm + 0.3)"' <<<"$cap_w") \
    || stop 'could not place the cap'
  l2_box=$(jq -r '"\(.x0_mm),\(.y_mm - 4),\(.x1_mm + 0.1),\(.y_mm + 0.3)"' <<<"$l2") \
    || stop 'could not place the second line'
  cap_foot=$(ink_foot "$cap_box") || stop 'could not measure the cap'
  l2_foot=$(ink_foot "$l2_box") || stop 'could not measure the second line'
  if awk -v c="$cap_foot" -v l="$l2_foot" -v t="$TOL" \
       'BEGIN{exit !(c != "none" && l != "none" && c-l < t && l-c < t)}'; then
    printf '  ✓ the cap stands on the baseline of the second line (%s, line %s)\n' "$cap_foot" "$l2_foot"
  else
    printf '  ✗ the foot of the cap is at %s, the baseline of the second line at %s\n' \
      "$cap_foot" "$l2_foot"; FAILED+=1
  fi
  # Two lines stand in beside the cap and the third returns to the margin.
  jq -n -e --argjson l1 "$l1" --argjson l2 "$l2" --argjson l3 "$l3" --argjson c "$cap_w" \
    '$l1.x0_mm > $c.x1_mm and $l2.x0_mm > $c.x1_mm and ($l3.x0_mm - $c.x0_mm | fabs) < 0.1' >/dev/null \
    && printf '  ✓ two lines stand beside the cap and the third returns to the margin\n' \
    || { printf '  ✗ the cap does not span two lines: %s %s %s\n' "$l1" "$l2" "$l3"; FAILED+=1; }

  echo '== 31 lines a page =='
  # Ramsey (2026-09-28): every page runs to 31 lines; widows and orphans are dealt
  # with by hand at the very end. A three-line paragraph cannot be split at all
  # while widows and orphans are both held to two lines, so a chapter made of
  # them leaves a page short wherever a page ends inside one.
  local -- three='<p>A paragraph of three lines, which a page may have to end inside: it holds '
  three+='words enough to run past two lines of the measure and into a third.</p>'
  local -- run=''
  for ((i_ = 0; i_ < 45; i_+=1)); do run+=$three; done
  cat > "$TMP"/full.html <<HTML || stop 'could not write full.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>One</h1>$run</section></body></html>
HTML
  render full
  local -- depth
  depth=$(depth_of full) || stop 'could not count the lines of the chapter fixture'
  if jq -e '(.pages | length) >= 4 and .short == []' <<<"$depth" >/dev/null; then
    printf '  ✓ every page of a chapter of three-line paragraphs runs to 31 lines\n'
  else
    printf '  ✗ pages fall short: %s\n' \
      "$(jq -c '[.pages[] | {page, lines, short_by}]' <<<"$depth")"; FAILED+=1
  fi

  # The same holds in the Sources, whose entries are list items, not paragraphs.
  local -- entry='<li>An Author, A Title of Some Length (1999) – a note on what the work is drawn on for here, '
  entry+='long enough to run past two lines of the measure and into a third.</li>'
  run=''
  for ((i_ = 0; i_ < 40; i_+=1)); do run+=$entry; done
  cat > "$TMP"/fullsrc.html <<HTML || stop 'could not write fullsrc.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>One</h1><p>The text.</p>
<div class="sources"><h2 id="sources">Sources</h2><ul>$run</ul></div></section></body></html>
HTML
  render fullsrc
  depth=$(depth_of fullsrc) || stop 'could not count the lines of the list fixture'
  if jq -e '(.pages | length) >= 4 and .short == []' <<<"$depth" >/dev/null; then
    printf '  ✓ every page of a list of three-line entries runs to 31 lines\n'
  else
    printf '  ✗ pages of the list fall short: %s\n' \
      "$(jq -c '[.pages[] | {page, lines, short_by}]' <<<"$depth")"; FAILED+=1
  fi

  echo '== blank verso =='
  # A chapter that ends on a recto leaves the next opener's verso blank. Ramsey
  # (2026-09-28): a blank verso carries the running head and the page number,
  # set as on any other page. mk-print.sh ends Part 1 with the element that
  # carries the number onto the blank pages after it.
  cat > "$TMP"/blank.html <<'HTML' || stop 'could not write blank.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter first"><h1>One</h1><p>A chapter one page long.</p>
<div class="blank-folio"></div></section>
<section class="chapter"><h1>Two</h1><p>The next opener, on a recto.</p></section>
</body></html>
HTML
  render blank
  local -- blank_lines blank_rule
  blank_lines=$(page_lines blank 2) || stop 'could not read the blank verso'
  blank_rule=$(page_rules blank 2 | jq -c '.rules[0]') || stop 'could not look for rules on the blank verso'
  [[ $(jq -r '[.lines[].text] | join("|")' <<<"$blank_lines") == 'in search of dharma|2' ]] \
    && printf '  ✓ the blank verso carries the running head and its page number\n' \
    || { printf '  ✗ the blank verso reads: %s\n' "$(jq -c '[.lines[].text]' <<<"$blank_lines")"; FAILED+=1; }
  assert_near head  "$(jq -r '.lines[0].y_mm' <<<"$blank_lines")"
  assert_near folio "$(jq -r '.lines[-1].y_mm' <<<"$blank_lines")"
  if [[ $blank_rule == null ]]; then
    printf '  ✗ the blank verso has no rule beside its folio\n'; FAILED+=1
  else
    assert_near rule_verso_x "$(jq -r .x0_mm <<<"$blank_rule")"
    assert_near rule_len "$(jq -r .len_mm <<<"$blank_rule")"
    assert_near rule_top "$(jq -r .y0_mm <<<"$blank_rule")"
  fi
  [[ $(faces_of blank 2) == *'Work-Sans 8'* ]] \
    && printf '  ✓ the folio of the blank verso is set in Work Sans Regular, 8pt\n' \
    || { printf '  ✗ the type on the blank verso is: %s\n' "$(faces_of blank 2)"; FAILED+=1; }

  echo '== subheads =='
  # Ramsey (2026-09-28): all Work Sans subheads 1pt smaller. A subhead in the
  # text goes from 12pt to 11pt, one below it from 10pt to 9pt, and a label in
  # the Sources from 10pt to 9pt. The chapter title keeps its 20pt. Read on
  # pages that carry no running head, which is Work Sans SemiBold too.
  cat > "$TMP"/heads.html <<'HTML' || stop 'could not write heads.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>One</h1><p>Text.</p><h2>A subhead</h2><p>Text.</p>
<h3>A lesser subhead</h3><p>Text.</p></section>
<section class="chapter"><h1>Two</h1>
<div class="sources" style="break-before:auto"><p class="label">Key works</p><ul><li>A work.</li></ul></div>
</section></body></html>
HTML
  render heads
  [[ $(faces_of heads 1 Semi) == 'Work-Sans-Semi-Bold 9|Work-Sans-Semi-Bold 11|Work-Sans-Semi-Bold 20' ]] \
    && printf '  ✓ subheads are set at 11pt and 9pt under a 20pt title\n' \
    || { printf '  ✗ the SemiBold sizes on the page are: %s\n' "$(faces_of heads 1 Semi)"; FAILED+=1; }
  [[ $(faces_of heads 3 Semi) == 'Work-Sans-Semi-Bold 9|Work-Sans-Semi-Bold 20' ]] \
    && printf '  ✓ a label in the Sources is set at 9pt\n' \
    || { printf '  ✗ the SemiBold sizes on the Sources page are: %s\n' "$(faces_of heads 3 Semi)"; FAILED+=1; }

  echo '== lists =='
  # Ramsey (2026-09-28, the Coda): every line of a bullet stands 10mm in. A
  # list with blank lines between its entries reaches the stylesheet with each
  # entry wrapped in a paragraph, which must not add its own first-line indent.
  cat > "$TMP"/list.html <<'HTML' || stop 'could not write list.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>One</h1><p>Text.</p>
<ul><li><p><strong>Comprehensive</strong> – it governs a whole life, or a whole domain of one, not a
single slice of behaviour, which is to say a good deal.</p></li>
<li><p>A second entry.</p></li></ul>
</section></body></html>
HTML
  render list
  local -- list_lines first_in next_in
  list_lines=$(page_lines list 1) || stop 'could not read the list fixture'
  # The entry opens on a word in bold, whose box ends a hair above the line's
  # and so is reported on its own; the page is a recto, its text 25mm in.
  first_in=$(jq -r '[.lines[] | select(.text | startswith("Comprehensive"))][0].x0_mm - 25
    | . * 100 | round / 100' <<<"$list_lines") || stop 'could not find the first line of the entry'
  # The entry's second line is the one under its bullet, wherever the first
  # happens to break.
  next_in=$(jq -r '(.lines | map(.text | startswith("• –")) | index(true)) as $i
    | .lines[$i + 1].x0_mm - 25 | . * 100 | round / 100' <<<"$list_lines") \
    || stop 'could not find the second line of the entry'
  awk -v a="$first_in" -v b="$next_in" 'BEGIN{exit !(a > 9.9 && a < 10.1 && b > 9.9 && b < 10.1)}' \
    && printf '  ✓ every line of a bullet stands 10mm in (%s, %s)\n' "$first_in" "$next_in" \
    || { printf '  ✗ a bullet stands %smm in on its first line and %smm on its next\n' \
           "$first_in" "$next_in"; FAILED+=1; }

  echo '== front matter and Preface in roman; page 1 is Part 1 =='
  # Ramsey (2026-09-28): page 1 is the first page of Part 1, and the pages before
  # it take roman numerals. Which of them show one he will say; until then the
  # half-title, title page and imprint show none, and the contents and the
  # Preface do. The Preface's pages carry running heads like any chapter's.
  local -- para='<p>The Preface runs on across several pages, so that its later pages, '
  para+='and the blank before Part 1, have somewhere to appear. '
  para+='The Preface runs on across several pages, so that its later pages have somewhere to appear.</p>'
  local -- preface_body=''
  # Fifteen paragraphs end the Preface on a recto, so a blank verso stands
  # before Part 1.
  for ((i_ = 0; i_ < 15; i_+=1)); do preface_body+=$para; done
  cat > "$TMP"/roman.html <<HTML || stop 'could not write roman.html'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="front">
<div class="halftitle"><p class="ht-title">in search of dharma</p></div>
<div class="titlepage"><p class="tp-title">in search of dharma</p></div>
<div class="imprint"><p>Imprint.</p></div>
<nav class="contents"><h1>Contents</h1><div class="toc-entries">
<p class="roman"><a href="#preface">Preface</a></p>
<p><a href="#part-1">Part 1</a></p>
</div></nav>
</section>
<section class="chapter prelim"><h1 id="preface">Preface</h1>$preface_body</section>
<section class="chapter first"><h1 id="part-1">Part 1</h1><p>Part 1 opens here.</p>
<div class="blank-folio"></div></section>
</body></html>
HTML
  render roman
  local -i roman_pages
  roman_pages=$(pdfinfo -- "$TMP"/roman.pdf | awk '/^Pages:/{print $2}') \
    || stop 'could not count the pages of the roman fixture'

  local -i contents_pg preface_pg part1_pg
  contents_pg=$(page_of 'Contents') || stop 'could not search for the contents'
  preface_pg=$(page_of 'Preface runs on') || stop 'could not search for the Preface'
  part1_pg=$(page_of 'Part 1 opens') || stop 'could not search for Part 1'
  ((contents_pg && preface_pg && part1_pg)) \
    || stop 'the contents, the Preface or Part 1 was not found in the roman fixture'
  expect_at 'half-title folio' 1 "${TARGET[folio]}" ''
  expect_at 'title page folio' 3 "${TARGET[folio]}" ''
  expect_at 'imprint folio' 4 "${TARGET[folio]}" ''
  expect_at 'contents folio' "$contents_pg" "${TARGET[folio]}" 'v'
  expect_at 'Preface opener folio' "$preface_pg" "${TARGET[folio]}" 'vii'
  expect_at 'Preface opener head' "$preface_pg" "${TARGET[head]}" ''
  expect_at 'Preface verso folio' $((preface_pg + 1)) "${TARGET[folio]}" 'viii'
  expect_at 'Preface verso head' $((preface_pg + 1)) "${TARGET[head]}" 'in search of dharma'
  expect_at 'Preface recto head' $((preface_pg + 2)) "${TARGET[head]}" 'Preface'
  expect_at 'Part 1 opener folio' "$part1_pg" "${TARGET[folio]}" '1'
  # The preliminaries' blank versos carry nothing: neither the one between the
  # contents and the Preface nor the one before Part 1. The running head on a
  # blank verso belongs to the text, from Part 1 on.
  expect_at 'blank before the Preface: head' $((preface_pg - 1)) "${TARGET[head]}" ''
  expect_at 'blank before the Preface: folio' $((preface_pg - 1)) "${TARGET[folio]}" ''
  expect_no_rule 'blank before the Preface: rule' $((preface_pg - 1))
  # The page before Part 1 must be a blank one for the two checks to mean
  # anything. pdftotext ends each page with a form feed, which is not text.
  local -- before_part1 other
  before_part1=$(pdftotext -f $((part1_pg - 1)) -l $((part1_pg - 1)) -- "$TMP"/roman.pdf - | tr -d '\f') \
    || stop 'could not read the page before Part 1'
  # grep exits 1 when nothing is left over, which is the blank page looked for.
  other=$(grep -v -x -e 'in search of dharma' -e '' <<<"$before_part1") ||:
  if [[ -z $other ]]; then
    expect_at 'blank before Part 1: head' $((part1_pg - 1)) "${TARGET[head]}" ''
    expect_at 'blank before Part 1: folio' $((part1_pg - 1)) "${TARGET[folio]}" ''
    expect_no_rule 'blank before Part 1: rule' $((part1_pg - 1))
  else
    printf '  ✗ the fixture left no blank verso before Part 1: resize the Preface\n'; FAILED+=1
  fi
  local -- toc
  toc=$(pdftotext -f "$contents_pg" -l "$contents_pg" -layout -- "$TMP"/roman.pdf - | tr -s ' .' ' ') \
    || stop 'could not read the contents page'
  [[ $toc == *'Preface vii'* ]] && printf '  ✓ the contents give the Preface in roman: vii\n' \
    || { printf '  ✗ the contents do not give the Preface as vii: %s\n' "${toc:0:120}"; FAILED+=1; }
  [[ $toc == *'Part 1 1'* ]] && printf '  ✓ the contents give Part 1 as page 1\n' \
    || { printf '  ✗ the contents do not give Part 1 as page 1: %s\n' "${toc:0:120}"; FAILED+=1; }

  # measure and margins, from the widest body line on the verso: the first line
  # may open an indented paragraph, the last may be a short one.
  local -- measure x0 x1
  measure=$(fixture_lines 2 | jq -r '.lines[1:-1] | max_by(.x1_mm - .x0_mm) | [.x0_mm, .x1_mm] | @tsv') \
    || stop 'could not measure the text block'
  read -r x0 x1 <<<"$measure"
  awk -v a="$x0" -v b="$x1" 'BEGIN{w=b-a; exit !(w>106.5 && w<107.5)}' \
    && printf '  ✓ measure %.1fmm\n' "$(awk -v a="$x0" -v b="$x1" 'BEGIN{print b-a}')" \
    || { printf '  ✗ measure is not 107mm (%s..%s)\n' "$x0" "$x1"; FAILED+=1; }

  echo '== the arithmetic behind the stylesheet =='
  # The stylesheet computes three lengths. Each is tried in a shell of its own,
  # given the setting as its arguments, so that a PATH or a locale can be handed
  # to it without touching this script's.
  # SC2016: the text is run by another shell, and $1 and $@ are that shell's
  # arguments, so they must reach it unexpanded.
  #shellcheck disable=SC2016  # expanded by the shell that runs it, not this one
  local -r SHEET='source -- "$1"/lib/fonts.sh && font_set_load bonanova-worksans "$1"/fonts \
    && source -- "$1"/lib/print-style.sh && print_geom_load "${@:2}" 2>/dev/null && print_page_css'
  local -- sheet
  local -i sheet_rc

  # The lengths are read back whatever field separator the caller has set.
  sheet=$(bash -c "IFS=,; $SHEET" _ "$ROOT" 2>&1) && sheet_rc=0 || sheet_rc=$?
  if ((sheet_rc == 0)) && [[ $sheet == *'margin:6.04mm 0 13.46mm 10mm'* ]]; then
    printf '  ✓ the lengths are read whatever the caller has set IFS to\n'
  else
    printf '  ✗ with IFS set to a comma: exit %d, %s\n' "$sheet_rc" "${sheet##*$'\n'}"; FAILED+=1
  fi

  # If awk fails, the stylesheet is refused, not written with its lengths missing.
  mkdir -p -- "$TMP"/noawk "$TMP"/mawk || stop 'could not make the directories for the stand-in awks'
  printf '#!/bin/bash\nexit 1\n' >"$TMP"/noawk/awk || stop 'could not write the failing awk'
  chmod -- +x "$TMP"/noawk/awk || stop 'could not mark the failing awk executable'
  # stderr dropped: the stylesheet says on stderr why it stopped, and what is
  # judged here is that it stopped.
  sheet=$(env PATH="$TMP"/noawk:/usr/local/bin:/usr/bin:/bin bash -c "$SHEET" _ "$ROOT" 2>/dev/null) \
    && sheet_rc=0 || sheet_rc=$?
  if ((sheet_rc != 0)) && [[ $sheet != *'margin:mm'* ]]; then
    printf '  ✓ a failed awk stops the stylesheet\n'
  else
    printf '  ✗ with awk failing the stylesheet was written all the same: exit %d, %s\n' "$sheet_rc" \
      "$(rule_in "$sheet" 'margin:mm[^;]*')"; FAILED+=1
  fi

  # A locale that writes its decimals with a comma, under an awk that follows the
  # locale (mawk does; gawk does not unless asked to). CSS knows only the point.
  # stderr dropped: locale complains of locales it cannot read, none of which is
  # the one looked for.
  if [[ -x /usr/bin/mawk ]] && locale -a 2>/dev/null | grep -q -x -- 'id_ID.utf8'; then
    ln -s -- /usr/bin/mawk "$TMP"/mawk/awk || stop 'could not link mawk in as awk'
    sheet=$(env PATH="$TMP"/mawk:/usr/local/bin:/usr/bin:/bin LC_ALL=id_ID.utf8 \
              bash -c "$SHEET" _ "$ROOT") && sheet_rc=0 || sheet_rc=$?
    if ((sheet_rc == 0)) && [[ $sheet == *'margin:6.04mm 0 13.46mm 10mm'* ]]; then
      printf '  ✓ the lengths keep their decimal point in a comma locale\n'
    else
      printf '  ✗ in a comma locale: exit %d, %s\n' "$sheet_rc" \
        "$(rule_in "$sheet" 'margin:[0-9][^;]*10mm')"; FAILED+=1
    fi
  else
    printf '  ◉ skipped: the comma-locale check needs mawk and the id_ID.utf8 locale\n'
  fi

  # The proof-setting warning. Run in subshells: print_geom_load sets globals.
  local -- warning help opt
  local -a named=()
  warning=$( (print_geom_load) 2>&1 ) || stop 'the shipping setting could not be loaded'
  [[ -z $warning ]] && printf '  ✓ the shipping setting loads without a warning\n' \
    || { printf '  ✗ the shipping setting warned: %s\n' "$warning"; FAILED+=1; }

  warning=$( (print_geom_load 10.5 17) 2>&1 ) || stop 'a proof setting could not be loaded'
  [[ $warning == *10.5pt*17pt* ]] && printf '  ✓ a proof setting warns, naming the setting\n' \
    || { printf '  ✗ a proof setting did not warn with its size and leading: %s\n' "$warning"; FAILED+=1; }

  # It once told the reader to run `mk-print.sh --solve`, an option that was
  # planned and never built. Any option the warning names must be a real one.
  help=$("$ROOT"/mk-print.sh --help) || stop 'mk-print.sh --help failed'
  # The options the warning names, each once. A warning that names none leaves
  # the list empty, which the next line reports.
  while [[ $warning =~ (--[a-z][a-z-]+)(.*) ]]; do
    [[ " ${named[*]} " == *" ${BASH_REMATCH[1]} "* ]] || named+=("${BASH_REMATCH[1]}")
    warning=${BASH_REMATCH[2]}
  done
  ((${#named[@]})) || printf '  ✓ the warning names no option at all\n'
  for opt in "${named[@]}"; do
    [[ $help == *"$opt"* ]] && printf '  ✓ the warning names a real option: %s\n' "$opt" \
      || { printf '  ✗ the warning names %s, which mk-print.sh --help does not list\n' "$opt"; FAILED+=1; }
  done

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
