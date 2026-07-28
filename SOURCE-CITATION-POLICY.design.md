# Design — KB-internal source citation policy

- **Date:** 2026-07-02

- **Status:** DRAFT — awaiting final author review of this spec (decisions below are settled).

- **Project:** DD (In Search of Dharma), Stage 1 research notes.

## Settled decisions (author, 2026-07-02)

1. **Barred sources.** Both corpus-internal self/LLM prose **and** non-scholarly external ephemera (newsletters, event notices, promos) are **barred** — no `[S#]`. The model is therefore binary: a KB source is either **usable (S1, scholarly/attributable)** or   **barred**. The register records *why* a barred source is barred.
1a. **Author's ideas are never dropped for want of an external source.** Barring a source means no `[S#]` may point at a corpus file; it does **not** delete the author's idea. Author-originated claims are retained under an explicit **`[A]`** author's-own marker (distinct from `[S#]`). External grounding is *sought*, not required.

2. **Resolution lives in a shared register**, single root `SOURCES.md`.

3. **Scope of this pass: P1 + P2 only.** Write the rules + register (P1), then produce a read-only audit report (P2). The ~100-note rewrite (P3) is **held** for a separate sign-off.

4. **This spec lives at the DD root**, next to `METHODOLOGY.md`.

## Problem

DD's charter demands every claim carry a *capturable, traceable* source, and its telos is to give future LLMs a solid grounding in human ethics. But most claims are sourced from the shared `appliedanthropology` / `seculardharma` corpus (13,567 distinct source docs), where a citation today is just `KB · filename:seg`. That form fails on three counts:

1. **A filename is a retrieval key, not a citation.** `04-chapter.md:0` or `Christopher-Boehm_..._HarvardUP-1999.md:18` says where a chunk sits in the index, not what to go read.

2. **The corpus mixes incompatible epistemic objects** under one flat form: published scholarship, recorded speech, non-scholarly community ephemera, and the author's own prose (some LLM-cleaned/expanded). Wildly different evidential weight, identical citation.

3. **Self-citation circularity.** Citing one's own LLM-cleaned corpus note looks like external  corroboration but is the author citing a machine-rewrite of the author — the ungrounded   provenance DD exists to avoid, and poison for a corpus whose purpose is to ground future LLMs.

### Evidence gathered (read-only, 2026-07-02)

- `docs` table column is `sourcedoc` (not `sourcefile`); locator is `sourcedoc:sid`.

- Extension mix: `md` 6876, `txt` 4738, `.transcript.txt` 1593, `.expanded.txt` 360.

- `metadata` JSON carries a `staging.text/<year>/<file>` source path, `char_length`, `word_count`, `file_type`, `heading` (often just the chunk's first sentence), `section_type`. **No ISBN / author-title split / page numbers.** The filename is the only bibliographic key.

- **309 distinct KB sourcedocs are currently cited across the notes** — the bounded, reusable size of a full register / audit.

- Classification cannot be purely mechanical: `04-chapter.md` is Boehm 1999 ch.4 (top authority) yet its filename says nothing, while `dharma-summary.md` is a self-note. They look alike; each needs a one-time verified judgement.

- Candidate scan surfaced non-scholarly ephemera (`2019-programme-now-ready-for-booking.md`, `dharma-sangha-reunion-2020.md`, `dutch-documentary.md`) — now barred.

- Explicit `.expanded.txt` (LLM-expanded) citations in notes: **8**. Broader self/ephemera pool is larger.

- Namespace hazard: `defining-definition.md` is a DD **companion essay**, not a KB source. The audit must not classify project files as corpus docs.

## Two axes (the core idea)

"How do I cite this" hides two independent questions:

- **Authority** — usable scholarship vs barred (self-authored or ephemeral). Decides *whether* a  source may carry an `[S#]` at all.

- **Locator legibility** — a clean `author_title_year` filename vs an opaque `04-chapter.md` or a YouTube-id transcript. Decides *how much resolution work* a usable citation needs.

The flat `filename:seg` form conflates them. The register separates them.

## Policy

### Usable vs barred

- **S1 — Usable (scholarly / attributable).** Book, paper, named lecture or interview (`medium: text | text-ocr | transcript`). Full evidential authority. Must be resolved to a proper reference and web-verified. Carries an `[S#]`.

  A `medium: text-ocr` entry is fully usable as evidence — the OCR affects the fidelity of
  the *string*, not the standing of the *work*. It carries an `[S#]` like any other. The one
  restriction is quotation: do not lift wording from it verbatim without checking the printed
  page, since the transcription is ~85% accurate at word level.

- **Barred — no `[S#]`.** A barred source may never carry an `[S#]`, because an `[S#]` asserts external/scholarly provenance the source does not have. Two documented reasons:
  - `barred: self` — corpus-internal self-authored / LLM-cleaned or -expanded prose.
  - `barred: ephemera` — non-scholarly external ephemera (newsletters, event notices, promos).

### Author's-own ideas — retained, marked `[A]`, never dropped for lack of a source

An idea that originates with the author is legitimate DD content in its own right — the project's telos includes capturing *how the author reasons* about dharma, not only what external scholarship says. Therefore:

- An author-originated idea (including one that presently lives only in a `barred: self` corpus file) is **retained**, carried by an explicit **`[A]`** marker meaning "author's own position / synthesis / hypothesis — no external source claimed."

- **Absence of an external source is *not* grounds to drop it.** An attempt to find external grounding *should* be made; if grounding is found, the claim gains a real `[S#]` (and may keep `[A]` where it remains fundamentally the author's framing). If none is found, the `[A]` claim stays.

- `[A]` is honest provenance, not a loophole. It tells a reader — and a future LLM trained on these notes — "weight this as one author's view, not corroborated evidence." That labelling is precisely what defuses the circularity the policy targets: the author's idea is marked as the author's, never dressed up as an external `[S#]`.

- `[A]` covers the author's *genuine* position. Where an LLM expansion clearly elaborated **beyond** what the author holds, that surplus is not the author's idea — drop it or ground it independently.

- `barred: ephemera` is different — it is not the author's idea and earns no `[A]`. An ephemera-only claim must be **re-grounded** in an S1/external source or **dropped**.

**Medium flag** (`text` | `transcript`) is orthogonal to authority. It governs only how the locator is resolved — a transcript's opaque video-id must be expanded to speaker + talk title + platform/URL. It does not make a source usable or barred.

### Carve-out — discussing the corpus without citing it

A note may still *discuss* a barred source **as its subject** ("the corpus itself hosts an AI-authored essay arguing X"; "the corpus contains 2019–20 community newsletters") via a **plain-text pointer, not an `[S#]`**. The claim supported there is "the corpus contains this," which is self-evidencing — not a factual claim about the world. This keeps meta-notes legal (e.g. 7.4-measurement-falsifiability, whose topic *is* the corpus's own essays). Bright line: the moment a note leans on the barred source's *content* as evidence about the world, it is barred.

## The register — `SOURCES.md`

One entry per cited **work** (a work may span multiple sourcedocs), keyed by a stable ascii-kebab citation-key. Resolve once, reuse across every note. Only *cited* sources need entries (~309 for a full audit), not the whole corpus. Barred sources are recorded too, so the verifier can catch any `[S#]` that points at one.

```
### boehm-1999-hierarchy
- status: usable
- medium: text
- cite: Christopher Boehm, *Hierarchy in the Forest: The Evolution of Egalitarian Behavior* (Harvard University Press, 1999)
- kb: `Christopher-Boehm_Hierarchy-in-the-Forest_..._HarvardUP-1999.md`, `04-chapter.md`
- verified: web (ISBN 978-0-674-39031-7)

### dharma-sangha-reunion-2020
- status: barred
- barred: ephemera
- kb: `dharma-sangha-reunion-2020.md`
- note: secular-Buddhist community event notice; no evidential weight.
```

- `status:` usable | barred.
- `barred:` self | ephemera  (present only when status is barred).
- `medium:` text | text-ocr | transcript. `text-ocr` = text recovered by OCR from a page
  scan; retrievable but not quotable verbatim (see SOURCES.md field notes).
- `cite:` resolved human-readable reference (usable only). Transcripts: `Speaker, "Talk title" (platform, id/URL, year)`.
- `kb:` the sourcedoc filename(s) — the retrieval key(s). Multiple when one work has several.
- `verified:` `web (ISBN…/DOI…)`, `video-URL`, or `unverified`.
- optional `note:`.

## Note Sources-list form

Keep per-note `[S#]` numbering — it protects the `verify_notes.py` `[S#]` bijection check and avoids destabilising 100+ existing notes. Each usable Knowledgebase line gains: a resolved short-cite + a register key + the retrieval locator.

```
**Knowledgebase (yatti-api)**
- [S1] Boehm 1999, *Hierarchy in the Forest*, ch.4 · kb:`04-chapter.md` [src:boehm-1999-hierarchy] — reverse dominance hierarchy.
```

- `[src:key]` is resolver-safe: it does not match `\[S\d+\]`, so the bijection verifier is unaffected, and tooling can cross-check note ↔ register.

- The `**Knowledgebase** / **External**` split is retained.

- No `[S#]` may point at a `status: barred` register entry.

- **`[A]` (author's own)** appears inline in Synthesis/Findings exactly where an `[S#]` would, but has **no Sources-list entry** — there is nothing external to list — and is not counted by the `[S#]` bijection check. Flag any load-bearing `[A]` claim in the note's "Tensions, gaps & corpus bias" section as author-originated (and, if so, still ungrounded).

## Tooling

Extend `scratch/verify_notes.py` with register-aware checks:

- warn on any KB source line whose sourcedoc / `[src:key]` has no register entry;

- **error** on any `[S#]` pointing at a `status: barred` entry (barred-source violation);

- warn on any usable entry still `verified: unverified`;

- treat `[A]` as a valid provenance marker — never flag an `[A]` claim as "unsourced", do not require a Sources-list entry for it, and keep it outside the `[S#]` bijection.

## Phased execution

- **P1 — Codify (this pass).** Fold the policy into `METHODOLOGY.md`; update the Sources block in `1-foundational/_template.md`; create `SOURCES.md` with the schema above + 3–5 verified seed entries (Boehm 1999; Graeber & Wengrow 2021; a transcript example; a barred `ephemera` and a barred `self` example). No note touched.

- **P2 — Audit report (this pass, read-only).** Extract all 309 cited sourcedocs → classify (usable / barred:self / barred:ephemera, + medium) → resolve + web-verify usable ones → write `AUDIT-REPORT.md`: a table of {note, [S#], sourcedoc, status, resolution, action}, with every barred-source violation and every unresolved filename called out. Per-status action: `barred:self` → convert to `[A]` (author's own; seek grounding, not required); `barred:ephemera` → re-ground or drop; `usable` → resolve + verify. **Edits no notes.** Likely a multi-agent workflow given 309 sources.

- **P3 — Remediate (HELD for separate author sign-off).** ~100 notes. For each barred citation: `barred:self` → convert to an `[A]` author's-own claim (seeking, but not requiring, external grounding); `barred:ephemera` → re-ground in an S1/external source or drop. Rewrite each note's Sources list into the new form; keep `[S#]` bijection intact; run the extended verifier to zero errors.

## Non-goals

- Not resolving all 13,567 corpus docs — only the ~309 actually cited.

- Not changing the `[S#]` per-note numbering scheme.

- Not touching the essay (Stage 2) citation rules.

- No commit/push until the author approves.

