#!/usr/bin/env python3
"""Take named words down from the line ends the publisher marked.

Tuwhiri's final corrections (Ramsey Margolis, 2026-10-06) name, page by page,
the divided words to be "taken down" to the next line, and two short words to
be kept with the word after them. lib/nobreak.py answers the rules of house
style for the whole book; this filter answers the marks made on single lines,
each by its own words, so nothing else in the book moves.

The rules live in a plain text file, one a line, read as the phrase stands in
the typeset text, with the words to keep on one line in square brackets:

    the slow quiet [sabotage] of people
    authority [he cannot] revoke

The whole phrase must occur exactly once in the text, or the build stops: a
phrase that has gone (the text was edited) or that occurs twice (the rule is
ambiguous) is a mistake to be looked at, not guessed at. The bracketed words
are wrapped in <span class="td">, and lib/print-style.sh keeps that span from
being divided or broken across lines.

A phrase is matched inside one run of text between tags, so it may not reach
across a word the other filters have wrapped (a hyphenated word, a run of
capitals, the last word of a paragraph). Choose a phrase that stops short of
them. Any white space in the phrase matches any in the text, since pandoc
wraps its output over lines. Lines beginning # and blank lines in the rules
file are ignored.

Usage:  takedown.py RULES < body.html > body-marked.html
"""
import re
import sys

OPEN, SHUT = '<span class="td">', '</span>'
TOKEN = re.compile(r'(<[^>]*>)')
RULE = re.compile(r'^([^\[\]]*)\[([^\[\]]+)\]([^\[\]]*)$')


def loose(text):
  """A pattern for text in which each run of white space matches any run."""
  return r'\s+'.join(re.escape(w) for w in re.split(r'\s+', text) if w) \
    if text.strip() else (r'\s+' if text else '')


def read_rules(path):
  """Return (phrase, pattern) for each rule: the pattern's group 1 is kept."""
  rules = []
  with open(path, encoding='utf-8') as f:
    for n, line in enumerate(f, 1):
      line = line.rstrip('\n')
      if not line.strip() or line.lstrip().startswith('#'):
        continue
      m = RULE.match(line)
      if not m:
        sys.exit(f'{path}:{n}: a rule is a phrase with one [bracketed] part: {line!r}')
      before, kept, after = m.groups()
      # The white space on either side of the brackets belongs to the join.
      pattern = loose(before.rstrip()) + (r'\s+' if before != before.rstrip() else '') \
        + '(' + loose(kept) + ')' \
        + (r'\s+' if after != after.lstrip() else '') + loose(after.lstrip())
      rules.append((before + kept + after, re.compile(pattern)))
  return rules


def apply(fragment, rules):
  """Wrap each rule's kept words; return the text and a list of complaints."""
  toks = TOKEN.split(fragment)
  errors = []
  for phrase, pattern in rules:
    hits = [(i, m) for i, t in enumerate(toks) if not t.startswith('<')
            for m in pattern.finditer(t)]
    if len(hits) != 1:
      errors.append(f'{len(hits)} matches for {phrase!r}')
      continue
    i, m = hits[0]
    t = toks[i]
    toks[i] = t[:m.start(1)] + OPEN + m.group(1) + SHUT + t[m.end(1):]
  return ''.join(toks), errors


def main():
  if len(sys.argv) != 2:
    sys.exit(__doc__)
  rules = read_rules(sys.argv[1])
  out, errors = apply(sys.stdin.read(), rules)
  for e in errors:
    print(f'takedown: {e}', file=sys.stderr)
  if errors:
    return 1
  sys.stdout.write(out)
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
