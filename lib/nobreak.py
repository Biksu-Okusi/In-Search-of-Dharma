#!/usr/bin/env python3
"""Keep a line from dividing the words house style would not divide.

Tuwhiri marked eleven divided words in the proof (2026-09-28), each to be
"taken down" to the next line. They are of three kinds, and each kind is
answered for the whole book, since the lines he numbered will not be the same
lines once the pages reflow:

  - a word that already has a hyphen (half-con/scious, three-quar/ters) is
    divided only at that hyphen
  - the last word of a paragraph is not divided, so that a paragraph never
    ends on a fragment (oth/er. cov/er. du/ties.)
  - a word named in WHOLE is not divided (Abra/hamic)

Capitalised words are not protected as such. He let a good many be divided on
pages he was marking (Zeal/and, Sec/ular, Chris/tianity), so that is not his
rule, and it would loosen some fifty lines of the book for nothing he asked.

CSS cannot choose these words: no selector reaches a word. Each is wrapped in
<span class="nb"> here, and lib/print-style.sh turns automatic hyphenation off
for that class. A line may still end at a hyphen the word already has.

Skipped: anything inside a tag; <code>, <pre> and headings; an address
(anything holding "://"), which the stylesheet keeps whole by other means.

Reads an HTML fragment on stdin, writes it on stdout.

Usage:  nobreak.py < chapter.html > chapter-marked.html
"""
import re
import sys

# Words never to be divided, each because the publisher asked.
WHOLE = ('Abrahamic',)

OPEN, SHUT = '<span class="nb">', '</span>'
# Elements whose text is left alone, with the depth counted so nesting is safe.
OPAQUE = ('code', 'pre', 'h1', 'h2', 'h3', 'h4', 'h5', 'h6')
# A paragraph ends at the close of one of these.
ENDS = ('p', 'li')
# Walking back from a paragraph's end, any of these says the paragraph's own
# text has run out: what lies before belongs to another block.
BLOCKS = ENDS + OPAQUE + ('ul', 'ol', 'div', 'blockquote', 'section', 'figure', 'table', 'br')

TOKEN = re.compile(r'(<[^>]*>)')
TAG_NAME = re.compile(r'</?\s*([A-Za-z][A-Za-z0-9]*)')
ENTITY = re.compile(r'&(?:#[0-9]+|#[xX][0-9A-Fa-f]+|[A-Za-z][A-Za-z0-9]*);')
# A word: letters and digits, with an apostrophe or a hyphen inside it.
WORD = r"\w+(?:[’'-]\w+)*"
LAST_WORD = re.compile(rf'({WORD})(?!.*\w)', re.S)
# The last word is marked where it stands and wrapped with the rest.
MARK, KRAM = '\x01', '\x02'
WRAP = re.compile(
  rf'{MARK}([^{KRAM}]*){KRAM}'
  rf"|(?<![\w’'-])(\w+(?:’\w+)?(?:-\w+(?:’\w+)?)+)(?![\w-])"
  rf"|(?<![\w’'-])({'|'.join(map(re.escape, WHOLE))})(?![\w-])")


def tag_name(tok):
  m = TAG_NAME.match(tok)
  return m.group(1).lower() if m and not tok.startswith('<!') else None


def mark_last_words(toks):
  """Put a mark round the last word of every paragraph and list entry."""
  for i, tok in enumerate(toks):
    if not (tok.startswith('</') and tag_name(tok) in ENDS):
      continue
    j = i - 1
    while j >= 0:
      t = toks[j]
      if t.startswith('<'):
        if tag_name(t) in BLOCKS:
          break
      elif MARK in t:
        break
      elif '://' not in t:
        m = LAST_WORD.search(ENTITY.sub(lambda e: ' ' * len(e.group(0)), t))
        if m:
          toks[j] = t[:m.start(1)] + MARK + t[m.start(1):m.end(1)] + KRAM + t[m.end(1):]
          break
      j -= 1


def wrap_text(text):
  """Wrap the words of one run of plain text that are to be kept whole."""
  if '://' in text:
    return text.replace(MARK, '').replace(KRAM, '')
  holes = []

  def stash(m):
    holes.append(m.group(0))
    return f'\x00{len(holes) - 1}\x00'

  text = ENTITY.sub(stash, text)
  text = WRAP.sub(lambda m: OPEN + (m.group(1) or m.group(2) or m.group(3)) + SHUT, text)
  return re.sub(r'\x00(\d+)\x00', lambda m: holes[int(m.group(1))], text)


def mark(fragment):
  toks = TOKEN.split(fragment)
  mark_last_words(toks)
  out = []
  depth = 0
  for tok in toks:
    if tok.startswith('<'):
      if tag_name(tok) in OPAQUE:
        depth += -1 if tok.startswith('</') else 1
        depth = max(depth, 0)
      out.append(tok)
      continue
    out.append(tok.replace(MARK, '').replace(KRAM, '') if depth else wrap_text(tok))
  return ''.join(out)


def main():
  sys.stdout.write(mark(sys.stdin.read()))
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
