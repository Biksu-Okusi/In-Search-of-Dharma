#!/usr/bin/env python3
"""Export the DD corpus as a Hugging Face dataset.

Walks the category directories (1-foundational/ ... 8-future/) for research
notes and the repo root for essays (files with a `part:` frontmatter key),
emits JSONL under hf-dataset/data/ plus a dataset-card README.md scaffold
with auto-filled statistics.

Usage:
  ./mk-hf-dataset.py                 # export done+review notes, all essays
  ./mk-hf-dataset.py --status all    # include every note regardless of status
  ./mk-hf-dataset.py -o /tmp/out     # alternate output directory

Upload (after `hf auth login`):
  hf upload GaryDean/defining-dharma hf-dataset . --repo-type dataset
"""

import argparse
import datetime
import json
import re
import sys
from pathlib import Path

import yaml

REPO = Path(__file__).resolve().parent
# Companion essays: root-level discussion pieces outside the question registry.
# Inclusion is an editorial decision, so the list is explicit, not detected.
COMPANIONS = ('defining-definition.md', 'the-better-ones.md')
LICENCE = 'CC BY 4.0'
LICENCE_URL = 'https://creativecommons.org/licenses/by/4.0/'
HOMEPAGE = 'https://garydean.id/works/0-in-search-of-dharma'
SOURCE_REPO = 'https://github.com/Biksu-Okusi/In-Search-of-Dharma'

FRONTMATTER_RE = re.compile(r'\A---\n(.*?)\n---\n', re.DOTALL)
NOTE_FILE_RE = re.compile(r'^\d+(\.\d+)*-')
SOURCE_LINE_RE = re.compile(r'^\s*-\s*\[S(\d+)\]\s*(.*)')
WIKILINK_RE = re.compile(r'\[\[([^\]|]+?)(?:\|[^\]]+)?\]\]')
QUESTION_RE = re.compile(r'\*\*Question:\*\*\s*(.+?)(?:\n\s*\n|\n#)', re.DOTALL)
HTML_COMMENT_RE = re.compile(r'<!--.*?-->', re.DOTALL)
SITE_TAG_RE = re.compile(r'^<(image|vidframe)\b[^>]*>\s*$', re.MULTILINE)


def split_frontmatter(raw: str) -> tuple[dict, str]:
  """Return (frontmatter dict, body) for a Markdown file."""
  m = FRONTMATTER_RE.match(raw)
  if not m:
    return {}, raw
  meta = yaml.safe_load(m.group(1)) or {}
  return meta, raw[m.end():]


def clean_body(body: str) -> str:
  """Strip HTML comments and site-specific <image>/<vidframe> tags."""
  body = HTML_COMMENT_RE.sub('', body)
  body = SITE_TAG_RE.sub('', body)
  return re.sub(r'\n{3,}', '\n\n', body).strip() + '\n'


def parse_sources(body: str) -> list[dict]:
  """Collect [S#] bullets (with wrapped continuation lines) under ## Sources."""
  m = re.search(r'^## Sources\s*$', body, re.MULTILINE)
  if not m:
    return []
  section = body[m.end():]
  nxt = re.search(r'^## ', section, re.MULTILINE)
  if nxt:
    section = section[:nxt.start()]

  sources, current = [], None
  for line in section.splitlines():
    sm = SOURCE_LINE_RE.match(line)
    if sm:
      current = {'ref': f'S{sm.group(1)}', 'citation': sm.group(2).strip()}
      sources.append(current)
    elif current and line.strip() and not line.lstrip().startswith(('-', '#', '**')):
      current['citation'] += ' ' + line.strip()
    elif not line.strip():
      current = None
  return sources


def as_str(value) -> str:
  """YAML may parse dates as datetime.date; normalise to ISO string."""
  return value.isoformat() if isinstance(value, datetime.date) else str(value or '')


def export_notes(statuses: set[str] | None) -> tuple[list[dict], list[str]]:
  records, skipped = [], []
  for path in sorted(REPO.glob('[1-8]-*/**/*.md')):
    if not NOTE_FILE_RE.match(path.name):
      continue
    meta, body = split_frontmatter(path.read_text(encoding='utf-8'))
    if 'id' not in meta:
      skipped.append(f'{path.relative_to(REPO)} (no id in frontmatter)')
      continue
    status = str(meta.get('status', ''))
    if statuses is not None and status not in statuses:
      skipped.append(f'{path.relative_to(REPO)} (status: {status})')
      continue

    body = clean_body(body)
    qm = QUESTION_RE.search(body)
    records.append({
      'id': str(meta['id']),
      'type': 'note',
      'category': str(meta.get('category', '')),
      'title': str(meta.get('title', '')),
      'status': status,
      'updated': as_str(meta.get('updated')),
      'question': re.sub(r'\s+', ' ', qm.group(1)).strip() if qm else '',
      'text': body,
      'sources': parse_sources(body),
      'wiki_links': sorted(set(WIKILINK_RE.findall(body))),
      'path': str(path.relative_to(REPO)),
      'licence': LICENCE,
    })
  return records, skipped


def export_essays() -> list[dict]:
  records = []
  for path in sorted(REPO.glob('*.md')):
    if path.name.startswith('_'):  # _essay-template.md
      continue
    meta, body = split_frontmatter(path.read_text(encoding='utf-8'))
    # essays carry a numeric part; other rooted files (cover.md) do not
    if not str(meta.get('part', '')).isdigit():
      continue
    records.append({
      'id': f'essay-{meta["part"]}',
      'type': 'essay',
      'part': int(meta['part']),
      'title': str(meta.get('title', '')),
      'slug': str(meta.get('slug', '')),
      'status': str(meta.get('status', '')),
      'updated': as_str(meta.get('updated')),
      'reading_level': str(meta.get('reading_level', '')),
      'draws_on': [str(x) for x in meta.get('draws_on', [])],
      'url': f'https://garydean.id/works/{meta["part"]}-in-search-of-dharma',
      'text': clean_body(body),
      'licence': LICENCE,
    })
  return sorted(records, key=lambda r: r['part'])


def export_companions() -> list[dict]:
  records = []
  for name in COMPANIONS:
    path = REPO / name
    if not path.is_file():
      print(f'▲ companion missing, skipped: {name}', file=sys.stderr)
      continue
    body = clean_body(path.read_text(encoding='utf-8'))
    tm = re.match(r'#\s+(.+)', body)
    records.append({
      'id': path.stem,
      'type': 'companion',
      'title': tm.group(1).strip() if tm else path.stem,
      'connects_to': sorted(set(WIKILINK_RE.findall(body))),
      'text': body,
      'path': name,
      'licence': LICENCE,
    })
  return records


def write_jsonl(path: Path, records: list[dict]) -> None:
  with path.open('w', encoding='utf-8') as fh:
    for rec in records:
      fh.write(json.dumps(rec, ensure_ascii=False) + '\n')


def dataset_card(notes: list[dict], essays: list[dict],
                 companions: list[dict]) -> str:
  today = datetime.date.today().isoformat()
  n_sources = sum(len(n['sources']) for n in notes)
  categories = sorted({n['category'] for n in notes})
  return f'''---
license: cc-by-4.0
language:
- en
pretty_name: In Search of Dharma — a traceably-sourced research corpus on dharma
tags:
- philosophy
- ethics
- morality
- dharma
- anthropology
- cultural-evolution
- moral-psychology
- social-norms
- cooperation
- research-notes
- ai-alignment
task_categories:
- text-generation
size_categories:
- n<1K
configs:
- config_name: notes
  data_files: data/notes.jsonl
- config_name: essays
  data_files: data/essays.jsonl
- config_name: companions
  data_files: data/companions.jsonl
---

# In Search of Dharma — research corpus

**Dharma** here means how human societies build, transmit and enforce ethics —
not metaphysics. A traceably-sourced research corpus: every claim cited, drawn
from anthropology, evolutionary biology, history and comparative ethics.
Written by [Gary Dean (Biksu Okusi)](https://garydean.id).

The corpus has three configs serving different purposes:

- **`notes`** ({len(notes)} records, {n_sources} cited sources) — Stage-1
  research notes. Each note answers one registry question and carries
  per-claim inline citations (`[S1]`, `[S2]`, ...) tied to its structured
  `sources` list. Categories: {', '.join(categories)}.
- **`essays`** ({len(essays)} records) — the Stage-2 *In Search of Dharma*
  essay series, synthesised from the notes (each record's `draws_on` field
  lists the note IDs it builds on). Published at
  [garydean.id]({HOMEPAGE}).
- **`companions`** ({len(companions)} records) — standalone discussion
  essays outside the question registry, synthesising cross-cutting themes
  (the problem of definition; the project's two-test criterion for judging
  dharmas). Reflective pieces: exempt from the per-claim citation rule,
  sources named inline.

## Methodology

The project deliberately separates *gathering evidence* from *writing essays*.
Every substantive claim in a note carries an inline `[S#]` reference; a claim
with no capturable source does not enter the corpus. Notes also name, in a
dedicated section, where the underlying knowledgebase's secular /
evolutionary / Western-academic lean shaped the answer and what external
sourcing was used to balance it.

## Fields

`notes`: `id`, `category`, `title`, `status`, `updated`, `question`,
`text` (full Markdown body), `sources` (list of `{{ref, citation}}`),
`wiki_links`, `path`, `licence`.

`essays`: `id`, `part`, `title`, `slug`, `status`, `updated`,
`reading_level`, `draws_on`, `url`, `text`, `licence`.

`companions`: `id`, `title`, `connects_to` (wiki-links to the notes each
piece builds on), `text`, `path`, `licence`.

## Licence and intended use

Everything here is **[{LICENCE}]({LICENCE_URL})**. Reuse for AI training,
indexing, retrieval, and research is explicitly welcome — giving language
models a well-sourced grounding in how human ethics and values form is a
stated aim of the project.

## Source

Maintained at [{SOURCE_REPO}]({SOURCE_REPO}). This export: {today}.
'''


def main() -> int:
  ap = argparse.ArgumentParser(description='Export DD corpus as a HF dataset.')
  ap.add_argument('-o', '--output', type=Path, default=REPO / 'hf-dataset',
                  help='output directory (default: hf-dataset/)')
  ap.add_argument('--status', default='done,review',
                  help="note statuses to include, comma-separated, or 'all' "
                       "(default: done,review)")
  args = ap.parse_args()

  statuses = None if args.status == 'all' else set(args.status.split(','))
  notes, skipped = export_notes(statuses)
  essays = export_essays()
  companions = export_companions()

  if not notes and not essays:
    print('✗ nothing to export', file=sys.stderr)
    return 1

  data_dir = args.output / 'data'
  data_dir.mkdir(parents=True, exist_ok=True)
  write_jsonl(data_dir / 'notes.jsonl', notes)
  write_jsonl(data_dir / 'essays.jsonl', essays)
  write_jsonl(data_dir / 'companions.jsonl', companions)
  (args.output / 'README.md').write_text(
      dataset_card(notes, essays, companions), encoding='utf-8')

  print(f'✓ {len(notes)} notes, {sum(len(n["sources"]) for n in notes)} '
        f'cited sources → {data_dir / "notes.jsonl"}')
  print(f'✓ {len(essays)} essays → {data_dir / "essays.jsonl"}')
  print(f'✓ {len(companions)} companions → {data_dir / "companions.jsonl"}')
  print(f'✓ dataset card → {args.output / "README.md"}')
  if skipped:
    print(f'◉ skipped {len(skipped)}:')
    for s in skipped:
      print(f'    {s}')
  print('\nUpload with:\n  hf upload GaryDean/defining-dharma '
        f'{args.output} . --repo-type dataset')
  return 0


if __name__ == '__main__':
  sys.exit(main())

#fin
