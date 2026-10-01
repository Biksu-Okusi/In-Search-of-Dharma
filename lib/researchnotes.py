#!/usr/bin/env python3
"""Set a chapter's Research notes block for print, as Tuwhiri asked.

Ramsey Margolis (2026-09-28): the block's first two lines are to read exactly

  Research notes used in this book are published on GitHub:
  https://github.com/Biksu-Okusi/In-Search-of-Dharma

with the URL never broken, hyphenation off, and the bullet indent 5mm, not the
10mm of every other list.

The source sentence ends "published on [GitHub](URL)." and lib/preprocess.sh
adds the URL after the link in a span.repo-url, which the reading PDF shows and
the EPUB hides. That serves a screen; this filter rewrites it for paper, so the
EPUB, the reading PDF and preprocess()'s golden hashes are untouched. It also
wraps the block -- the label, that sentence and the notes list -- in div.rn,
which lib/print-style.sh sets without hyphenation and with the narrower
bullet indent.

Key works is set the same way (Ramsey, 2026-09-30: "Indeed yes, with a 5mm
indent and no hyphenation"): its label and list are wrapped in div.rn.kw, so
the two lists of a Sources block match. It needs no rewriting, only the wrap,
and a chapter may have one without the other.

Each Research note's title is bold -- the name alone, not the number before
it nor the description after (Ramsey, 2026-10-01, by marked example: "0.1" in
the text face, "Life & Formation" in Work Sans SemiBold). The entry's anchor
holds "N.N Title", so the title is the anchor text after its number, wrapped
in strong, which the print stylesheet already sets as the book's bold. Key
works entries name their works in italic and take no bold.

Reads a chapter's HTML fragment on stdin, after mk-print.sh has marked the
bold label paragraph p.label, and writes it on stdout. A chapter with no
Research notes passes through untouched. One whose label is followed by a
sentence in any other form is refused, so a source edit cannot ship the old
form without anyone noticing.

Usage:  researchnotes.py < chapter.html > chapter-print.html
"""
import re
import sys

LABEL = '<p class="label">Research notes</p>'
LEAD = 'Research notes used in this book are published on'
# pandoc wraps at 72 columns, so any space in the sentence may be a newline.
INTRO = re.compile(r'<p>' + r'\s+'.join(map(re.escape, LEAD.split())) + r'\s+'
                   r'<a\s+href="([^"]+)">GitHub</a>'
                   r'<span\s+class="repo-url">\s*[–—]\s*(\S+)</span>\.(.*?)</p>', re.S)
BLOCK = re.compile(re.escape(LABEL) + r'.*?</ul>', re.S)
KW_LABEL = '<p class="label">Key works</p>'
KW_BLOCK = re.compile(re.escape(KW_LABEL) + r'\s*<ul>.*?</ul>', re.S)
# A note entry's anchor: its number, then its title. pandoc may break the
# anchor text anywhere, so any whitespace run stands for one space.
ENTRY = re.compile(r'(<a\s[^>]*>)\s*(\d+\.\d+(?:\.\d+)?)\s+(.*?)\s*(</a>)', re.S)


def intro(m):
  """The sentence as two lines. Whatever follows the link in the source (the
  Preface goes on to say how its notes are redacted) starts a third line: the
  URL carries no full stop, so run on after it the text would read as one."""
  href, url, tail = m.group(1), m.group(2), m.group(3).strip()
  out = (f'<p class="rn-intro">{LEAD} GitHub:<br />\n'
         f'<span class="repo-url"><a href="{href}">{url}</a></span>')
  return out + (f'<br />\n{tail}</p>' if tail else '</p>')


def rewrite(fragment):
  if KW_LABEL in fragment:
    fragment, n = KW_BLOCK.subn(lambda m: f'<div class="rn kw">\n{m.group(0)}\n</div>', fragment)
    if n != 1:
      raise ValueError('the Key works label is not followed by its list')
  if LABEL not in fragment:
    return fragment
  fragment, n = INTRO.subn(intro, fragment)
  if n != 1:
    raise ValueError(f'found {n} Research notes sentences, want 1, in the form '
                     f'"{LEAD} [GitHub](URL)."')
  fragment, n = BLOCK.subn(lambda m: f'<div class="rn">\n{titled(m.group(0))}\n</div>', fragment)
  if n != 1:
    raise ValueError('the Research notes label is not followed by its list')
  return fragment


def titled(block):
  """Each entry's title in bold, its number left in the text face."""
  return ENTRY.sub(
    lambda m: f'{m.group(1)}{m.group(2)} <strong>{m.group(3)}</strong>{m.group(4)}', block)


def main():
  try:
    sys.stdout.write(rewrite(sys.stdin.read()))
  except ValueError as e:
    print(f'researchnotes.py: ✗ {e}', file=sys.stderr)
    return 1
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
