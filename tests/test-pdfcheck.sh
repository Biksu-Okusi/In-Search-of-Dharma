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

# Build a minimal conforming interior: 2 pages, 152x229mm, black text, blank
# final page.
make_pdf() {
  local -- out=$1 size=${2:-152mm 229mm} colour=${3:-#000} pages=${4:-2}
  local -- html=$TMP/in.html body='' i
  for ((i = 1; i < pages; i += 1)); do
    body+="<p>Page $i text.</p><p style=\"break-after:page\"></p>"
  done
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
gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -dProcessColorModel=/DeviceGray \
   -sColorConversionStrategy=Gray -dCompatibilityLevel=1.6 -dSubsetFonts=true \
   -dEmbedAllFonts=true -dAutoRotatePages=/None \
   -sOutputFile="$TMP/good-gray.pdf" "$TMP/good.pdf"

# measure reports the trim
trim=$("$CHECK" measure "$TMP/good-gray.pdf" \
  | python3 -c 'import json,sys;w,h=json.load(sys.stdin)["trim_mm"];print(f"{w:.1f}x{h:.1f}")')
[[ $trim == 152.0x229.0 ]] && ok "measure reports 152.0x229.0" || bad "measure reported $trim"

# check accepts the conforming file
"$CHECK" check "$TMP/good-gray.pdf" &>/dev/null \
  && ok 'check accepts a conforming interior' \
  || bad 'check rejected a conforming interior'

# check rejects an odd page count. --require-even is mandatory here: without it
# the rule is never armed and this test would pass against a tool that does
# nothing at all.
make_pdf "$TMP/odd.pdf" '152mm 229mm' '#000' 3
"$CHECK" check "$TMP/odd.pdf" --require-even &>/dev/null \
  && bad 'check accepted an odd page count' \
  || ok 'check rejects an odd page count'

# check rejects the wrong trim
make_pdf "$TMP/a4.pdf" 'A4'
"$CHECK" check "$TMP/a4.pdf" &>/dev/null \
  && bad 'check accepted the wrong trim size' \
  || ok 'check rejects the wrong trim size'

# check rejects RGB colour (WeasyPrint's native output, before the gs pass)
"$CHECK" check "$TMP/good.pdf" &>/dev/null \
  && bad 'check accepted non-grey colour' \
  || ok 'check rejects non-grey colour'

((FAILED == 0)) || exit 1
#fin
