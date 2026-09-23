# in search of dharma

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21348716.svg)](https://doi.org/10.5281/zenodo.21348716)

*A traceably sourced research project and essay series that recovers **dharma** as the universal human craft of building an ethical world to live inside — secular, cross-cultural, and evidence-based.*

**in search of dharma** takes the word *dharma* away from the yoga studio and shows it as something far larger: what every human group does when it assembles a way of living — values, stories, practices — that *holds the group together*. There is no single *The* Dharma. There are many, and they are **made, plural, and unprivileged**; because they are made rather than found, we can, and now must, build new ones consciously.

## Two-stage method

The project deliberately separates **gathering evidence** from **writing essays**:

- **Stage 1 — Research notes.** For each research question, one cited note whose every claim carries a source. The product is *traceable evidence*, not polished prose.
- **Stage 2 — Essays.** A preface, eight essays and a coda, written *from* the notes. The prose names its sources in the open and hides the citation apparatus; each essay closes with a **Sources & further reading** list that preserves the chain back to the notes and their original works.

The point of the whole project (*traceable evidence behind every claim*) is meant to survive the move from note to essay. The per-note recipe is in [`METHODOLOGY.md`](METHODOLOGY.md).

## The essays

Read in order, the ten parts form one argument: a first-person search from *"what even is a dharma?"* through real dharmas in the wild to *"can we build new ones on purpose?"*

| Part | Title |
|------|-------|
| 0 | [Preface](0-preface.md) |
| 1 | [Defining dharma](1-defining-dharma.md) |
| 2 | [The genesis of dharmas](2-birth-of-dharma.md) |
| 3 | [The dharmas of the Samin of Java](3-samin-of-java.md) |
| 4 | [A world of dharmas](4-world-of-dharmas.md) |
| 5 | [How a dharma gets under your skin](5-under-your-skin.md) |
| 6 | [When dharmas go wrong](6-when-dharma-goes-wrong.md) |
| 7 | [Dharmas in a secular age](7-secular-age.md) |
| 8 | [Creating dharmas](8-creating-dharmas.md) |
| 9 | [Coda](9-coda.md) |

The series blueprint (the arc, the per-part briefs, and the status dashboard) is in [`Essays.md`](Essays.md).

## The book

The ten parts are also assembled into a single book, *in search of dharma* — subtitled *What holds a life, a people, a world together* (tagline: *A natural history of ethics*) — built from [`cover.md`](cover.md) and the part files by [`mk-book.sh`](mk-book.sh):

```bash
./mk-book.sh [epub|pdf|all] [--audio none|link]   # defaults: all, link
```

The script preprocesses each part (frontmatter, image shortcodes), then stitches them into an EPUB3 with pandoc and a PDF via weasyprint, with embedded fonts and optional per-chapter audio narration (`link` adds hyperlinks to the hosted MP3s; `none` omits them). The companion essay [`the-better-ones.md`](the-better-ones.md), which states and stress-tests the project's two-test standard for judging dharmas, closes the book as its appendix. The built books are tracked in the repository (`--audio embed` also produces a self-contained EPUB with the MP3s bundled in, about 75 MB, which is built locally and not tracked):

- [`In-Search-of-Dharma_Biksu-Okusi_2026.epub`](In-Search-of-Dharma_Biksu-Okusi_2026.epub) — EPUB3, with links to the hosted chapter narrations (~3.6 MB)
- [`In-Search-of-Dharma_Biksu-Okusi_2026.pdf`](In-Search-of-Dharma_Biksu-Okusi_2026.pdf) — A4 reading PDF (~2.4 MB)

An Indonesian edition, *Mencari Dharma*, is built the same way in [`id/`](id/): [`Mencari-Dharma_Biksu-Okusi_2026.epub`](id/Mencari-Dharma_Biksu-Okusi_2026.epub) and [`Mencari-Dharma_Biksu-Okusi_2026.pdf`](id/Mencari-Dharma_Biksu-Okusi_2026.pdf). Milestone versions of the books are also published via [GitHub Releases](https://github.com/Biksu-Okusi/In-Search-of-Dharma/releases).

Building needs no configuration. Copying the finished files to a web-root, and mirroring them to another host, is optional and off by default: [`deploy.conf.example`](deploy.conf.example) lists the settings that enable it.

### The printed edition

[`mk-print.sh`](mk-print.sh) builds the interior of the paperback, separately from the reading formats above:

```bash
./mk-print.sh                      # build the interior
./mk-print.sh --preflight FILE     # check an existing PDF and stop
```

The interior only: a print cover is a separate artefact, and the printer requires it uploaded as a separate file. The page is 152 × 229 mm with a 107 mm measure, a 25 mm gutter and a 20 mm outer margin mirrored across the spread, set in Bona Nova at 10 pt on 16 pt leading with Work Sans SemiBold for chapter titles, subheads, running heads and folios, and the book's title on the half-title and title page in Literata Medium Italic, the face chosen for the cover. Chapters open recto with a two-line drop cap and the first two words in small capitals; front matter takes roman folios and the arabic sequence restarts at the Preface. The contents page numbers come from the renderer, so they cannot drift from the pages they point at. Geometry lives in [`lib/print-style.sh`](lib/print-style.sh), and [`lib/dropcap.py`](lib/dropcap.py) marks each chapter's opening paragraph.

The finished file is then hardened to the printer's interior rules and checked against them by [`lib/pdfcheck.py`](lib/pdfcheck.py): even page count, blank final page, DeviceGray throughout, every font embedded, no crop or registration marks, no ICC profiles, greyscale images at 300 ppi or better, no ink closer to the trim than the printer allows, and no word lying more than 0.05 mm outside the measure. **The build refuses to write a file that fails any of these.** The same tool runs standalone via `--preflight`.

[`lib/glyphcheck.py`](lib/glyphcheck.py) fails the build when a source character is absent from the bound typefaces, naming the character and the first file and line that uses it. Bona Nova and Work Sans both lack the rarer IAST diacritics; no current source uses them, and this gate is what keeps it that way.

Run the test suite with [`tests/run_tests.sh`](tests/run_tests.sh). It covers the conformance rules, the preprocessing parity between the two builders, the print page geometry against its measured targets, and the glyph gate.

### Tools

[`tools/`](tools/) holds two small scripts for producing the printed edition. [`tools/mk-barcode.py`](tools/mk-barcode.py) draws the cover barcode for an ISBN, the EAN-13 symbol with its five-digit price add-on, as a vector SVG in pure black with the quiet zones built in; it refuses a number whose check digit is wrong, and with `--price-label` prints the add-on's US price above it. [`tools/presend-check.sh`](tools/presend-check.sh) is the book's check on an attachment about to go to the publisher: a print interior must be newer than every source it is built from and pass `mk-print.sh --preflight`. The correspondence itself runs on tooling outside this repository, which calls that check before anything is sent.

## Research notes

The evidence base is organised into eight categories, each a directory of cited notes:

1. [Foundational](1-foundational/) — etymology, universal patterns, boundaries, cognates
2. [Historical](2-historical/) — the Axial Age, urban complexity, pre-literate ethics, transmission, the lifecycle of a dharma
3. [Philosophical](3-philosophical/) — autonomy vs collective, grounding, relativism
4. [Cultural](4-cultural/) — the Samin, Ubuntu, indigenous oral dharmas, Abrahamic frameworks, Subud and Sumarah, the Badui
5. [Psychological](5-psychological/) — neuroscience, evolution, moral development, ritual, psychopathy, neurodivergence
6. [Contemporary](6-contemporary/) — secular translation, the digital age, economics, gender
7. [Critical](7-critical/) — failure modes, appropriation, power, falsifiability
8. [Future](8-future/) — planetary dharma, AI, post-traditional dharmas, encoding ethics

The master question registry, with its status dashboard, is [`Questions.md`](Questions.md); the shared note structure is fixed by [`1-foundational/_template.md`](1-foundational/_template.md). Every work cited across the notes is resolved once in the citation register, [`SOURCES.md`](SOURCES.md).

The **Preface (Part 0)** has its own set of research notes ([`0-preface/`](0-preface/)), held to the same template and citation discipline. Because they rest substantially on primary self-report and private correspondence, they are published as **redacted public editions**: passages resting on private family records or third-party correspondence remain in the author's private records, and every redaction is disclosed in place. Passages drawing on a colleague's private correspondence are published with his consent; the mail archive and seed correspondence are permanently private.

◉ **Status.** Both stages are complete: all 52 research questions have their cited notes, and all ten parts are written. The series is in final pre-publication polish, so wording may still shift; the evidence base is stable.

## Dataset

The full corpus (the 52 cited research notes, the ten essays and the two companion essays) is published as a Hugging Face dataset: **<https://huggingface.co/datasets/garydean/defining-dharma>** (configs `notes`, `essays` and `companions`), generated from this repository by [`mk-hf-dataset.py`](mk-hf-dataset.py). Reuse for AI training, retrieval, and research is welcome under the same CC BY 4.0 licence. Each milestone release is also archived on Zenodo with a citable DOI: [10.5281/zenodo.21348716](https://doi.org/10.5281/zenodo.21348716) (all versions; resolves to the latest release).

## Contributing

Corrections — factual errors, broken citations, cross-essay inconsistencies — are the most valuable contribution. See [`CONTRIBUTING.md`](CONTRIBUTING.md) for what fits this (curated, authored) project and how to submit.

## Author

Written by **Gary Dean** (Biksu Okusi) — <https://garydean.id>.

## Licence

This work is licensed under the [Creative Commons Attribution 4.0 International Licence (CC BY 4.0)](LICENSE). You are free to share and adapt the material for any purpose, even commercially, provided you give appropriate credit.
