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


def close_box(a, b, tol=0.1):
  """True if two 4-tuples of point coordinates agree within tol points.

  Ghostscript's pdfwrite rounds MediaBox to fewer decimal places than it
  rounds TrimBox/BleedBox, so exact tuple equality spuriously fails on a
  file that is, for print purposes, conforming. 0.1pt is about 0.035mm,
  far tighter than any real bleed or crop-mark offset.
  """
  return all(abs(x - y) < tol for x, y in zip(a, b))


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
    'boxes_equal': all(t is None or close_box(t, m) for m, t in boxes),
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
