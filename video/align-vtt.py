#!/usr/bin/env python3
"""Forced-align a narrated MP3 to its spoken text and emit sentence-level WebVTT.

The text is the *known* script (gentts --dump-text), so the cues carry the
book's exact words; only the timings come from the model. Cues are built from
the text first (sentences, long ones split at clause punctuation, wrapped to
two lines of <=42 chars), then each cue line is aligned as one unit.

Outputs:
  OUT.vtt       sentence-level WebVTT captions
  OUT.chapters  "M:SS Heading" lines for the YouTube description

Usage:
  align-vtt.py --audio N.mp3 --text N.txt --md N-part.md --out out/N-stem
  align-vtt.py ... --spot-check 5     # ASR-transcribe 5 random cue windows and compare
"""

import argparse
import os
import json
import random
import re
import subprocess
import sys
import textwrap
from difflib import SequenceMatcher
from pathlib import Path

os.environ.setdefault("TQDM_DISABLE", "1")  # stable-ts progress bars

MAX_CUE_CHARS = 84          # two lines of 42
LINE_WIDTH = 42
TAIL_PAD = 0.30             # seconds a cue lingers after its last word
MIN_CUE = 0.50
MAX_CUE = 10.0

# Preferred break points when a long sentence has no clause punctuation
BREAK_WORDS = re.compile(r'\s(?=(?:and|but|or|nor|for|that|which|who|whom|whose|when|where|while|'
                         r'because|so|with|without|to|from|into|than|as|if|unless|until|after|before)\b)')

# Abbreviations that end in a full stop but do not end a sentence
ABBREV = re.compile(r'(?:\b(?:e\.g|i\.e|cf|Dr|Mr|Mrs|Ms|St|vs|c|ca|etc|no|vol|pp|ch)\.)$', re.I)


def die(msg, code=1):
  print(f'align-vtt: ✗ {msg}', file=sys.stderr)
  sys.exit(code)


def info(msg):
  print(f'align-vtt: ◉ {msg}', file=sys.stderr)


def warn(msg):
  print(f'align-vtt: ▲ {msg}', file=sys.stderr)


# --- Text -> cues ---

def split_sentences(paragraph):
  """Sentence split on terminal punctuation (optionally followed by a closing
  quote/bracket), re-joining false splits after known abbreviations."""
  pieces = re.split(r'(?<=[.!?])\s+|(?<=[.!?]["”’\')\]])\s+', paragraph.strip())
  out = []
  for piece in pieces:
    if out and (ABBREV.search(out[-1]) or piece[:1].islower()):
      out[-1] = f'{out[-1]} {piece}'
    else:
      out.append(piece)
  return [p for p in out if p]


def split_long(sentence):
  """Split a sentence over MAX_CUE_CHARS at the clause break nearest its
  midpoint; failing punctuation, at the nearest word boundary."""
  if len(sentence) <= MAX_CUE_CHARS:
    return [sentence]
  mid = len(sentence) / 2
  candidates = [m.end() for m in re.finditer(r'[,;:]\s|\s--\s|—\s|\s–\s|\.\.\.\s', sentence)]
  candidates = [c for c in candidates if 20 <= c <= len(sentence) - 20]
  if not candidates:
    # No clause punctuation: prefer a break before a conjunction or preposition
    candidates = [m.start() + 1 for m in re.finditer(BREAK_WORDS, sentence)
                  if 20 <= m.start() + 1 <= len(sentence) - 20]
  if not candidates:
    candidates = [m.end() for m in re.finditer(r'\s', sentence) if 20 <= m.end() <= len(sentence) - 20]
  if not candidates:
    return [sentence]
  cut = min(candidates, key=lambda c: abs(c - mid))
  return split_long(sentence[:cut].rstrip()) + split_long(sentence[cut:].lstrip())


def wrap_cue(text):
  lines = textwrap.wrap(text, LINE_WIDTH, break_long_words=False, break_on_hyphens=False)
  if len(lines) > 2:
    # Rebalance into two lines at the word boundary nearest the middle
    words = text.split()
    best, best_gap = None, None
    for i in range(1, len(words)):
      a, b = ' '.join(words[:i]), ' '.join(words[i:])
      gap = abs(len(a) - len(b))
      if best_gap is None or gap < best_gap:
        best, best_gap = (a, b), gap
    lines = list(best)
  return lines


def build_cues(text):
  """Paragraph-aware cue list: [{'text', 'lines', 'paragraph'}]."""
  cues = []
  paragraphs = [p.strip() for p in re.split(r'\n\s*\n', text) if p.strip()]
  for pi, para in enumerate(paragraphs):
    para = re.sub(r'\s+', ' ', para)
    for sent in split_sentences(para):
      for chunk in split_long(sent):
        cues.append({'text': chunk, 'lines': wrap_cue(chunk), 'paragraph': pi})
  return cues, paragraphs


# --- Markdown headings -> chapter markers ---

def md_headings(md_path):
  """Level-2 headings spoken in the audio (everything before <!--audio stop-->)."""
  heads = []
  for line in Path(md_path).read_text(encoding='utf-8').splitlines():
    if re.match(r'^\s*<!--\s*audio\s+stop\s*-->', line):
      break
    m = re.match(r'^##\s+(.+?)\s*$', line)
    if m:
      h = re.sub(r'[*_`]', '', m.group(1))
      heads.append(re.sub(r'\s+', ' ', h).strip())
  return heads


# --- Alignment ---

def audio_duration(path):
  out = subprocess.run(
    ['ffprobe', '-v', 'error', '-show_entries', 'format=duration', '-of', 'json', str(path)],
    check=True, capture_output=True, text=True).stdout
  return float(json.loads(out)['format']['duration'])


def load_model(name, device, compute_type):
  import stable_whisper  # noqa: PLC0415 -- heavy import, keep it lazy
  info(f'loading {name} ({device}, {compute_type})')
  return stable_whisper.load_faster_whisper(name, device=device, compute_type=compute_type)


def align(model, audio, cues, language):
  script = '\n'.join(c['text'] for c in cues)
  result = model.align(str(audio), script, language=language, original_split=True,
                       verbose=None)
  segs = [s for s in result.segments if s.words]
  if len(segs) != len(cues):
    # Fall back: slice the aligned word stream by each cue's word count
    words = result.all_words()
    expected = sum(len(c['text'].split()) for c in cues)
    if len(words) != expected:
      die(f'alignment mismatch: {len(segs)} segments for {len(cues)} cues, '
          f'{len(words)} words for {expected} expected')
    warn(f'{len(segs)} segments for {len(cues)} cues; slicing by word count')
    i = 0
    timings = []
    for c in cues:
      n = len(c['text'].split())
      ws = words[i:i + n]
      timings.append((ws[0].start, ws[-1].end))
      i += n
    return timings
  return [(s.start, s.end) for s in segs]


def norm_words(text):
  text = re.sub(r'[-\u2010-\u2015]', ' ', text.lower())  # hyphens and dashes split words
  return [w for w in re.sub(r'[^a-z0-9 ]', '', text).split() if w]


def transcribe_window(model, audio, start, end, language):
  """ASR the audio window; returns [(abs_start, abs_end, word)]."""
  import tempfile  # noqa: PLC0415
  with tempfile.NamedTemporaryFile(suffix='.wav') as tmp:
    subprocess.run(['ffmpeg', '-v', 'error', '-y', '-ss', f'{start:.3f}', '-t', f'{end - start:.3f}',
                    '-i', str(audio), '-ac', '1', '-ar', '16000', tmp.name], check=True)
    words = model.transcribe(tmp.name, language=language, word_timestamps=True,
                             verbose=None).all_words()
  return [(start + w.start, start + w.end, w.word) for w in words]


def suspicious(cue, start, end):
  """Speech-rate sanity: narration runs ~10-20 chars/s; short clauses reach ~30."""
  d = max(end - start, 1e-3)
  rate = len(cue['text']) / d
  return rate > 40 or (rate < 6 and len(cue['text']) > 25)


def flagged_runs(flags, n, gap=2, margin=1):
  """Group flagged indices into runs (joined when <= gap apart), each widened by
  margin on both sides: [(lo, hi), ...]."""
  runs = []
  for i in flags:
    if runs and i - runs[-1][1] <= gap:
      runs[-1][1] = i
    else:
      runs.append([i, i])
  return [(max(0, lo - margin), min(n - 1, hi + margin)) for lo, hi in runs]


def retime_run(cues, lo, hi, heard):
  """One monotonic sequence match of the run's words against the heard words.
  Returns {cue_index: (start, end)} for cues with enough matched words."""
  want = [(j, w) for j in range(lo, hi + 1) for w in norm_words(cues[j]['text'])]
  got = [(norm_words(w) or [''])[0] for _, _, w in heard]
  sm = SequenceMatcher(None, [w for _, w in want], got, autojunk=False)
  hits = {}
  for a, b, size in sm.get_matching_blocks():
    for k in range(size):
      j = want[a + k][0]
      t0, t1 = heard[b + k][0], heard[b + k][1]
      s0, s1, cnt = hits.get(j, (t0, t1, 0))
      hits[j] = (min(s0, t0), max(s1, t1), cnt + 1)
  out = {}
  for j in range(lo, hi + 1):
    need = len(norm_words(cues[j]['text']))
    if j in hits and hits[j][2] >= max(1, need * 0.5):
      out[j] = (hits[j][0], hits[j][1])
  return out


def interpolate(cues, raw, lo, hi, found):
  """Fill cues the ASR pass could not place by sharing the gap between their
  placed neighbours in proportion to text length."""
  result = dict(found)
  j = lo
  while j <= hi:
    if j in result:
      j += 1
      continue
    k = j
    while k <= hi and k not in result:
      k += 1
    gap_start = result[j - 1][1] if j - 1 in result else (raw[j - 1][1] if j > 0 else 0.0)
    gap_end = result[k][0] if k in result else raw[k][0] if k < len(cues) else raw[hi][1]
    total = sum(len(cues[m]['text']) for m in range(j, k)) or 1
    t = gap_start
    for m in range(j, k):
      share = (gap_end - gap_start) * len(cues[m]['text']) / total
      result[m] = (t, t + share)
      t += share
    j = k
  return result


def repair_timings(model, audio, cues, raw, language, duration):
  """Re-time rate-anomalous cues from an ASR pass over their neighbourhood.
  Forced alignment occasionally fails a short sentence (zero-length span) or
  drops it into a pause and hands its span to the next cue; ASR word
  timestamps put the run back, monotonic by construction."""
  raw = list(raw)
  flags = [i for i, c in enumerate(cues) if suspicious(c, *raw[i])]
  if not flags:
    return raw, 0
  runs = flagged_runs(flags, len(cues))
  info(f'{len(flags)} rate-anomalous cue(s) in {len(runs)} run(s); repairing from ASR')
  repaired = 0
  for lo, hi in runs:
    w_start = max(0.0, min(raw[m][0] for m in range(lo, hi + 1)) - 1.0)
    w_end = min(duration, max(raw[m][1] for m in range(lo, hi + 1)) + 1.0)
    # A collapsed run under-reports its true length: allow ~12 chars/s of speech
    need = sum(len(cues[m]['text']) for m in range(lo, hi + 1)) / 12.0
    w_end = min(duration, max(w_end, w_start + need + 2.0))
    heard = transcribe_window(model, audio, w_start, w_end, language)
    found = retime_run(cues, lo, hi, heard)
    if not found:
      warn(f'  cues {lo + 1}-{hi + 1} @{ts(w_start)}: ASR matched nothing; left as aligned')
      continue
    for j, span in interpolate(cues, raw, lo, hi, found).items():
      if abs(span[0] - raw[j][0]) > 0.25 or abs(span[1] - raw[j][1]) > 0.25:
        how = 'asr' if j in found else 'interpolated'
        info(f'  cue {j + 1} @{ts(raw[j][0])} -> {ts(span[0])} ({how}): {cues[j]["text"][:40]!r}')
        repaired += 1
      raw[j] = span
  # Safety clamp: never let a repair step backwards past its predecessor
  for i in range(1, len(raw)):
    if raw[i][0] < raw[i - 1][1]:
      raw[i] = (raw[i - 1][1], max(raw[i][1], raw[i - 1][1] + 0.3))
  still = [i for i, c in enumerate(cues) if suspicious(c, *raw[i])]
  for i in still:
    warn(f'cue {i + 1} still rate-anomalous after repair @{ts(raw[i][0])} '
         f'(text missing or garbled in the audio?): {cues[i]["text"][:40]!r}')
  return raw, repaired


def detect_silences(audio, noise_db=-35, min_dur=0.3):
  """[(start, end), ...] of silences via ffmpeg silencedetect."""
  out = subprocess.run(
    ['ffmpeg', '-v', 'info', '-i', str(audio), '-af', f'silencedetect=noise={noise_db}dB:d={min_dur}',
     '-f', 'null', '-'], check=True, capture_output=True, text=True).stderr
  starts = [float(m) for m in re.findall(r'silence_start: ([\d.]+)', out)]
  ends = [float(m) for m in re.findall(r'silence_end: ([\d.]+)', out)]
  return list(zip(starts, ends))


def snap_to_silence(raw, silences, lead=0.10, slack=0.30):
  """Aligned cue edges sometimes land inside a pause (the model spreads a
  boundary into silence). Move a start that sits in a silence up to just
  before speech resumes; pull an end that sits in a silence back to where
  speech stopped. Returns (timings, starts_moved, ends_moved)."""
  timings = []
  moved_s = moved_e = 0
  for start, end in raw:
    for s0, s1 in silences:
      if s0 <= start < s1 and s1 - start > slack and s1 - lead < end:
        start = s1 - lead
        moved_s += 1
      if s0 < end <= s1 and end - s0 > slack and s0 > start:
        end = s0
        moved_e += 1
    timings.append((start, end))
  return timings, moved_s, moved_e


def finalise_timings(raw, duration):
  """Apply tail padding, clamp to neighbours and the audio length."""
  timings = []
  for i, (start, end) in enumerate(raw):
    nxt = raw[i + 1][0] if i + 1 < len(raw) else duration
    end = min(end + TAIL_PAD, nxt, duration)
    if end - start < MIN_CUE:
      end = min(start + MIN_CUE, nxt, duration)
    timings.append((start, end))
  return timings


def self_check(cues, timings, duration):
  prev_end = -1.0
  problems = 0
  for c, (start, end) in zip(cues, timings):
    if start < prev_end - 1e-3 or end <= start:
      warn(f'non-monotonic cue at {ts(start)}: {c["text"][:50]!r}')
      problems += 1
    if end > duration + 1e-3:
      warn(f'cue past end of audio at {ts(start)}')
      problems += 1
    d = end - start
    if d > MAX_CUE:
      warn(f'long cue {d:.1f}s at {ts(start)}: {c["text"][:50]!r}')
    if d < MIN_CUE - 1e-3:
      warn(f'short cue {d:.2f}s at {ts(start)}: {c["text"][:50]!r}')
    prev_end = end
  if problems:
    die(f'{problems} timing problem(s)')


# --- Output ---

def ts(seconds):
  ms = int(round(seconds * 1000))
  h, ms = divmod(ms, 3_600_000)
  m, ms = divmod(ms, 60_000)
  s, ms = divmod(ms, 1000)
  return f'{h:02d}:{m:02d}:{s:02d}.{ms:03d}'


def chapter_ts(seconds):
  s = int(seconds)
  h, s = divmod(s, 3600)
  m, s = divmod(s, 60)
  return f'{h}:{m:02d}:{s:02d}' if h else f'{m}:{s:02d}'


def vtt_escape(line):
  return line.replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;')


def write_vtt(path, cues, timings, offset=0.0):
  with open(path, 'w', encoding='utf-8') as fh:
    fh.write('WEBVTT\n\n')
    for i, (c, (start, end)) in enumerate(zip(cues, timings), 1):
      fh.write(f'{i}\n{ts(start + offset)} --> {ts(end + offset)}\n')
      fh.write('\n'.join(vtt_escape(ln) for ln in c['lines']) + '\n\n')


def chapters(cues, timings, paragraphs, headings, offset=0.0):
  """First cue of each heading paragraph -> (start, heading). Always opens at 0:00."""
  out = [(0.0, 'Introduction')]
  para_first = {}
  for c, (start, _) in zip(cues, timings):
    para_first.setdefault(c['paragraph'], start + offset)
  for pi, para in enumerate(paragraphs):
    norm = re.sub(r'\s+', ' ', para).strip()
    if norm in headings and pi in para_first:
      out.append((para_first[pi], norm))
  return out


def write_chapters(path, chaps):
  with open(path, 'w', encoding='utf-8') as fh:
    for start, title in chaps:
      fh.write(f'{chapter_ts(start)} {title}\n')


# --- Spot check ---

def spot_check(model, audio, cues, timings, n, language, seed=7):
  """Transcribe a window from N random cue starts and fuzzy-match the cue text
  (plus what follows, since the window may outrun the cue).
  Returns the worst (ratio, drift-seconds) pair."""
  rng = random.Random(seed)
  idx = rng.sample(range(len(cues)), min(n, len(cues)))
  worst_ratio, worst_drift = 1.0, 0.0
  for i in sorted(idx):
    start, end = timings[i]
    win_end = min(start + max(4.0, end - start), audio_duration(audio))
    heard = transcribe_window(model, audio, start, win_end, language)
    heard_text = ' '.join(norm_words(w) and norm_words(w)[0] or '' for _, _, w in heard)
    expect = ' '.join(norm_words(' '.join(c['text'] for c in cues[i:i + 4])))[:len(heard_text) + 8]
    ratio = SequenceMatcher(None, expect, heard_text).ratio()
    drift = (heard[0][0] - start) if heard else (win_end - start)
    info(f'spot {i + 1:4d} @{ts(start)} ratio={ratio:.2f} drift={drift:.2f}s '
         f'| {cues[i]["text"][:40]!r} ~ {heard_text[:40]!r}')
    worst_ratio, worst_drift = min(worst_ratio, ratio), max(worst_drift, drift)
  return worst_ratio, worst_drift


# --- Main ---

def main():
  ap = argparse.ArgumentParser(description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter)
  ap.add_argument('--audio', required=True, type=Path)
  ap.add_argument('--text', required=True, type=Path, help='spoken text from gentts --dump-text')
  ap.add_argument('--md', required=True, type=Path, help='the Part markdown (for ## chapter headings)')
  ap.add_argument('--out', required=True, help='output stem; writes STEM.vtt and STEM.chapters')
  ap.add_argument('--language', default='en')
  ap.add_argument('--model', default='large-v3')
  ap.add_argument('--device', default='cuda')
  ap.add_argument('--compute-type', default='int8_float16',
                  help='ctranslate2 compute type; int8_float16 fits beside other GPU tenants')
  ap.add_argument('--offset', type=float, default=0.0, metavar='SECONDS',
                  help='shift every written cue and chapter by this much (intro music lead-in)')
  ap.add_argument('--spot-check', type=int, default=0, metavar='N')
  ap.add_argument('--min-ratio', type=float, default=0.6,
                  help='fail if any spot-check fuzzy ratio is below this')
  args = ap.parse_args()

  for p in (args.audio, args.text, args.md):
    if not p.exists():
      die(f'missing input {p}')

  text = args.text.read_text(encoding='utf-8')
  cues, paragraphs = build_cues(text)
  if not cues:
    die('no cues built from text')
  duration = audio_duration(args.audio)
  info(f'{len(cues)} cues from {len(paragraphs)} paragraphs; audio {ts(duration)}')

  model = load_model(args.model, args.device, args.compute_type)
  raw = align(model, args.audio, cues, args.language)
  raw, repaired = repair_timings(model, args.audio, cues, raw, args.language, duration)
  raw, moved_s, moved_e = snap_to_silence(raw, detect_silences(args.audio))
  info(f'silence snap: {moved_s} start(s), {moved_e} end(s) moved')
  timings = finalise_timings(raw, duration)
  self_check(cues, timings, duration)

  heads = md_headings(args.md)
  chaps = chapters(cues, timings, paragraphs, heads, args.offset)
  missing = set(heads) - {t for _, t in chaps}
  if missing:
    warn(f'headings not found in spoken text: {sorted(missing)}')

  write_vtt(f'{args.out}.vtt', cues, timings, args.offset)
  if args.offset:
    info(f'cues and chapters offset by {args.offset:.3f}s')
  write_chapters(f'{args.out}.chapters', chaps)
  info(f'wrote {args.out}.vtt ({len(cues)} cues) and {args.out}.chapters ({len(chaps)} chapters)')

  if args.spot_check:
    ratio, drift = spot_check(model, args.audio, cues, timings, args.spot_check, args.language)
    info(f'spot-check worst ratio {ratio:.2f}, max drift {drift:.2f}s; {repaired} cue(s) repaired')
    if ratio < args.min_ratio:
      die(f'spot-check ratio {ratio:.2f} below {args.min_ratio}')
    Path(f'{args.out}.check').write_text(f'ratio={ratio:.2f}\ndrift={drift:.2f}\nrepaired={repaired}\n')


if __name__ == '__main__':
  main()

#fin
