#!/usr/bin/env python3
"""Move every page's content sideways by a whole number of millimetres.

  pageshift.py IN.pdf OUT.pdf MM

Positive MM moves the content to the right, negative to the left; the page
size, boxes and everything else stay as they are. mk-print.sh uses it on the
publisher's supplied last page, which was set to the book's earlier 25mm
gutter and does not follow the stylesheet: the text block moved 5mm away from
the spine on 2026-10-22 (lib/print-style.sh), so that page moves with it.

The move is a translation wrapped round the existing content stream
(q ... cm at the front, Q at the back), so no operator of the page is
rewritten and the images are untouched byte for byte.
"""
import sys

import pikepdf

PT_PER_MM = 72 / 25.4


def main():
  if len(sys.argv) != 4:
    sys.exit(__doc__)
  src, out, mm = sys.argv[1], sys.argv[2], sys.argv[3]
  try:
    shift = float(mm)
  except ValueError:
    sys.exit(f'{mm!r} is not a number of millimetres')
  dx = shift * PT_PER_MM
  pdf = pikepdf.open(src)
  for page in pdf.pages:
    page.contents_add(pikepdf.Stream(pdf, b'q 1 0 0 1 %.4f 0 cm\n' % dx), prepend=True)
    page.contents_add(pikepdf.Stream(pdf, b'\nQ\n'))
  pdf.save(out)
  print(f'{out}: {len(pdf.pages)} page(s) moved {shift:g}mm '
        f'{"right" if shift >= 0 else "left"}')


if __name__ == '__main__':
  main()

#fin
