#!/bin/bash
#shellcheck disable=SC2015  # the measure check only printf+append; A&&B||C is safe here
# tests/test-print-style.sh - the print stylesheet puts every baseline on the
# grid measured from Tuwhiri's The secular path to well-being.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -i FAILED=0
declare -r TOL=0.1

# Target baselines in mm from the trim top, measured from the model book.
declare -rA TARGET=(
  [title]=87.59 [opener]=131.13 [head]=16.80 [first]=29.53 [folio]=214.38
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
</section></body></html>
HTML

weasyprint "$TMP"/fixture.html "$TMP"/fixture.pdf 2>/dev/null

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

# measure and margins
measure=$(b 2 | jq -r '[.lines[1].x0_mm, .lines[1].x1_mm] | @tsv')
read -r x0 x1 <<<"$measure"
awk -v a="$x0" -v b="$x1" 'BEGIN{w=b-a; exit !(w>106.5 && w<107.5)}' \
  && printf '  ✓ measure %.1fmm\n' "$(awk -v a="$x0" -v b="$x1" 'BEGIN{print b-a}')" \
  || { printf '  ✗ measure is not 107mm (%s..%s)\n' "$x0" "$x1"; FAILED+=1; }

((FAILED == 0)) || exit 1
#fin
