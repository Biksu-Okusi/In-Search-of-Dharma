#!/usr/bin/env python3
"""Restore the ligatures' text mappings that Ghostscript damages.

  ligmap.py RAW.pdf GREY.pdf OUT.pdf

Each embedded font carries a ToUnicode map, which says what text a glyph
stands for: it is what copy, search and a screen reader read. WeasyPrint
writes the map correctly; the glyph for the ffi ligature maps to "ffi".
Ghostscript 10.02, converting the file to DeviceGray, rewrites a mapping of
three characters as two, adding the last two together: "ffi" becomes "f" +
U+00CF (Ï), "ffl" becomes "f" + U+00D2 (Ò). On the page nothing changes; in
the text layer every "official" reads "ofÏcial" (Paul Regan, 2026-10-07).

This takes the maps from the file before Ghostscript (RAW) and, for every
glyph whose mapping is more than one character there, puts that mapping back
in the file after it (GREY). Glyph numbers are the same in both: Ghostscript
keeps the fonts' Identity-H encodings. Fonts are matched by name without the
subset tag. Nothing else in the file is touched.
"""
import re
import sys

import pikepdf

# A map lists its entries in bfchar sections, <glyph> <text>, or in bfrange
# sections, <first> <last> <text>, which WeasyPrint and Ghostscript use in
# turn. Only the one-glyph ranges Ghostscript writes are read; a range of
# several glyphs stands for consecutive single characters, never a ligature.
BFCHAR = re.compile(rb'beginbfchar(.*?)endbfchar', re.S)
BFRANGE = re.compile(rb'beginbfrange(.*?)endbfrange', re.S)
CHAR = re.compile(rb'<([0-9A-Fa-f]{4})>\s*<([0-9A-Fa-f]+)>')
RANGE = re.compile(rb'<([0-9A-Fa-f]{4})>\s*<([0-9A-Fa-f]{4})>\s*<([0-9A-Fa-f]+)>')


def entries(data):
  """(glyph, text) for every single-glyph entry of a ToUnicode map, as hex"""
  out = []
  for sec in BFCHAR.findall(data):
    out += [(c, d) for c, d in CHAR.findall(sec)]
  for sec in BFRANGE.findall(data):
    out += [(a, d) for a, b, d in RANGE.findall(sec) if a.lower() == b.lower()]
  return [(c.lower().decode(), d.lower().decode()) for c, d in out]


def fonts(pdf):
  """BaseFont name without its subset tag -> font dictionary, one per name."""
  out = {}
  for page in pdf.pages:
    res = page.get('/Resources')
    if res is None or '/Font' not in res:
      continue
    for _, font in res.Font.items():
      name = re.sub(r'^/[A-Z]{6}\+', '', str(font.get('/BaseFont')))
      out.setdefault(name, font)
  return out


def multi(font):
  """glyph -> hex destination, for the glyphs that stand for several characters"""
  tu = font.get('/ToUnicode')
  if tu is None:
    return {}
  return {cid: dst for cid, dst in entries(tu.read_bytes()) if len(dst) > 4}


def main():
  if len(sys.argv) != 4:
    sys.exit(__doc__)
  raw, grey, out = sys.argv[1:4]
  with pikepdf.open(raw) as r, pikepdf.open(grey) as g:
    good = {name: multi(font) for name, font in fonts(r).items()}
    fixed = 0
    for name, font in fonts(g).items():
      want = good.get(name)
      tu = font.get('/ToUnicode')
      if not want or tu is None:
        continue
      data = tu.read_bytes()
      bad = {cid: dst for cid, dst in multi(font).items() if cid in want and dst != want[cid]}
      if not bad:
        continue
      for cid, dst in bad.items():
        # the entry as bfchar (<glyph> <text>) or as a one-glyph bfrange
        pat = rb'(<' + cid.encode() + rb'>\s*(?:<' + cid.encode() + rb'>\s*)?)<' + dst.encode() + rb'>'
        data, k = re.subn(pat, rb'\1<' + want[cid].encode() + b'>', data, flags=re.I)
        if k != 1:
          sys.exit(f'{name}: glyph {cid}: expected one entry to repair, found {k}')
        fixed += 1
      tu.write(data)
    g.save(out)
  print(f'ligmap: {fixed} mapping(s) restored')
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
