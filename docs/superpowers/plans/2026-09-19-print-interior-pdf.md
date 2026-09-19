# Print-Interior PDF Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build a print-ready interior PDF of *In Search of Dharma* for Tuwhiri's printer, generated from the existing Markdown sources by script.

**Architecture:** A new `mk-print.sh` renders the book through pandoc and WeasyPrint at 152 × 229 mm, then hardens the result to IngramSpark's file rules. The front half of the pipeline (frontmatter stripping, the `<image ...>` shortcode, image staging) is lifted out of `mk-book.sh` into `lib/preprocess.sh` so both builds share one source of truth. A Python conformance tool, `lib/pdfcheck.py`, serves double duty as the test oracle and the build's preflight gate.

**Tech Stack:** Bash 5.2+, Python 3.12+, pandoc, WeasyPrint 69, Ghostscript, poppler-utils (`pdftotext`, `pdfinfo`, `pdffonts`, `pdfimages`), mupdf-tools (`mutool`), ImageMagick.

**Spec:** `docs/superpowers/specs/2026-09-19-print-interior-pdf-design.md`

## Global Constraints

- Shell: `#!/bin/bash`, `set -euo pipefail`, `shopt -s inherit_errexit`, 2-space indent, file ends with `#fin`.
- Python: `#!/usr/bin/env python3`, 2-space indent, file ends with `#fin`.
- Libraries under `lib/` are sourced, never executed. They carry the guard `[[ ${BASH_SOURCE[0]} != "$0" ]] || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }` and must not set shell options.
- Every modified `.sh` file passes `shellcheck` **and** the `bcscheck` skill before its task is declared done.
- Message icons: `◉` info, `⦿` debug, `▲` warning, `✓` success, `✗` error.
- Commit author is `Biksu-Okusi <biksu@okusi.id>`. Never name the assistant in a commit message. Use unquoted `EOF` heredocs. End every commit message with `Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5`.
- Never commit `CLAUDE.md`, `.claude/`, `deploy.conf`, or anything under `print/`.
- Trim size is exactly 152 × 229 mm, which is 430.866 × 649.134 pt. MediaBox equals trim on every page. No bleed, no TrimBox, no crop marks.
- Body setting is 10 pt on 16 pt leading in Bona Nova. Leading is 5.644 mm.
- Frozen layout constants, in mm: `top=24.58`, `headpad=13.35`, `foliopad=6.80`, `h1pad=55.34`, `h1gap=39.21`; drop cap `font-size: 3.200em`, `line-height: 0.688`.
- Target baselines, in mm from trim top: chapter title 87.59, opener first line 131.13, running head 16.80, first body line 29.53, folio 214.38. Tolerance 0.1 mm.

---

## File Structure

| Path | Responsibility |
|------|----------------|
| `.gitignore` | modify: exclude `print/`, exclude the built interior |
| `lib/pdfcheck.py` | new: measure a PDF's geometry, colour, fonts, images; assert IngramSpark conformance |
| `lib/preprocess.sh` | new: source preprocessing lifted verbatim from `mk-book.sh` |
| `lib/print-style.sh` | new: frozen geometry constants and the print stylesheet |
| `mk-print.sh` | new: the print-interior build |
| `mk-book.sh` | modify: source `lib/preprocess.sh` instead of defining `preprocess()`; lining-figures fix |
| `tests/run_tests.sh` | new: runner, discovers and runs `tests/test-*.sh` |
| `tests/test-preprocess.sh` | new: the extraction produces byte-identical output |
| `tests/test-print-style.sh` | new: rendered baselines land on the model grid |
| `tests/test-pdfcheck.sh` | new: conformance rules accept a good file and reject bad ones |
| `tests/golden/` | new: checksums captured from the pre-extraction script |

---

## Task 0: Keep the Tuwhiri samples out of the public repository

`print/` holds Tuwhiri's book extract, IngramSpark's checklist and Ramsey's
markup. None of it is ours to publish, and the repository is public under CC
BY 4.0. It is currently untracked but **not** ignored, so one `git add -A`
would push all of it.

**Files:**
- Modify: `.gitignore`

- [ ] **Step 1: Confirm the exposure**

```bash
cd /var/lib/vectordbs/seculardharma/projects/DefiningDharma
git status --short print/
git check-ignore -v print/ || echo "NOT IGNORED — this is the bug"
```

Expected: `?? print/` and `NOT IGNORED — this is the bug`.

- [ ] **Step 2: Add the ignore rule**

Append to `.gitignore`:

```gitignore

# Printer's reference material from Tuwhiri: their book extract, IngramSpark's
# file checklist, and Ramsey's marked-up typographic specs. Third-party
# copyright, supplied for reference only. This repository is public, so none of
# it may ever be committed. The measurements taken from these files live in
# docs/superpowers/specs/2026-09-19-print-interior-pdf-design.md, which is the
# durable record; the files themselves are disposable.
print/

# The print interior, rebuilt on demand from the sources like every other
# artefact in this list.
In-Search-of-Dharma_interior_*.pdf
```

- [ ] **Step 3: Verify the rule bites**

```bash
git check-ignore -v print/ && echo "✓ ignored"
git status --short | grep -c '^?? print/' || echo "✓ no longer offered"
```

Expected: `✓ ignored`, and `print/` absent from `git status`.

- [ ] **Step 4: Commit**

```bash
git add .gitignore
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
chore(git): never track the printer's third-party reference material

print/ holds Tuwhiri's book extract, IngramSpark's file checklist and
Ramsey's marked-up specs. None is ours to publish and this repository is
public. The measurements taken from them are recorded in the design spec,
which is the durable record.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 3
```

---

## Task 1: `lib/pdfcheck.py`, the measurement and conformance tool

This is the test oracle for every later task and the build's preflight gate. It
is written first so that everything after it is verifiable.

**Files:**
- Create: `lib/pdfcheck.py`
- Create: `tests/run_tests.sh`
- Test: `tests/test-pdfcheck.sh`

**Interfaces:**
- Consumes: nothing from earlier tasks.
- Produces:
  - `lib/pdfcheck.py measure FILE` prints JSON with keys `pages`, `trim_mm` (a
    two-element list), `boxes_equal` (bool), `fonts` (list of
    `{name, embedded, subset}`), `colorspaces` (list of str), `images` (list of
    `{page, colorspace, ppi, has_icc}`), `ink_to_trim_mm` (dict with keys
    `top`, `bottom`, `left`, `right`), `blank_pages` (list of 1-based ints).
  - `lib/pdfcheck.py baselines FILE --page N` prints JSON `{"lines": [{"y_mm":
    float, "x0_mm": float, "text": str}]}`, y measured from the trim top.
  - `lib/pdfcheck.py check FILE` exits 0 when every rule passes, 1 otherwise,
    printing one `✗ rule: detail` line per failure and `▲ rule: detail` per
    warning.

- [ ] **Step 1: Write the failing test**

Create `tests/test-pdfcheck.sh`:

```bash
#!/bin/bash
# tests/test-pdfcheck.sh - lib/pdfcheck.py accepts a conforming interior and
# rejects each way of breaking conformance.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r CHECK=$ROOT/lib/pdfcheck.py
declare -i FAILED=0

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }

# Build a minimal conforming interior: 2 pages, 152x229mm, black text, blank
# final page.
make_pdf() {
  local -- out=$1 size=${2:-152mm 229mm} colour=${3:-#000} pages=${4:-2}
  local -- html=$TMP/in.html body='' i
  for ((i = 1; i < pages; i++)); do
    body+="<p>Page $i text.</p><p style=\"break-after:page\"></p>"
  done
  cat >"$html" <<HTML
<!doctype html><html lang="en"><head><meta charset="utf-8"><style>
@font-face{font-family:BN;src:url(file://$(realpath "$ROOT")/fonts/bonanova/BonaNova-Regular.ttf)}
@page{size:$size;margin:25mm 20mm}
body{font-family:BN;font-size:10pt;line-height:16pt;color:$colour;margin:0}
</style></head><body>$body</body></html>
HTML
  weasyprint "$html" "$out" 2>/dev/null
}

TMP=$(mktemp -d)
trap 'rm -rf -- "$TMP"' EXIT

echo '== pdfcheck =='

make_pdf "$TMP/good.pdf"
gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite -dProcessColorModel=/DeviceGray \
   -sColorConversionStrategy=Gray -dCompatibilityLevel=1.6 -dSubsetFonts=true \
   -dEmbedAllFonts=true -dAutoRotatePages=/None \
   -sOutputFile="$TMP/good-gray.pdf" "$TMP/good.pdf"

# measure reports the trim
trim=$("$CHECK" measure "$TMP/good-gray.pdf" | python3 -c 'import json,sys;d=json.load(sys.stdin);print(f"{d[\"trim_mm\"][0]:.1f}x{d[\"trim_mm\"][1]:.1f}")')
[[ $trim == 152.0x229.0 ]] && ok "measure reports 152.0x229.0" || bad "measure reported $trim"

# check accepts the conforming file
"$CHECK" check "$TMP/good-gray.pdf" >/dev/null 2>&1 \
  && ok 'check accepts a conforming interior' \
  || bad 'check rejected a conforming interior'

# check rejects an odd page count. --require-even is mandatory here: without it
# the rule is never armed and this test would pass against a tool that does
# nothing at all.
make_pdf "$TMP/odd.pdf" '152mm 229mm' '#000' 3
"$CHECK" check "$TMP/odd.pdf" --require-even >/dev/null 2>&1 \
  && bad 'check accepted an odd page count' \
  || ok 'check rejects an odd page count'

# check rejects the wrong trim
make_pdf "$TMP/a4.pdf" 'A4'
"$CHECK" check "$TMP/a4.pdf" >/dev/null 2>&1 \
  && bad 'check accepted the wrong trim size' \
  || ok 'check rejects the wrong trim size'

# check rejects RGB colour (WeasyPrint's native output, before the gs pass)
"$CHECK" check "$TMP/good.pdf" >/dev/null 2>&1 \
  && bad 'check accepted non-grey colour' \
  || ok 'check rejects non-grey colour'

((FAILED == 0)) || exit 1
#fin
```

- [ ] **Step 2: Run it to make sure it fails**

```bash
chmod +x tests/test-pdfcheck.sh && ./tests/test-pdfcheck.sh
```

Expected: FAIL, with `lib/pdfcheck.py: No such file or directory`.

- [ ] **Step 3: Write `lib/pdfcheck.py`**

```python
#!/usr/bin/env python3
"""Measure and conformance-check a print-interior PDF.

Serves two callers: the test suite, which asks for measurements, and
mk-print.sh, which asks for a verdict. Every rule is checked against the
finished file, never against intent.

Usage:
  pdfcheck.py measure FILE
  pdfcheck.py baselines FILE [--page N]
  pdfcheck.py check FILE [--trim WxH] [--require-even] [--require-blank-last]
"""
import argparse
import json
import re
import subprocess
import sys

PT_MM = 25.4 / 72.0
TRIM_W_PT, TRIM_H_PT = 430.866, 649.134
INK_WARN_MM = 13.0   # IngramSpark's stated minimum
INK_FAIL_MM = 12.0   # below the model book's own 12.20mm, so certainly wrong
MIN_PPI = 300


def run(*args):
  """Run a tool and return stdout, raising with context on failure."""
  p = subprocess.run(args, capture_output=True, text=True)
  if p.returncode != 0:
    raise RuntimeError(f"{args[0]} failed: {p.stderr.strip()[:200]}")
  return p.stdout


def page_boxes(path):
  """Return [(media, trim)] per page, each a 4-tuple in points."""
  out = run('mutool', 'pages', path)
  boxes = []
  for blk in re.findall(r'<page pagenum="\d+">(.*?)</page>', out, re.S):
    def box(tag):
      m = re.search(rf'<{tag} l="([-\d.]+)" b="([-\d.]+)" '
                    rf'r="([-\d.]+)" t="([-\d.]+)" />', blk)
      return tuple(float(g) for g in m.groups()) if m else None
    boxes.append((box('MediaBox'), box('TrimBox')))
  return boxes


def fonts(path):
  out = run('pdffonts', path)
  rows = []
  for line in out.splitlines()[2:]:
    if not line.strip():
      continue
    f = line.split()
    if len(f) < 8:
      continue
    rows.append({'name': f[0], 'embedded': f[-5] == 'yes', 'subset': f[-4] == 'yes'})
  return rows


def colorspaces(path, pages):
  """Colour spaces named by actual drawing operators.

  Only fill/stroke operators count as ink. The <set_default_colorspaces>
  element names DeviceRGB and DeviceCMYK on every page as a declaration, not
  as a mark, so matching it would fail every file ever produced.
  """
  ops = set()
  for n in range(1, pages + 1):
    out = run('mutool', 'draw', '-F', 'trace', '-o', '-', path, str(n))
    for m in re.finditer(r'<(?:fill|stroke)_(?:text|path)[^>]*'
                         r'colorspace="([^"]+)"', out):
      ops.add(m.group(1))
  return sorted(ops)


def images(path):
  out = run('pdfimages', '-list', path)
  rows = []
  for line in out.splitlines()[2:]:
    f = line.split()
    if len(f) < 15 or f[1] == 'num':
      continue
    rows.append({'page': int(f[0]), 'type': f[2], 'colorspace': f[5],
                 'ppi': min(_num(f[12]), _num(f[13]))})
  return rows


def _num(s):
  try:
    return float(s)
  except ValueError:
    return 0.0


def words(path, first=None, last=None):
  """Yield (page_index, x0, y0, x1, y1, text) in points, origin at page top."""
  args = ['pdftotext', '-bbox']
  if first:
    args += ['-f', str(first), '-l', str(last or first)]
  out = run(*args, path, '-')
  for i, pm in enumerate(re.finditer(
      r'<page width="([\d.]+)" height="([\d.]+)">(.*?)</page>', out, re.S), 1):
    page = (first or 1) + i - 1
    for a, b, c, d, t in re.findall(
        r'<word xMin="([\d.]+)" yMin="([\d.]+)" '
        r'xMax="([\d.]+)" yMax="([\d.]+)">(.*?)</word>', pm.group(3)):
      yield page, float(a), float(b), float(c), float(d), t


def ink_to_trim(path, w_pt, h_pt):
  worst = {'top': 1e9, 'bottom': 1e9, 'left': 1e9, 'right': 1e9}
  for _, x0, y0, x1, y1, _t in words(path):
    worst['top'] = min(worst['top'], y0)
    worst['bottom'] = min(worst['bottom'], h_pt - y1)
    worst['left'] = min(worst['left'], x0)
    worst['right'] = min(worst['right'], w_pt - x1)
  return {k: round(v * PT_MM, 2) for k, v in worst.items() if v < 1e9}


def blank_pages(path, pages):
  """1-based page numbers carrying neither text nor drawing operators."""
  blank = []
  for n in range(1, pages + 1):
    txt = run('pdftotext', '-f', str(n), '-l', str(n), path, '-').strip()
    if txt:
      continue
    trace = run('mutool', 'draw', '-F', 'trace', '-o', '-', path, str(n))
    if not re.search(r'<(?:fill|stroke)_(?:text|path)', trace):
      blank.append(n)
  return blank


def measure(path):
  boxes = page_boxes(path)
  n = len(boxes)
  media = boxes[0][0]
  w_pt, h_pt = media[2] - media[0], media[3] - media[1]
  return {
    'pages': n,
    'trim_mm': [round(w_pt * PT_MM, 2), round(h_pt * PT_MM, 2)],
    'boxes_equal': all(t is None or t == m for m, t in boxes),
    'uniform_size': all(
      abs((m[2] - m[0]) - w_pt) < 0.1 and abs((m[3] - m[1]) - h_pt) < 0.1
      for m, _ in boxes),
    'fonts': fonts(path),
    'colorspaces': colorspaces(path, n),
    'images': images(path),
    'ink_to_trim_mm': ink_to_trim(path, w_pt, h_pt),
    'blank_pages': blank_pages(path, n),
  }


def baselines(path, page):
  lines = {}
  for _p, x0, _y0, x1, y1, t in words(path, page, page):
    lines.setdefault(round(y1, 1), []).append((x0, x1, t))
  out = []
  for y in sorted(lines):
    ws = sorted(lines[y])
    out.append({'y_mm': round(y * PT_MM, 2),
                'x0_mm': round(ws[0][0] * PT_MM, 2),
                'x1_mm': round(max(w[1] for w in ws) * PT_MM, 2),
                'text': ' '.join(w[2] for w in ws)})
  return {'lines': out}


def check(path, trim, require_even, require_blank_last):
  m = measure(path)
  fail, warn = [], []

  tw, th = trim
  if abs(m['trim_mm'][0] - tw) > 0.1 or abs(m['trim_mm'][1] - th) > 0.1:
    fail.append(('trim', f"{m['trim_mm'][0]}x{m['trim_mm'][1]}mm, want {tw}x{th}mm"))
  if not m['uniform_size']:
    fail.append(('trim', 'page sizes are not uniform'))
  if not m['boxes_equal']:
    fail.append(('boxes', 'a TrimBox/BleedBox differs from the MediaBox; '
                          'IngramSpark forbids crop and registration marks'))
  if require_even and m['pages'] % 2:
    fail.append(('parity', f"{m['pages']} pages, must be a multiple of 2"))
  if require_blank_last and m['pages'] not in m['blank_pages']:
    fail.append(('last-page', 'the final page carries ink; it must be blank'))

  for f in m['fonts']:
    if not f['embedded']:
      fail.append(('fonts', f"{f['name']} is not embedded"))

  for cs in m['colorspaces']:
    if cs != 'DeviceGray':
      fail.append(('colour', f"{cs} used; a B&W interior must be DeviceGray only"))

  for im in m['images']:
    if im['colorspace'] not in ('gray', 'index'):
      fail.append(('images', f"page {im['page']}: {im['colorspace']}, must be grayscale"))
    if im['ppi'] and im['ppi'] < MIN_PPI:
      fail.append(('images', f"page {im['page']}: {im['ppi']:.0f} ppi, want >= {MIN_PPI}"))

  for edge, v in sorted(m['ink_to_trim_mm'].items()):
    if v < INK_FAIL_MM:
      fail.append(('margins', f"ink {v}mm from the {edge} trim, below {INK_FAIL_MM}mm"))
    elif v < INK_WARN_MM:
      warn.append(('margins', f"ink {v}mm from the {edge} trim; "
                              f"IngramSpark states {INK_WARN_MM}mm minimum"))

  for kind, detail in warn:
    print(f"▲ {kind}: {detail}", file=sys.stderr)
  for kind, detail in fail:
    print(f"✗ {kind}: {detail}", file=sys.stderr)
  if not fail:
    print(f"✓ conforms: {m['pages']} pages at "
          f"{m['trim_mm'][0]}x{m['trim_mm'][1]}mm", file=sys.stderr)
  return 1 if fail else 0


def main():
  ap = argparse.ArgumentParser(description=__doc__)
  ap.add_argument('action', choices=('measure', 'baselines', 'check'))
  ap.add_argument('file')
  ap.add_argument('--page', type=int, default=1)
  ap.add_argument('--trim', default='152x229')
  ap.add_argument('--require-even', action='store_true')
  ap.add_argument('--require-blank-last', action='store_true')
  a = ap.parse_args()
  if a.action == 'measure':
    print(json.dumps(measure(a.file), indent=2))
  elif a.action == 'baselines':
    print(json.dumps(baselines(a.file, a.page), indent=2))
  else:
    w, h = (float(v) for v in a.trim.split('x'))
    return check(a.file, (w, h), a.require_even, a.require_blank_last)
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
```

- [ ] **Step 4: Write the test runner**

Create `tests/run_tests.sh`:

```bash
#!/bin/bash
# tests/run_tests.sh - run every tests/test-*.sh, report a pass count.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -i PASS=0 FAIL=0
declare -a FAILED=()
declare -- t

for t in "$TEST_DIR"/test-*.sh; do
  [[ -f $t ]] || continue
  if bash "$t"; then
    PASS+=1
  else
    FAIL+=1
    FAILED+=("${t##*/}")
  fi
done

printf '\n%d/%d test files passed\n' "$PASS" "$((PASS + FAIL))"
((FAIL == 0)) || { printf '✗ failed: %s\n' "${FAILED[*]}"; exit 1; }
printf '✓ all green\n'
#fin
```

- [ ] **Step 5: Run the tests and make sure they pass**

```bash
chmod +x lib/pdfcheck.py tests/run_tests.sh tests/test-pdfcheck.sh
./tests/run_tests.sh
```

Expected: `1/1 test files passed` and `✓ all green`.

- [ ] **Step 6: Lint**

```bash
shellcheck tests/run_tests.sh tests/test-pdfcheck.sh
```

Then run the `bcscheck` skill over both files. Fix every ERROR; justify or fix
every WARN.

- [ ] **Step 7: Commit**

```bash
git add lib/pdfcheck.py tests/run_tests.sh tests/test-pdfcheck.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): add a PDF conformance tool and a test harness

lib/pdfcheck.py measures a PDF's trim, boxes, colour operators, fonts,
image resolution and ink-to-trim distances, and asserts IngramSpark's
interior rules against the finished file. It is both the test oracle for
the print build and that build's preflight gate.

The ink-to-trim rule is two-tier: warn below 13mm, which IngramSpark
states as the minimum, and fail below 12mm, which is looser than the
publisher's own printed book at 12.20mm.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 3
```

---

## Task 2: Extract `preprocess()` into `lib/preprocess.sh`

`mk-book.sh` lines 213 to 275 hold the documentation block and the
`preprocess()` function. They move to `lib/preprocess.sh` unchanged. The proof
of correctness is that output stays byte-identical.

**Files:**
- Create: `lib/preprocess.sh`
- Create: `tests/golden/preprocess.sha256`
- Modify: `mk-book.sh:213-275` (remove), `mk-book.sh:141` (source the new lib after `lib/fonts.sh`)
- Test: `tests/test-preprocess.sh`

**Interfaces:**
- Consumes: nothing.
- Produces: `preprocess SRC` writes pandoc-ready Markdown to stdout. It reads the
  globals `REPO_URL` and `REPO_BLOB`, which the calling script must declare
  before sourcing.

- [ ] **Step 1: Capture the golden output from the current script**

This must happen **before** any edit to `mk-book.sh`, because it is the baseline.

```bash
cd /var/lib/vectordbs/seculardharma/projects/DefiningDharma
mkdir -p tests/golden
{
  echo '#!/bin/bash'
  echo 'declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma'
  echo 'declare -r REPO_BLOB="$REPO_URL"/blob/main'
  sed -n '254,275p' mk-book.sh
  echo 'preprocess "$1"'
} > /tmp/golden-preprocess.sh
for f in cover.md 0-preface.md [1-9]-*.md the-better-ones.md; do
  printf '%s  %s\n' "$(bash /tmp/golden-preprocess.sh "$f" | sha256sum | cut -d' ' -f1)" "$f"
done > tests/golden/preprocess.sha256
wc -l tests/golden/preprocess.sha256
```

Expected: 12 lines, one per source file.

- [ ] **Step 2: Write the failing test**

Create `tests/test-preprocess.sh`:

```bash
#!/bin/bash
# tests/test-preprocess.sh - lib/preprocess.sh reproduces, byte for byte, what
# mk-book.sh produced before the function was extracted.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r GOLDEN=$TEST_DIR/golden/preprocess.sha256
declare -i FAILED=0

declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main
#shellcheck source=../lib/preprocess.sh
source "$ROOT"/lib/preprocess.sh

echo '== preprocess parity =='
[[ -f $GOLDEN ]] || { printf '  ✗ missing golden file %s\n' "$GOLDEN"; exit 1; }

declare -- want file got
while read -r want file; do
  got=$( cd -- "$ROOT" && preprocess "$file" | sha256sum | cut -d' ' -f1 )
  if [[ $got == "$want" ]]; then
    printf '  ✓ %s\n' "$file"
  else
    printf '  ✗ %s: got %s want %s\n' "$file" "${got:0:12}" "${want:0:12}"
    FAILED+=1
  fi
done < "$GOLDEN"

((FAILED == 0)) || exit 1
#fin
```

- [ ] **Step 3: Run it to make sure it fails**

```bash
chmod +x tests/test-preprocess.sh && ./tests/test-preprocess.sh
```

Expected: FAIL with `lib/preprocess.sh: No such file or directory`.

- [ ] **Step 4: Create `lib/preprocess.sh`**

Write the library header, then paste `mk-book.sh` lines 213 to 275 **verbatim**.
Do not reword the comments; they are the record of why each rule exists.

```bash
{
  cat <<'HEADER'
#!/bin/bash
#shellcheck shell=bash
# lib/preprocess.sh - Markdown source preprocessing for the In Search of Dharma
# book builds.
#
# Sourced (never executed) by mk-book.sh and mk-print.sh, which render the same
# sources to different targets and so must agree exactly on what the sources
# mean. Extracted from mk-book.sh unchanged; the rules below are the record of
# why each rewrite exists, and are not to be reworded casually.
#
# Usage:
#   declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
#   declare -r REPO_BLOB="$REPO_URL"/blob/main
#   source "$SCRIPT_DIR"/lib/preprocess.sh
#   preprocess path/to/essay.md > staged.md
#
# Requires REPO_URL and REPO_BLOB to be declared by the caller before sourcing.

# Library only: it defines a function and does nothing on its own, so running it
# is always a mistake worth naming. No `set -euo pipefail` here -- that belongs
# to the calling script and must never be forced on its shell.
[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

HEADER
  sed -n '213,275p' mk-book.sh
  printf '\n#fin\n'
} > lib/preprocess.sh
chmod 0644 lib/preprocess.sh
```

- [ ] **Step 5: Run the test to verify it passes**

```bash
./tests/test-preprocess.sh
```

Expected: 12 lines each beginning `✓`.

- [ ] **Step 6: Remove the function from `mk-book.sh` and source the library**

Delete lines 213 to 275 of `mk-book.sh`, and immediately after the existing
`source "$FONT_LIB"` block (line 141) insert:

```bash
# Source preprocessing lives in lib/preprocess.sh, which mk-print.sh sources
# too: one set of sources, one reading of what they mean. It needs REPO_URL and
# REPO_BLOB, declared above.
declare -r PREPROCESS_LIB="$SCRIPT_DIR"/lib/preprocess.sh
[[ -f $PREPROCESS_LIB ]] \
  || { >&2 echo "✗ missing preprocessing library ${PREPROCESS_LIB@Q}"; exit 3; }
#shellcheck source=lib/preprocess.sh
source "$PREPROCESS_LIB" \
  || { >&2 echo "✗ failed to source ${PREPROCESS_LIB@Q}"; exit 1; }
```

▲ `REPO_URL` and `REPO_BLOB` are declared at `mk-book.sh:89-90`, above the
`lib/fonts.sh` source block, so the ordering already works. Verify it rather
than assuming.

- [ ] **Step 7: Prove `mk-book.sh` is unchanged end to end**

The EPUB and PDF embed build timestamps, so compare rendered content, not files.

```bash
./mk-book.sh all --quiet
pdftotext In-Search-of-Dharma_Biksu-Okusi_2026.pdf - | sha256sum
mkdir -p /tmp/epubcmp && (cd /tmp/epubcmp && rm -rf ./* \
  && unzip -q -o "$OLDPWD"/In-Search-of-Dharma_Biksu-Okusi_2026.epub \
  && find . -name '*.xhtml' | sort | xargs cat | sha256sum)
```

Record both checksums. They must equal the checksums taken from a build made
from `git stash`-ed (pre-change) sources. If either differs, the extraction was
not verbatim: revert and redo Step 4.

- [ ] **Step 8: Lint**

```bash
shellcheck -x mk-book.sh lib/preprocess.sh tests/test-preprocess.sh
```

Then run the `bcscheck` skill over all three.

- [ ] **Step 9: Commit**

```bash
git add lib/preprocess.sh mk-book.sh tests/test-preprocess.sh tests/golden/preprocess.sha256
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
refactor(build): extract source preprocessing into lib/preprocess.sh

The print interior renders the same sources as the EPUB and the reading
PDF, so the two builds must agree exactly on what those sources mean.
The function moves verbatim; the golden checksums in tests/ prove its
output is byte-identical to what mk-book.sh produced before the move.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 3
```

---

## Task 3: `lib/print-style.sh`, the geometry and the stylesheet

**Files:**
- Create: `lib/print-style.sh`
- Test: `tests/test-print-style.sh`

**Interfaces:**
- Consumes: `font_faces_css` and the `FONT_*` globals from `lib/fonts.sh`.
- Produces:
  - `print_geom_load [SIZE_PT] [LEAD_PT]` populates `PRINT_TRIM_W_MM`,
    `PRINT_TRIM_H_MM`, `PRINT_MEASURE_MM`, `PRINT_INNER_MM`, `PRINT_OUTER_MM`,
    `PRINT_TOP_MM`, `PRINT_BOT_MM`, `PRINT_HEADPAD_MM`, `PRINT_FOLIOPAD_MM`,
    `PRINT_H1PAD_MM`, `PRINT_H1GAP_MM`, `PRINT_DROP_FS`, `PRINT_DROP_LH`,
    `PRINT_SIZE_PT`, `PRINT_LEAD_PT`, `PRINT_SUB_PT`, `PRINT_SRC_PT`.
    Defaults are 10 and 16. Any other pair is a proof setting and prints a
    warning, because the frozen constants were solved for 10 on 16.
  - `print_page_css` writes the complete print stylesheet to stdout.

- [ ] **Step 1: Write the failing test**

Create `tests/test-print-style.sh`:

```bash
#!/bin/bash
# tests/test-print-style.sh - the print stylesheet puts every baseline on the
# grid measured from Tuwhiri's The secular path to well-being.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -i FAILED=0
declare -r TOL=0.1

# Target baselines in mm from the trim top, measured from the model book.
declare -rA TARGET=(
  [title]=87.59 [opener]=131.13 [head]=16.80 [first]=29.53 [folio]=214.38
)

TMP=$(mktemp -d); trap 'rm -rf -- "$TMP"' EXIT

#shellcheck source=../lib/fonts.sh
source "$ROOT"/lib/fonts.sh
font_set_load bonanova-worksans "$ROOT"/fonts
#shellcheck source=../lib/print-style.sh
source "$ROOT"/lib/print-style.sh
print_geom_load

{ font_faces_css pdf; print_page_css; } > "$TMP"/print.css

cat > "$TMP"/fixture.html <<'HTML'
<!doctype html><html lang="en"><head><meta charset="utf-8">
<link rel="stylesheet" href="print.css"></head><body>
<section class="chapter"><h1>Preface</h1>
<p class="op">Most books that refer to the word 'dharma' come from one of two
places: a monastery or a university, or somewhere in their vicinity. A teacher
hands down a lineage received from their own teacher, or a scholar maps the
territory from a careful distance. This one comes from neither. It was written
by a lifelong anarchist, raised on the remote western rim of Australia: a
naturalised Indonesian now, writing from the island of Bali.</p>
<p>A preface is normally a throat-clearing, the part most sensible readers skip
on the way to Part 1. I would ask you not to skip this one; I have made it
longer than is fashionable on purpose, and the eight parts that follow make
fairly bold assertions about where our worldviews and ethics come from.</p>
<p>A third paragraph, present so the fixture runs onto a second page and the
running head and folio have somewhere to appear for measurement purposes, with
enough text to guarantee the overflow under any reasonable setting whatsoever.
A third paragraph, present so the fixture runs onto a second page and the
running head and folio have somewhere to appear for measurement purposes.</p>
</section></body></html>
HTML

weasyprint "$TMP"/fixture.html "$TMP"/fixture.pdf 2>/dev/null

b() { "$ROOT"/lib/pdfcheck.py baselines "$TMP"/fixture.pdf --page "$1"; }

assert_near() {
  local -- name=$1 got=$2 want=${TARGET[$1]}
  if awk -v g="$got" -v w="$want" -v t="$TOL" 'BEGIN{exit !(g-w<t && w-g<t)}'; then
    printf '  ✓ %-7s %8s (want %s)\n' "$name" "$got" "$want"
  else
    printf '  ✗ %-7s %8s (want %s)\n' "$name" "$got" "$want"; FAILED+=1
  fi
}

echo '== print geometry =='
assert_near title  "$(b 1 | jq -r '.lines[] | select(.text=="Preface") | .y_mm')"
assert_near opener "$(b 1 | jq -r '[.lines[] | select(.text|startswith("ost"))][0].y_mm')"
assert_near head   "$(b 2 | jq -r '.lines[0].y_mm')"
assert_near first  "$(b 2 | jq -r '.lines[1].y_mm')"
assert_near folio  "$(b 2 | jq -r '.lines[-1].y_mm')"

# measure and margins
measure=$(b 2 | jq -r '[.lines[1].x0_mm, .lines[1].x1_mm] | @tsv')
read -r x0 x1 <<<"$measure"
awk -v a="$x0" -v b="$x1" 'BEGIN{w=b-a; exit !(w>106.5 && w<107.5)}' \
  && printf '  ✓ measure %.1fmm\n' "$(awk -v a="$x0" -v b="$x1" 'BEGIN{print b-a}')" \
  || { printf '  ✗ measure is not 107mm (%s..%s)\n' "$x0" "$x1"; FAILED+=1; }

((FAILED == 0)) || exit 1
#fin
```

- [ ] **Step 2: Run it to make sure it fails**

```bash
chmod +x tests/test-print-style.sh && ./tests/test-print-style.sh
```

Expected: FAIL with `lib/print-style.sh: No such file or directory`.

- [ ] **Step 3: Write `lib/print-style.sh`**

```bash
#!/bin/bash
#shellcheck shell=bash disable=SC2034
# lib/print-style.sh - page geometry and stylesheet for the print interior.
#
# Sourced (never executed) by mk-print.sh. Holds the frozen layout constants
# that put every baseline on the grid of Tuwhiri's The secular path to
# well-being, the book Tuwhiri asked this one to follow.
#
# Usage:
#   source "$SCRIPT_DIR"/lib/fonts.sh
#   font_set_load bonanova-worksans "$SCRIPT_DIR"/fonts
#   source "$SCRIPT_DIR"/lib/print-style.sh
#   print_geom_load            # or: print_geom_load 10.5 17  (a proof setting)
#   { font_faces_css pdf; print_page_css; } > print.css
#
# The constants below were solved numerically against the model book and are
# frozen. They are specific to 10pt on 16pt leading in Bona Nova; any other
# setting needs them re-solved, which is what mk-print.sh --solve does.

[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

# Trim and margins, in mm. Measured from the model book and confirmed against
# Ramsey's marked-up recto and verso scans. The gutter is the larger of the two
# because a perfect-bound spine swallows part of it.
declare -r PRINT_TRIM_W_MM=152 PRINT_TRIM_H_MM=229
declare -r PRINT_MEASURE_MM=107 PRINT_INNER_MM=25 PRINT_OUTER_MM=20

# Populated by print_geom_load. Declared here so a `set -u` script may reference
# them before the call.
declare -- PRINT_SIZE_PT='' PRINT_LEAD_PT='' PRINT_SUB_PT='' PRINT_SRC_PT=''
declare -- PRINT_TOP_MM='' PRINT_BOT_MM='' PRINT_HEADPAD_MM='' PRINT_FOLIOPAD_MM=''
declare -- PRINT_H1PAD_MM='' PRINT_H1GAP_MM='' PRINT_DROP_FS='' PRINT_DROP_LH=''

# The shipping setting, and the constants solved for it.
print_geom_load() {
  PRINT_SIZE_PT=${1:-10} PRINT_LEAD_PT=${2:-16}
  if [[ $PRINT_SIZE_PT != 10 || $PRINT_LEAD_PT != 16 ]]; then
    >&2 printf '▲ %s: %spt on %spt is a proof setting; the frozen constants were solved for 10 on 16. Run mk-print.sh --solve.\n' \
      "${BASH_SOURCE[0]##*/}" "$PRINT_SIZE_PT" "$PRINT_LEAD_PT"
  fi
  PRINT_SUB_PT=12 PRINT_SRC_PT=9
  PRINT_TOP_MM=24.58 PRINT_BOT_MM=24.5
  PRINT_HEADPAD_MM=13.35 PRINT_FOLIOPAD_MM=6.80
  PRINT_H1PAD_MM=55.34 PRINT_H1GAP_MM=39.21
  PRINT_DROP_FS=3.200 PRINT_DROP_LH=0.688
}

# The complete print stylesheet. Written after font_faces_css pdf, which binds
# every face by absolute file:// URL.
print_page_css() {
  cat <<CSS
@page{size:${PRINT_TRIM_W_MM}mm ${PRINT_TRIM_H_MM}mm;
  margin:${PRINT_TOP_MM}mm ${PRINT_OUTER_MM}mm ${PRINT_BOT_MM}mm ${PRINT_INNER_MM}mm;
  @top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page:left{margin-left:${PRINT_OUTER_MM}mm;margin-right:${PRINT_INNER_MM}mm;
  @top-left{content:string(booktitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-left{content:counter(page);font:600 8pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_FOLIOPAD_MM}mm}}
@page:right{margin-left:${PRINT_INNER_MM}mm;margin-right:${PRINT_OUTER_MM}mm;
  @top-right{content:string(chaptitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-right{content:counter(page);font:600 8pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_FOLIOPAD_MM}mm}}
@page:blank{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page chapopen{@top-left{content:none}@top-right{content:none}}
@page front{
  @bottom-left{content:counter(page,lower-roman)}
  @bottom-right{content:counter(page,lower-roman)}
  @top-left{content:none}@top-right{content:none}}

html{font-family:"$FONT_SERIF_FAMILY",serif;font-size:${PRINT_SIZE_PT}pt;
  line-height:${PRINT_LEAD_PT}pt;color:#000;hyphens:auto;
  font-variant-numeric:lining-nums;
  font-feature-settings:"lnum" 1,"liga" 1,"kern" 1}
body{margin:0;string-set:booktitle "In search of dharma"}

h1{page:chapopen;break-before:recto;margin:0 0 0 10mm;
  font:600 20pt/1 "$FONT_SANS_FAMILY";
  padding-top:${PRINT_H1PAD_MM}mm;padding-bottom:${PRINT_H1GAP_MM}mm;
  string-set:chaptitle content()}
h2{font:600 ${PRINT_SUB_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}
h3{font:600 ${PRINT_SIZE_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}

p{margin:0;text-align:justify;text-indent:10mm;widows:2;orphans:2}
p.op,h1+p,h2+p,h3+p,blockquote+p{text-indent:0}
blockquote{margin:${PRINT_LEAD_PT}pt 0 ${PRINT_LEAD_PT}pt 8mm;font-style:italic}
blockquote p{text-indent:0}
p.attrib{text-indent:20mm;font:600 9pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY"}
.sources p{font-size:${PRINT_SRC_PT}pt}
ul,ol{margin:${PRINT_LEAD_PT}pt 0;padding-left:8mm}

h1+p::first-letter{float:left;font-size:${PRINT_DROP_FS}em;
  line-height:${PRINT_DROP_LH};padding:0 0.06em 0 0}
.sc{font-variant-caps:small-caps;letter-spacing:0.02em}

section.front{page:front}
section.front h1{break-before:auto;page:front;padding-top:0;padding-bottom:${PRINT_LEAD_PT}pt}
section.chapter:first-of-type{counter-reset:page 1}

nav.contents a{text-decoration:none;color:#000}
nav.contents a::after{content:leader('.') target-counter(attr(href), page)}

img{max-width:100%;height:auto;display:block;margin:0 auto}
CSS
}
#fin
```

- [ ] **Step 4: Run the test to verify it passes**

```bash
./tests/test-print-style.sh
```

Expected: five `✓` baseline lines and `✓ measure 107.0mm`.

- [ ] **Step 5: Lint**

```bash
shellcheck -x lib/print-style.sh tests/test-print-style.sh
```

Then run the `bcscheck` skill over both.

- [ ] **Step 6: Commit**

```bash
git add lib/print-style.sh tests/test-print-style.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): add the print page geometry and stylesheet

Trim 152x229mm, 107mm measure, 25mm gutter and 20mm outer margin,
mirrored across the spread. The layout constants were solved against the
baselines of The secular path to well-being, the Tuwhiri book this one
is asked to follow, and the test asserts every baseline lands within
0.1mm of that grid.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 3
```

---

## Task 4: `mk-print.sh`, the body build

The first build that produces a real book: chapters only, no front matter. It
establishes the script's shape, option parsing and staging.

**Files:**
- Create: `mk-print.sh`

**Interfaces:**
- Consumes: `preprocess` from `lib/preprocess.sh`; `font_set_load` and
  `font_faces_css` from `lib/fonts.sh`; `print_geom_load` and `print_page_css`
  from `lib/print-style.sh`.
- Produces: `In-Search-of-Dharma_interior_152x229.pdf` in the script directory,
  and, for the tasks that follow, these `main`-scope variables: `TMP_DIR`,
  `img_stage` (`$TMP_DIR/img`), `raw_pdf` (`$TMP_DIR/raw.pdf`, the WeasyPrint
  output before hardening), `OUTPUT_PDF`, `sources[]`, and the readonly
  `JPEG_QUALITY`.

- [ ] **Step 1: Write the script header and helpers**

```bash
#!/bin/bash
# mk-print.sh - Build the print-ready interior PDF of "In Search of Dharma"
# for Tuwhiri's printer.
#
#   ./mk-print.sh [--size PT] [--lead PT] [--fonts SET] [--quiet] [--keep-temp]
#   ./mk-print.sh --preflight FILE     # check an existing PDF and stop
#
# The interior only. A print cover is a separate artefact and a separate design
# job, and IngramSpark requires it uploaded as a separate file.
#
# Renders essays 0..9 plus the companion essay as the appendix, through pandoc
# and WeasyPrint, at the 152 x 229mm trim of Tuwhiri's The secular path to
# well-being, on that book's measured baseline grid (see lib/print-style.sh).
# The result is then hardened to IngramSpark's interior rules: even page count,
# blank final page, DeviceGray throughout, every font embedded, no crop marks.
# lib/pdfcheck.py asserts all of that against the finished file, and the build
# refuses to write a non-conforming PDF.
#
# Sources, preprocessing and typefaces are shared with mk-book.sh through
# lib/preprocess.sh and lib/fonts.sh: one set of sources, one reading of them.
set -euo pipefail
shopt -s inherit_errexit

declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION=1.0.0
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='In search of dharma'
declare -r SUBTITLE='What holds a life, a people, a world together'
declare -r AUTHOR='Biksu Okusi'
declare -r PUBLISHER='The Tuwhiri Project'
declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main
declare -ir JPEG_QUALITY=92

declare -r OUTPUT_PDF="$SCRIPT_DIR"/In-Search-of-Dharma_interior_152x229.pdf

# Script-scope state, declared before any function (BCS0105).
declare -i VERBOSE=1 KEEP_TEMP=0
declare -- TMP_DIR=''

_msg()  { >&2 printf '%s: %s %s\n' "$SCRIPT_NAME" "$1" "${*:2}"; }
info()  { ((VERBOSE)) || return 0; _msg '◉' "$@"; }
warn()  { _msg '▲' "$@"; }
error() { _msg '✗' "$@"; }
die()   { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }
```

- [ ] **Step 2: Source the libraries and parse options**

```bash
declare -r FONT_LIB="$SCRIPT_DIR"/lib/fonts.sh
declare -r PREPROCESS_LIB="$SCRIPT_DIR"/lib/preprocess.sh
declare -r STYLE_LIB="$SCRIPT_DIR"/lib/print-style.sh
declare -r PDFCHECK="$SCRIPT_DIR"/lib/pdfcheck.py

declare -- lib
for lib in "$FONT_LIB" "$PREPROCESS_LIB" "$STYLE_LIB"; do
  [[ -f $lib ]] || { >&2 echo "✗ missing library ${lib@Q}"; exit 3; }
done
#shellcheck source=lib/fonts.sh
source "$FONT_LIB"       || { >&2 echo "✗ failed to source ${FONT_LIB@Q}"; exit 1; }
#shellcheck source=lib/preprocess.sh
source "$PREPROCESS_LIB" || { >&2 echo "✗ failed to source ${PREPROCESS_LIB@Q}"; exit 1; }
#shellcheck source=lib/print-style.sh
source "$STYLE_LIB"      || { >&2 echo "✗ failed to source ${STYLE_LIB@Q}"; exit 1; }
```

In `main`, parse options with a `while (($#))` loop over `case "$1"`, supporting
`--size PT`, `--lead PT`, `--fonts SET`, `--quiet`, `--keep-temp`,
`--preflight FILE`, `-h|--help`, `-V|--version`, and `die 2` on anything else.
`--preflight FILE` runs `"$PDFCHECK" check "$FILE" --trim 152x229 --require-even
--require-blank-last` and returns its status without building.

- [ ] **Step 3: Assemble the source list and stage the chapters**

```bash
# Essays 0..9 by numeric prefix, then the companion essay as the appendix.
# Unlike mk-book.sh there is no cover.md: a print interior carries no cover.
local -a sources=()
local -i n
local -a match
for n in {0..9}; do
  match=("$SCRIPT_DIR/$n"-*.md)
  (( ${#match[@]} == 1 )) \
    || die 3 "expected exactly one file for essay $n, found ${#match[@]}"
  sources+=("${match[0]}")
done
local -r APPENDIX="$SCRIPT_DIR"/the-better-ones.md
[[ -f $APPENDIX ]] || die 3 "appendix source not found: ${APPENDIX@Q}"
sources+=("$APPENDIX")

trap 'rm -rf -- "$TMP_DIR"' EXIT
trap 'exit 130' SIGINT
trap 'exit 143' SIGTERM
TMP_DIR=$(mktemp -d -t mkprint.XXXXXX) || die 5 'failed to create temp dir'
local -r img_stage="$TMP_DIR"/img
mkdir -p "$img_stage"/images || die 5 'failed to create image staging dir'

# Stage JPEG copies of every source image, mirroring the on-disk layout so the
# .webp/.png -> .jpg rewrites that preprocess() performs resolve against
# --base-url. Source files are never modified. Task 6 replaces this recipe with
# the greyscale-plus-tone-curve one a black-and-white interior needs; a plain
# copy is used here only so this task's build renders its images at all.
local -- isrc irel
while IFS= read -r -d '' isrc; do
  irel=${isrc#"$SCRIPT_DIR"/}
  convert "$isrc" -quality "$JPEG_QUALITY" "$img_stage/${irel%.*}.jpg" \
    || die 5 "image staging failed ${isrc@Q}"
done < <(find "$SCRIPT_DIR"/images -maxdepth 2 \
           \( -name '*.webp' -o -name '*.png' \) -print0)
cp -- "$SCRIPT_DIR"/images/*.svg "$img_stage"/images/ 2>/dev/null || true

# Preprocess into ordered temp files so chapter order survives the glob.
local -a inputs=()
local -i i=0
local -- src dst
for src in "${sources[@]}"; do
  printf -v dst '%s/%02d-%s' "$TMP_DIR" "$i" "${src##*/}"
  preprocess "$src" >"$dst" || die 1 "preprocessing failed for ${src@Q}"
  if [[ $src == "$APPENDIX" ]]; then
    # Same appendix treatment as mk-book.sh: label it, strip the repo-surface
    # headnote. Exact-match rewrite plus check, so a future title change fails
    # the build loudly instead of shipping unlabelled.
    sed -i 's/^# Dharmas: The Better Ones$/# Appendix: Dharmas, the Better Ones/' "$dst" \
      || die 1 "appendix H1 rewrite failed for ${dst@Q}"
    grep -q '^# Appendix: ' "$dst" \
      || die 1 "appendix H1 not rewritten in ${dst@Q} (title changed in ${APPENDIX@Q}?)"
    sed -i -e '/^\*A discussion piece /d' -e '0,/^---$/{/^---$/d}' "$dst" \
      || die 1 "appendix headnote strip failed for ${dst@Q}"
  fi
  # The print interior carries no audio links: a hyperlink is useless on paper
  # and the bare URL belongs to the reading PDF, not to a printed book.
  sed -i '/^<p class="audio">/d' "$dst" || die 1 "audio strip failed for ${dst@Q}"
  inputs+=("$dst")
  i+=1
done
```

- [ ] **Step 4: Wrap each chapter in its own section**

pandoc emits one flat document from several inputs, so the chapter boundary has
to be drawn explicitly. Convert each staged file on its own and concatenate the
fragments, which also keeps each chapter's `<h1>` at the head of its section.

```bash
# One <section class="chapter"> per source, so the stylesheet can give each
# chapter's opener its own page rules without guessing where chapters begin.
local -- frag body_html="$TMP_DIR"/body.html
: >"$body_html"
for dst in "${inputs[@]}"; do
  frag=$(pandoc --from=markdown-yaml_metadata_block --to=html5 "$dst") \
    || die 1 "pandoc failed for ${dst@Q}"
  printf '<section class="chapter">\n%s\n</section>\n' "$frag" >>"$body_html"
done

# The Sources & further reading section sets smaller. pandoc gives the h2 an
# id; wrap from that heading to the end of its chapter.
sed -i -E 's#(<h2 id="sources[^"]*">)#<div class="sources">\1#' "$body_html" \
  || die 1 'sources wrap failed'
sed -i -E 's#</section>#</div></section>#' "$body_html" \
  || die 1 'sources close failed'
```

▲ That second `sed` closes a `<div>` in every section, including any that never
opened one. Verify against the built HTML and, if a chapter lacks a Sources
heading, close the div only where one was opened. This is the single fiddliest
line in the build; check it rather than trusting it.

- [ ] **Step 5: Render**

```bash
local -- css="$TMP_DIR"/print.css
{ font_faces_css pdf; print_page_css; } >"$css" \
  || die 5 "failed to write ${css@Q}"

local -- doc="$TMP_DIR"/book.html
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8">'
  printf '<title>%s</title><link rel="stylesheet" href="print.css"></head><body>\n' "$TITLE"
  cat "$body_html"
  printf '</body></html>\n'
} >"$doc" || die 5 "failed to write ${doc@Q}"
cp -- "$css" "$TMP_DIR"/print.css

local -r raw_pdf="$TMP_DIR"/raw.pdf
info 'rendering interior'
weasyprint --base-url "$img_stage/" "$doc" "$raw_pdf" \
  || die 1 'weasyprint failed'
cp -- "$raw_pdf" "$OUTPUT_PDF"   # replaced by the hardening chain in Task 7
```

- [ ] **Step 6: Build it**

```bash
chmod +x mk-print.sh
./mk-print.sh
pdfinfo In-Search-of-Dharma_interior_152x229.pdf | grep -E 'Pages|Page size'
```

Expected: about 209 pages at `430.87 x 649.13 pts`.

- [ ] **Step 7: Assert the geometry on the real book**

```bash
./lib/pdfcheck.py baselines In-Search-of-Dharma_interior_152x229.pdf --page 3 \
  | jq '.lines[0:3]'
```

Expected: the running head at about 16.8 mm and the first body line at about
29.53 mm.

- [ ] **Step 8: Verify chapters open recto and openers carry no running head**

```bash
./lib/pdfcheck.py measure In-Search-of-Dharma_interior_152x229.pdf \
  | jq '{pages, blank_pages}'
```

Expected: `blank_pages` is non-empty, because forcing recto openers inserts
blank versos.

- [ ] **Step 9: Lint**

```bash
shellcheck -x mk-print.sh
```

Then run the `bcscheck` skill over it.

- [ ] **Step 10: Commit**

```bash
git add mk-print.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): build the interior body at Tuwhiri's trim size

Chapters only for now: recto openers with blank versos where needed,
mirrored margins, running heads carrying the book title on versos and
the chapter title on rectos, and a two-line drop cap opening each
chapter. Front matter follows.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 3
```

---

## Task 5: Front matter and a contents list with real page numbers

**Files:**
- Modify: `mk-print.sh`

- [ ] **Step 0: Add `slugify` to `mk-print.sh`**

Task 5 needs pandoc's auto-identifier algorithm to build contents anchors.
Copy `slugify()` verbatim from `mk-book.sh:205-211` into `mk-print.sh`, beside
the other helpers:

```bash
# Mirror pandoc's auto-identifier algorithm for a heading: downcase, drop
# anything outside [a-z0-9 ._-], spaces to hyphens, then strip leading
# characters until the first is a letter. Contents links are built from this,
# so it must track pandoc's behaviour exactly.
slugify() {
  local -- s=${1,,}
  s=${s//[^a-z0-9 ._-]/}
  s=${s// /-}
  while [[ -n $s && ! $s =~ ^[a-z] ]]; do s=${s:1}; done
  printf '%s' "$s"
}
```

◉ Duplicated rather than shared: it mirrors a *renderer's* behaviour, which is
not what `lib/preprocess.sh` is for. Seven duplicated lines cost less than
widening a shared library's contract, and a drift between the two breaks the
contents links loudly in preflight rather than silently.

- [ ] **Step 1: Generate the four front-matter pages**

Emit into `$TMP_DIR/00-front.html`. It is spliced into the document by Task 4
Step 5's `$doc` assembly, between the `<body>` line and `cat "$body_html"`:

```bash
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8">'
  printf '<title>%s</title><link rel="stylesheet" href="print.css"></head><body>\n' "$TITLE"
  cat "$TMP_DIR"/00-front.html          # <- added by this task
  cat "$body_html"
  printf '</body></html>\n'
} >"$doc" || die 5 "failed to write ${doc@Q}"
```

The front matter's own markup:

```html
<section class="front">
  <div class="halftitle"><p class="ht-title">In search of dharma</p></div>
  <div class="titlepage">
    <p class="tp-title">In search of dharma</p>
    <p class="tp-sub">What holds a life, a people, a world together</p>
    <p class="tp-author">Biksu Okusi</p>
    <p class="tp-imprint">The Tuwhiri Project</p>
  </div>
  <div class="imprint">IMPRINT_PLACEHOLDER</div>
  <nav class="contents"><h1>Contents</h1>CONTENTS_ENTRIES</nav>
</section>
```

`IMPRINT_PLACEHOLDER` is replaced by the contents of
`print-imprint.md` when that file exists, and otherwise by a visible
placeholder block reading `[imprint copy to come from Tuwhiri: print ISBN,
Tuwhiri's details, printing history, CC BY 4.0 statement]`. A visible
placeholder is deliberate: it must be impossible to send a proof and not
notice.

- [ ] **Step 2: Build the contents entries from the staged chapter H1s**

One `<p><a href="#ID">TITLE</a></p>` per chapter, where `ID` is the pandoc
auto-identifier. `mk-book.sh` already mirrors that algorithm in `slugify()`
(`mk-book.sh:205`); reuse it rather than reimplementing.

The page numbers come from CSS, not from the script:
`nav.contents a::after{content:leader('.') target-counter(attr(href), page)}`
is already in `lib/print-style.sh`.

- [ ] **Step 3: Build and verify the folio sequence**

```bash
./mk-print.sh
./lib/pdfcheck.py baselines In-Search-of-Dharma_interior_152x229.pdf --page 4 \
  | jq -r '.lines[-1].text'
```

Expected: a lower-roman folio such as `iv`.

```bash
./lib/pdfcheck.py baselines In-Search-of-Dharma_interior_152x229.pdf --page 9 \
  | jq -r '.lines[-1].text'
```

Expected: `1`, the arabic sequence restarting at the Preface.

- [ ] **Step 4: Verify the contents carries real page numbers**

```bash
pdftotext -f 7 -l 8 -layout In-Search-of-Dharma_interior_152x229.pdf -
```

Expected: each chapter title followed by leader dots and a page number, and
those numbers must match where the chapters actually start.

- [ ] **Step 5: Lint and commit**

```bash
shellcheck -x mk-print.sh
git add mk-print.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): add front matter and a contents list with real page numbers

Half-title, title page, imprint and contents, on roman folios, with the
arabic sequence restarting at the Preface. The contents page numbers come
from the renderer's target-counter, so they cannot drift from the pages
they point at. The imprint carries a visible placeholder until Tuwhiri
supplies the copy.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
```

---

## Task 6: Greyscale image staging

**Files:**
- Modify: `mk-print.sh`

- [ ] **Step 1: Stage greyscale copies**

The source `.webp` files are never modified. Staged copies go to
`$TMP_DIR/img/images/`:

```bash
# A black-and-white IngramSpark interior needs greyscale images carrying no ICC
# profile. Plain desaturation flattens a watercolour; the level and sigmoidal
# curve restore the tonal separation that press dot-gain would otherwise close
# up. -strip removes the colour profile IngramSpark rejects.
local -- src rel
while IFS= read -r -d '' src; do
  rel=${src#"$SCRIPT_DIR"/}
  convert "$src" -colorspace Gray -level 5%,95% -sigmoidal-contrast 3,50% \
    -strip -quality "$JPEG_QUALITY" "$img_stage/${rel%.*}.jpg" \
    || die 5 "greyscale conversion failed ${src@Q}"
done < <(find "$SCRIPT_DIR"/images -maxdepth 2 \
           \( -name '*.webp' -o -name '*.png' \) -print0)
```

- [ ] **Step 2: Verify the staged images are grey and the sources untouched**

```bash
./mk-print.sh --keep-temp
identify -format '%f %[colorspace] %[profiles:icc]\n' /tmp/mkprint.*/img/images/*.jpg | head
identify -format '%f %[colorspace]\n' images/3-defining-dharma_watercolor.webp
```

Expected: staged files report `Gray` with no ICC profile; the source still
reports `sRGB`.

- [ ] **Step 3: Verify resolution at print size**

```bash
./lib/pdfcheck.py measure In-Search-of-Dharma_interior_152x229.pdf | jq '.images[0:3]'
```

Expected: every entry reports `"colorspace": "gray"` and `ppi` at or above 300.

- [ ] **Step 4: Commit**

```bash
git add mk-print.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): stage the chapter watercolours in greyscale

IngramSpark's black-and-white interior requires greyscale images with no
ICC profile. Plain desaturation flattens a watercolour, so a level and a
sigmoidal curve restore the separation press dot-gain would close up. The
source files are never touched, and the EPUB and reading PDF keep colour.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
```

---

## Task 7: Conformance: even page count, blank final page, DeviceGray, preflight gate

**Files:**
- Modify: `mk-print.sh`

- [ ] **Step 1: Pad to an even page count with a blank final page**

After the WeasyPrint run, append a blank page when the count is odd, and
guarantee the last page is blank either way:

```bash
# IngramSpark: "The final page should be blank. If there is no blank page,
# we'll add one for you." Adding it here keeps the page count ours to control,
# and Ramsey requires a multiple of 2.
#
# Forcing chapter openers onto rectos already leaves blank versos, so the book
# often ends blank and even with nothing to do. Four cases, in order:
#   even + last blank -> nothing to add
#   odd  + last blank -> one blank (even, still ends blank)
#   even + last inked -> two blanks (even, ends blank)
#   odd  + last inked -> one blank (even, ends blank)
pad_to_even() {
  local -- src=$1 out=$2
  local -i pages last_blank=0 add=0
  pages=$(pdfinfo "$src" | awk '/^Pages:/{print $2}')
  # blank_pages is a pretty-printed JSON array, so it spans lines; grep with .*
  # cannot match across them. Ask jq whether the last page is in the list.
  if "$PDFCHECK" measure "$src" \
       | jq --argjson p "$pages" -e '.blank_pages | index($p)' >/dev/null; then
    last_blank=1
  fi
  if ((last_blank)); then
    add=$(( pages % 2 ))
  else
    add=$(( pages % 2 == 0 ? 2 : 1 ))
  fi
  if ((add == 0)); then
    cp -- "$src" "$out" || die 5 "failed to copy ${src@Q}"
    info "page count $pages is even and ends blank; nothing to pad"
    return 0
  fi
  local -- blank="$TMP_DIR"/blank.pdf
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8"><style>@page{size:%smm %smm;margin:0}</style></head><body></body></html>' \
    "$PRINT_TRIM_W_MM" "$PRINT_TRIM_H_MM" > "$TMP_DIR"/blank.html
  weasyprint "$TMP_DIR"/blank.html "$blank" || die 1 'blank-page render failed'
  local -a parts=("$src")
  local -i i
  for ((i = 0; i < add; i++)); do parts+=("$blank"); done
  pdfunite "${parts[@]}" "$out" || die 1 'pdfunite failed'
  info "padded $pages -> $((pages + add)) pages"
}
pad_to_even "$raw_pdf" "$TMP_DIR"/padded.pdf
```

▲ The `grep -q ... && last_blank=1` line is an AND-list whose first command may
fail; that is exempt from `set -e`, but `bcscheck` may still flag it. Prefer an
explicit `if` if it does.

- [ ] **Step 2: Convert to DeviceGray**

```bash
# WeasyPrint writes black as DeviceRGB 0 0 0. The model book sets its text in
# 100% K, and IngramSpark's B&W interior rules forbid ICC profiles. Ghostscript
# converts the whole file to DeviceGray while keeping every font embedded and
# subset, and preserves the trim to two decimals.
gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite \
   -dProcessColorModel=/DeviceGray -sColorConversionStrategy=Gray \
   -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress \
   -dSubsetFonts=true -dEmbedAllFonts=true -dAutoRotatePages=/None \
   -dDetectDuplicateImages=true \
   -sOutputFile="$OUTPUT_PDF" "$TMP_DIR"/padded.pdf \
  || die 1 'greyscale conversion failed'
```

- [ ] **Step 3: Wire in the preflight gate**

```bash
info 'running preflight'
"$SCRIPT_DIR"/lib/pdfcheck.py check "$OUTPUT_PDF" \
  --trim "${PRINT_TRIM_W_MM}x${PRINT_TRIM_H_MM}" \
  --require-even --require-blank-last \
  || die 1 "preflight failed for ${OUTPUT_PDF@Q}; the file was NOT written for upload"
```

- [ ] **Step 4: Verify the gate passes on the real build**

```bash
./mk-print.sh
```

Expected: `✓ conforms: NNN pages at 152.0x229.0mm`, with an even `NNN`.

- [ ] **Step 5: Verify the gate rejects Tuwhiri's proof export as a negative control**

```bash
./lib/pdfcheck.py check "print/TASTER The secular path to well-being.pdf"; echo "exit=$?"
```

Expected: non-zero exit, naming the box mismatch, because that file carries
crop marks in a slug.

- [ ] **Step 6: Lint and commit**

```bash
shellcheck -x mk-print.sh
git add mk-print.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): harden the interior to IngramSpark's file rules

Pads to an even page count with a blank final page, converts the whole
file to DeviceGray so the text sets in 100% K as the model book does,
then refuses to emit anything that fails preflight. A rejected upload
costs money and days, and every rule on the checklist is machine-checkable
from the finished file.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
```

---

## Task 8: Lining figures across every format

Bona Nova defaults to oldstyle figures, so "Part 1" sets as something a reader
takes for "Part I". This is in the shipping EPUB and reading PDF today.

**Files:**
- Modify: `mk-book.sh` (the EPUB and PDF stylesheet blocks)

- [ ] **Step 1: Confirm the defect**

```bash
pdftotext -f 20 -l 40 In-Search-of-Dharma_Biksu-Okusi_2026.pdf - | grep -n 'Part [0-9]' | head -3
```

Then inspect the rendered glyphs:

```bash
mutool draw -F trace -o - In-Search-of-Dharma_Biksu-Okusi_2026.pdf 25 2>/dev/null \
  | grep -oE 'unicode="[0-9]" glyph="[0-9]+"' | sort -u | head
```

Record the glyph IDs. Oldstyle and lining figures occupy different IDs.

- [ ] **Step 2: Add the declaration to both stylesheets**

In the EPUB `body{...}` rule and the PDF `body{...}` rule in `mk-book.sh`, add:

```css
font-variant-numeric:lining-nums;font-feature-settings:"lnum" 1
```

- [ ] **Step 3: Rebuild and verify the glyphs changed**

```bash
./mk-book.sh all --quiet
mutool draw -F trace -o - In-Search-of-Dharma_Biksu-Okusi_2026.pdf 25 2>/dev/null \
  | grep -oE 'unicode="[0-9]" glyph="[0-9]+"' | sort -u | head
```

Expected: different glyph IDs from Step 1.

- [ ] **Step 4: Confirm visually**

```bash
pdftoppm -r 150 -png -f 25 -l 25 In-Search-of-Dharma_Biksu-Okusi_2026.pdf /tmp/lnum
```

Open `/tmp/lnum-25.png` and confirm figures now sit on the baseline at cap
height.

- [ ] **Step 5: Lint and commit**

```bash
shellcheck -x mk-book.sh
git add mk-book.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
fix(type): set figures lining, not oldstyle

Bona Nova defaults to oldstyle figures, whose 1 is easily read as a
small-capital I. In a book that refers to Part 1 through Part 8 on almost
every page that is a real ambiguity, so both the EPUB and the PDF now ask
for lining figures.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
```

---

## Task 9: The glyph gate

Bona Nova and Work Sans lack ṝ, ḹ and ṁ and their capitals. No current source
uses them. The gate makes a future edit that introduces one fail loudly rather
than print a blank.

**Files:**
- Create: `lib/glyphcheck.py`
- Modify: `mk-print.sh` (call it before rendering)
- Test: `tests/test-glyphcheck.sh`

**Interfaces:**
- Produces: `lib/glyphcheck.py FONT... -- FILE...` exits 1 and names each
  missing character, with the first source file and line it appears on.

- [ ] **Step 1: Write the failing test**

Create `tests/test-glyphcheck.sh`, asserting three things: the current sources
pass against the Bona Nova faces; a fixture containing `ṁ` fails; and the
failure message names the character and the file.

```bash
#!/bin/bash
# tests/test-glyphcheck.sh - the glyph gate passes the real sources and fails a
# fixture using a character Bona Nova does not carry.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r GC=$ROOT/lib/glyphcheck.py
declare -i FAILED=0
TMP=$(mktemp -d); trap 'rm -rf -- "$TMP"' EXIT

echo '== glyph gate =='

if "$GC" "$ROOT"/fonts/bonanova/BonaNova-Regular.ttf -- "$ROOT"/[0-9]-*.md >/dev/null 2>&1; then
  printf '  ✓ current sources pass\n'
else
  printf '  ✗ current sources failed the gate\n'; FAILED+=1
fi

printf 'The word saṁsāra uses a character Bona Nova lacks.\n' > "$TMP"/bad.md
if "$GC" "$ROOT"/fonts/bonanova/BonaNova-Regular.ttf -- "$TMP"/bad.md 2>"$TMP"/err; then
  printf '  ✗ gate accepted a missing glyph\n'; FAILED+=1
else
  printf '  ✓ gate rejects a missing glyph\n'
  grep -q 'ṁ' "$TMP"/err \
    && printf '  ✓ the message names the character\n' \
    || { printf '  ✗ the message does not name the character\n'; FAILED+=1; }
fi

((FAILED == 0)) || exit 1
#fin
```

- [ ] **Step 2: Run it to make sure it fails**

```bash
chmod +x tests/test-glyphcheck.sh && ./tests/test-glyphcheck.sh
```

Expected: FAIL with `lib/glyphcheck.py: No such file or directory`.

- [ ] **Step 3: Write `lib/glyphcheck.py`**

```python
#!/usr/bin/env python3
"""Fail if any source character is absent from the bound faces.

Bona Nova and Work Sans both lack the rarer IAST diacritics, notably the
vocalic long r and l and the anusvara m with dot above. No current source uses
them, and this gate makes sure a future edit that does fails the build instead
of printing a blank.

Usage:
  glyphcheck.py FONT... -- FILE...
"""
import sys
import unicodedata
from fontTools.ttLib import TTFont

IGNORE = set('\n\r\t')


def coverage(paths):
  """Characters present in EVERY face, since body text may use any of them."""
  common = None
  for p in paths:
    f = TTFont(p, fontNumber=0, lazy=True)
    cps = set()
    for t in f['cmap'].tables:
      cps |= set(t.cmap.keys())
    f.close()
    common = cps if common is None else (common & cps)
  return common or set()


def main(argv):
  if '--' not in argv:
    print(__doc__, file=sys.stderr)
    return 2
  cut = argv.index('--')
  fonts, files = argv[:cut], argv[cut + 1:]
  if not fonts or not files:
    print(__doc__, file=sys.stderr)
    return 2

  have = coverage(fonts)
  missing = {}
  for path in files:
    with open(path, encoding='utf-8') as fh:
      for lineno, line in enumerate(fh, 1):
        for ch in line:
          if ch in IGNORE or ord(ch) < 128 or ord(ch) in have:
            continue
          missing.setdefault(ch, (path, lineno))

  for ch, (path, lineno) in sorted(missing.items()):
    name = unicodedata.name(ch, 'UNNAMED')
    print(f"✗ glyph: '{ch}' U+{ord(ch):04X} {name} is missing from the bound "
          f"faces; first used at {path}:{lineno}", file=sys.stderr)
  if missing:
    return 1
  print(f"✓ glyphs: {len(files)} files, every character present", file=sys.stderr)
  return 0


if __name__ == '__main__':
  sys.exit(main(sys.argv[1:]))
#fin
```

- [ ] **Step 4: Run the test to verify it passes**

```bash
chmod +x lib/glyphcheck.py && ./tests/test-glyphcheck.sh
```

Expected: four `✓` lines.

- [ ] **Step 5: Wire it into `mk-print.sh` before rendering**

```bash
info 'checking glyph coverage'
"$SCRIPT_DIR"/lib/glyphcheck.py "${FONT_FILES[@]}" -- "${sources[@]}" \
  || die 1 'a source character is missing from the bound faces'
```

- [ ] **Step 6: Run the whole suite and commit**

```bash
./tests/run_tests.sh
git add lib/glyphcheck.py mk-print.sh tests/test-glyphcheck.sh
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
feat(print): fail the build on a character the faces cannot set

Bona Nova and Work Sans lack the rarer IAST diacritics. No current source
uses them, so this gate costs nothing today and stops a future edit
printing a blank where a letter should be.

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
```

---

## Task 10: Documentation and the full verification pass

**Files:**
- Modify: `README.md`, `CONTRIBUTING.md` if either describes the build targets

- [ ] **Step 1: Run the whole suite**

```bash
./tests/run_tests.sh
```

Expected: `4/4 test files passed` and `✓ all green`.

- [ ] **Step 2: Build all three artefacts from clean**

```bash
./mk-book.sh all --quiet && ./mk-print.sh
```

Expected: EPUB, reading PDF and print interior all built, with preflight
reporting `✓ conforms`.

- [ ] **Step 3: Lint every shell file touched**

```bash
shellcheck -x mk-book.sh mk-print.sh lib/preprocess.sh lib/print-style.sh \
  lib/fonts.sh tests/run_tests.sh tests/test-*.sh
```

Then run the `bcscheck` skill over the same list, one file at a time. The
`bcscheck` binary can fork-bomb via its nested backend, so never run several at
once.

- [ ] **Step 4: Update the documentation**

Describe `mk-print.sh` alongside `mk-book.sh` wherever build targets are
listed. Do not mention anything under `print/` or `hf-dataset/`; both are
gitignored, and documentation must not name ignored files.

- [ ] **Step 5: Produce proof 1**

```bash
./mk-print.sh
./lib/pdfcheck.py measure In-Search-of-Dharma_interior_152x229.pdf \
  | jq '{pages, trim_mm, ink_to_trim_mm}'
```

Send the PDF to Ramsey with the four open questions from the spec §9: the
imprint copy, the print ISBN, the Okusi logo file, and where the chapter
watercolour sits on an opener.

- [ ] **Step 6: Commit**

```bash
git add -A README.md CONTRIBUTING.md
git commit --author='Biksu-Okusi <biksu@okusi.id>' -F - <<EOF
docs(build): describe the print-interior target

Claude-Session: https://claude.ai/code/session_01CYrUYTQvkus6hP2NgoN6Z5
EOF
git log --oneline -n 5
```

---

## Self-Review Notes

**Spec coverage.** Every section of the design has a task. §3 and §4 are
Task 3. §5 is Tasks 4 and 5. §6 is Tasks 2, 3 and 4. §7 is Tasks 1 and 7. §8 is
Task 6. §9 surfaces as the visible imprint placeholder in Task 5 and the
hand-off in Task 10. §10 is deliberately **not** in this plan: the quote-style
conversion is an editorial change to the sources and belongs in its own change,
as the spec says. §11 is Tasks 2, 3, 7 and 10. §12 is respected throughout.

**Deferred deliberately.** The single-quote conversion and carrying Ramsey's
paragraph splits back into the Markdown are editorial work on the manuscript.
They change what the book says, not how it is built, and mixing them into a
build change would make both harder to review.
