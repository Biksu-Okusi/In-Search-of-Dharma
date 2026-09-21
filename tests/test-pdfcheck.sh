#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-pdfcheck.sh - lib/pdfcheck.py accepts a conforming interior and
# rejects each way of breaking conformance.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -i FAILED=0

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }

# assert_fails DESC PDF PATTERN [CHECK_ARGS...]
# Runs `pdfcheck check PDF CHECK_ARGS...`, expecting a non-zero exit whose
# combined output contains PATTERN. Grepping for the specific failure tag,
# not just a non-zero exit, proves the intended rule fired rather than some
# unrelated rule the fixture also happens to break.
assert_fails() {
  local -- desc=$1 pdf=$2 pattern=$3
  shift 3
  local -- out
  if out=$("$CHECK" check "$pdf" "$@" 2>&1); then
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
     -sOutputFile="$2" "$1"
}

# Build a minimal conforming interior: N pages, 152x229mm, black text, blank
# final page. Every page boundary is forced with break-before, not
# break-after: WeasyPrint elides a trailing break-after with nothing
# following it, which would silently collapse the intended page count (a
# 3-page request rendering as 2 real pages, a 2-page request as 1).
make_pdf() {
  local -- out=$1 size=${2:-152mm 229mm} colour=${3:-#000} pages=${4:-2}
  local -- html=$TMP/in.html body='' i
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
@font-face{font-family:BN;src:url(file://$(realpath "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:$size;margin:25mm 20mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:$colour;margin:0}
</style></head><body>$body</body></html>
HTML
  weasyprint "$html" "$out" 2>/dev/null
}

declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== pdfcheck =='

make_pdf "$TMP/good.pdf"
gs_gray "$TMP/good.pdf" "$TMP/good-gray.pdf"

# measure reports the trim
declare -- trim
trim=$("$CHECK" measure "$TMP/good-gray.pdf" \
  | python3 -c 'import json,sys;w,h=json.load(sys.stdin)["trim_mm"];print(f"{w:.1f}x{h:.1f}")')
[[ $trim == 152.0x229.0 ]] && ok "measure reports 152.0x229.0" || bad "measure reported $trim"

# check accepts the conforming file
"$CHECK" check "$TMP/good-gray.pdf" &>/dev/null \
  && ok 'check accepts a conforming interior' \
  || bad 'check rejected a conforming interior'

# check rejects a genuinely odd page count. Confirmed with pdfinfo rather
# than assumed from the fixture's parameters: WeasyPrint can collapse a
# trailing page make_pdf() intended to emit, which would let this assertion
# pass for the wrong reason (a tool whose --require-even does nothing would
# still "pass" if the fixture were secretly even, or if colour failed
# instead). gs-converted to grey so colour cannot be what fails here either.
make_pdf "$TMP/odd.pdf" '152mm 229mm' '#000' 3
declare -i odd_pages
odd_pages=$(pdfinfo "$TMP/odd.pdf" | awk '/^Pages:/ {print $2}')
if ((odd_pages % 2 == 0)); then
  bad "odd.pdf fixture is not odd (pdfinfo reports $odd_pages pages)"
fi
gs_gray "$TMP/odd.pdf" "$TMP/odd-gray.pdf"
assert_fails 'check rejects an odd page count' "$TMP/odd-gray.pdf" 'parity:' --require-even

# check rejects the wrong trim
make_pdf "$TMP/a4.pdf" 'A4'
assert_fails 'check rejects the wrong trim size' "$TMP/a4.pdf" 'trim:'

# check rejects RGB colour (WeasyPrint's native output, before the gs pass)
assert_fails 'check rejects non-grey colour' "$TMP/good.pdf" 'colour:'

# check rejects a MediaBox carrying bleed and crop marks: WeasyPrint's own
# bleed/marks CSS produces exactly the TrimBox-inside-a-larger-MediaBox
# shape this rule exists to catch.
cat >"$TMP/bleed.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$(realpath "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm;bleed:3mm;marks:crop}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Bleed test.</p></body></html>
HTML
weasyprint "$TMP/bleed.html" "$TMP/bleed.pdf" 2>/dev/null
gs_gray "$TMP/bleed.pdf" "$TMP/bleed-gray.pdf"
assert_fails 'check rejects a MediaBox with bleed/crop marks' "$TMP/bleed-gray.pdf" 'boxes:'

# check rejects non-uniform page sizes (page 1 sized differently to the rest)
cat >"$TMP/uneven.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$(realpath "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
@page:first{size:100mm 150mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Page 1.</p><div style="break-before:page"><p>Page 2.</p></div></body></html>
HTML
weasyprint "$TMP/uneven.html" "$TMP/uneven.pdf" 2>/dev/null
gs_gray "$TMP/uneven.pdf" "$TMP/uneven-gray.pdf"
assert_fails 'check rejects non-uniform page sizes' "$TMP/uneven-gray.pdf" 'not uniform'

# check --require-blank-last rejects a non-blank final page
cat >"$TMP/nonblanklast.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$(realpath "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
</style></head><body><p>Page 1 text.</p><div style="break-before:page"><p>Page 2 text.</p></div></body></html>
HTML
weasyprint "$TMP/nonblanklast.html" "$TMP/nonblanklast.pdf" 2>/dev/null
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
   -sOutputFile="$TMP/noembed.pdf" "$TMP/noembed.ps"
assert_fails 'check rejects a non-embedded font' "$TMP/noembed.pdf" 'is not embedded'

# check rejects a colour image, and separately its low resolution: a 100x100
# red square placed at 20mm is both RGB and, at ~127ppi, under the 300ppi
# floor -- one fixture, two independent rule failures to grep for.
convert -size 100x100 xc:red "$TMP/rgb.png"
cat >"$TMP/rgbimg.html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@page{size:152mm 229mm;margin:25mm 20mm}
body{margin:0}
img{width:20mm;height:20mm}
</style></head><body><img src="file://$TMP/rgb.png"></body></html>
HTML
weasyprint "$TMP/rgbimg.html" "$TMP/rgbimg.pdf" 2>/dev/null
assert_fails 'check rejects a colour image' "$TMP/rgbimg.pdf" 'must be grayscale'
assert_fails 'check rejects a low-resolution image' "$TMP/rgbimg.pdf" 'ppi, want'

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
@font-face{font-family:BN;src:url(file://$(realpath -- "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:152mm 229mm;margin:25mm 20mm}
@page:right{margin-left:25mm;margin-right:20mm}
@page:left{margin-left:20mm;margin-right:25mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:#000;margin:0}
p{margin:0;text-align:justify}
$extra_css
</style></head><body><p class="recto">$filler</p>
<p class="verso" style="break-before:page">$filler</p></body></html>
HTML
  # stderr dropped: the renderer's warnings are noise here, and a failed render
  # still stops the suite through set -e.
  weasyprint -- "$TMP/spread.html" "$TMP/spread-rgb.pdf" 2>/dev/null
  gs_gray "$TMP/spread-rgb.pdf" "$out"
}

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

((FAILED == 0)) || exit 1
#fin
