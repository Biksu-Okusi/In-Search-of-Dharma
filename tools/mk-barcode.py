#!/usr/bin/env python3
"""Draw the barcode for a book's cover: EAN-13 for the ISBN, with the EAN-5 add-on.

An ISBN-13 already is an EAN-13 number, so the barcode on a book is the
ordinary retail symbol with the ISBN printed above it. The five-digit add-on to
its right carries the price; 90000 means "no price given", which is what a
book sold at different prices in different countries wants.

Usage:
  mk-barcode.py ISBN [--addon 90000] [--no-addon] [--price-label] [--scale 1.0] [-o FILE.svg]

  mk-barcode.py 979-8-9980676-0-0 -o isbn-paperback.svg
  mk-barcode.py 979-8-9980676-0-0 --addon 51995 --price-label -o priced.svg

An add-on beginning 5 is a price in US dollars: 51995 is US$19.95. With
--price-label that price is also printed in words, right-aligned above the
add-on on the ISBN line, as on Tuwhiri's other covers. The words are read from
the add-on, so the label and the bars cannot disagree.

The output is a vector SVG in pure black on white, sized in millimetres, with
the quiet zones the standard requires drawn into the white background -- so
the file's edge is the edge nothing may cross. At --scale 1.0 a module is
0.33mm and the symbol is nominal size; the standard allows 0.8 to 2.0.
A cover designer places the file and sets the black to 100% K only.

Exit status: 0 written, 1 the ISBN or add-on is not valid, 2 usage.
"""
import argparse
import re
import sys

L = ('0001101', '0011001', '0010011', '0111101', '0100011',
     '0110001', '0101111', '0111011', '0110111', '0001011')
G = ('0100111', '0110011', '0011011', '0100001', '0011101',
     '0111001', '0000101', '0010001', '0001001', '0010111')
R = ('1110010', '1100110', '1101100', '1000010', '1011100',
     '1001110', '1010000', '1000100', '1001000', '1110100')
# The first digit is not drawn: it chooses which of the next six use G.
PARITY_13 = ('LLLLLL', 'LLGLGG', 'LLGGLG', 'LLGGGL', 'LGLLGG',
             'LGGLLG', 'LGGGLL', 'LGLGLG', 'LGLGGL', 'LGGLGL')
# The add-on has no check digit of its own; its checksum chooses the parity.
PARITY_5 = ('GGLLL', 'GLGLL', 'GLLGL', 'GLLLG', 'LGGLL',
            'LLGGL', 'LLLGG', 'LGLGL', 'LGLLG', 'LLGLG')

MODULE_MM = 0.33          # nominal X-dimension
BAR_MM = 22.85            # nominal bar height
GUARD_EXTRA_MM = 1.65     # guard bars run this far below the rest
QUIET_LEFT, QUIET_RIGHT = 11, 7      # modules, EAN-13
ADDON_GAP, ADDON_QUIET = 9, 5        # modules: gap before the add-on, quiet after
TEXT_MM = 2.75            # digit height, for an OCR-B-like sans
PRICE_SIZE = 0.8          # the price label, relative to the digits
FONT ="'OCR-B','OCRB','Work Sans','DejaVu Sans',sans-serif"


def check_digit(first12):
  total = sum(int(c) * (3 if i % 2 else 1) for i, c in enumerate(first12))
  return str((10 - total % 10) % 10)


def ean13_modules(digits):
  out = '101'
  for digit, parity in zip(digits[1:7], PARITY_13[int(digits[0])]):
    out += (L if parity == 'L' else G)[int(digit)]
  out += '01010'
  for digit in digits[7:]:
    out += R[int(digit)]
  return out + '101'


def ean5_modules(digits):
  checksum = (3 * sum(int(c) for c in digits[0::2]) + 9 * sum(int(c) for c in digits[1::2])) % 10
  out = '1011'
  for i, (digit, parity) in enumerate(zip(digits, PARITY_5[checksum])):
    if i:
      out += '01'
    out += (L if parity == 'L' else G)[int(digit)]
  return out


def usd_label(addon):
  """The price a US-dollar add-on carries, in words: 51995 is US$19.95."""
  cents = int(addon[1:])
  return f'US${cents // 100}.{cents % 100:02d}'


def bars(modules, x0, y, height, m):
  """Merge runs of dark modules into one rectangle each: fewer, cleaner shapes."""
  out = []
  for run in re.finditer('1+', modules):
    out.append(f'<rect x="{x0 + run.start() * m:.4f}" y="{y:.4f}" '
               f'width="{len(run.group()) * m:.4f}" height="{height:.4f}"/>')
  return out


def svg(isbn_text, digits, addon, scale, price_label=False):
  m = MODULE_MM * scale
  bar, extra, text = BAR_MM * scale, GUARD_EXTRA_MM * scale, TEXT_MM * scale
  top = text * 1.9                       # room for the ISBN line above
  main = ean13_modules(digits)
  x_main = QUIET_LEFT * m
  width_mod = QUIET_LEFT + len(main) + QUIET_RIGHT
  shapes = []
  # Guard bars (start, centre, end) are drawn long; the digit runs stop short.
  guards = {0, 1, 2, 45, 46, 47, 48, 49, 92, 93, 94}
  long_mod = ''.join(c if i in guards else '0' for i, c in enumerate(main))
  short_mod = ''.join('0' if i in guards else c for i, c in enumerate(main))
  shapes += bars(long_mod, x_main, top, bar + extra, m)
  shapes += bars(short_mod, x_main, top, bar, m)
  base = top + bar + text * 1.05
  # Each label is (x, y, anchor, text, spread, size): the two six-digit groups
  # are spread to sit under their bars, one digit per seven modules.
  labels = [
    (x_main, text, 'start', f'ISBN {isbn_text}', 0, 1),
    (x_main - 2 * m, base, 'end', digits[0], 0, 1),
    (x_main + (3 + 21) * m, base, 'middle', digits[1:7], 42 * m * 0.92, 1),
    (x_main + (50 + 21) * m, base, 'middle', digits[7:], 42 * m * 0.92, 1),
  ]
  if addon:
    extra_mod = ean5_modules(addon)
    x_add = (width_mod - QUIET_RIGHT + ADDON_GAP) * m
    # The add-on's digits sit ABOVE its bars, which start lower to make room.
    shapes += bars(extra_mod, x_add, top + text * 1.25, bar + extra - text * 1.25, m)
    labels.append((x_add + len(extra_mod) * m / 2, top + text * 0.95, 'middle', addon, 0, 1))
    if price_label:
      # On the ISBN line, a size smaller, flush with the add-on's last bar.
      labels.append((x_add + len(extra_mod) * m, text, 'end', usd_label(addon), 0, PRICE_SIZE))
    width_mod = width_mod - QUIET_RIGHT + ADDON_GAP + len(extra_mod) + ADDON_QUIET
  width, height = width_mod * m, base + text * 0.45
  texts = []
  for x, y, anchor, label, spread, size in labels:
    fit = f' textLength="{spread:.4f}" lengthAdjust="spacing"' if spread else ''
    small = f' font-size="{text * size:.4f}"' if size != 1 else ''
    texts.append(f'<text x="{x:.4f}" y="{y:.4f}" text-anchor="{anchor}"{fit}{small}>{label}</text>')
  return '\n'.join([
    '<?xml version="1.0" encoding="UTF-8"?>',
    f'<svg xmlns="http://www.w3.org/2000/svg" width="{width:.3f}mm" height="{height:.3f}mm" '
    f'viewBox="0 0 {width:.4f} {height:.4f}">',
    f'<title>ISBN {isbn_text}{" + " + addon if addon else ""}</title>',
    f'<rect width="{width:.4f}" height="{height:.4f}" fill="#fff"/>',
    '<g fill="#000" shape-rendering="crispEdges">', *shapes, '</g>',
    f'<g fill="#000" font-family="{FONT}" font-size="{text:.4f}">', *texts, '</g>',
    '</svg>', ''])


def main():
  ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0])
  ap.add_argument('isbn')
  ap.add_argument('--addon', default='90000')
  ap.add_argument('--no-addon', action='store_true')
  ap.add_argument('--price-label', action='store_true')
  ap.add_argument('--scale', type=float, default=1.0)
  ap.add_argument('-o', '--output')
  args = ap.parse_args()

  digits = re.sub(r'[\s-]', '', args.isbn)
  if not re.fullmatch(r'97[89]\d{10}', digits):
    print(f'✗ not an ISBN-13 (13 digits beginning 978 or 979): {args.isbn}', file=sys.stderr)
    return 1
  if check_digit(digits[:12]) != digits[12]:
    print(f'✗ check digit is wrong: {args.isbn} should end in {check_digit(digits[:12])}',
          file=sys.stderr)
    return 1
  addon = '' if args.no_addon else args.addon
  if addon and not re.fullmatch(r'\d{5}', addon):
    print(f'✗ the add-on is five digits, e.g. 90000 for no price: {addon}', file=sys.stderr)
    return 1
  if args.price_label and not addon.startswith('5'):
    print(f'✗ --price-label needs a US-dollar add-on, 5 then the cents: 51995 for US$19.95, '
          f'not {addon or "none"}', file=sys.stderr)
    return 1
  if not 0.8 <= args.scale <= 2.0:
    print(f'✗ --scale {args.scale} is outside the 0.8 to 2.0 the standard allows', file=sys.stderr)
    return 1
  out = svg(args.isbn.strip(), digits, addon, args.scale, args.price_label)
  if args.output:
    with open(args.output, 'w', encoding='utf-8') as fh:
      fh.write(out)
  else:
    sys.stdout.write(out)
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
