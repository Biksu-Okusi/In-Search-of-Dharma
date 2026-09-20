#!/usr/bin/env python3
"""Set runs of two or more capitals in small capitals.

Tuwhiri's house style asks that "where in the text you have two or more capital
letters together" the run be set in small capitals — AI, BCE, WEIRD, and the
initials in BR Ambedkar or EO Wilson. Full capitals in a line of 10pt Bona Nova
stand well above the lowercase around them and pull the eye off the line;
small capitals carry the same letters at the weight of the text.

CSS cannot do this alone: no selector reaches an element by what it contains.
So each run is wrapped in <span class="caps"> here, and lib/print-style.sh
turns on c2sc for that class.

Skipped, because a small-capital there would be wrong or meaningless:
  - anything inside a tag, so href="..." and id="..." are never touched
  - <code> and <pre>, where the capitals are the content
  - headings, which are already set in the sans and feed the running heads
  - HTML entities, so &AMP; style sequences stay intact

Reads an HTML fragment on stdin, writes it on stdout.

Usage:  smallcaps.py < chapter.html > chapter-marked.html
"""
import re
import sys

# A capital run, bounded by non-letters so COVID19 matches whole and USAid not
# at all. Digits may follow, which \b would not allow. A plural takes its own
# lowercase s outside the span -- AIs and NGOs are small capitals plus a roman
# s, not a small-capital S.
RUN = re.compile(r'(?<![A-Za-z])[A-Z]{2,}(?:(?=s(?![A-Za-z]))|(?![A-Za-z]))')

# Elements whose text is left alone, with the depth counted so nesting is safe.
OPAQUE = ('code', 'pre', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6')

TOKEN = re.compile(r'(<[^>]*>)')
TAG_NAME = re.compile(r'</?\s*([A-Za-z][A-Za-z0-9]*)')
ENTITY = re.compile(r'&(?:#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z][A-Za-z0-9]*);')


def mark_text(text):
  """Wrap the capital runs in one run of plain text."""
  if not text:
    return text
  # Entities are masked rather than skipped in the pattern, because a named
  # entity can hold capitals that are part of its spelling, not of the prose.
  holes = []

  def stash(m):
    holes.append(m.group(0))
    return f'\x00{len(holes) - 1}\x00'

  text = ENTITY.sub(stash, text)
  text = RUN.sub(lambda m: f'<span class="caps">{m.group(0)}</span>', text)
  return re.sub(r'\x00(\d+)\x00', lambda m: holes[int(m.group(1))], text)


def mark(fragment):
  out = []
  depth = 0
  for tok in TOKEN.split(fragment):
    if tok.startswith('<'):
      name = TAG_NAME.match(tok)
      if name and name.group(1).lower() in OPAQUE and not tok.startswith('<!'):
        depth += -1 if tok.startswith('</') else 1
        depth = max(depth, 0)
      out.append(tok)
      continue
    out.append(tok if depth else mark_text(tok))
  return ''.join(out)


def main():
  sys.stdout.write(mark(sys.stdin.read()))
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
