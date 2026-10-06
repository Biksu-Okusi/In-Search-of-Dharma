#!/usr/bin/env python3
"""Set each page of a finished interior on a larger sheet with crop marks.

  cropmarks.py IN.pdf OUT.pdf

The interior for upload carries no marks: the printer's rules forbid them and
lib/pdfcheck.py refuses them. The publisher asked separately for a copy of the
inner pages with crop marks (Ramsey Margolis, 2026-10-06), to see the trim
against the type. This takes the finished interior, page for page, and sets
each page unchanged at the centre of a sheet 10mm larger on every side, with
a hairline at each corner marking the trim, 3mm clear of it and 5mm long.
The trim is also recorded in each page's TrimBox.

The page content is carried over as a form, so no glyph, image or colour
space is touched, and the marks are drawn in DeviceGray, as the interior is.
"""
import sys

import pikepdf

MM = 72 / 25.4
SLUG_MM, GAP_MM, LEN_MM = 10, 3, 5
LINE_PT = 0.25


def marks(x0, y0, x1, y1):
  """The eight mark segments round the trim box (x0,y0)-(x1,y1), in points."""
  gap, ln = GAP_MM * MM, LEN_MM * MM
  segs = []
  for x in (x0, x1):
    for y in (y0, y1):
      dx = -1 if x == x0 else 1
      dy = -1 if y == y0 else 1
      # Horizontal mark, outside the trim beside the corner; vertical likewise.
      segs.append((x + dx * gap, y, x + dx * (gap + ln), y))
      segs.append((x, y + dy * gap, x, y + dy * (gap + ln)))
  out = [f'q 0 G {LINE_PT} w']
  out += [f'{a:.3f} {b:.3f} m {c:.3f} {d:.3f} l S' for a, b, c, d in segs]
  out.append('Q')
  return '\n'.join(out)


def main():
  if len(sys.argv) != 3:
    sys.exit(__doc__)
  src, dst = sys.argv[1], sys.argv[2]
  slug = SLUG_MM * MM
  with pikepdf.open(src) as pdf, pikepdf.new() as out:
    for page in pdf.pages:
      box = [float(v) for v in page.mediabox]
      w, h = box[2] - box[0], box[3] - box[1]
      sheet = out.add_blank_page(page_size=(w + 2 * slug, h + 2 * slug))
      form = out.copy_foreign(page.as_form_xobject())
      name = sheet.add_resource(form, pikepdf.Name.XObject, prefix='Pg')
      place = f'q 1 0 0 1 {slug - box[0]:.3f} {slug - box[1]:.3f} cm {name} Do Q'
      content = place + '\n' + marks(slug, slug, slug + w, slug + h) + '\n'
      sheet.Contents = out.make_stream(content.encode('ascii'))
      sheet.TrimBox = pikepdf.Array([slug, slug, slug + w, slug + h])
    out.save(dst)
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
