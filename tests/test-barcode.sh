#!/bin/bash
# tests/test-barcode.sh - tools/mk-barcode.py draws the symbol a scanner reads,
# and refuses numbers that are not what they claim to be.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r MK=$TEST_DIR/../tools/mk-barcode.py
declare -i FAILED=0
declare -- TMP=''

trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== barcode =='

# The module patterns below are pinned from a symbol that an independent
# decoder (zxing-cpp, 2026-09-21) read back as 9798998067600 + 90000. Nothing
# here re-derives them from the encoder's own tables, so a slip in a table or
# in the parity logic moves a pattern and fails the test.
declare -r WANT_13=10101110110010111000100100010110010111011011101010111001010100001000100101000011100101110010101
declare -r WANT_5=10110001011010100111010001101010100111010001101

declare -- got
got=$(cd -- "$TEST_DIR"/../tools && python3 -c '
import importlib
mk = importlib.import_module("mk-barcode")
print(mk.ean13_modules("9798998067600")); print(mk.ean5_modules("90000"))')
if [[ $got == "$WANT_13"$'\n'"$WANT_5" ]]; then
  printf '  ✓ the EAN-13 and add-on modules match the scanned symbol\n'
else
  printf '  ✗ the module patterns have moved\n'; FAILED+=1
fi

"$MK" 979-8-9980676-0-0 -o "$TMP"/b.svg
if python3 -c 'import sys, xml.dom.minidom as m; m.parse(sys.argv[1])' "$TMP"/b.svg; then
  printf '  ✓ the SVG is well-formed\n'
else
  printf '  ✗ the SVG does not parse\n'; FAILED+=1
fi

# 11 quiet + 95 + 9 gap + 47 add-on + 5 quiet = 167 modules of 0.33mm.
if grep -q 'width="55.110mm"' "$TMP"/b.svg; then
  printf '  ✓ nominal width is 167 modules, quiet zones included\n'
else
  printf '  ✗ width is not 55.110mm: %s\n' "$(grep -o 'width="[0-9.]*mm"' "$TMP"/b.svg)"; FAILED+=1
fi

declare -- fills
fills=$(grep -o 'fill="[^"]*"' "$TMP"/b.svg | sort -u | tr '\n' ' ')
if [[ $fills == 'fill="#000" fill="#fff" ' ]]; then
  printf '  ✓ black and white only\n'
else
  printf '  ✗ fills other than black and white: %s\n' "$fills"; FAILED+=1
fi

"$MK" 979-8-9980676-0-0 --no-addon -o "$TMP"/plain.svg
if grep -q '90000' "$TMP"/plain.svg; then
  printf '  ✗ --no-addon still drew the add-on\n'; FAILED+=1
else
  printf '  ✓ --no-addon leaves the add-on out\n'
fi

# refuses <name> <expected message fragment> <args...>
refuses() {
  local -- name=$1 want=$2 err
  shift 2
  if err=$("$MK" "$@" 2>&1 >/dev/null); then
    printf '  ✗ %s: was accepted\n' "$name"; FAILED+=1
  elif [[ $err == *"$want"* ]]; then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s: refused, but said: %s\n' "$name" "$err"; FAILED+=1
  fi
}

refuses 'a wrong check digit, and says the right one' 'should end in 0' 979-8-9980676-0-1
refuses 'a number that is not an ISBN-13'            'not an ISBN-13'  590-1-2341234-5-7
refuses 'a short number'                             'not an ISBN-13'  979-8-99806
refuses 'an add-on that is not five digits'          'five digits'     979-8-9980676-0-0 --addon 9000
refuses 'a scale outside the standard'               'outside the 0.8' 979-8-9980676-0-0 --scale 0.5

((FAILED == 0)) || exit 1
exit 0
#fin
