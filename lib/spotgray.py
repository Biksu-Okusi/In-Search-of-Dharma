#!/usr/bin/env python3
"""Turn a publisher's PDF page's black spot images into plain greyscale.

  spotgray.py IN.pdf OUT.pdf

A page set in InDesign for a black-only book can carry its images in the
Separation colour space named Black (a one-ink spot colour whose tint 1 is
full black). Ghostscript keeps such an image as it is when it converts a file
to DeviceGray, and the printer's rule, and lib/pdfcheck.py, want every image
greyscale. A Separation /Black image is a grey image read backwards: the tint
is ink, the grey level is light. So each is relabelled DeviceGray with its
Decode array reversed, which changes no pixel data and so leaves JPEG images
untouched byte for byte.

Only Separation /Black is rewritten. Any other spot colour is an error, not a
guess: a changed cover or page fails loudly instead of printing in the wrong
grey. Images in other spaces are left to Ghostscript.
"""
import sys

import pikepdf


def main():
  if len(sys.argv) != 3:
    sys.exit(__doc__)
  src, out = sys.argv[1], sys.argv[2]
  pdf = pikepdf.open(src)
  done = 0
  for page in pdf.pages:
    for name, image in page.Resources.get('/XObject', {}).items():
      if image.get('/Subtype') != '/Image':
        continue
      space = image.get('/ColorSpace')
      if not isinstance(space, pikepdf.Array) or space[0] != '/Separation':
        continue
      if space[1] != '/Black':
        sys.exit(f'{src}: image {name} is in the spot colour {space[1]}, '
                 f'not Black; not converted')
      decode = image.get('/Decode')
      image.ColorSpace = pikepdf.Name.DeviceGray
      image.Decode = pikepdf.Array(list(reversed(list(decode)))
                                   if decode is not None else [1, 0])
      done += 1
  pdf.save(out)
  print(f'{out}: {done} black spot image(s) set as DeviceGray')


main()
#fin
