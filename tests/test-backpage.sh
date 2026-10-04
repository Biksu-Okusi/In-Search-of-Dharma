#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-backpage.sh - the publisher's last page in mk-print.sh: set on a
# recto straight after the text whatever the length of the book, refused when
# it is not one page at the trim, skipped with a warning when absent; and
# lib/spotgray.py, which sets its black spot images in greyscale as the
# printer's rules want.
#
# The two functions are lifted out of mk-print.sh and run on stand-in books of
# one-line pages: nothing is typeset and no interior is built.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r SPOTGRAY=$ROOT/lib/spotgray.py
declare -i FAILED=0 N
declare -- TMP='' LOG='' GOT=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# book N OUT : N pages at 152 x 229 mm, each with its number as text.
book() {
  local -- html=$TMP/book-$1.html
  local -i i
  {
    printf '<!doctype html><meta charset="utf-8"><style>@page{size:152mm 229mm;margin:20mm}'
    printf 'p{page-break-after:always}</style>'
    for ((i = 1; i <= $1; i+=1)); do printf '<p>page %d of the book</p>' "$i"; done
  } >"$html" || die 1 'failed to write a stand-in book'
  weasyprint -- "$html" "$2" 2>/dev/null || die 1 "failed to render a stand-in book of $1 pages"
}

pages() { pdfinfo -- "$1" | awk '/^Pages:/{print $2}'; }

printf 'test-backpage.sh\n'
TMP=$(mktemp -d) || die 1 'mktemp failed'
LOG=$TMP/log

# The publisher's page: a black spot image (a ramp from white to full ink)
# and a line of text, at the trim.
python3 - "$TMP"/publisher.pdf <<'PY' || die 1 'failed to draw the publisher page'
import sys
import pikepdf
pdf = pikepdf.new()
pdf.add_blank_page(page_size=(430.87, 649.13))
page = pdf.pages[0]
ramp = pikepdf.Stream(pdf, bytes(range(0, 256, 16)) * 16)
ramp.Type, ramp.Subtype = pikepdf.Name.XObject, pikepdf.Name.Image
ramp.Width, ramp.Height, ramp.BitsPerComponent = 16, 16, 8
ramp.ColorSpace = pikepdf.Array([
  pikepdf.Name.Separation, pikepdf.Name.Black, pikepdf.Name.DeviceGray,
  pikepdf.Dictionary(FunctionType=2, Domain=[0, 1], C0=[1], C1=[0], N=1)])
page.Resources = pikepdf.Dictionary(XObject=pikepdf.Dictionary(Im1=ramp))
page.Contents = pdf.make_stream(b'q 200 0 0 200 100 300 cm /Im1 Do Q')
pdf.save(sys.argv[1])
PY
python3 - "$TMP"/other-spot.pdf "$TMP"/publisher.pdf <<'PY' || die 1 'failed to draw the other-spot page'
import sys
import pikepdf
pdf = pikepdf.open(sys.argv[2])
image = pdf.pages[0].Resources.XObject.Im1
image.ColorSpace[1] = pikepdf.Name.PANTONE_485
pdf.save(sys.argv[1])
PY

# spotgray.py.
if "$SPOTGRAY" "$TMP"/publisher.pdf "$TMP"/grey.pdf >/dev/null; then
  GOT=$(pdfimages -list -- "$TMP"/grey.pdf | awk 'NR > 2 {print $6}')
  [[ $GOT == gray ]] && ok 'a black spot image is set as DeviceGray' \
    || bad "the image is ${GOT:-(none)} after spotgray, want gray"
  pdftoppm -r 40 -gray -png -- "$TMP"/publisher.pdf "$TMP"/before
  pdftoppm -r 40 -gray -png -- "$TMP"/grey.pdf "$TMP"/after
  python3 - "$TMP"/before-1.png "$TMP"/after-1.png <<'PY' \
    && ok 'it looks as it did: the grey ramp is not turned into its negative' \
    || bad 'the page looks different once its spot image is grey'
import sys
from PIL import Image, ImageChops
a, b = (Image.open(p).convert('L') for p in sys.argv[1:3])
assert ImageChops.difference(a, b).getextrema()[1] <= 2
PY
else
  bad 'spotgray.py failed on a black spot image'
fi
"$SPOTGRAY" "$TMP"/other-spot.pdf "$TMP"/nope.pdf &>/dev/null \
  && bad 'another spot colour was converted as if it were black' \
  || ok 'a spot colour that is not Black is refused, not guessed'

printf '<!doctype html><meta charset="utf-8"><style>@page{size:100mm 100mm}</style><p>small' \
  >"$TMP"/small.html || die 1 'failed to write the small page'
weasyprint -- "$TMP"/small.html "$TMP"/small.pdf 2>/dev/null || die 1 'failed to render the small page'

# add_back_page and the blank it needs, lifted from mk-print.sh.
#shellcheck disable=SC2034,SC2329  # read and called by the sourced functions
(
  TMP_DIR=$TMP
  PRINT_TRIM_W_MM=152 PRINT_TRIM_H_MM=229
  BACKPAGE_SRC=$TMP/publisher.pdf
  warn() { >&2 printf 'warn: %s\n' "$*"; }
  info() { >&2 printf 'info: %s\n' "$*"; }
  die()  { >&2 printf 'die: %s\n' "${*:2}"; exit "$1"; }
  #shellcheck disable=SC1090  # the functions are cut from the script at run time
  source <(sed -n -- '/^blank_page() {$/,/^}$/p;/^add_back_page() {$/,/^}$/p' "$ROOT"/mk-print.sh)

  for N in 6 7; do
    book "$N" "$TMP"/book.pdf
    add_back_page "$TMP"/book.pdf "$TMP"/out-"$N".pdf 2>"$LOG" || { >&2 cat -- "$LOG"; exit 1; }
  done
  # An absent file, a file of several pages, a page of the wrong size. The last
  # two must be refused: the call exits non-zero and says why, which is read
  # below, and a call that succeeds is the failure here.
  BACKPAGE_SRC=$TMP/absent.pdf
  add_back_page "$TMP"/book.pdf "$TMP"/out-absent.pdf 2>"$TMP"/log-absent || exit 1
  BACKPAGE_SRC=$TMP/book.pdf
  if ( add_back_page "$TMP"/book.pdf "$TMP"/out-wrong.pdf ) 2>"$TMP"/log-wrong; then exit 1; fi
  BACKPAGE_SRC=$TMP/small.pdf
  if ( add_back_page "$TMP"/book.pdf "$TMP"/out-small.pdf ) 2>"$TMP"/log-small; then exit 1; fi
) || die 1 'add_back_page failed on a stand-in book'

# Six pages end on a verso, so the next page is a recto: his page is page 7.
# Seven end on a recto, so a blank stands in between: his page is page 9.
[[ $(pages "$TMP"/out-6.pdf) == 7 ]] && ok 'a book of 6 pages: the publisher page is page 7, a recto' \
  || bad "a book of 6 pages made $(pages "$TMP"/out-6.pdf) pages, want 7"
[[ $(pages "$TMP"/out-7.pdf) == 9 ]] && ok 'a book of 7 pages: a blank, then the page, as page 9' \
  || bad "a book of 7 pages made $(pages "$TMP"/out-7.pdf) pages, want 9"
GOT=$(pdftotext -f 8 -l 8 -- "$TMP"/out-7.pdf - | tr -d '[:space:]')
[[ -z $GOT ]] && ok 'the page in between is blank' || bad "the page in between holds ${GOT@Q}"
GOT=$(pdfimages -list -f 9 -l 9 -- "$TMP"/out-7.pdf | awk 'NR > 2 {print $6}')
[[ $GOT == gray ]] && ok 'the publisher page is in the book as greyscale' \
  || bad "the publisher page's image is ${GOT:-(none)} in the book"
GOT=$(pdfinfo -- "$TMP"/out-6.pdf | awk '/^Page size:/{printf "%.0f x %.0f", $3 * 25.4 / 72, $5 * 25.4 / 72}')
[[ $GOT == '152 x 229' ]] && ok 'the book is still at the trim' || bad "the book's trim is $GOT mm"
[[ $(pages "$TMP"/out-absent.pdf) == 7 ]] && grep -q -- 'no publisher' "$TMP"/log-absent \
  && ok 'no publisher page: the book is as it was, with a warning' \
  || bad 'an absent publisher page did not leave the book as it was with a warning'
grep -q -- 'has 7 pages, want 1' "$TMP"/log-wrong && ok 'a publisher file of several pages is refused' \
  || bad "a many-page publisher file was not refused: $(<"$TMP"/log-wrong)"
grep -q -- 'is not 152x229 mm' "$TMP"/log-small && ok 'a publisher page that is not at the trim is refused' \
  || bad "a page of the wrong size was not refused: $(<"$TMP"/log-small)"

((FAILED == 0)) || { printf '  %d failed\n' "$FAILED"; exit 1; }
#fin
