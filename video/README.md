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
  mk-thumbnail.sh    the playlist thumbnail (cover art + centred title, large)
  mk-banner.sh       the channel banner (wide terraces art + channel name)
  align-vtt.py       spoken text + MP3 → sentence-level WebVTT + chapter list
  out/
    playlist-thumbnail.png          1920×1080 playlist cover                        [gitignored]
    channel-banner.png              2560×1440 channel banner                        [gitignored]
    channel-banner-{desktop,mobile,safe}.png   device-crop proofs                   [gitignored]
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

## Playlist thumbnail

`mk-thumbnail.sh` letters the whole book rather than a Part: it scales the cover
watercolour (`../images/defining-dharma-cover.png`, portrait, untyped) to 1920
wide, cuts a 16:9 band out of it, lays a white veil over the art so the navy
holds against the terrace walls, and centres title, hairline rule, italic
tagline and author on the frame. Type is set as the book cover sets it — EB
Garamond and Lato in `#0b295a`, each line *fitted to a target width* rather than
given a point size — and the strings are read out of `../mk-book.sh`, so
retitling the book re-letters the thumbnail.

The book's subtitle is deliberately absent: a playlist card renders about 360px
wide, and only three lines survive at a size worth reading there. The title is
fitted to 1560 of the 1920px, the tagline to 880, the author to 700.

```bash
./mk-thumbnail.sh                    # out/playlist-thumbnail.png
./mk-thumbnail.sh -c 0.50            # crop higher: all mist, no walking figure
./mk-thumbnail.sh -e 0               # no veil (type sits straight on the art)
./mk-thumbnail.sh -i other-art.png   # a 16:9 source is used whole, not cropped
```

The default crop (`-c 0.575`) keeps the figure on the ridge at lower right.
Check any layout change at card size before accepting it:

```bash
convert out/playlist-thumbnail.png -resize 360x /tmp/card.png
```

The PNG is ~1.7 MB, inside YouTube's 2 MB thumbnail limit; re-encode to JPEG if a
different crop pushes it over.

## Channel banner

`mk-banner.sh` writes the 2560×1440 banner for the *a secular dharma?* channel.

A banner is not one image, it is four crops of one image. YouTube shows the full
2560×1440 only on a television; desktop crops to **2560×423**, mobile to
**1546×423**, and the region guaranteed visible on every device is the centre
**1235×338**. So the type has to live inside that centre box while the art still
reads as composed in the wider bands — which is why the banner cannot be a crop
of the portrait book cover, whose whole composition is a diagonal sweep.

The art is therefore a *sibling* of the cover, not the cover: same model, same
watercolour style, same palette, but prompted as a wide band — terraces along
the bottom rising into the visible strip, mist through the middle, empty sky
above. `../images/channel-banner-genart.sh` records the prompt and the choice;
`../images/channel-banner-art.png` is the chosen candidate with its deckle edge
trimmed. Type is set as everywhere else: EB Garamond in `#0b295a`, fitted to a
target width.

The only type on the banner is the channel's own name, `a secular dharma?`, set
exactly as written — lower case, question mark included. It was chosen
"deliberately unsure" (see `../0-preface.md`), and capitalising it into display
caps throws that away. The book's tagline is *not* here: it belongs to the
audiobook, not to the channel. With one line and no second line to separate
from, the hairline rule goes too. So the banner has no dependency on
`mk-book.sh` at all — the name is a constant in the script.

```bash
./mk-banner.sh -p          # banner + the three device-crop proofs
./mk-banner.sh -g          # draw the safe / mobile / desktop regions on it
./mk-banner.sh -y -80      # slide the art down/up in frame
```

Two things are worth knowing before changing the layout:

- **The script refuses to write a banner whose type overflows the safe area.**
  Widen `NAME_WIDTH` past 1235 and it dies with the measured size rather than
  shipping something a phone will crop.
- **`SHIFT` defaults to `-140` for one specific reason.** The art is very nearly
  16:9, so filling the canvas leaves no vertical slack; at `0` the walking
  figure lands exactly on the desktop band's bottom edge and is sliced in half.
  `-140` over-scales just enough to bring the whole figure inside the band.
  Always check `-p` output after touching it — the full 2560×1440 frame is the
  one view almost nobody sees.

Grok's output is 1280×720, so the banner is a ~2.5× Lanczos upscale. That is
acceptable here only because a watercolour has no hard edges to smear; checked
at 1:1 before accepting. `gemini-3-pro-image` would give native 4K but the
Google project is not billing-enabled, so every Gemini model returns a zero
free-tier quota.

Upload: **Customise channel → Branding → Banner image**. YouTube's own cropper
opens on upload; the image is already sized to what it expects, so accept the
default framing.

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

YouTube takes a playlist's cover from one of its videos, so there is nowhere to
upload `out/playlist-thumbnail.png` as playlist art directly. Use it as the
**Part 0 thumbnail** (step 4 above, in place of `0-in-search-of-dharma.png`) and
set Part 0 as the playlist's cover video — *Playlist → Edit → ⋮ on Part 0 → Set
as playlist thumbnail*. It also serves as the channel banner source and as the
card image wherever the playlist is linked off-site.

## Not built (designed for)

Indonesian edition (`N-mencari-dharma.mp3`, `language: id` → `--language id`),
an appendix video, scripted API upload, burned-in captions.
