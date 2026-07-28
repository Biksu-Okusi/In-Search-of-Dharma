#!/usr/bin/env python3
"""Generate TTS narration for the Indonesian essays (Mencari Dharma).

Reads the id/*.md essay sources directly (no database) and synthesises one
narration MP3 per essay with Google Cloud TTS (Chirp3-HD Indonesian voices),
named to match what id/mk-book.sh --audio link|embed expects:
  <part>-mencari-dharma.mp3  in  /var/www/vhosts/garydean.id/html/audio

Usage:
  ./generate_tts --list                        # essays and audio status
  ./generate_tts --part 3                      # generate one essay
  ./generate_tts --part 3 --preview            # processed text/SSML, no API call
  ./generate_tts --all                         # generate all essays
  ./generate_tts --part 3 --force              # regenerate existing audio
  ./generate_tts --part 3 --gender female      # female voice
  ./generate_tts --all --output-dir /tmp/out   # write elsewhere (test runs)

Adapted from ../www/tts/generate_tts.py. The preprocessing pipeline is the
same, minus the database/provider machinery, plus what file sources need:
  - YAML frontmatter stripping (DB rows carried none)
  - <!--audio start--> accepted alongside restart (the essay files use start;
    an unclosed stop still excises to end-of-file, which is how every essay
    fences off its trailing nav link and Sources section)
  - remaining HTML comments (e.g. the <!--\\newpage--> print markers) stripped
No pronunciation lexicon: the www lexicon exists to teach an English voice
Indonesian words; the id-ID voice needs no such help.

Auth: Application Default Credentials (gcloud auth application-default login).
Chirp3-HD voices require OAuth2 principals; plain API keys are rejected.
"""

import argparse
import os
import re
import shutil
import subprocess
import sys
import tempfile
from pathlib import Path

# --- Configuration ---

SCRIPT_DIR = Path(__file__).resolve().parent
AUDIO_DIR = Path("/var/www/vhosts/garydean.id/html/audio")
AUDIO_STEM = "mencari-dharma"

SERIES_TITLE = "Mencari Dharma"
AUTHOR = "Biksu Okusi"

GOOGLE_VOICES = {
  'male':   "id-ID-Chirp3-HD-Puck",
  'female': "id-ID-Chirp3-HD-Autonoe",
}
GOOGLE_LANG_CODE = "id-ID"
GOOGLE_CHUNK_LIMIT = 3500  # bytes, under 5000 SSML limit (break tags add overhead)


# --- Essay Discovery ---

def find_essays():
  """Return the essay source files, in part order (0-preface.md .. 9-coda.md)."""
  return sorted(SCRIPT_DIR.glob('[0-9]-*.md'))


def parse_frontmatter(raw):
  """Split YAML frontmatter from body; return (meta dict, body).

  Minimal scalar-only parse (title, part, ...) — the venv has no PyYAML and
  the frontmatter in these files is flat key: value lines."""
  m = re.match(r'\A---\n(.*?)\n---\n', raw, re.DOTALL)
  if not m:
    return {}, raw
  meta = {}
  for line in m.group(1).splitlines():
    kv = re.match(r'([A-Za-z_]+):\s*(.*)$', line)
    if kv:
      meta[kv.group(1)] = kv.group(2).strip().strip('"\'')
  return meta, raw[m.end():]


# --- Content Preprocessing ---

def strip_audio_excluded_regions(text):
  """Remove regions fenced by <!--audio stop--> ... <!--audio start-->.

  An unclosed 'stop' excludes everything to the end of the content (used to
  fence off the trailing nav link and Sources section). 'restart' is accepted
  as a synonym for 'start'. Matching is lenient: case insensitive and tolerant
  of internal whitespace. Prints a diagnostic only when content was excised."""
  marker = re.compile(r'<!--\s*audio\s+(stop|start|restart)\s*-->', re.IGNORECASE)
  out = []
  pos = 0
  emitting = True
  removed = 0
  for m in marker.finditer(text):
    if emitting:
      out.append(text[pos:m.start()])
    else:
      removed += m.start() - pos
    emitting = (m.group(1).lower() != 'stop')
    pos = m.end()
  if emitting:
    out.append(text[pos:])
  else:
    removed += len(text) - pos
  if removed:
    print(f"  ◉ audio: excised {removed:,} chars in excluded region(s)")
  return ''.join(out)


def strip_custom_tags(text):
  """Remove custom <image> and other non-speakable tags."""
  # Remove <image ...> tags (single tag, no closing)
  text = re.sub(r'<image\s[^>]*>', '', text, flags=re.IGNORECASE)

  # Remove remaining HTML comments (<!--\newpage--> print markers etc.)
  text = re.sub(r'<!--.*?-->', '', text, flags=re.DOTALL)

  # Remove <style>/<table>/<pre>/<audio>/<figure>/<iframe> blocks
  for tag in ('style', 'table', 'pre', 'audio', 'figure', 'iframe'):
    text = re.sub(rf'<{tag}[^>]*>.*?</{tag}>', '', text,
                  flags=re.DOTALL | re.IGNORECASE)

  return text


def strip_html_tags(text):
  """Remove remaining HTML tags, keeping text content."""
  # Remove footnote references
  text = re.sub(r'<sup>\d+</sup>', '', text, flags=re.IGNORECASE)

  # Keep figcaption text
  text = re.sub(r'<figcaption[^>]*>(.*?)</figcaption>', r'\1', text,
                flags=re.DOTALL | re.IGNORECASE)

  # Strip all remaining HTML tags
  text = re.sub(r'<[^>]+>', '', text)

  return text


def strip_markdown(text):
  """Remove markdown formatting markers."""
  # Strip bold/italic markers
  text = re.sub(r'\*\*\*([^*]+?)\*\*\*', r'\1', text)
  text = re.sub(r'\*\*([^*]+?)\*\*', r'\1', text)
  text = re.sub(r'(?<!\*)\*([^*\n]+?)\*(?!\*)', r'\1', text)
  text = re.sub(r'___([^_]+?)___', r'\1', text)
  text = re.sub(r'__([^_]+?)__', r'\1', text)
  text = re.sub(r'(?<!\w)_([^_]+?)_(?!\w)', r'\1', text)

  # Strip markdown links [text](url) -> text
  text = re.sub(r'\[([^\]]+)\]\([^)]+\)', r'\1', text)

  # Strip markdown images ![alt](url)
  text = re.sub(r'!\[[^\]]*\]\([^)]+\)', '', text)

  # Strip footnote references: [^1], [S1], [2], etc.
  text = re.sub(r'\[\^?[^\]]*\d+[^\]]*\]', '', text)

  return text


def process_headings(text):
  """Convert markdown headings to plain text with markers for pauses."""
  text = re.sub(r'^###\s+(.+)$', r'[PAUSE_MEDIUM]\1[PAUSE_SHORT]', text, flags=re.MULTILINE)
  text = re.sub(r'^##\s+(.+)$', r'[PAUSE_LONG]\1[PAUSE_MEDIUM]', text, flags=re.MULTILINE)
  text = re.sub(r'^#\s+(.+)$', r'[PAUSE_LONG]\1[PAUSE_MEDIUM]', text, flags=re.MULTILINE)
  return text


def process_blockquotes(text):
  """Mark blockquoted text for prosody changes."""
  lines = text.split('\n')
  result = []
  in_quote = False

  for line in lines:
    stripped = line.strip()
    if stripped.startswith('> '):
      if not in_quote:
        result.append('[QUOTE_START]')
        in_quote = True
      result.append(stripped[2:])
    else:
      if in_quote:
        result.append('[QUOTE_END]')
        in_quote = False
      result.append(line)

  if in_quote:
    result.append('[QUOTE_END]')

  return '\n'.join(result)


def process_hr(text):
  """Convert horizontal rules to long pause markers."""
  text = re.sub(r'^---+$', '[PAUSE_XLONG]', text, flags=re.MULTILINE)
  text = re.sub(r'^\*\*\*+$', '[PAUSE_XLONG]', text, flags=re.MULTILINE)
  return text


def decode_entities(text):
  """Decode HTML entities."""
  import html
  return html.unescape(text)


def strip_misc_symbols(text):
  """Remove non-speakable symbols."""
  text = text.replace('↩︎', '')
  text = text.replace('↩', '')
  # Linguistic root sign (e.g. "√dhṛ"): visual notation the voice would
  # otherwise read as "akar kuadrat". Drop it; the root word stands on its own.
  text = text.replace('√', '')
  return text


def clean_whitespace(text):
  """Collapse excessive whitespace."""
  text = re.sub(r'\n{3,}', '\n\n', text)
  text = re.sub(r'[ \t]{2,}', ' ', text)
  text = '\n'.join(line.strip() for line in text.split('\n'))
  return text.strip()


def preprocess_content(content):
  """Full preprocessing pipeline: raw markdown → clean text with pause markers."""
  text = content

  # Normalise line endings
  text = text.replace('\r\n', '\n').replace('\r', '\n')

  # Stage 0.5: Honour <!--audio stop--> / <!--audio start--> fences
  text = strip_audio_excluded_regions(text)

  # Stage 1: Strip non-speakable content
  text = strip_custom_tags(text)

  # Stage 2: Handle structural elements
  text = process_hr(text)
  text = process_blockquotes(text)
  text = process_headings(text)

  # Stage 3: Strip formatting
  text = strip_markdown(text)
  text = strip_html_tags(text)

  # Stage 4: Decode entities and clean up
  text = decode_entities(text)
  text = strip_misc_symbols(text)
  text = clean_whitespace(text)

  return text


# --- SSML Generation ---

def escape_ssml(text):
  """Escape special XML characters for SSML."""
  text = text.replace('&', '&amp;')
  text = text.replace('<', '&lt;')
  text = text.replace('>', '&gt;')
  text = text.replace('"', '&quot;')
  text = text.replace("'", '&apos;')
  return text


def text_to_ssml(text):
  """Convert preprocessed text with pause markers to SSML."""
  text = escape_ssml(text)

  # NOTE: Chirp 3 HD honours <break> and <prosody> despite Google's docs
  # listing only <phoneme>/<p>/<s>/<sub>/<say-as> as supported. Verified
  # empirically (2026-06-21) for the English pipeline; see
  # ../www/tts/generate_tts.py. Do not "simplify" these tags away on the
  # strength of the documentation.
  text = text.replace('[PAUSE_XLONG]', '<break time="2000ms"/>')
  text = text.replace('[PAUSE_LONG]', '<break time="1200ms"/>')
  text = text.replace('[PAUSE_MEDIUM]', '<break time="800ms"/>')
  text = text.replace('[PAUSE_SHORT]', '<break time="400ms"/>')

  # Blockquote prosody
  text = text.replace('[QUOTE_START]', '<prosody rate="95%" pitch="-1st">')
  text = text.replace('[QUOTE_END]', '</prosody>')

  # Slight pause after sentence-ending punctuation
  text = re.sub(r'([.!?])\s', r'\1<break time="300ms"/> ', text)

  # Paragraph pauses (double newline = paragraph break)
  text = text.replace('\n\n', '<break time="1400ms"/>\n')

  # Single newline within paragraphs = small pause
  text = text.replace('\n', '<break time="200ms"/>\n')

  return f'<speak><break time="1500ms"/>{text}</speak>'


# --- Chunking ---

def chunk_ssml(ssml_text):
  """Chunk SSML content respecting the byte limit."""
  inner = ssml_text
  if inner.startswith('<speak>'):
    inner = inner[7:]
  if inner.endswith('</speak>'):
    inner = inner[:-8]

  def ssml_bytes(text):
    return len(f'<speak>{text}</speak>'.encode('utf-8'))

  # Split on all break tags as natural boundaries
  segments = re.split(r'(<break time="\d+ms"/>)', inner)

  chunks = []
  current = ""

  for seg in segments:
    test = current + seg
    if ssml_bytes(test) > GOOGLE_CHUNK_LIMIT:
      if not current.strip() or ssml_bytes(seg) > GOOGLE_CHUNK_LIMIT:
        if current.strip():
          chunks.append(f'<speak>{current.strip()}</speak>')
          current = ""
        # Split oversized segment on sentence-ending punctuation
        sentences = re.split(r'(?<=[.!?])\s+', seg)
        for sent in sentences:
          if current and ssml_bytes(current + ' ' + sent) > GOOGLE_CHUNK_LIMIT:
            if current.strip():
              chunks.append(f'<speak>{current.strip()}</speak>')
            current = sent
          else:
            current = f"{current} {sent}" if current else sent
      else:
        chunks.append(f'<speak>{current.strip()}</speak>')
        current = seg
    else:
      current = test

  if current.strip():
    chunks.append(f'<speak>{current.strip()}</speak>')

  return balance_prosody_tags(chunks)


def balance_prosody_tags(chunks):
  """Ensure each chunk has balanced <prosody> open/close tags."""
  prosody_pattern = re.compile(r'<prosody[^>]*>')
  result = []
  carry_tag = None  # prosody tag to re-open in next chunk

  for chunk in chunks:
    inner = chunk
    if inner.startswith('<speak>'):
      inner = inner[7:]
    if inner.endswith('</speak>'):
      inner = inner[:-8]

    if carry_tag:
      inner = carry_tag + inner
      carry_tag = None

    opens = prosody_pattern.findall(inner)
    closes = inner.count('</prosody>')

    if len(opens) > closes:
      # Unclosed prosody — close it and carry to next chunk
      carry_tag = opens[-1]
      inner += '</prosody>'

    result.append(f'<speak>{inner}</speak>')

  return result


# --- Audio Generation: Google Cloud TTS ---

def generate_google_rest(ssml_chunks, output_path, voice_name):
  """Generate audio using Google Cloud TTS via ADC (OAuth2).

  Chirp3-HD voices require principal-asserting credentials, not API keys.
  Authenticate with: gcloud auth application-default login"""
  from google.cloud import texttospeech as gtts
  from google.api_core import exceptions as gax_exceptions
  from google.api_core import retry as gax_retry

  try:
    client = gtts.TextToSpeechClient()
  except Exception as e:
    print(f"  ERROR: failed to init TTS client "
          f"(run 'gcloud auth application-default login'): {e}", file=sys.stderr)
    sys.exit(1)

  retry_policy = gax_retry.Retry(
    predicate=lambda exc: isinstance(exc, (
      gax_exceptions.DeadlineExceeded,
      gax_exceptions.ServiceUnavailable,
      gax_exceptions.InternalServerError,
      gax_exceptions.ResourceExhausted,
    )),
    initial=2.0, maximum=30.0, multiplier=2.0,
    deadline=240.0,
  )

  chunk_files = []
  tmpdir = tempfile.mkdtemp(prefix="tts_")

  try:
    for i, ssml in enumerate(ssml_chunks):
      print(f"  Chunk {i+1}/{len(ssml_chunks)} "
            f"({len(ssml.encode('utf-8'))} bytes)...", end=" ", flush=True)

      try:
        response = client.synthesize_speech(
          request=gtts.SynthesizeSpeechRequest(
            input=gtts.SynthesisInput(ssml=ssml),
            voice=gtts.VoiceSelectionParams(
              language_code=GOOGLE_LANG_CODE,
              name=voice_name,
            ),
            audio_config=gtts.AudioConfig(
              audio_encoding=gtts.AudioEncoding.MP3,
              speaking_rate=0.95,
            ),
          ),
          retry=retry_policy,
          timeout=120,
        )
      except gax_exceptions.GoogleAPIError as e:
        print(f"FAILED ({type(e).__name__}: {e})", file=sys.stderr)
        sys.exit(1)

      chunk_path = os.path.join(tmpdir, f"chunk_{i:04d}.mp3")
      with open(chunk_path, 'wb') as f:
        f.write(response.audio_content)

      chunk_files.append(chunk_path)
      print("OK", flush=True)

    if len(chunk_files) == 1:
      shutil.move(chunk_files[0], str(output_path))
    else:
      concatenate_audio(chunk_files, output_path, tmpdir)

    print(f"  Written: {output_path}")

  finally:
    for f in chunk_files:
      if os.path.exists(f):
        os.remove(f)
    for f in Path(tmpdir).glob("*"):
      f.unlink()
    os.rmdir(tmpdir)


def concatenate_audio(chunk_files, output_path, tmpdir):
  """Concatenate MP3 chunks using ffmpeg with silence between them."""
  silence_path = os.path.join(tmpdir, "silence.mp3")
  subprocess.run([
    "ffmpeg", "-y", "-f", "lavfi", "-i", "anullsrc=r=24000:cl=mono",
    "-t", "0.5", "-c:a", "libmp3lame", "-q:a", "4", silence_path,
  ], capture_output=True, check=True)

  list_path = os.path.join(tmpdir, "filelist.txt")
  with open(list_path, 'w') as f:
    for i, chunk in enumerate(chunk_files):
      f.write(f"file '{chunk}'\n")
      if i < len(chunk_files) - 1:
        f.write(f"file '{silence_path}'\n")

  subprocess.run([
    "ffmpeg", "-y", "-f", "concat", "-safe", "0",
    "-i", list_path, "-c", "copy", str(output_path),
  ], capture_output=True, check=True)


def set_web_perms(path):
  """Match the webroot convention (group www-data, mode 664), best effort:
  the setgid audio dir usually inherits the group anyway."""
  try:
    shutil.chown(path, group='www-data')
  except (LookupError, PermissionError, OSError):
    pass
  try:
    os.chmod(path, 0o664)
  except OSError:
    pass


# --- Reporting helpers ---

def get_audio_duration(filepath):
  """Get MP3 duration in seconds using ffprobe."""
  try:
    result = subprocess.run(
      ["ffprobe", "-v", "quiet", "-show_entries", "format=duration",
       "-of", "default=noprint_wrappers=1:nokey=1", str(filepath)],
      capture_output=True, text=True, check=True,
    )
    return float(result.stdout.strip())
  except (subprocess.CalledProcessError, ValueError):
    return 0.0


def format_duration(seconds):
  """Format seconds as mm:ss."""
  m = int(seconds) // 60
  s = int(seconds) % 60
  return f"{m}:{s:02d}"


# --- Main Logic ---

def process_essay(path, output_dir, preview=False, force=False, gender='male'):
  """Process one essay file: preprocess, synthesise, write MP3."""
  raw = path.read_text(encoding='utf-8')
  meta, body = parse_frontmatter(raw)
  part = meta.get('part', path.name[0])
  title = meta.get('title', path.stem)

  print(f"\n{'='*60}")
  print(f"Essay: {part}: {title}")
  print(f"File:  {path.name}")

  output_path = output_dir / f"{part}-{AUDIO_STEM}.mp3"

  if output_path.exists() and not force:
    dur = get_audio_duration(output_path)
    print(f"  SKIPPED: audio exists ({format_duration(dur)}). Use --force to regenerate.")
    return

  # Spoken series/author preamble; the body's own H1 ("0: Kata Pengantar")
  # then announces the chapter, so the title is not repeated here.
  preamble = f"{SERIES_TITLE}.\n\nOleh {AUTHOR}.\n\n"

  text = preprocess_content(preamble + body)

  if not text.strip():
    print("  SKIPPED: no speakable content after preprocessing")
    return

  char_count = len(text)
  print(f"  Content: {char_count} chars ({char_count / 1000:.1f}K)")

  ssml = text_to_ssml(text)
  ssml_chunks = chunk_ssml(ssml)

  if preview:
    print(f"\n--- Preprocessed Text ---")
    print(text[:3000])
    if len(text) > 3000:
      print(f"\n... [{len(text) - 3000} more chars] ...")
    print(f"\n--- SSML Preview (chunk 1/{len(ssml_chunks)}) ---")
    print(ssml_chunks[0][:2000])
    if len(ssml_chunks[0]) > 2000:
      print(f"\n... [{len(ssml_chunks[0]) - 2000} more chars in chunk 1] ...")
    print(f"\nTotal chunks: {len(ssml_chunks)}")
    return

  voice_name = GOOGLE_VOICES[gender]
  print(f"  Voice: {voice_name} ({gender})")
  print(f"  Chunks: {len(ssml_chunks)}")

  generate_google_rest(ssml_chunks, output_path, voice_name)

  if output_path.exists():
    set_web_perms(output_path)
    dur = get_audio_duration(output_path)
    size_mb = output_path.stat().st_size / (1024 * 1024)
    print(f"  Duration: {format_duration(dur)}")
    print(f"  Size: {size_mb:.1f} MB")


def list_essays(output_dir):
  """List essay files with audio status."""
  essays = find_essays()
  print(f"\n{'File':<28} {'Title':<28} {'Chars':>7} {'Audio':>8}")
  print("-" * 76)

  total_chars = 0
  with_audio = 0

  for path in essays:
    raw = path.read_text(encoding='utf-8')
    meta, body = parse_frontmatter(raw)
    part = meta.get('part', path.name[0])
    title = meta.get('title', path.stem)
    chars = len(body)
    total_chars += chars

    audio_path = output_dir / f"{part}-{AUDIO_STEM}.mp3"
    if audio_path.exists():
      status = format_duration(get_audio_duration(audio_path))
      with_audio += 1
    else:
      status = "-"

    print(f"{path.name:<28} {title:<28} {chars:>7} {status:>8}")

  print("-" * 76)
  print(f"Total: {len(essays)} essays, {with_audio} with audio")
  print(f"Total content: {total_chars:,} chars ({total_chars/1000:.0f}K, pre-clean)")
  print(f"Audio dir: {output_dir}")


def main():
  parser = argparse.ArgumentParser(
    description="Generate TTS narration for the Indonesian (Mencari Dharma) essays")
  parser.add_argument("--list", action="store_true", help="List essays and audio status")
  parser.add_argument("--part", type=int, choices=range(0, 10), metavar="N",
                      help="Essay part number to process (0-9)")
  parser.add_argument("--all", action="store_true", help="Process all essays")
  parser.add_argument("--preview", action="store_true",
                      help="Show processed text and SSML, no API call")
  parser.add_argument("--gender", choices=["male", "female"], default="male",
                      help="Voice gender (default: male)")
  parser.add_argument("--force", action="store_true",
                      help="Regenerate even if audio exists")
  parser.add_argument("--output-dir", type=Path, default=AUDIO_DIR,
                      help=f"Output directory (default: {AUDIO_DIR})")
  args = parser.parse_args()

  if not any([args.list, args.part is not None, args.all]):
    parser.print_help()
    sys.exit(0)

  if args.all and args.preview:
    print("--preview cannot be combined with --all (it would dump every essay's "
          "text). Use --preview with --part N.", file=sys.stderr)
    sys.exit(1)

  args.output_dir.mkdir(parents=True, exist_ok=True)

  if args.list:
    list_essays(args.output_dir)
    return

  if args.part is not None:
    matches = [p for p in find_essays() if p.name.startswith(f"{args.part}-")]
    if not matches:
      print(f"No essay file found for part {args.part}", file=sys.stderr)
      sys.exit(1)
    process_essay(matches[0], args.output_dir, preview=args.preview,
                  force=args.force, gender=args.gender)
    return

  if args.all:
    essays = find_essays()
    print(f"Processing {len(essays)} essays...")
    for path in essays:
      process_essay(path, args.output_dir, preview=args.preview,
                    force=args.force, gender=args.gender)
    print(f"\nDone. {len(essays)} essays processed.")


if __name__ == "__main__":
  main()

#fin
