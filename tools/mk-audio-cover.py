#!/usr/bin/env python3
"""Recompose Tuwhiri's portrait front cover as the square an audiobook wants.

  mk-audio-cover.py FRONT.jpg OUT.jpg [SIDE]

The cover is five centred blocks on a flat ground: title, compass, subtitle,
author, endorsement. Each block is lifted from the portrait cover unchanged
(the compass alone is reduced, to COMPASS_SCALE) and the five are stacked with
smaller gaps on a square of the same ground colour, SIDE pixels a side
(default 2000). Nothing is redrawn, so the type and artwork stay Tuwhiri's.

The blocks are found, not assumed: rows that differ from the ground colour,
with breaks under MERGE_GAP rows joined. Anything but five blocks is an error,
so a changed cover fails loudly instead of producing a wrong square.
"""
import sys

import numpy as np
from PIL import Image

MERGE_GAP = 70        # rows; line spacing within a block is smaller than this
INK = 60              # summed RGB distance from the ground that counts as ink
EDGE = 100            # columns ignored at each side (the trim-edge thumb tab)
COMPASS_SCALE = 0.75
# Space above each block and below the last, as shares of the free height.
GAPS = (0.19, 0.17, 0.17, 0.10, 0.19, 0.18)


def blocks(ink):
  """[(top, bottom)] of each run of inked rows, close runs merged."""
  runs, start = [], None
  for y, row in enumerate(ink.any(axis=1)):
    if row and start is None:
      start = y
    elif not row and start is not None:
      runs.append([start, y])
      start = None
  if start is not None:
    runs.append([start, len(ink)])
  merged = []
  for run in runs:
    if merged and run[0] - merged[-1][1] < MERGE_GAP:
      merged[-1][1] = run[1]
    else:
      merged.append(run)
  return merged


def main():
  if len(sys.argv) not in (3, 4):
    sys.exit(__doc__)
  src, out = sys.argv[1], sys.argv[2]
  side = int(sys.argv[3]) if len(sys.argv) == 4 else 2000
  front = Image.open(src).convert('RGB')
  px = np.asarray(front).astype(int)
  ground = np.median(px.reshape(-1, 3), axis=0)
  ink = np.abs(px - ground).sum(axis=2) > INK
  ink[:, :EDGE] = False
  ink[:, -EDGE:] = False
  found = blocks(ink)
  if len(found) != 5:
    sys.exit(f'{src}: expected 5 blocks (title, compass, subtitle, author, '
             f'endorsement), found {len(found)}')

  pieces = []
  for i, (top, bottom) in enumerate(found):
    piece = front.crop((EDGE, top, front.width - EDGE, bottom))
    if i == 1:
      piece = piece.resize((round(piece.width * COMPASS_SCALE),
                            round(piece.height * COMPASS_SCALE)), Image.LANCZOS)
    pieces.append(piece)

  free = side - sum(p.height for p in pieces)
  if free <= 0 or max(p.width for p in pieces) > side:
    sys.exit(f'the blocks do not fit a {side} px square')
  square = Image.new('RGB', (side, side), tuple(int(c) for c in ground))
  y = 0.0
  for piece, gap in zip(pieces, GAPS):
    y += gap * free
    square.paste(piece, ((side - piece.width) // 2, round(y)))
    y += piece.height
  square.save(out, quality=92, optimize=True)
  print(f'{out}: {side}x{side}')


main()
#fin
