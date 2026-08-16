# In Search of Dharma

[![DOI](https://zenodo.org/badge/DOI/10.5281/zenodo.21348716.svg)](https://doi.org/10.5281/zenodo.21348716)

*A traceably-sourced research project and essay series that recovers **dharma** as the universal human craft of building an ethical world to live inside — secular, cross-cultural, and evidence-based.*

**In Search of Dharma** takes the word *dharma* away from the yoga studio and shows it as something far larger: what every human group does when it assembles a way of living — values, stories, practices — that *holds the group together*. There is no single *The* Dharma. There are many, and they are **made, plural, and unprivileged**; because they are made rather than found, we can, and now must, build new ones consciously.

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
| 1 | [Defining Dharma](1-defining-dharma.md) |
| 2 | [The Genesis of Dharmas](2-birth-of-dharma.md) |
| 3 | [The Dharmas of the Samin of Java](3-samin-of-java.md) |
| 4 | [A World of Dharmas](4-world-of-dharmas.md) |
| 5 | [How a Dharma Gets Under Your Skin](5-under-your-skin.md) |
| 6 | [When Dharmas Go Wrong](6-when-dharma-goes-wrong.md) |
| 7 | [Dharmas in a Secular Age](7-secular-age.md) |
| 8 | [Creating Dharmas](8-creating-dharmas.md) |
| 9 | [Coda](9-coda.md) |

The series blueprint (the arc, the per-part briefs, and the status dashboard) is in [`Essays.md`](Essays.md).

## The book

The ten parts are also assembled into a single book, *In Search of Dharma* — subtitled *The human craft of building ethical worlds: a natural history of ethics in eight essays* — built from [`cover.md`](cover.md) and the part files by [`mk-book.sh`](mk-book.sh):

```bash
./mk-book.sh [epub|pdf|all] [--audio none|link|embed]   # defaults: all, link
```

The script preprocesses each part (frontmatter, image shortcodes), then stitches them into an EPUB3 with pandoc and a PDF via weasyprint, with embedded fonts and optional per-chapter audio narration (`link` adds hyperlinks to the hosted MP3s; `embed` bundles them into the EPUB). The built books are tracked in the repository:

- [`In-Search-of-Dharma_Biksu-Okusi_2026.epub`](In-Search-of-Dharma_Biksu-Okusi_2026.epub) — EPUB3, with links to the hosted chapter narrations (~3.5 MB)
- [`In-Search-of-Dharma_Biksu-Okusi_2026_with-audio.epub`](In-Search-of-Dharma_Biksu-Okusi_2026_with-audio.epub) — EPUB3 with the narration MP3s embedded (~69 MB)
- [`In-Search-of-Dharma_Biksu-Okusi_2026.pdf`](In-Search-of-Dharma_Biksu-Okusi_2026.pdf) — print-styled PDF (~2.3 MB)

An Indonesian edition, *Mencari Dharma*, is built the same way in [`id/`](id/): [`Mencari-Dharma_Biksu-Okusi_2026.epub`](id/Mencari-Dharma_Biksu-Okusi_2026.epub) and [`Mencari-Dharma_Biksu-Okusi_2026.pdf`](id/Mencari-Dharma_Biksu-Okusi_2026.pdf). Milestone versions of the books are also published via [GitHub Releases](https://github.com/Biksu-Okusi/In-Search-of-Dharma/releases).

Building needs no configuration. Copying the finished files to a web-root, and mirroring them to another host, is optional and off by default: [`deploy.conf.example`](deploy.conf.example) lists the settings that enable it.

## Research notes

The evidence base is organised into eight categories, each a directory of cited notes:

1. [Foundational](1-foundational/) — etymology, universal patterns, boundaries, cognates
2. [Historical](2-historical/) — the Axial Age, urban complexity, pre-literate ethics, transmission, the lifecycle of a dharma
3. [Philosophical](3-philosophical/) — autonomy vs. collective, grounding, relativism
4. [Cultural](4-cultural/) — the Samin, Ubuntu, indigenous oral dharmas, Abrahamic frameworks, Subud and Sumarah, the Badui
5. [Psychological](5-psychological/) — neuroscience, evolution, moral development, ritual, psychopathy, neurodivergence
6. [Contemporary](6-contemporary/) — secular translation, the digital age, economics, gender
7. [Critical](7-critical/) — failure modes, appropriation, power, falsifiability
8. [Future](8-future/) — planetary dharma, AI, post-traditional dharmas, encoding ethics

The master question registry and status dashboard is [`Questions.md`](Questions.md); the shared note structure is fixed by [`1-foundational/_template.md`](1-foundational/_template.md). Every work cited across the notes is resolved once in the citation register, [`SOURCES.md`](SOURCES.md).

The **Preface (Part 0)** has its own set of research notes ([`0-preface/`](0-preface/)), held to the same template and citation discipline. Because they rest substantially on primary self-report and private correspondence, they are published as **redacted public editions**: passages resting on private family records or third-party correspondence remain in the author's private records, and every redaction is disclosed in place. One note (0.4) is held back pending correspondent review; the mail archive and seed correspondence are permanently private.

◉ **Status.** Both stages are complete: all 52 research questions have their cited notes, and all ten parts are written. The series is in final pre-publication polish, so wording may still shift; the evidence base is stable.

## Dataset

The full corpus (the 52 cited research notes, the ten essays and the two companion essays) is published as a Hugging Face dataset: **<https://huggingface.co/datasets/garydean/defining-dharma>** (configs `notes`, `essays` and `companions`), generated from this repository by [`mk-hf-dataset.py`](mk-hf-dataset.py). Reuse for AI training, retrieval, and research is welcome under the same CC BY 4.0 licence. Each milestone release is also archived on Zenodo with a citable DOI: [10.5281/zenodo.21348716](https://doi.org/10.5281/zenodo.21348716) (all versions; resolves to the latest release).

## Contributing

Corrections — factual errors, broken citations, cross-essay inconsistencies — are the most valuable contribution. See [`CONTRIBUTING.md`](CONTRIBUTING.md) for what fits this (curated, authored) project and how to submit.

## Author

Written by **Gary Dean** (Biksu Okusi) — <https://garydean.id>.

## Licence

This work is licensed under the [Creative Commons Attribution 4.0 International Licence (CC BY 4.0)](LICENSE). You are free to share and adapt the material for any purpose, even commercially, provided you give appropriate credit.
