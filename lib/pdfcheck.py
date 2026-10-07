#!/usr/bin/env python3
"""Measure and conformance-check a print-interior PDF.

Serves two callers: the test suite, which asks for measurements, and
mk-print.sh, which asks for a verdict. Every rule is checked against the
finished file, never against intent.

Usage:
  pdfcheck.py measure FILE
  pdfcheck.py baselines FILE [--page N]
  pdfcheck.py rules FILE [--page N]
  pdfcheck.py ink FILE [--page N] --box X0,Y0,X1,Y1
  pdfcheck.py lines FILE [--top MM] [--lead PT] [--want N]
  pdfcheck.py faces FILE [--page N]
  pdfcheck.py breaks FILE
  pdfcheck.py check FILE [--trim WxH] [--require-even] [--require-blank-last]
                         [--measure MM --inner MM]
"""
import argparse
import json
import os
import re
import shutil
import subprocess
import sys
import tempfile

import numpy as np
from PIL import Image

PT_MM = 25.4 / 72.0
INK_WARN_MM = 13.0   # IngramSpark's stated minimum
INK_FAIL_MM = 12.0   # below the model book's own 12.20mm, so certainly wrong
MIN_PPI = 300
# IngramSpark's own preflight (ColorBookCheck) flags a grey image "higher than
# 600 pixels per inch" and asks for the file to be corrected (2026-10-06: the
# publisher's word mark at 1989 ppi).
MAX_PPI = 600
RENDER_DPI = 72      # 1 pixel == 1pt at this resolution; no pixel<->point scaling
INK_THRESHOLD = 255  # any pixel darker than pure white counts as ink
# How far a word may sit outside the measure before it counts as an overrun.
# Renderer and Ghostscript rounding leave ordinary justified lines up to about
# 0.03mm past the edge; the smallest real overrun this rule was written for
# measured 0.07mm.
MEASURE_TOL_MM = 0.05
MEASURE_LIST_MAX = 10  # overruns named one by one before the rest are counted
# A vertical rule, told from a letter by its ink: at least this long, and no
# wider than this. A 10pt ascender stands about 2.6mm, and a 20pt stem is
# 0.25mm wide in Bona Nova Regular and some 0.8mm in Work Sans SemiBold, while
# the book's hairlines are 0.4pt (0.14mm).
RULE_DPI = 600
INK_DPI = 1200       # one pixel is 0.02mm: fine enough to hold 0.1mm tolerances
# Where a 10pt Bona Nova baseline falls in its 16pt line box, from the top:
# half the leading left over by the 1.2em content area, then the 0.932em ascent.
# lines() rounds to the nearest line, so other faces and sizes, which stand
# within a point of this, are read correctly.
LINE_BASE_PT = 11.32
TITLE_MIN_PT = 18.0  # a chapter title is 20pt; nothing else in the text exceeds 12pt
# Subheads are 11pt, and 9pt for the lesser ones and the labels of the Sources.
# Bold in the text is the same face at 0.94 of the text's size: 9.4pt, and
# 8.46pt in the Sources. A line wholly in bold is not thereby a subhead.
HEAD_MIN_PT = 8.9
BOLD_IN_TEXT_PT = 9.4
# The text block, in mm from the trim top: what lies above is the running head
# and what lies below is the folio.
BLOCK_TOP_MM = 24.0
BLOCK_FOOT_MM = 206.0
SOFT_BREAK = '\u2010'  # the hyphen the renderer sets where it divides a word
# A word whose box stands taller than this is display type, a title or a drop
# cap, and no part of a line of text: 10pt text stands 12pt, a 20pt title 24pt.
TEXT_MAX_PT = 18.0
RULE_MIN_MM = 4.0
RULE_MAX_W_MM = 0.2


def run(*args):
  """Run a tool and return stdout, raising with context on failure."""
  p = subprocess.run(args, capture_output=True, text=True)
  if p.returncode != 0:
    raise RuntimeError(f"{args[0]} failed: {p.stderr.strip()[:200]}")
  return p.stdout


def page_boxes(path):
  """Return [(media, trim, bleed, art)] per page, each a 4-tuple in points.

  trim/bleed/art are None when the box is absent from the page -- mutool
  only emits a box element when the PDF actually defines one.
  """
  out = run('mutool', 'pages', path)
  boxes = []
  for blk in re.findall(r'<page pagenum="\d+">(.*?)</page>', out, re.S):
    def box(tag):
      m = re.search(rf'<{tag} l="([-\d.]+)" b="([-\d.]+)" '
                    rf'r="([-\d.]+)" t="([-\d.]+)" />', blk)
      return tuple(float(g) for g in m.groups()) if m else None
    boxes.append((box('MediaBox'), box('TrimBox'), box('BleedBox'), box('ArtBox')))
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
    x_ppi, y_ppi = _num(f[12]), _num(f[13])
    ppi = None if x_ppi is None or y_ppi is None else min(x_ppi, y_ppi)
    rows.append({'page': int(f[0]), 'type': f[2], 'colorspace': f[5],
                 'has_icc': f[5] == 'icc', 'ppi': ppi})
  return rows


def _num(s):
  """Parse a pdfimages numeric field; None (not 0.0) means unparseable.

  0.0 is a value pdfimages can report honestly (e.g. a mask); None must
  stay distinct from it so an unparseable field fails loudly instead of
  silently passing the ppi floor as if 0 meant "no data".
  """
  try:
    return float(s)
  except ValueError:
    return None


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


def render_pages(path, dpi=RENDER_DPI):
  """Rasterise every page to grayscale PNG in one pdftoppm call.

  One process for the whole document, not one per page -- the print build
  runs this over 200+ page books, and pdftoppm's own per-page startup cost
  dominates if invoked in a loop. Returns (tmp_dir, {page_num: png_path});
  the caller must remove tmp_dir.
  """
  tmp_dir = tempfile.mkdtemp(prefix='pdfcheck-')
  run('pdftoppm', '-r', str(dpi), '-gray', '-png', path, os.path.join(tmp_dir, 'p'))
  pages = {}
  for name in os.listdir(tmp_dir):
    m = re.match(r'p-(\d+)\.png$', name)
    if m:
      pages[int(m.group(1))] = os.path.join(tmp_dir, name)
  return tmp_dir, pages


def ink_bbox(png_path, threshold=INK_THRESHOLD):
  """Pixel (x0, y0, x1, y1) bbox of ink darker than threshold, or None."""
  gray = Image.open(png_path).convert('L')
  mask = gray.point(lambda p: 255 if p < threshold else 0)
  return mask.getbbox()


def ink_to_trim(path, w_pt, h_pt, dpi=RENDER_DPI):
  """Closest approach of any ink (text, image or vector) to each trim edge.

  Rasterises rather than parsing text/vector geometry: a watercolour or a
  rule near the trim is real ink and pdftotext alone cannot see it. At
  RENDER_DPI=72, one pixel is exactly one point, so pixel and point
  coordinates are the same number -- no scale factor to get wrong.

  Returns a dict with a subset of {top, bottom, left, right}: an edge with
  no ink anywhere in the document is omitted, and a wholly blank document
  returns {}. Callers must not assume all four keys are present.
  """
  tmp_dir, pages = render_pages(path, dpi)
  try:
    scale = 72.0 / dpi
    worst = {'top': 1e9, 'bottom': 1e9, 'left': 1e9, 'right': 1e9}
    for png in pages.values():
      bbox = ink_bbox(png)
      if bbox is None:
        continue
      x0, y0, x1, y1 = (v * scale for v in bbox)
      worst['top'] = min(worst['top'], y0)
      worst['bottom'] = min(worst['bottom'], h_pt - y1)
      worst['left'] = min(worst['left'], x0)
      worst['right'] = min(worst['right'], w_pt - x1)
    return {k: round(v * PT_MM, 2) for k, v in worst.items() if v < 1e9}
  finally:
    shutil.rmtree(tmp_dir, ignore_errors=True)


def blank_pages(path, pages):
  """1-based page numbers carrying neither text, images nor drawing ops."""
  blank = []
  for n in range(1, pages + 1):
    txt = run('pdftotext', '-f', str(n), '-l', str(n), path, '-').strip()
    if txt:
      continue
    trace = run('mutool', 'draw', '-F', 'trace', '-o', '-', path, str(n))
    if not re.search(r'<(?:fill|stroke)_(?:text|path|image)', trace):
      blank.append(n)
  return blank


def measure_overruns(path, trim_w_mm, inner_mm, measure_mm, tol=MEASURE_TOL_MM):
  """Words lying outside the text block: [(page, side, mm, word)], worst first.

  The block is mirrored across the spread. Page 1 is a recto, so an odd page
  has the inner margin on its left and an even page has it on its right.
  """
  out = []
  for page, x0, _y0, x1, _y1, text in words(path):
    left = inner_mm if page % 2 else trim_w_mm - inner_mm - measure_mm
    past_left = left - x0 * PT_MM
    past_right = x1 * PT_MM - (left + measure_mm)
    if past_left > tol:
      out.append((page, 'left', round(past_left, 2), text))
    if past_right > tol:
      out.append((page, 'right', round(past_right, 2), text))
  return sorted(out, key=lambda o: -o[2])


def measure(path):
  boxes = page_boxes(path)
  n = len(boxes)
  media = boxes[0][0]
  w_pt, h_pt = media[2] - media[0], media[3] - media[1]
  return {
    'pages': n,
    'trim_mm': [round(w_pt * PT_MM, 2), round(h_pt * PT_MM, 2)],
    'boxes_equal': all(
      all(b is None or close_box(b, m) for b in (trim, bleed, art))
      for m, trim, bleed, art in boxes),
    'uniform_size': all(
      abs((m[2] - m[0]) - w_pt) < 0.1 and abs((m[3] - m[1]) - h_pt) < 0.1
      for m, *_ in boxes),
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
                'text': ' '.join(w[2] for w in ws),
                'words': [{'x0_mm': round(a * PT_MM, 2), 'x1_mm': round(b * PT_MM, 2),
                           'text': t} for a, b, t in ws]})
  return {'lines': out}


def rules(path, page, dpi=RULE_DPI):
  """Vertical hairline rules on one page, left to right, in mm from the trim.

  Found by rasterising, not by reading the drawing: a border reaches the file
  as a filled rectangle from WeasyPrint and in whatever form Ghostscript then
  rewrites it, but the ink is the same either way. Each column's longest run
  of ink is taken, so where two rules share a column only the longer counts.
  """
  tmp_dir = tempfile.mkdtemp(prefix='pdfcheck-')
  try:
    run('pdftoppm', '-r', str(dpi), '-f', str(page), '-l', str(page), '-gray',
        '-png', path, os.path.join(tmp_dir, 'p'))
    pngs = [n for n in os.listdir(tmp_dir) if n.endswith('.png')]
    if not pngs:
      raise RuntimeError(f'page {page} did not render')
    ink = np.asarray(Image.open(os.path.join(tmp_dir, pngs[0])).convert('L')) < 128
  finally:
    shutil.rmtree(tmp_dir, ignore_errors=True)
  px_mm = 25.4 / dpi
  # The longest vertical run of ink in every column, and the row it ends on.
  cur = np.zeros(ink.shape[1], dtype=np.int32)
  best = np.zeros_like(cur)
  end = np.zeros_like(cur)
  for y, row in enumerate(ink):
    cur = (cur + 1) * row
    longer = cur > best
    best[longer] = cur[longer]
    end[longer] = y
  tall = np.flatnonzero(best * px_mm >= RULE_MIN_MM)
  out = []
  # Adjacent tall columns ending on (nearly) the same row are one rule.
  groups = []
  for x in tall:
    if groups and x == groups[-1][-1] + 1 and abs(int(end[x]) - int(end[groups[-1][-1]])) <= 2:
      groups[-1].append(x)
    else:
      groups.append([x])
  for g in groups:
    if len(g) * px_mm > RULE_MAX_W_MM:
      continue
    y1 = max(int(end[x]) for x in g) + 1
    y0 = y1 - max(int(best[x]) for x in g)
    out.append({'x0_mm': round(g[0] * px_mm, 2), 'x1_mm': round((g[-1] + 1) * px_mm, 2),
                'y0_mm': round(y0 * px_mm, 2), 'y1_mm': round(y1 * px_mm, 2),
                'len_mm': round((y1 - y0) * px_mm, 2)})
  return {'rules': out}


def ink(path, page, box, dpi=INK_DPI):
  """The extent of the ink inside a box, all in mm from the trim's top left.

  pdftotext reports a word's box from its font's metrics, so the foot of that
  box lies a descent below the baseline, and further below for larger type. A
  32pt drop cap and the 10pt line beside it cannot be compared by their boxes.
  Their ink can: a letter with no descender stands on its baseline.
  """
  x0, y0, x1, y1 = box
  px = dpi / 25.4
  tmp_dir = tempfile.mkdtemp(prefix='pdfcheck-')
  try:
    run('pdftoppm', '-r', str(dpi), '-f', str(page), '-l', str(page), '-gray', '-png',
        '-x', str(int(x0 * px)), '-y', str(int(y0 * px)),
        '-W', str(int((x1 - x0) * px)), '-H', str(int((y1 - y0) * px)),
        path, os.path.join(tmp_dir, 'p'))
    pngs = [n for n in os.listdir(tmp_dir) if n.endswith('.png')]
    if not pngs:
      raise RuntimeError(f'page {page} did not render')
    dark = np.asarray(Image.open(os.path.join(tmp_dir, pngs[0])).convert('L')) < 128
  finally:
    shutil.rmtree(tmp_dir, ignore_errors=True)
  ys, xs = np.nonzero(dark)
  if not len(ys):
    return {'ink': None}
  ox, oy = int(x0 * px) / px, int(y0 * px) / px
  return {'ink': {'x0_mm': round(ox + xs.min() / px, 2), 'y0_mm': round(oy + ys.min() / px, 2),
                  'x1_mm': round(ox + (xs.max() + 1) / px, 2),
                  'y1_mm': round(oy + (ys.max() + 1) / px, 2)}}


def text_rows(path, only=None):
  """Yield (page, [row]) for every page, a row being the text on one baseline:
  {'y': baseline in points from the page top, 'spans': [(font, size)]}.

  Read from mutool's structured text, which gives each character's origin --
  the baseline itself, where pdftotext gives only the foot of a word's box --
  and the face and size it is set in.
  """
  cmd = ['mutool', 'draw', '-F', 'stext', '-o', '-', path]
  if only:
    cmd.append(str(only))
  proc = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True)
  page, spans, font, fresh = (only - 1 if only else 0), [], None, False
  try:
    for line in proc.stdout:
      if line.startswith('<char'):
        if fresh:  # one character places the span; the rest share its baseline
          m = re.search(r' y="([-\d.]+)"', line)
          if m:
            spans.append((float(m.group(1)), font[0], font[1]))
            fresh = False
      elif line.startswith('<font'):
        m = re.search(r'name="([^"]*)" size="([\d.]+)"', line)
        font, fresh = (m.group(1), float(m.group(2))), True
      elif line.startswith('<page'):
        if page:
          yield page, _rows(spans)
        page, spans = page + 1, []
    if page:
      yield page, _rows(spans)
  finally:
    proc.stdout.close()
    if proc.wait() != 0:
      raise RuntimeError('mutool could not read the text')


def _rows(spans):
  rows = []
  for y, name, size in sorted(spans):
    if rows and y - rows[-1]['y'] < 2.0:
      rows[-1]['spans'].append((name, size))
    else:
      rows.append({'y': y, 'spans': [(name, size)]})
  return rows


def _is_head_face(name):
  """Work Sans SemiBold or Bold, upright or italic, however the file spells
  it. The Bold cut belongs to the Sources headings alone (Ramsey,
  2026-10-01), so a line in it is a heading as surely as one in SemiBold;
  bold in the text is SemiBold at 0.94em and is turned away by size below."""
  plain = re.sub(r'^[A-Z]{6}\+', '', name)
  plain = re.sub(r'[^a-z]', '', plain.lower())
  return plain.startswith(('worksanssemibold', 'worksansbold'))


def _opens_with(rows):
  """What a page's first line is: 'title', 'subhead', 'text', or 'blank'."""
  if not rows:
    return 'blank'
  spans = rows[0]['spans']
  if not all(_is_head_face(name) for name, _size in spans):
    return 'text'
  size = max(size for _name, size in spans)
  if size >= TITLE_MIN_PT:
    return 'title'
  if size < HEAD_MIN_PT or abs(size - BOLD_IN_TEXT_PT) < 0.06:
    return 'text'
  return 'subhead'


def lines(path, top_mm, lead_pt, want):
  """How far each page of the text falls short of a full page at its foot.

  A page is full when its last line stands on the last line of the grid, which
  is not the same as holding `want` lines of type: a subhead's space counts. The
  rule is Tuwhiri's (2026-09-28): every page runs to the full depth, except
  where the next page opens with a subhead or starts a new chapter. The front
  matter, everything before the first chapter title, is left out.
  """
  top = top_mm / PT_MM
  foot = top + want * lead_pt          # the foot of the last line box
  depth = lead_pt - LINE_BASE_PT       # from a baseline to the foot of its box
  pages = []
  for page, rows in text_rows(path):
    # The running head stands above the text and the folio below it. A chapter
    # opener hangs from its title, not from the grid, and may end part of a
    # line lower than other pages do.
    body = [r for r in rows if top < r['y'] < foot + 0.6 * lead_pt]
    pages.append((page, body))
  start = next((i for i, (_p, body) in enumerate(pages) if _opens_with(body) == 'title'), None)
  if start is None:
    raise RuntimeError('no chapter title found, so no text to measure')
  pages = pages[start:]
  last_inked = max(i for i, (_p, body) in enumerate(pages) if body)
  out, short = [], []
  for i, (page, body) in enumerate(pages):
    if not body:
      continue
    short_by = max(0, round((foot - (body[-1]['y'] + depth)) / lead_pt))
    follows = _opens_with(pages[i + 1][1]) if i < last_inked else 'blank'
    excused = None
    if short_by:
      if follows in ('title', 'blank'):
        excused = 'ends a chapter'
      elif follows == 'subhead':
        excused = 'the next page opens with a subhead'
    out.append({'page': page, 'lines': len(body), 'short_by': short_by,
                'opens': _opens_with(body), 'excused': excused})
    if short_by and not excused:
      short.append({'page': page, 'short_by': short_by})
  return {'want': want, 'pages': out, 'short': short}


def faces(path, page):
  """The faces and sizes of the type on one page, each pair once."""
  seen = set()
  for _page, rows in text_rows(path, only=page):
    for row in rows:
      for name, size in row['spans']:
        seen.add((re.sub(r'^[A-Z]{6}\+', '', name), round(size, 1)))
  return {'faces': [{'font': n, 'size': s} for n, s in sorted(seen, key=lambda f: (f[1], f[0]))]}


def body_lines(path):
  """Yield (page, [line]) for every page, a line being the words of the text
  block that share a baseline, left to right."""
  by_page = {}
  for page, x0, y0, _x1, y1, text in words(path):
    # A drop cap is left out: its box ends between two lines of the text, and
    # read as a line it would stand between a divided word and its remainder.
    if BLOCK_TOP_MM < y1 * PT_MM < BLOCK_FOOT_MM and y1 - y0 < TEXT_MAX_PT:
      by_page.setdefault(page, []).append((y1, x0, text))
  for page in sorted(by_page):
    rows = []
    for y, x, text in sorted(by_page[page]):
      # bold and italic in a line end a little above or below the roman
      if rows and y - rows[-1][0] < 3.5:
        rows[-1][1].append((x, text))
      else:
        rows.append([y, [(x, text)]])
    yield page, [[t for _x, t in sorted(r[1])] for r in rows]


def breaks(path):
  """Words a line divides that house style would not have divided.

  Three kinds, after Tuwhiri's marks of 2026-09-28: a word that already has a
  hyphen ('compound'), a word that begins with a capital ('capital'), and a
  word whose remainder is all there is of the next line ('fragment'). A break
  at a hyphen the word already has is no fault, and ends in that hyphen, not
  in the one the renderer sets.
  """
  pages = list(body_lines(path))
  flat = [(page, line) for page, lines in pages for line in lines]
  found = []
  for i, (page, line) in enumerate(flat[:-1]):
    head = html_unescape(line[-1])
    if not head.endswith(SOFT_BREAK):
      continue
    rest = [html_unescape(w) for w in flat[i + 1][1]]
    whole = head + rest[0]
    bare = head.lstrip('‘“(\'"')
    if '-' in head[:-1] or '-' in rest[0].rstrip('.,;:!?’”)'):
      kind = 'compound'
    elif bare[:1].isupper():
      kind = 'capital'
    elif len(rest) == 1:
      kind = 'fragment'
    else:
      continue
    found.append({'page': page, 'kind': kind, 'word': whole})
  return {'breaks': found}


def html_unescape(text):
  """pdftotext -bbox writes its words as HTML."""
  for a, b in (('&amp;', '&'), ('&lt;', '<'), ('&gt;', '>'), ('&quot;', '"'), ('&apos;', "'")):
    text = text.replace(a, b)
  return text


def check(path, trim, require_even, require_blank_last, text_block=None):
  m = measure(path)
  fail, warn = [], []

  tw, th = trim
  if abs(m['trim_mm'][0] - tw) > 0.1 or abs(m['trim_mm'][1] - th) > 0.1:
    fail.append(('trim', f"{m['trim_mm'][0]}x{m['trim_mm'][1]}mm, want {tw}x{th}mm"))
  if not m['uniform_size']:
    fail.append(('trim', 'page sizes are not uniform'))
  if not m['boxes_equal']:
    fail.append(('boxes', 'a TrimBox/BleedBox/ArtBox differs from the MediaBox; '
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
    if im['has_icc']:
      fail.append(('images', f"page {im['page']}: carries an ICC profile; "
                             'IngramSpark interiors must be plain DeviceGray'))
    elif im['colorspace'] not in ('gray', 'index'):
      fail.append(('images', f"page {im['page']}: {im['colorspace']}, must be grayscale"))
    if im['ppi'] is None:
      fail.append(('images', f"page {im['page']}: resolution unreadable, "
                             f"want >= {MIN_PPI} ppi"))
    elif im['ppi'] < MIN_PPI:
      fail.append(('images', f"page {im['page']}: {im['ppi']:.0f} ppi, want >= {MIN_PPI}"))
    elif im['ppi'] > MAX_PPI:
      fail.append(('images', f"page {im['page']}: {im['ppi']:.0f} ppi, want <= {MAX_PPI}"))

  for edge, v in sorted(m['ink_to_trim_mm'].items()):
    if v < INK_FAIL_MM:
      fail.append(('margins', f"ink {v}mm from the {edge} trim, below {INK_FAIL_MM}mm"))
    elif v < INK_WARN_MM:
      warn.append(('margins', f"ink {v}mm from the {edge} trim; "
                              f"IngramSpark states {INK_WARN_MM}mm minimum"))

  if text_block:
    inner_mm, measure_mm = text_block
    over = measure_overruns(path, tw, inner_mm, measure_mm)
    for page, side, mm, word in over[:MEASURE_LIST_MAX]:
      fail.append(('measure', f"page {page}: {word!r} runs {mm}mm past the {side} "
                              f"of the {measure_mm:g}mm measure"))
    if len(over) > MEASURE_LIST_MAX:
      fail.append(('measure', f"and {len(over) - MEASURE_LIST_MAX} more "
                              f"(tolerance {MEASURE_TOL_MM}mm)"))

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
  ap.add_argument('action', choices=('measure', 'baselines', 'rules', 'ink', 'lines', 'faces',
                                      'breaks', 'check'))
  ap.add_argument('file')
  ap.add_argument('--page', type=int, default=1)
  ap.add_argument('--box', metavar='X0,Y0,X1,Y1',
                  help='for ink: the box to look in, in mm from the top left of the trim')
  ap.add_argument('--top', type=float, default=24.58, metavar='MM',
                  help='for lines: the top margin, where the grid begins')
  ap.add_argument('--lead', type=float, default=16.0, metavar='PT',
                  help='for lines: the leading')
  ap.add_argument('--want', type=int, default=31, metavar='N',
                  help='for lines: the lines a full page holds')
  ap.add_argument('--trim', default='152x229')
  ap.add_argument('--require-even', action='store_true')
  ap.add_argument('--require-blank-last', action='store_true')
  ap.add_argument('--measure', type=float, metavar='MM',
                  help='width of the text block; no word may lie outside it')
  ap.add_argument('--inner', type=float, metavar='MM',
                  help='inner (gutter) margin, which places the text block')
  a = ap.parse_args()
  if (a.measure is None) != (a.inner is None):
    ap.error('--measure and --inner go together')
  # Absolute, so a name beginning with a dash cannot reach mutool, pdftotext and
  # the rest as an option: not all of them honour `--`.
  a.file = os.path.abspath(a.file)
  try:
    if a.action == 'measure':
      print(json.dumps(measure(a.file), indent=2))
    elif a.action == 'baselines':
      print(json.dumps(baselines(a.file, a.page), indent=2))
    elif a.action == 'rules':
      print(json.dumps(rules(a.file, a.page), indent=2))
    elif a.action == 'lines':
      report = lines(a.file, a.top, a.lead, a.want)
      print(json.dumps(report, indent=2))
      if report['short']:
        n = len(report['short'])
        print(f"▲ {n} {'page falls' if n == 1 else 'pages fall'} short of {a.want} lines "
              f"with no subhead or chapter after: "
              f"{', '.join(str(s['page']) for s in report['short'])}", file=sys.stderr)
      else:
        print(f"✓ every page runs to {a.want} lines or is excused", file=sys.stderr)
    elif a.action == 'faces':
      print(json.dumps(faces(a.file, a.page), indent=2))
    elif a.action == 'breaks':
      report = breaks(a.file)
      print(json.dumps(report, ensure_ascii=False, indent=2))
      if report['breaks']:
        n = len(report['breaks'])
        print(f"▲ {n} {'word is' if n == 1 else 'words are'} divided against house style",
              file=sys.stderr)
      else:
        print('✓ no word is divided against house style', file=sys.stderr)
    elif a.action == 'ink':
      if not a.box:
        ap.error('ink needs --box X0,Y0,X1,Y1')
      box = tuple(float(v) for v in a.box.split(','))
      if len(box) != 4 or box[2] <= box[0] or box[3] <= box[1]:
        ap.error('--box wants X0,Y0,X1,Y1 in mm, with X1 > X0 and Y1 > Y0')
      print(json.dumps(ink(a.file, a.page, box), indent=2))
    else:
      w, h = (float(v) for v in a.trim.split('x'))
      text_block = None if a.measure is None else (a.inner, a.measure)
      return check(a.file, (w, h), a.require_even, a.require_blank_last, text_block)
  except Exception as e:  # deliberately broad: a preflight gate must never traceback
    print(f"✗ {e}", file=sys.stderr)
    return 1
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
