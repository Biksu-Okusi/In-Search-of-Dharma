#!/bin/bash
#shellcheck disable=SC2015  # the measure check only printf+append; A&&B||C is safe here
# tests/test-print-style.sh - the print stylesheet puts every baseline on the
# grid measured from Tuwhiri's The secular path to well-being.
set -euo pipefail
shopt -s inherit_errexit

# Resolved, never relative: lib/fonts.sh binds the faces as file://PATH URLs, and
# a relative PATH (tests/../fonts) reads as a host name, so the faces silently
# fail to load and the geometry is measured in a fallback font instead.
#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
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
TMP=$(mktemp -d)

#shellcheck source=SCRIPTDIR/../lib/fonts.sh
source "$ROOT"/lib/fonts.sh
font_set_load bonanova-worksans "$ROOT"/fonts
#shellcheck source=SCRIPTDIR/../lib/print-style.sh
source "$ROOT"/lib/print-style.sh
print_geom_load

{ font_faces_css pdf; print_page_css; } > "$TMP"/print.css

cat > "$TMP"/fixture.html <<'HTML'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>Preface</h1>
<p class="op"><span class="dc">M</span><span class="sc">ost books</span> that refer to the word 'dharma' come from one of two
places: a monastery or a university, or somewhere in their vicinity. A teacher
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

weasyprint "$TMP"/fixture.html "$TMP"/fixture.pdf 2>/dev/null

# The measurements mean something only in the book's own faces. If a face
# fails to load, WeasyPrint falls back to another font without an error.
declare -- embedded
embedded=$(pdffonts -- "$TMP"/fixture.pdf)
if [[ $embedded == *Bona-Nova* && $embedded == *Work-Sans* ]]; then
  printf '  ✓ the fixture is set in Bona Nova and Work Sans\n'
else
  printf '  ✗ the fixture is not set in the book'"'"'s faces: %s\n' \
    "$(awk 'NR>2{printf "%s ", $1}' <<<"$embedded")"; FAILED+=1
fi

b() { "$ROOT"/lib/pdfcheck.py baselines "$TMP"/fixture.pdf --page "$1"; }

assert_near() {
  local -- name=$1 got=$2 want=${TARGET[$1]}
  if awk -v g="$got" -v w="$want" -v t="$TOL" 'BEGIN{exit !(g-w<t && w-g<t)}'; then
    printf '  ✓ %-7s %8s (want %s)\n' "$name" "$got" "$want"
  else
    printf '  ✗ %-7s %8s (want %s)\n' "$name" "$got" "$want"; FAILED+=1
  fi
}

echo '== print geometry =='
assert_near title  "$(b 1 | jq -r '.lines[] | select(.text=="Preface") | .y_mm')"
# The opening line is found by its small-caps lead-in, which lib/dropcap.py
# emits as <span class="dc">M</span><span class="sc">ost books</span>. The
# floated drop cap sits on its own baseline, so the line to measure is the one
# carrying the lead-in text, not the cap.
assert_near opener "$(b 1 | jq -r '[.lines[] | select(.text|startswith("ost books"))][0].y_mm')"
assert_near head   "$(b 2 | jq -r '.lines[0].y_mm')"
assert_near first  "$(b 2 | jq -r '.lines[1].y_mm')"
assert_near folio  "$(b 2 | jq -r '.lines[-1].y_mm')"

echo '== folio =='
# The folio's rule is the one in the foot; an opener also carries a 71mm rule
# above its title.
foot_rule() { "$ROOT"/lib/pdfcheck.py rules "$TMP"/fixture.pdf --page "$1" | jq -c '[.rules[] | select(.y0_mm > 200)][0]'; }
declare -- rule folio_x side
declare -i pg
for side in verso recto; do
  if [[ $side == verso ]]; then pg=2; else pg=1; fi
  rule=$(foot_rule "$pg")
  if [[ $rule == null ]]; then
    printf '  ✗ %s: no rule beside the folio\n' "$side"; FAILED+=1; continue
  fi
  assert_near "rule_${side}_x" "$(jq -r .x0_mm <<<"$rule")"
  assert_near rule_len "$(jq -r .len_mm <<<"$rule")"
  assert_near rule_top "$(jq -r .y0_mm <<<"$rule")"
  # The numeral stands just after the rule: 0.65mm of padding, and What is
  # this? shows 0.8mm of white between rule and figure.
  folio_x=$(b "$pg" | jq -r '.lines[-1].x0_mm')
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
cat > "$TMP"/cap.html <<'HTML'
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
weasyprint "$TMP"/cap.html "$TMP"/cap.pdf 2>/dev/null
declare -- cap_lines cap_w l1 l2 l3 cap_foot l2_foot
cap_lines=$("$ROOT"/lib/pdfcheck.py baselines "$TMP"/cap.pdf --page 1)
cap_w=$(jq -c '[.lines[] | select(.text == "M")][0]' <<<"$cap_lines")
# The three lines beside and below the cap, in order, the cap's own excluded.
read -r l1 l2 l3 < <(jq -r '[.lines[] | select(.text != "M" and .text != "Coda" and .y_mm < 200)]
  | .[0:3] | map(tojson) | join(" ")' <<<"$cap_lines" | tr -d ' ' | sed 's/}{/} {/g')
ink_foot() { "$ROOT"/lib/pdfcheck.py ink "$TMP"/cap.pdf --page 1 --box "$1" | jq -r '.ink.y1_mm // "none"'; }
cap_foot=$(ink_foot "$(jq -r --argjson l1 "$l1" --argjson l2 "$l2" \
  '"\(.x0_mm - 0.3),\($l1.y_mm - 9),\(.x1_mm),\($l2.y_mm + 0.3)"' <<<"$cap_w")")
l2_foot=$(ink_foot "$(jq -r '"\(.x0_mm),\(.y_mm - 4),\(.x1_mm + 0.1),\(.y_mm + 0.3)"' <<<"$l2")")
if awk -v c="$cap_foot" -v l="$l2_foot" -v t="$TOL" 'BEGIN{exit !(c != "none" && l != "none" && c-l < t && l-c < t)}'; then
  printf '  ✓ the cap stands on the second line'"'"'s baseline (%s, line %s)\n' "$cap_foot" "$l2_foot"
else
  printf '  ✗ the cap'"'"'s foot is at %s, the second line'"'"'s baseline at %s\n' "$cap_foot" "$l2_foot"; FAILED+=1
fi
# Two lines stand in beside the cap and the third returns to the margin.
jq -n -e --argjson l1 "$l1" --argjson l2 "$l2" --argjson l3 "$l3" --argjson c "$cap_w" \
  '$l1.x0_mm > $c.x1_mm and $l2.x0_mm > $c.x1_mm and ($l3.x0_mm - $c.x0_mm | fabs) < 0.1' >/dev/null \
  && printf '  ✓ two lines stand beside the cap and the third returns to the margin\n' \
  || { printf '  ✗ the cap does not span two lines: %s %s %s\n' "$l1" "$l2" "$l3"; FAILED+=1; }

echo '== blank verso =='
# A chapter that ends on a recto leaves the next opener's verso blank. Ramsey
# (2026-09-28): a blank verso carries the running head too. It still carries no
# folio: he asked for the head alone.
cat > "$TMP"/blank.html <<'HTML'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>One</h1><p>A chapter one page long.</p></section>
<section class="chapter"><h1>Two</h1><p>The next opener, on a recto.</p></section>
</body></html>
HTML
weasyprint "$TMP"/blank.html "$TMP"/blank.pdf 2>/dev/null
declare -- blank_lines
blank_lines=$("$ROOT"/lib/pdfcheck.py baselines "$TMP"/blank.pdf --page 2)
[[ $(jq -r '[.lines[].text] | join("|")' <<<"$blank_lines") == 'in search of dharma' ]] \
  && printf '  ✓ the blank verso carries the running head and nothing else\n' \
  || { printf '  ✗ the blank verso reads: %s\n' "$(jq -c '[.lines[].text]' <<<"$blank_lines")"; FAILED+=1; }
[[ $("$ROOT"/lib/pdfcheck.py rules "$TMP"/blank.pdf --page 2 | jq '.rules | length') == 0 ]] \
  && printf '  ✓ the blank verso has no folio rule\n' \
  || { printf '  ✗ the blank verso carries a folio rule\n'; FAILED+=1; }

echo '== front matter and Preface in roman; page 1 is Part 1 =='
# Ramsey (2026-09-28): page 1 is the first page of Part 1, and the pages before
# it take roman numerals. Which of them show one he will say; until then the
# half-title, title page and imprint show none, and the contents and the
# Preface do. The Preface's pages carry running heads like any chapter's.
declare -- para='<p>The Preface runs on across several pages, so that its later pages, and the blank before Part 1, have somewhere to appear. The Preface runs on across several pages, so that its later pages have somewhere to appear.</p>'
declare -- preface_body=''
declare -i i_
# Fifteen paragraphs end the Preface on a recto, so a blank verso stands
# before Part 1.
for ((i_ = 0; i_ < 15; i_+=1)); do preface_body+=$para; done
cat > "$TMP"/roman.html <<HTML
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
<section class="chapter first"><h1 id="part-1">Part 1</h1><p>Part 1 opens here.</p></section>
</body></html>
HTML
weasyprint "$TMP"/roman.html "$TMP"/roman.pdf 2>/dev/null
declare -i roman_pages
roman_pages=$(pdfinfo "$TMP"/roman.pdf | awk '/^Pages:/{print $2}')
# The text at a page's folio and running-head positions, "" where none.
at_y() { "$ROOT"/lib/pdfcheck.py baselines "$TMP"/roman.pdf --page "$1" \
  | jq -r --argjson y "$2" '[.lines[] | select((.y_mm - $y | fabs) < 0.5) | .text] | join(" ")'; }
page_of() { # the first page whose text includes $1
  local -i n
  for ((n = 1; n <= roman_pages; n+=1)); do
    pdftotext -f "$n" -l "$n" "$TMP"/roman.pdf - | grep -q -F -- "$1" && { echo "$n"; return; }
  done
  echo 0
}
expect() { # expect <name> <got> <want>
  [[ $2 == "$3" ]] && printf '  ✓ %s: %s\n' "$1" "${3:-(none)}" \
    || { printf '  ✗ %s: got %s, want %s\n' "$1" "${2:-(none)}" "${3:-(none)}"; FAILED+=1; }
}
declare -i contents_pg preface_pg part1_pg
contents_pg=$(page_of 'Contents') preface_pg=$(page_of 'Preface runs on') part1_pg=$(page_of 'Part 1 opens')
expect 'half-title folio' "$(at_y 1 "${TARGET[folio]}")" ''
expect 'title page folio' "$(at_y 3 "${TARGET[folio]}")" ''
expect 'imprint folio' "$(at_y 4 "${TARGET[folio]}")" ''
expect 'contents folio' "$(at_y "$contents_pg" "${TARGET[folio]}")" 'v'
expect 'Preface opener folio' "$(at_y "$preface_pg" "${TARGET[folio]}")" 'vii'
expect 'Preface opener head' "$(at_y "$preface_pg" "${TARGET[head]}")" ''
expect 'Preface verso folio' "$(at_y $((preface_pg + 1)) "${TARGET[folio]}")" 'viii'
expect 'Preface verso head' "$(at_y $((preface_pg + 1)) "${TARGET[head]}")" 'in search of dharma'
expect 'Preface recto head' "$(at_y $((preface_pg + 2)) "${TARGET[head]}")" 'Preface'
expect 'Part 1 opener folio' "$(at_y "$part1_pg" "${TARGET[folio]}")" '1'
# The blank verso between the contents and the Preface belongs to the front
# matter and carries nothing; the one before Part 1 is a blank verso like any
# between chapters, with its running head and no folio.
expect 'blank before the Preface: head' "$(at_y $((preface_pg - 1)) "${TARGET[head]}")" ''
expect 'blank before the Preface: folio' "$(at_y $((preface_pg - 1)) "${TARGET[folio]}")" ''
# pdftotext ends each page with a form feed, which is not text.
if [[ -z $(pdftotext -f $((part1_pg - 1)) -l $((part1_pg - 1)) "$TMP"/roman.pdf - | tr -d '\f' \
           | grep -v -x -e 'in search of dharma' -e '' || true) ]]; then
  expect 'blank before Part 1: head' "$(at_y $((part1_pg - 1)) "${TARGET[head]}")" 'in search of dharma'
  expect 'blank before Part 1: folio' "$(at_y $((part1_pg - 1)) "${TARGET[folio]}")" ''
else
  printf '  ✗ the fixture left no blank verso before Part 1: resize the Preface\n'; FAILED+=1
fi
declare -- toc
toc=$(pdftotext -f "$contents_pg" -l "$contents_pg" -layout "$TMP"/roman.pdf - | tr -s ' .' ' ')
[[ $toc == *'Preface vii'* ]] && printf '  ✓ the contents give the Preface in roman: vii\n' \
  || { printf '  ✗ the contents do not give the Preface as vii: %s\n' "$(grep Preface <<<"$toc")"; FAILED+=1; }
[[ $toc == *'Part 1 1'* ]] && printf '  ✓ the contents give Part 1 as page 1\n' \
  || { printf '  ✗ the contents do not give Part 1 as page 1: %s\n' "$(grep 'Part 1' <<<"$toc")"; FAILED+=1; }

# measure and margins, from the widest body line on the verso: the first line
# may open an indented paragraph, the last may be a short one.
measure=$(b 2 | jq -r '.lines[1:-1] | max_by(.x1_mm - .x0_mm) | [.x0_mm, .x1_mm] | @tsv')
read -r x0 x1 <<<"$measure"
awk -v a="$x0" -v b="$x1" 'BEGIN{w=b-a; exit !(w>106.5 && w<107.5)}' \
  && printf '  ✓ measure %.1fmm\n' "$(awk -v a="$x0" -v b="$x1" 'BEGIN{print b-a}')" \
  || { printf '  ✗ measure is not 107mm (%s..%s)\n' "$x0" "$x1"; FAILED+=1; }

# The proof-setting warning. Run in subshells: print_geom_load sets globals.
declare -- warning help opt
declare -a named=()
warning=$( (print_geom_load) 2>&1 )
[[ -z $warning ]] && printf '  ✓ the shipping setting loads without a warning\n' \
  || { printf '  ✗ the shipping setting warned: %s\n' "$warning"; FAILED+=1; }

warning=$( (print_geom_load 10.5 17) 2>&1 )
[[ $warning == *10.5pt*17pt* ]] && printf '  ✓ a proof setting warns, naming the setting\n' \
  || { printf '  ✗ a proof setting did not warn with its size and leading: %s\n' "$warning"; FAILED+=1; }

# It once told the reader to run `mk-print.sh --solve`, an option that was
# planned and never built. Any option the warning names must be a real one.
help=$("$ROOT"/mk-print.sh --help)
readarray -t named < <(grep -oE -- '--[a-z][a-z-]+' <<<"$warning" | sort -u)
((${#named[@]})) || printf '  ✓ the warning names no option at all\n'
for opt in "${named[@]}"; do
  [[ $help == *"$opt"* ]] && printf '  ✓ the warning names a real option: %s\n' "$opt" \
    || { printf '  ✗ the warning names %s, which mk-print.sh --help does not list\n' "$opt"; FAILED+=1; }
done

((FAILED == 0)) || exit 1
#fin
