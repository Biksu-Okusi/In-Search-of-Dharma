#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-pdfcheck.sh - lib/pdfcheck.py accepts a conforming interior and
# rejects each way of breaking conformance.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

# Canonical, so the test runs the same from any directory and however it is
# named on the command line; ROOT is absolute and needs no realpath later.
#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -i FAILED=0
declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# render HTML PDF
# stderr dropped: the renderer's font and anchor warnings are noise in a test
# log. A failed render is not dropped: it stops the suite and says which file.
render() {
  weasyprint -- "$1" "$2" 2>/dev/null || die 1 "weasyprint failed on ${1@Q}"
}

# assert_fails DESC PDF PATTERN [CHECK_ARGS...]
# Runs `pdfcheck check CHECK_ARGS... -- PDF`, expecting a non-zero exit whose
# combined output contains PATTERN. Grepping for the specific failure tag,
# not just a non-zero exit, proves the intended rule fired rather than some
# unrelated rule the fixture also happens to break.
assert_fails() {
  local -- desc=$1 pdf=$2 pattern=$3
  shift 3
  local -- out
  if out=$("$CHECK" check "$@" -- "$pdf" 2>&1); then
    bad "$desc (check exited 0)"
  elif [[ $out == *"$pattern"* ]]; then
    ok "$desc"
  else
    bad "$desc (unexpected output: $out)"
  fi
}

gs_gray() {
  gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -dProcessColorModel=/DeviceGray \
     -sColorConversionStrategy=Gray -dCompatibilityLevel=1.6 -dSubsetFonts=true \
     -dEmbedAllFonts=true -dAutoRotatePages=/None \
     -sOutputFile="$2" "$1" || die 1 "greyscale conversion failed on ${1@Q}"
}

# Build a minimal conforming interior: N pages, 152x229mm, black text, blank
# final page. Every page boundary is forced with break-before, not
# break-after: WeasyPrint elides a trailing break-after with nothing
# following it, which would silently collapse the intended page count (a
# 3-page request rendering as 2 real pages, a 2-page request as 1).
make_pdf() {
  local -- out=$1 size=${2:-152mm 229mm} colour=${3:-#000}
  local -i pages=${4:-2} i
  local -- html=$TMP/in.html body=''
  for ((i = 1; i < pages; i += 1)); do
    if ((i == 1)); then
      body+="<p>Page $i text.</p>"
    else
      body+="<div style=\"break-before:page\"><p>Page $i text.</p></div>"
    fi
  done
  body+='<div style="break-before:page"></div>'
  cat >"$html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:$size;margin:25mm 20mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:$colour;margin:0}
</style></head><body>$body</body></html>
HTML
  render "$html" "$out"
}

# check --measure: no line may run outside the text block. The block is
# mirrored across the spread, so the fixtures are too: page 1 is a recto with
# the inner margin on its left, page 2 a verso with it on its right. EXTRA_CSS
# is where each fixture breaks the rule, or does not.
make_spread() {
  local -- out=$1 extra_css=${2:-}
  local -- filler='Words enough to fill several justified lines of the measure, '
  filler+=$filler$filler$filler$filler$filler
  cat >"$TMP/spread.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
@page:right{margin-left:25mm;margin-right:20mm}
@page:left{margin-left:20mm;margin-right:25mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
p{margin:0;text-align:justify}
$extra_css
</style></head><body><p class="recto">$filler</p>
<p class="verso" style="break-before:page">$filler</p></body></html>
HTML
  render "$TMP/spread.html" "$TMP/spread-rgb.pdf"
  gs_gray "$TMP/spread-rgb.pdf" "$out"
}

main() {
  echo '== pdfcheck =='

  local -- cmd
  for cmd in python3 weasyprint gs pdfinfo convert mutool pdftotext; do
    command -v "$cmd" >/dev/null || die 18 "required: ${cmd@Q}"
  done
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'

  make_pdf "$TMP/good.pdf"
  gs_gray "$TMP/good.pdf" "$TMP/good-gray.pdf"

  local -- trim
  trim=$("$CHECK" measure -- "$TMP/good-gray.pdf" \
    | python3 -c 'import json,sys;w,h=json.load(sys.stdin)["trim_mm"];print(f"{w:.1f}x{h:.1f}")') \
    || die 1 'pdfcheck measure failed on the conforming fixture'
  [[ $trim == 152.0x229.0 ]] && ok 'measure reports 152.0x229.0' || bad "measure reported $trim"

  "$CHECK" check -- "$TMP/good-gray.pdf" &>/dev/null \
    && ok 'check accepts a conforming interior' \
    || bad 'check rejected a conforming interior'

  # check rejects a genuinely odd page count. Confirmed with pdfinfo rather
  # than assumed from the fixture's parameters: WeasyPrint can collapse a
  # trailing page make_pdf() intended to emit, which would let this assertion
  # pass for the wrong reason (a tool whose --require-even does nothing would
  # still "pass" if the fixture were secretly even, or if colour failed
  # instead). gs-converted to grey so colour cannot be what fails here either.
  make_pdf "$TMP/odd.pdf" '152mm 229mm' '#000' 3
  local -i odd_pages
  odd_pages=$(pdfinfo -- "$TMP/odd.pdf" | awk '/^Pages:/ {print $2}') \
    || die 1 'pdfinfo failed on the odd-page fixture'
  if ((odd_pages % 2 == 0)); then
    bad "odd.pdf fixture is not odd (pdfinfo reports $odd_pages pages)"
  fi
  gs_gray "$TMP/odd.pdf" "$TMP/odd-gray.pdf"
  assert_fails 'check rejects an odd page count' "$TMP/odd-gray.pdf" 'parity:' --require-even

  make_pdf "$TMP/a4.pdf" 'A4'
  assert_fails 'check rejects the wrong trim size' "$TMP/a4.pdf" 'trim:'

  # check rejects RGB colour (WeasyPrint's native output, before the gs pass)
  assert_fails 'check rejects non-grey colour' "$TMP/good.pdf" 'colour:'

  # check rejects a MediaBox carrying bleed and crop marks: WeasyPrint's own
  # bleed/marks CSS produces exactly the TrimBox-inside-a-larger-MediaBox
  # shape this rule exists to catch.
  cat >"$TMP/bleed.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm;bleed:3mm;marks:crop}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Bleed test.</p></body></html>
HTML
  render "$TMP/bleed.html" "$TMP/bleed.pdf"
  gs_gray "$TMP/bleed.pdf" "$TMP/bleed-gray.pdf"
  assert_fails 'check rejects a MediaBox with bleed/crop marks' "$TMP/bleed-gray.pdf" 'boxes:'

  # check rejects non-uniform page sizes (page 1 sized differently to the rest)
  cat >"$TMP/uneven.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
@page:first{size:100mm 150mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Page 1.</p><div style="break-before:page"><p>Page 2.</p></div></body></html>
HTML
  render "$TMP/uneven.html" "$TMP/uneven.pdf"
  gs_gray "$TMP/uneven.pdf" "$TMP/uneven-gray.pdf"
  assert_fails 'check rejects non-uniform page sizes' "$TMP/uneven-gray.pdf" 'not uniform'

  cat >"$TMP/nonblanklast.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Page 1 text.</p><div style="break-before:page"><p>Page 2 text.</p></div></body></html>
HTML
  render "$TMP/nonblanklast.html" "$TMP/nonblanklast.pdf"
  gs_gray "$TMP/nonblanklast.pdf" "$TMP/nonblanklast-gray.pdf"
  assert_fails 'check --require-blank-last rejects a non-blank final page' \
    "$TMP/nonblanklast-gray.pdf" 'last-page:' --require-blank-last

  # check rejects a non-embedded font. Built directly with Ghostscript from a
  # one-line PostScript program referencing a bare base-14 name (Helvetica):
  # WeasyPrint always embeds whatever font it resolves, so producing a
  # genuinely unembedded font needs a tool that will not.
  cat >"$TMP/noembed.ps" <<'PS'
%!PS
<< /PageSize [430.866 649.134] >> setpagedevice
/Helvetica findfont 24 scalefont setfont
100 500 moveto (Hello) show
showpage
PS
  gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -dEmbedAllFonts=false \
     -sOutputFile="$TMP/noembed.pdf" "$TMP/noembed.ps" \
    || die 1 'failed to build the unembedded-font fixture'
  assert_fails 'check rejects a non-embedded font' "$TMP/noembed.pdf" 'is not embedded'

  # check rejects a colour image, and separately its low resolution: a 100x100
  # red square placed at 20mm is both RGB and, at ~127ppi, under the 300ppi
  # floor -- one fixture, two independent rule failures to grep for.
  convert -size 100x100 xc:red "$TMP/rgb.png" || die 1 'failed to build the colour-image fixture'
  cat >"$TMP/rgbimg.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@page{size:152mm 229mm;margin:25mm 20mm}
body{margin:0}
img{width:20mm;height:20mm}
</style></head><body><img src="file://$TMP/rgb.png"></body></html>
HTML
  render "$TMP/rgbimg.html" "$TMP/rgbimg.pdf"
  assert_fails 'check rejects a colour image' "$TMP/rgbimg.pdf" 'must be grayscale'
  assert_fails 'check rejects a low-resolution image' "$TMP/rgbimg.pdf" 'ppi, want'

  make_spread "$TMP/spread.pdf"
  "$CHECK" check --measure 107 --inner 25 -- "$TMP/spread.pdf" &>/dev/null \
    && ok 'check --measure accepts text set within a mirrored measure' \
    || bad 'check --measure rejected text set within the measure'

  make_spread "$TMP/past-right.pdf" '.recto{margin-right:-0.3mm}'
  assert_fails 'check --measure rejects a recto line 0.3mm past the right of the measure' \
    "$TMP/past-right.pdf" 'measure: page 1' --measure 107 --inner 25

  # The same paragraph is in bounds on a recto and out of bounds on a verso only
  # if the block really is mirrored: this one starts 0.3mm left of the verso's
  # 20mm outer margin, which would sit well inside a recto's measure.
  make_spread "$TMP/past-left.pdf" '.verso{margin-left:-0.3mm}'
  assert_fails 'check --measure mirrors the block: rejects a verso line 0.3mm past the left' \
    "$TMP/past-left.pdf" 'measure: page 2' --measure 107 --inner 25

  # Renderer and Ghostscript rounding put ordinary justified lines up to about
  # 0.03mm past the edge; the rule's stated tolerance is 0.05mm.
  make_spread "$TMP/within-tol.pdf" '.recto{margin-right:-0.03mm}'
  "$CHECK" check --measure 107 --inner 25 -- "$TMP/within-tol.pdf" &>/dev/null \
    && ok 'check --measure tolerates 0.03mm, inside its 0.05mm tolerance' \
    || bad 'check --measure rejected a 0.03mm overrun'

  # rules: vertical hairlines, found by their ink. A 5mm folio rule and a 71mm
  # opener rule are reported; text beside them, whose stems are short or wide,
  # is not.
  cat >"$TMP/rules.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:0}
body{margin:0;font-family:BN;font-size:10pt;line-height:16pt}
div.r{position:absolute;width:0;border-left:0.4pt solid #000}
p{position:absolute;left:40mm;top:100mm;width:80mm;margin:0;font-size:20pt}
</style></head><body>
<div class="r" style="left:30mm;top:210mm;height:5mm"></div>
<div class="r" style="left:35mm;top:15mm;height:71mm"></div>
<p>Lifelong ledger: filled halls, bold kilns.</p>
</body></html>
HTML
  render "$TMP/rules.html" "$TMP/rules.pdf"
  local -- found
  found=$("$CHECK" rules "$TMP/rules.pdf" --page 1 2>/dev/null) || found='{"rules":[]}'
  jq -e '.rules | length == 2' <<<"$found" >/dev/null \
    && ok 'rules finds the two hairlines and no letter stem' \
    || bad "rules did not find exactly the two hairlines: $(jq -c . <<<"$found")"
  jq -e '.rules[0] | (.x0_mm - 30 | fabs) < 0.1 and (.y0_mm - 210 | fabs) < 0.1
         and (.len_mm - 5 | fabs) < 0.1' <<<"$found" >/dev/null \
    && ok 'rules reports a 5mm rule at x 30mm, from 210mm down' \
    || bad "rules misplaced the 5mm rule: $(jq -c '.rules[0]' <<<"$found")"
  jq -e '.rules[1] | (.x0_mm - 35 | fabs) < 0.1 and (.len_mm - 71 | fabs) < 0.1' <<<"$found" >/dev/null \
    && ok 'rules reports the 71mm rule at x 35mm' \
    || bad "rules misplaced the 71mm rule: $(jq -c '.rules[1]' <<<"$found")"

  # ink: the extent of the ink inside a box given in mm, which is how a drop
  # cap's foot is measured. A box around the 5mm rule returns the rule; a box
  # over white paper returns null.
  found=$("$CHECK" ink "$TMP/rules.pdf" --page 1 --box 28,205,32,220 2>/dev/null) || found='{}'
  jq -e '.ink | (.y0_mm - 210 | fabs) < 0.05 and (.y1_mm - 215 | fabs) < 0.05
         and (.x0_mm - 30 | fabs) < 0.05' <<<"$found" >/dev/null \
    && ok 'ink reports the extent of the ink inside a box' \
    || bad "ink misreported the rule inside the box: $(jq -c . <<<"$found")"
  found=$("$CHECK" ink "$TMP/rules.pdf" --page 1 --box 100,150,120,170 2>/dev/null) || found='{}'
  jq -e 'has("ink") and .ink == null' <<<"$found" >/dev/null \
    && ok 'ink reports null for a box of white paper' \
    || bad "ink did not report null for white paper: $(jq -c . <<<"$found")"

  # lines: how many lines a page falls short of the full 31 at its foot, and
  # whether that is excused. Ramsey's rule (2026-09-28): 31 lines a page, except
  # where the next page opens with a subhead or starts a new chapter.
  #   p1 front matter, p2 opener (full), p3 31 lines, p4 30 lines then text,
  #   p5 25 lines then a subhead, p6 subhead and 10 lines then a chapter,
  #   p7 the last chapter's opener, which ends the book.
  local -- body='' n
  run_of() { local -i k; for ((k = 1; k <= $1; k+=1)); do body+="<p>Line $k of the run.</p>"; done; }
  body+='<div class="front"><p>Contents</p><p>Preface</p></div>'
  body+='<h1>One</h1>';                                   run_of 29
  run_of 31
  run_of 30
  body+='<p style="break-before:page">A new page.</p>';   run_of 24
  body+='<h2 style="break-before:page">A subhead</h2>';   run_of 10
  body+='<h1>Two</h1>';                                   run_of 3
  cat >"$TMP/lines.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$ROOT/fonts/bonanova/BonaNova-Regular.ttf)}
@font-face{font-family:"Work Sans";font-weight:600;src:url(file://$ROOT/fonts/worksans/WorkSans-SemiBold.ttf)}
@page{size:152mm 229mm;margin:24.58mm 20mm 24.5mm 25mm;
  @top-left{content:"running head";font:9pt BN;vertical-align:top;padding-top:13.35mm}
  @bottom-left{content:counter(page);font:8pt BN;vertical-align:top;padding-top:6.8mm}}
body{font-family:BN;font-size:10pt;line-height:16pt;margin:0}
p{margin:0;widows:1;orphans:1}
.front{break-after:page}
h1{font:600 20pt/32pt "Work Sans";margin:0;break-before:page}
h2{font:600 12pt/16pt "Work Sans";margin:0}
</style></head><body>$body</body></html>
HTML
  render "$TMP/lines.html" "$TMP/lines.pdf"
  found=$("$CHECK" lines "$TMP/lines.pdf" 2>/dev/null) || found='{}'
  n=$(jq -c '[.short[]?.page]' <<<"$found")
  [[ $n == '[4]' ]] && ok 'lines flags the one page that is short with no excuse' \
    || bad "lines flagged $n, want [4]: $(jq -c '.pages' <<<"$found")"
  jq -e '.short[0].short_by == 1' <<<"$found" >/dev/null \
    && ok 'lines says the page is one line short' \
    || bad "lines misjudged how short page 4 is: $(jq -c '.short' <<<"$found")"
  jq -e '[.pages[] | select(.page == 2 or .page == 3) | .short_by] == [0, 0]' <<<"$found" >/dev/null \
    && ok 'lines finds an opener and a text page full' \
    || bad "lines misjudged the full pages: $(jq -c '[.pages[] | select(.page < 4)]' <<<"$found")"
  jq -e '[.pages[] | select(.page == 5)][0] | .short_by == 6 and (.excused | test("subhead"))' <<<"$found" >/dev/null \
    && ok 'lines excuses a page before a subhead' \
    || bad "lines did not excuse page 5: $(jq -c '[.pages[] | select(.page == 5)]' <<<"$found")"
  jq -e '[.pages[] | select(.page == 6)][0] | .short_by > 0 and (.excused | test("chapter"))' <<<"$found" >/dev/null \
    && ok 'lines excuses the last page of a chapter' \
    || bad "lines did not excuse page 6: $(jq -c '[.pages[] | select(.page == 6)]' <<<"$found")"
  jq -e '([.pages[].page] | index(1)) == null' <<<"$found" >/dev/null \
    && ok 'lines leaves the front matter out' \
    || bad 'lines reported on the front matter'

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
