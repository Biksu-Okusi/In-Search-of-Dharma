#!/bin/bash
#shellcheck disable=SC2015  # pass() only prints, so A && pass || fail is safe here
# tests/test-ligmap.sh - lib/ligmap.py restores the text behind the ffi and ffl
# ligatures after Ghostscript's greyscale conversion, which turns "official"
# into "ofÏcial" in the text layer (Paul Regan, 2026-10-07).
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r LM=$ROOT/lib/ligmap.py FONT=$ROOT/fonts/bonanova/BonaNova-Regular.ttf
declare -i FAILED=0
declare -- TMP='' TOOL='' GOT=''
declare -i BEFORE=0 AFTER=0
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; FAILED+=1; }
# stop WHAT [CODE] : a fixture could not be made or read; the test ends there.
stop() { >&2 printf '  ✗ %s\n' "$1"; exit "${2:-1}"; }

for TOOL in python3 weasyprint gs pdftotext; do
  command -v "$TOOL" >/dev/null || { >&2 printf '  ✗ required: %s\n' "$TOOL"; exit 18; }
done
[[ -f $FONT ]] || stop "no font at $FONT" 3
TMP=$(mktemp -d) || stop 'could not make a temporary directory'

echo '== ligature mappings =='
# Bona Nova sets ffi and ffl as single glyphs: the words below use both.
cat >"$TMP"/in.html <<HTML || stop 'could not write the fixture'
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:B;src:url("file://$FONT")}
@page{size:100mm 100mm;margin:10mm} body{font-family:B;font-size:12pt}
</style></head><body><p>The officials were baffled by the affluent traffic.</p></body></html>
HTML
weasyprint -- "$TMP"/in.html "$TMP"/raw.pdf 2>/dev/null || stop 'weasyprint could not render the fixture'
gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -dProcessColorModel=/DeviceGray \
   -sColorConversionStrategy=Gray -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress \
   -sOutputFile="$TMP"/grey.pdf "$TMP"/raw.pdf || stop 'ghostscript failed'
GOT=$(pdftotext -- "$TMP"/raw.pdf - | tr -s '\n ' ' ') || stop 'could not read the text before Ghostscript'
[[ $GOT == *'officials were baffled by the affluent traffic'* ]] \
  && pass 'before Ghostscript the text reads as typed' || fail "the renderer's own text layer is off: $GOT"
GOT=$(pdftotext -- "$TMP"/grey.pdf - | tr -s '\n ' ' ') || stop 'could not read the text after Ghostscript'
[[ $GOT == *'officials'* && $GOT == *'affluent'* ]] \
  && pass 'this Ghostscript keeps the ligatures readable (nothing to repair)' \
  || pass "Ghostscript damaged the text layer, as expected: ${GOT:0:60}"
"$LM" "$TMP"/raw.pdf "$TMP"/grey.pdf "$TMP"/out.pdf >"$TMP"/log || stop "ligmap.py failed: $(<"$TMP"/log)"
GOT=$(pdftotext -- "$TMP"/out.pdf - | tr -s '\n ' ' ') || stop 'could not read the repaired text'
[[ $GOT == *'officials were baffled by the affluent traffic'* ]] \
  && pass "after the repair the text reads as typed ($(<"$TMP"/log))" \
  || fail "after the repair the text still reads: $GOT"
# The page itself is untouched: the same glyphs are drawn.
# grep -c exits 1 on a count of nought, which the comparison below reports.
BEFORE=$(pdftotext -bbox -- "$TMP"/grey.pdf - | grep -c '<word') || stop 'could not count the words before the repair'
AFTER=$(pdftotext -bbox -- "$TMP"/out.pdf - | grep -c '<word') || stop 'could not count the words after the repair'
((BEFORE == AFTER && AFTER > 0)) && pass "the same words stand on the page ($AFTER)" \
  || fail "the repair changed what is on the page: $BEFORE words before, $AFTER after"

((FAILED == 0)) || { printf '✗ ligature mappings: %d failed\n' "$FAILED"; exit 1; }
printf '✓ ligature mappings: all passed\n'
exit 0
#fin
