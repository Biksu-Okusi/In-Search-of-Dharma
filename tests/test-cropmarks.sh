#!/bin/bash
#shellcheck disable=SC2015  # pass() only prints, so A && pass || fail is safe here
# tests/test-cropmarks.sh - lib/cropmarks.py sets each page of a finished PDF
# on a sheet 10mm larger all round, unchanged, with the trim recorded and eight
# hairline marks round it (Ramsey's copy with crop marks, 2026-10-06).
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r CM=$ROOT/lib/cropmarks.py
declare -i FAILED=0 PAGES=0
declare -- TMP='' TOOL='' INFO=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; FAILED+=1; }
stop() { >&2 printf '  ✗ %s\n' "$1"; exit 1; }

for TOOL in python3 weasyprint pdfinfo pdftotext; do
  command -v "$TOOL" >/dev/null || { >&2 printf '  ✗ required: %s\n' "$TOOL"; exit 18; }
done
python3 -c 'import pikepdf' 2>/dev/null || { >&2 printf '  ✗ required: python3 pikepdf\n'; exit 18; }
TMP=$(mktemp -d) || stop 'could not make a temporary directory'

echo '== crop marks =='

# A two-page fixture at the trim, 152 x 229mm, with a word on each page.
cat >"$TMP"/in.html <<'HTML' || stop 'could not write the fixture'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<style>@page{size:152mm 229mm;margin:20mm}</style></head>
<body><p>hello</p><p style="break-before:page">world</p></body></html>
HTML
weasyprint -- "$TMP"/in.html "$TMP"/in.pdf 2>/dev/null || stop 'weasyprint could not render the fixture'
"$CM" "$TMP"/in.pdf "$TMP"/out.pdf || stop 'cropmarks.py failed'

# The sheet: 172 x 249mm is 487.56 x 705.83pt.
INFO=$(pdfinfo -- "$TMP"/out.pdf) || stop 'pdfinfo could not read the output'
[[ $INFO =~ Pages:[[:space:]]+([0-9]+) ]] && PAGES=${BASH_REMATCH[1]}
((PAGES == 2)) && pass 'both pages are carried over' || fail "pages: $PAGES, want 2"
[[ $INFO =~ Page\ size:[[:space:]]+([0-9.]+)\ x\ ([0-9.]+) ]] || stop 'no page size read'
awk -v w="${BASH_REMATCH[1]}" -v h="${BASH_REMATCH[2]}" \
    'BEGIN{exit !(w > 487.4 && w < 487.7 && h > 705.7 && h < 706.0)}' \
  && pass "the sheet is 172 x 249mm (${BASH_REMATCH[1]} x ${BASH_REMATCH[2]}pt)" \
  || fail "the sheet is ${BASH_REMATCH[1]} x ${BASH_REMATCH[2]}pt, want 487.56 x 705.83"

# The words still read, each on its own page.
[[ $(pdftotext -f 1 -l 1 -- "$TMP"/out.pdf - | tr -d '\f[:space:]') == hello ]] \
  && pass 'page 1 still reads hello' || fail 'page 1 does not read hello'
[[ $(pdftotext -f 2 -l 2 -- "$TMP"/out.pdf - | tr -d '\f[:space:]') == world ]] \
  && pass 'page 2 still reads world' || fail 'page 2 does not read world'

# The trim box and the marks, read from the file itself: the trim is 10mm
# (28.35pt) in from every edge, and each page draws eight stroked segments in
# DeviceGray, none of them inside the trim.
python3 - "$TMP"/out.pdf <<'PY' && pass 'each page records the trim and draws eight marks outside it' \
  || fail 'the trim box or the marks are not as expected (see above)'
import re, sys
import pikepdf
MM = 72 / 25.4
ok = True
with pikepdf.open(sys.argv[1]) as pdf:
  for n, page in enumerate(pdf.pages, 1):
    tb = [float(v) for v in page.TrimBox]
    want = [10 * MM, 10 * MM, 162 * MM, 239 * MM]
    if any(abs(a - b) > 0.01 for a, b in zip(tb, want)):
      print(f'    page {n}: TrimBox {tb}, want {want}'); ok = False
    content = page.Contents.read_bytes().decode('latin-1')
    segs = re.findall(r'([-\d.]+) ([-\d.]+) m ([-\d.]+) ([-\d.]+) l S', content)
    if len(segs) != 8:
      print(f'    page {n}: {len(segs)} marks, want 8'); ok = False
    for a, b, c, d in segs:
      xs, ys = (float(a), float(c)), (float(b), float(d))
      inside = all(want[0] < x < want[2] for x in xs) and all(want[1] < y < want[3] for y in ys)
      if inside:
        print(f'    page {n}: a mark lies inside the trim: {a} {b} {c} {d}'); ok = False
    if ' 0 G ' not in content:
      print(f'    page {n}: the marks are not stroked in DeviceGray'); ok = False
sys.exit(0 if ok else 1)
PY

((FAILED == 0)) || { printf '✗ crop marks: %d failed\n' "$FAILED"; exit 1; }
printf '✓ crop marks: all passed\n'
exit 0
#fin
