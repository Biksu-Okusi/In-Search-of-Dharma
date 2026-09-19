#!/usr/bin/env python3
"""Mark a chapter's opening paragraph for the drop cap and small-caps lead-in.

Tuwhiri's house style opens each chapter with a two-line drop cap, and sets the
first two words after it in small capitals. Neither can be done in CSS alone:
`::first-letter` needs the paragraph identified, and no selector can reach "the
first two words".

A chapter's opening paragraph is NOT the element after the <h1>. pandoc emits
the chapter watercolour as a <figure> and the epigraph as a <blockquote> first,
so the opener is the first top-level <p> that follows them. This filter finds
it, tags it `class="op"`, and wraps its first two words in <span class="sc">.

Reads an HTML fragment on stdin, writes it on stdout. A chapter with no
qualifying paragraph passes through untouched.

Usage:  dropcap.py < chapter.html > chapter-marked.html
"""
import re
import sys

# A top-level opening <p>: no attributes, not inside a figure or blockquote.
# The fragment is pandoc's own output, so the markup is regular enough to scan
# linearly rather than parse.
SKIP_OPEN = re.compile(r'<(figure|blockquote|table|ul|ol|div)\b', re.I)
SKIP_CLOSE = re.compile(r'</(figure|blockquote|table|ul|ol|div)>', re.I)
PARA = re.compile(r'<p>')


def first_two_words(text):
  """Split leading text into (first two words, remainder).

  Returns (None, text) when the paragraph does not start with plain words, for
  example when it opens with a tag or a quotation mark, since a drop cap on
  punctuation looks like a mistake rather than a flourish.
  """
  m = re.match(r'([A-Za-z][\wÀ-ɏḀ-ỿ\'’-]*'
               r'(?:\s+[A-Za-z][\wÀ-ɏḀ-ỿ\'’-]*){1})'
               r'(\s)', text)
  if not m:
    return None, text
  return m.group(1), text[m.end(1):]


def mark(fragment):
  out = []
  depth = 0
  done = False
  for line in fragment.splitlines(keepends=True):
    if not done:
      depth += len(SKIP_OPEN.findall(line))
      depth -= len(SKIP_CLOSE.findall(line))
      depth = max(depth, 0)
    if done or depth > 0 or not line.lstrip().startswith('<p>'):
      out.append(line)
      continue
    body = line.lstrip()[len('<p>'):]
    words, rest = first_two_words(body)
    if words is None:
      out.append(line)
      continue
    # The drop cap gets its own element rather than ::first-letter. A floated
    # first letter that sits INSIDE the small-caps span nests one float in
    # another, and WeasyPrint asserts out of its float layout when it does.
    # Part 8 opens "A woman sits...", where the whole first word is the cap,
    # which is exactly the case that crashes.
    out.append(f'<p class="op"><span class="dc">{words[0]}</span>'
               f'<span class="sc">{words[1:]}</span>{rest}')
    done = True
  return ''.join(out)


def main():
  sys.stdout.write(mark(sys.stdin.read()))
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
