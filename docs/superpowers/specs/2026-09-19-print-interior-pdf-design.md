# Print-interior PDF: design

**Date:** 2026-09-19
**Status:** design, awaiting review
**Scope:** a print-ready interior PDF of *In Search of Dharma* for Tuwhiri's
printer, generated from the existing Markdown sources by script.

---

## 1. Purpose

Tuwhiri will print the book through IngramSpark. The printer needs an
**interior** PDF at the publisher's trim size, conforming to IngramSpark's file
rules, typeset to the house style of Tuwhiri's own *The secular path to
well-being*.

The book is not laid out by hand. It renders programmatically from the
Markdown sources through the same pipeline that produces the EPUB and the
reading PDF. The print interior becomes a third output target, so that a fault
spotted on a proof is fixed once in the pipeline and is correct in every
subsequent build.

The cover is **out of scope**. A print cover is a separate artefact and a
separate design job, and IngramSpark requires it uploaded as a separate file.

---

## 2. Authorities

The specification below is reconciled from four sources, listed in order of
precedence where they disagree.

| # | Source | What it settles |
|---|--------|-----------------|
| 1 | Ramsey Margolis, email of 2026-09-18, "In search of dharma - typographic specs" | Typefaces, structural rules, text conventions, trim size, page-count parity |
| 2 | `print/What is dharma typographic specs.pdf` | Marked-up recto and verso scans giving margins and the chapter-opener layout |
| 3 | `print/TASTER The secular path to well-being.pdf` | The model book, measured directly for baselines, leading and colour |
| 4 | `print/IngramSpark PDF checklist.pdf` | The printer's file rules |

`print/Gary Dean - In search of dharma typography.{pdf,docx,rtf}` is Ramsey's
A4 mock-up of an out-of-date manuscript. It is evidence of intent, not of
measurement: its 13pt-on-22pt setting belongs to an A4 measure and does not
transfer to a 152mm page.

▲ **The model book's PDF is a proof export, not an upload file.** Its pages are
168.6 × 245.6mm carrying a 152 × 229mm TrimBox inside an 8.29mm slug, and its
crop marks are stroked in `Separation(DeviceGray, All)` registration ink.
IngramSpark forbids crop, registration and printer marks. Copy its typography;
do not copy its box structure.

---

## 3. Page specification

All figures are measured from the model book and cross-checked against the
marked-up scans. The MediaBox equals the trim; there is no bleed and no slug,
because no element runs to the trim edge.

| Item | Value |
|------|-------|
| Trim | 152 × 229 mm (430.866 × 649.134 pt) |
| Bleed | none |
| Measure | 107 mm |
| Inner margin (gutter) | 25 mm |
| Outer margin | 20 mm |
| First body baseline | 29.53 mm below trim top |
| Last body baseline | 24.5 mm above trim bottom |
| Lines per page | 32 |
| Running-head baseline | 16.80 mm below trim top |
| Folio baseline | 14.62 mm above trim bottom |
| Paragraph indent | 10 mm |
| Chapter-title baseline | 87.59 mm below trim top |
| First baseline on a chapter opener | 131.13 mm below trim top |
| Epigraph attribution indent | 20 mm from the measure's left |

Margins mirror across the spread: the 25 mm gutter is on the right of a verso
and the left of a recto.

### Derived layout constants

These are the values that place the above on the page in WeasyPrint. They were
solved numerically against the model book's baselines and are frozen; they are
not to be re-derived by eye.

| Constant | Value | Places |
|----------|-------|--------|
| `top` (page margin-top) | 24.58 mm | first body baseline |
| `headpad` (running-head box padding-top) | 13.35 mm | running-head baseline |
| `foliopad` (folio box padding-top) | 6.80 mm | folio baseline |
| `h1pad` (chapter-title padding-top) | 55.34 mm | chapter-title baseline |
| `h1gap` (chapter-title padding-bottom) | 39.21 mm | opener's first baseline |
| drop-cap font-size | 3.200 em | two-line cap |
| drop-cap line-height | 0.688 | cap baseline on line 2 |

◉ These constants are specific to 10pt on 16pt leading in Bona Nova. Changing
the body setting requires re-solving them. The build script keeps the solver so
this is a command, not a craft exercise.

---

## 4. Type specification

Decision taken: **10pt on 16pt leading**, the setting of Tuwhiri's own model
book. Ramsey suggested 11 on 20; measured against the real text that runs about
70 pages longer, and Ramsey's own house book is the stronger authority on what a
Tuwhiri page looks like.

| Element | Face | Size | Leading |
|---------|------|------|---------|
| Body | Bona Nova Regular | 10 pt | 16 pt |
| Body italic | Bona Nova Italic | 10 pt | 16 pt |
| Small caps | Bona Nova, `smcp` | 10 pt | 16 pt |
| Subheads | Work Sans SemiBold | 12 pt | 16 pt |
| Chapter titles | Work Sans SemiBold | 20 pt | — |
| Running heads | Work Sans SemiBold | 9 pt | — |
| Folios | Work Sans SemiBold | 8 pt | — |
| Sources and further reading | Bona Nova Regular | 9 pt | 16 pt |

Measured extents for the whole body text, should the setting be revisited:

| Setting | Body pages |
|---------|-----------:|
| 10 on 16 | 209 |
| 10.5 on 17 | 231 |
| 11 on 18 | 249 |
| 11 on 20 | 279 |

### Typographic rules

- Justified, with automatic hyphenation (`hyphens: auto`, `lang="en"`).
- **Lining figures** (`font-variant-numeric: lining-nums`). Bona Nova defaults
  to oldstyle, which sets "Part 1" as something a reader takes for "Part I".
- Ligatures and kerning on; discretionary ligatures off in body text.
- Widows and orphans: 2 minimum.
- Real small caps from the font's `smcp` feature, never synthesised.

✓ No new font file is needed. The vendored `fonts/bonanova/BonaNova-Regular.ttf`
already carries `smcp` and `c2sc`, and WeasyPrint engages the genuine glyphs.

▲ Bona Nova and Work Sans both lack ṝ, ḹ and ṁ and their capitals. No current
source file uses them. The build gains a glyph gate (§7) so a future edit that
introduces one fails the build rather than printing a blank.

---

## 5. Structure

### Front matter

Roman folios, no running heads, restarting the arabic sequence at 1 on the
first page of the Preface.

1. Half-title
2. Title page
3. Imprint (copy supplied by Ramsey; see §9)
4. Contents, with real page numbers and leader dots

### Body

- Chapters open **recto**. A blank verso is inserted where needed, carrying
  neither running head nor folio.
- A chapter opener carries the Okusi logo, the vertical rule, and the chapter
  title, and suppresses its running head. It keeps its folio.
- Verso running head: the book title. Recto running head: the chapter title.
- First paragraph after a chapter title, a subhead or a block quote is
  unindented. Every subsequent paragraph indents 10 mm.
- A chapter's opening paragraph begins with a two-line drop cap, with the first
  two words after it in small caps.
- `Sources & further reading` sets at 9pt on the same 16pt leading.
- `the-better-ones.md` closes the book as the appendix, as it already does in
  the EPUB and reading PDF.

### Back matter

The final page is blank, and the total page count is even.

---

## 6. Architecture

**A separate `mk-print.sh`, with the shared front half extracted into `lib/`.**

`mk-book.sh` is already a thousand lines carrying two targets. The print
interior shares only source preprocessing, the chapter list and font binding.
Everything after that diverges: different front matter, an imprint page, a
contents list with page numbers, mirrored margins, recto-forcing, drop caps,
blank-page padding, greyscale conversion and a preflight gate. It has no cover
plate, no back cover and no audio links. Folding all of that into `mk-book.sh`
would push one script past 1,500 lines and three unrelated output targets.

```
lib/fonts.sh        (exists)   typeface sets, @font-face generation
lib/preprocess.sh   (new)      extracted from mk-book.sh: frontmatter
                               stripping, the <image ...> shortcode, image
                               staging, the chapter file list and order
lib/print-geom.sh   (new)      the frozen layout constants of §3, and the
                               solver that re-derives them for a new setting
mk-book.sh          (edit)     sources lib/preprocess.sh; behaviour unchanged
mk-print.sh         (new)      the print-interior target
```

The extraction must leave `mk-book.sh` byte-identical in output. That is a
verification requirement, not an aspiration: see §10.

### Invocation

```bash
./mk-print.sh                      # build the interior at the shipping setting
./mk-print.sh --size 10.5 --lead 17   # a proof at another setting
./mk-print.sh --solve              # re-derive the layout constants, print them
./mk-print.sh --preflight FILE     # run the gate over an existing PDF
```

Output is `In-Search-of-Dharma_interior_152x229.pdf`, gitignored alongside the
other built artefacts.

---

## 7. Build pipeline

| Stage | Action |
|-------|--------|
| 1 | Preprocess sources via `lib/preprocess.sh` (shared with `mk-book.sh`) |
| 2 | Convert the watercolours to greyscale with a tone curve (§8) |
| 3 | Generate front matter: half-title, title, imprint, contents |
| 4 | `pandoc` to one HTML5 document, one `<section>` per chapter |
| 5 | Generate the print stylesheet from `lib/fonts.sh` + `lib/print-geom.sh` |
| 6 | `weasyprint` to a 152 × 229 mm PDF |
| 7 | Pad to an even page count with a blank final page |
| 8 | `gs` to DeviceGray, stripping ICC profiles |
| 9 | Preflight gate; the build fails if any rule below is broken |

### Preflight rules

Every rule is checked against the finished PDF, not against intent.

| Rule | Threshold | On failure |
|------|-----------|------------|
| MediaBox equals trim on every page | 152 × 229 mm ± 0.1 | fail |
| No TrimBox, BleedBox or ArtBox differing from MediaBox | — | fail |
| Page count even | — | fail |
| Final page blank | — | fail |
| All fonts embedded and subset | — | fail |
| Colour operators DeviceGray only | — | fail |
| No `Separation` or registration colour | — | fail |
| Raster images greyscale, no ICC profile | — | fail |
| Raster image resolution | ≥ 300 ppi | fail |
| Closest ink to trim | ≥ 13 mm | warn |
| Closest ink to trim | ≥ 12 mm | fail |
| Every source glyph present in its bound face | — | fail |

◉ The two-tier ink-to-trim rule is evidence-based. IngramSpark states 13 mm as
the minimum, but Tuwhiri's own printed book puts its running head at 12.20 mm
from the trim top and prints acceptably. The design as specified sits at
13.08 mm, inside IngramSpark's stated rule and looser than the model book.

▲ A rejected upload costs 25 US dollars and several days. Every rule on
IngramSpark's checklist is machine-checkable from the finished file, so the
build refuses to emit a non-conforming PDF rather than relying on memory.

---

## 8. Images

Decision taken: **keep the chapter watercolours, converted to greyscale.**

A black-and-white IngramSpark interior requires greyscale images carrying no
ICC profile and no spot colour. The watercolours are 1024 × 1024 sRGB, which at
40% of the 107 mm measure is about 600 ppi, comfortably above the 300 ppi floor.

Plain desaturation flattens them. The build applies a gentle tone curve so the
midtones survive press dot-gain:

```
-colorspace Gray -level 5%,95% -sigmoidal-contrast 3,50%
```

The greyscale conversion happens at stage 2, on the staged copies only. The
source `.webp` files are untouched, and the EPUB and reading PDF keep their
colour.

### Placement

A chapter opener has roughly 71 mm of white above the title, and the Tuwhiri
device (a thin vertical rule carrying a small roundel) occupies it. Ramsey's
markup replaces that roundel with the Okusi logo. The watercolour is a
different kind of mark, and the two compete for the same zone.

Default, to be settled on the first proof: **the watercolour sits in the
opener's upper zone at 40% of the measure, centred, with the Okusi logo and
rule retained above it at small size.** The title baseline stays at 87.59 mm
regardless, so the watercolour's height is capped, not the other way round.

▲ This is the one item in this design that cannot be settled by measurement.
It needs Ramsey's eye on a printed proof, and it is the first question to put
to him when proof 1 goes out.

---

## 9. Dependencies on Tuwhiri

These block a *final* file, not a first proof. The build uses clearly-marked
placeholders until each arrives.

1. **Imprint page copy.** Ramsey supplies it. Must carry the print ISBN,
   Tuwhiri's details, printing history, and the CC BY 4.0 statement.
2. **Print ISBN.** Not yet issued.
3. **Spine width.** Determined by Sue. Cover only, so it does not block the
   interior.
4. **The Okusi logo** for chapter openers, replacing the Tuwhiri roundel, as a
   vector or a 300 ppi-equivalent raster.
5. **Ramsey's decision on the chapter-opener watercolour** (§8, Placement), to
   be put to him with proof 1.

---

## 10. Text changes

Decision taken: **the quote-style change goes into the Markdown sources**, so
every format follows.

Ramsey has moved the manuscript to single quotes throughout, with doubles
nested inside, and sentence-final punctuation inside the closing quote. Applying
this to the source rather than to the print target alone keeps the EPUB, the
reading PDF and the print interior in agreement.

This is an editorial pass with its own risks and belongs in its own change, not
inside the print build. It is recorded here because the print interior is what
surfaced it.

Ramsey also broke up a small number of very long paragraphs in his copy. Those
edits live only in his Pages document and must be identified and carried back
into the Markdown, or they will be lost.

---

## 11. Verification

- `mk-book.sh` output is byte-identical before and after the `lib/preprocess.sh`
  extraction, verified by building the EPUB and reading PDF on both sides of the
  change and comparing checksums of the rendered content.
- The print build's baselines are asserted against the model book's measured
  grid: title 87.59, opener 131.13, running head 16.80, first body 29.53,
  folio 214.38, all in mm from the trim top, to within 0.1 mm.
- The preflight gate runs over `print/TASTER The secular path to well-being.pdf`
  as a negative control and must reject it, since it carries crop marks.
- `shellcheck` and the `bcscheck` skill pass on every modified `.sh` file.

---

## 12. Out of scope

- The print cover, including spine and barcode.
- The Indonesian edition's print interior. The same machinery will serve it,
  but `id/` is a separate build and a later change.
- Any change to the EPUB or the reading PDF, apart from the lining-figures fix
  and the shared `lib/preprocess.sh` extraction.
