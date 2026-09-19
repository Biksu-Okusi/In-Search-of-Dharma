#!/usr/bin/env python3
"""Fail if any source character is absent from the bound faces.

Bona Nova and Work Sans both lack the rarer IAST diacritics, notably the
vocalic long r and l (U+1E5D, U+1E39) and the anusvara m with dot above
(U+1E41). No current source uses them, so this gate costs nothing today. It
exists so that a future edit which does introduce one fails the build instead
of printing a blank where a letter should be.

Coverage is the INTERSECTION of the bound faces, not their union: body text may
be set in any of them, so a character present in only one is still a hole.

Usage:  glyphcheck.py FONT... -- FILE...
"""
import sys
import unicodedata

from fontTools.ttLib import TTFont

# Characters that never reach a glyph: line structure, and the soft hyphen and
# zero-width joiners a renderer consumes rather than draws.
IGNORE = set('\n\r\t­​‌‍﻿')


def coverage(paths):
  """Codepoints present in EVERY face."""
  common = None
  for path in paths:
    font = TTFont(path, fontNumber=0, lazy=True)
    cps = set()
    for table in font['cmap'].tables:
      cps |= set(table.cmap.keys())
    font.close()
    common = cps if common is None else (common & cps)
  return common or set()


def missing_in(files, have):
  """First use of each uncovered character, as {char: (path, line)}."""
  missing = {}
  for path in files:
    try:
      with open(path, encoding='utf-8') as handle:
        for lineno, line in enumerate(handle, 1):
          for ch in line:
            if ch in IGNORE or ord(ch) < 128 or ord(ch) in have:
              continue
            missing.setdefault(ch, (path, lineno))
    except OSError as exc:
      print(f"✗ glyphs: cannot read {path}: {exc}", file=sys.stderr)
      raise
  return missing


def main(argv):
  if '--' not in argv:
    print(__doc__, file=sys.stderr)
    return 2
  cut = argv.index('--')
  fonts, files = argv[:cut], argv[cut + 1:]
  if not fonts or not files:
    print(__doc__, file=sys.stderr)
    return 2

  try:
    have = coverage(fonts)
    missing = missing_in(files, have)
  except Exception as exc:  # a broken font or unreadable source, not a traceback
    print(f"✗ glyphs: {exc}", file=sys.stderr)
    return 2

  for ch, (path, lineno) in sorted(missing.items()):
    name = unicodedata.name(ch, 'UNNAMED')
    print(f"✗ glyphs: '{ch}' U+{ord(ch):04X} {name} is missing from the bound "
          f"faces; first used at {path}:{lineno}", file=sys.stderr)
  if missing:
    return 1
  print(f"✓ glyphs: {len(files)} files, every character present in all "
        f"{len(fonts)} faces", file=sys.stderr)
  return 0


if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
#fin
