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

The first paragraph always takes the mark, and no later one ever does. The
second word of the lead-in may be a single word in <strong> or <em> ("A
<strong>dharma</strong>", as the Coda opens); anything longer ("Throughout
<em>in search of dharma</em>", as the Appendix opens) leaves the lead-in at the
first word alone. A paragraph that opens with something other than a letter,
such as a quotation mark, is marked but given no cap, with a warning: a cap on
punctuation looks like a mistake. Until 2026-09-28 the filter passed over any
paragraph it could not split and capped the next one instead, which put the
Coda's cap on its second paragraph and the Appendix's on a one-line paragraph
mid-section.

Reads an HTML fragment on stdin, writes it on stdout. A chapter with no
top-level paragraph passes through untouched.

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


WORD = r"[A-Za-z][\wÀ-ɏḀ-ỿ'’-]*"
# The lead-in: a first word, then optionally a second, which may be one word
# wrapped whole in <strong> or <em>. The second counts only where it ends,
# before a space, a tag or punctuation; a word that runs on into something
# else is not taken.
LEAD = re.compile(rf'({WORD})'
                  rf'(\s+(?:{WORD}|<(strong|em)>{WORD}</\3>)(?=[\s<.,;:!?’”)]|$))?')


def lead_in(text):
  """Split a paragraph's opening into (cap, small-caps run, remainder).

  Returns None when the paragraph does not open with a letter.
  """
  m = LEAD.match(text)
  if not m:
    return None
  first, second = m.group(1), m.group(2) or ''
  return first[0], first[1:] + second, text[m.end():]


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
    done = True
    split = lead_in(body)
    if split is None:
      print(f'dropcap.py: ▲ the opening paragraph does not begin with a letter, '
            f'so it takes no drop cap: {body[:40]!r}', file=sys.stderr)
      out.append(f'<p class="op">{body}')
      continue
    cap, small, rest = split
    # The drop cap gets its own element rather than ::first-letter. A floated
    # first letter that sits INSIDE the small-caps span nests one float in
    # another, and WeasyPrint asserts out of its float layout when it does.
    # Part 8 opens "A woman sits...", where the whole first word is the cap,
    # which is exactly the case that crashes.
    run = f'<span class="sc">{small}</span>' if small else ''
    out.append(f'<p class="op"><span class="dc">{cap}</span>{run}{rest}')
  return ''.join(out)


def main():
  sys.stdout.write(mark(sys.stdin.read()))
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
