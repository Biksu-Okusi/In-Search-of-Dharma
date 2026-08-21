# In Search of Dharma — video-audiobook

One YouTube video per Part of *In Search of Dharma* (Parts 0–9; the appendix has
no narration by design). Each video is a still title frame over the intro sting
(`../audio-assets/dharmic-ai.mp3`, 10 s), two seconds of silence, then the
published narration; plus a forced-aligned WebVTT caption file so viewers can
read along, and a paste-ready description with chapter timestamps.

Nothing here re-synthesises audio: the MP3s are the narrations already published
at `https://garydean.id/audio/N-in-search-of-dharma.mp3`.

## Layout

```
video/
  mk-video.sh        orchestrator: frame → vtt → video → desc, per Part
  align-vtt.py       spoken text + MP3 → sentence-level WebVTT + chapter list
  out/
    N-in-search-of-dharma.png       1920×1080 title frame (doubles as thumbnail)   [gitignored]
    N-in-search-of-dharma.mov       the video                                       [gitignored]
    N-in-search-of-dharma.vtt       captions
    N-in-search-of-dharma.chapters  "M:SS Heading" list
    N-in-search-of-dharma.txt       title + description, paste-ready
```

## How it works

1. **Frame** — ImageMagick composes the Part's `<image>` (PNG master in
   `../images/`) at 900×900 on a dark ground with the title, Part line, author
   and the channel handle in EB Garamond. Title text comes from the Part's
   frontmatter `audio.title` / `audio.subtitle`.
2. **Captions** — `gentts --dump-text` writes exactly the text that was
   synthesised (preamble included, footnotes/tables/Sources excluded), so the
   cues carry the book's words and only the *timings* come from a model.
   `align-vtt.py` splits that text into cues (sentences; long ones broken at
   clause punctuation; ≤2 lines of ≤42 chars), force-aligns each cue with
   `stable-ts` + `faster-whisper large-v3`, then applies two corrections:
   any run of cues with an implausible speech rate (the aligner occasionally
   fails a short sentence or drops it into a pause) is re-timed from an ASR
   pass over that window, matched word-by-word and monotonic by construction;
   and cue edges that land inside a pause (`ffmpeg silencedetect`) are snapped
   to where speech actually starts or stops. Self-checks fail loudly on
   non-monotonic or out-of-range cues. `--spot-check N` transcribes N random
   cue windows and fuzzy-matches them against the text, reporting the worst
   match ratio and the largest start drift.

   A cue reported as *"still rate-anomalous after repair (text missing or
   garbled in the audio?)"* means the narration does not contain those words:
   the pipeline squashes such cues to 0.3 s and the MP3 should be re-synthesised
   (as of 2026-08-21 Part 7 has one such gap at 21:39, about two sentences).
3. **Mux** — ffmpeg concatenates sting + 2 s silence + narration (stereo AAC
   256 kbps: ffmpeg's native encoder smears the sting's sharp onset at 128 kbps,
   ~21 dB SNR there vs ~44 dB at 256) and loops the frame over it (libx264 `-tune stillimage`,
   `+faststart`). The container is **MOV, not MP4**: with bit-identical streams,
   MP4 made some desktop players glitch the sting about a second in while MOV
   played clean (A/B-tested 2026-08-21); YouTube accepts MOV. Captions and chapters are written with the matching offset
   (`align-vtt.py --offset`), so alignment itself always runs on the bare MP3.
4. **Description** — title, the Part's standfirst, a series line, links (book
   page, MP3, repository, DOI), the chapter list, narration credit and licence.

Outputs are rebuilt only when the MP3, sting, image or Part markdown is newer
(`-f` forces).

## Setup

```bash
uv venv .venv && uv pip install -p .venv/bin/python stable-ts faster-whisper
```

Needs `ffmpeg`, ImageMagick (`convert`), `gentts` (with `--dump-text`), the EB
Garamond fonts, and a CUDA GPU (large-v3 in `int8_float16` fits in ~2 GB; use
`--compute-type`/`-m medium` otherwise). First run downloads the model (~3 GB).

## Build

```bash
./mk-video.sh            # all Parts, all steps
./mk-video.sh 7 9        # selected Parts
./mk-video.sh -s frame   # one step only (frame, vtt, video, desc)
./mk-video.sh -f 3       # force a rebuild
```

## Upload checklist (YouTube Studio, manual)

For each Part, in order 0 → 9:

1. **Create → Upload videos** → `out/N-in-search-of-dharma.mov`.
2. **Title**: first line of `out/N-in-search-of-dharma.txt`
   (e.g. `In Search of Dharma — 7: Dharmas in a Secular Age`).
3. **Description**: paste the rest of the `.txt`. The `Chapters` block gives
   YouTube chapters automatically (first entry is `0:00`).
4. **Thumbnail**: upload `out/N-in-search-of-dharma.png`.
5. **Playlist**: *In Search of Dharma* (create it on Part 0).
6. **Audience**: not made for kids. **Licence** (Show more): *Creative Commons –
   Attribution*. Leave altered-content / paid-promotion unticked.
7. **Subtitles** (left menu after upload, or Video elements → Add subtitles):
   language English (Australia) → **Upload file → With timing** →
   `out/N-in-search-of-dharma.vtt`.
8. **Visibility**: Public (or Unlisted first, then flip the whole playlist).

After all ten: sort the playlist 0 → 9, set its description from
`../ABSTRACT-SHORT_In-Search-of-Dharma.md`, and add the playlist URL to the book
page at garydean.id.

## Not built (designed for)

Indonesian edition (`N-mencari-dharma.mp3`, `language: id` → `--language id`),
an appendix video, scripted API upload, burned-in captions.
