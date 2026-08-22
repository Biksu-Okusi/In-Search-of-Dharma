# METHODOLOGY — How to research one DD question

This is the repeatable recipe applied to **every** question in [Questions.md](Questions.md).

The output of each pass is exactly one research note, copied from [`1-foundational/_template.md`](1-foundational/_template.md) into its category directory as `<id>-<slug>.md`.

The goal of this phase (Stage 1) is **traceable evidence**, not polished prose. Essays (Stage 2) come later and are written *from* these notes — so a note that asserts something without a capturable source has failed its job.

For a different kind of pass — characterising **how the author uses a term** (an idiolect *usage-gloss*: Stage-2 support, not a per-question note) — see the companion [METHODOLOGY-usage-gloss.md](METHODOLOGY-usage-gloss.md).

---

## The shared-corpus fact (read once, remember always)

`seculardharma` and `appliedanthropology` are the **same underlying corpus**. In this dev tree `seculardharma.faiss` is a symlink to `appliedanthropology.faiss` — *identical vectors*. The only meaningful difference is the **persona** (`query_role` / system prompt): `seculardharma` answers as a Secular Dharma Research Assistant, `appliedanthropology` as DrAA, the applied-anthropology expert.

Consequences for research:

- For **raw context retrieval** (`-c`, context-only), query the shared corpus **once**. Do not run the same context-only query against both KBs — you get the same chunks back.

- Query **both personas** only when you want a *synthesised* answer and the two lenses (secular-dharma vs. applied-anthropology) would frame it differently.

- `prosocial` (a.k.a. `prosocial.world`) is a **separate** corpus — query it independently for cooperation / prosociality / group-selection material.

---

## The six steps

### 1. Survey (context-only) — map the terrain

Broad, context-only query against the shared corpus to see what evidence exists before committing to an angle.

```bash
yatti-api query -K seculardharma -q "<broad framing of the question>" -c --top-k 20
# prosocial is a DIFFERENT corpus — survey it too when relevant:
yatti-api query -K prosocial -q "<broad framing>" -c --top-k 20
```

Read the returned chunks. Note which sub-claims the corpus can support and where it looks thin or one-sided. (`-c` returns context only, no LLM answer — fast, cheap, and gives you raw source material with metadata to cite.)

### 2. Targeted RAG — get cited answers to sub-questions

Focused queries with the `scholarly` persona for each sub-question. Capture the source metadata (doc/segment id or title) for the Sources list.

```bash
yatti-api query -K seculardharma -q "<sharp sub-question>" -p scholarly -M 2000
# When a synthesised cross-lens view helps, also pull the applied-anthropology persona:
yatti-api query -K appliedanthropology -q "<same sub-question>" -p scholarly -M 2000
```

### 3. External research — balance the corpus

The corpus has a **known secular / evolutionary / Western-academic lean** (curated around Boehm, Sapolsky, Graeber, Batchelor, Bregman). Do a web pass wherever the corpus is thin or slanted — in particular:

- Sanskrit / Proto-Indo-European philology and primary etymological scholarship,

- primary historical / scriptural texts,

- indigenous and oral traditions (under-documented in text corpora),

- non-secular perspectives the corpus under-weights (e.g. Abrahamic, theological).

Use, in increasing order of weight:

- `WebSearch` for a quick fact or source check,

- the **firecrawl** skills (`firecrawl-search`, `firecrawl-scrape`) to pull full source pages for citation,

- the **deep-research** skill for a wide, adversarially-verified multi-source pass when a question genuinely needs it.

### 4. Synthesise into the template

Copy `1-foundational/_template.md` to `<category-dir>/<id>-<slug>.md`. Fill **Synthesis** (the distilled answer) and **Findings** (the substance). Attach an inline provenance ref to every claim — `[S#]` (external/scholarly, matched to the Sources list) or `[A]` (the author's own position/synthesis).

### 5. Flag bias & gaps

Fill **Tensions, gaps & corpus bias** honestly: where sources disagree, where the corpus lean shaped the answer, what external sourcing was needed and why, what is still unresolved. This section is not optional — it is how Stage 2 knows how far to trust the note.

### 6. Update the registry

Set the question's `status` in both the note frontmatter and the dashboard table in [Questions.md](Questions.md). Status vocabulary (identical everywhere): `todo` → `in-progress` → `review` → `done`.

---

## Definition of done (per note)

- All five template sections present and non-empty.

- Every factual claim in Synthesis and Findings carries explicit provenance: an `[S#]` (external/scholarly source) or `[A]` (author's own). No unmarked claim; no `[S#]` pointing at a barred register entry.

- At least one **external** source where step 3 applied (philology, primary texts, oral/indigenous, non-secular angle).

- Corpus bias explicitly addressed (even if the conclusion is "no material lean").

- `status: done` and `updated:` set; row updated in Questions.md.

---

## Source citation policy (KB-internal sources)

The shared corpus mixes published scholarship, recorded speech, community ephemera, and the author's own prose (some LLM-cleaned). A bare `filename:seg` is a *retrieval key*, not a citation. Each cited source is typed once in [`SOURCES.md`](SOURCES.md):

- **Usable (`[S#]`)** — scholarly / attributable work (book, paper, named lecture or interview). Resolve to a proper reference and web-verify. Notes cite it canonically as `[S#] <kbname> · <file>:<seg> — gloss`; the backticked filename is the register linkage and must resolve to a `usable` entry (the verifier errors on a cited corpus file with no entry). Optional precision upgrades — a resolved short cite and/or an explicit `[src:<key>]` — are recommended where the filename alone is ambiguous (the 3.5.x notes carry the full form).

- **Author's own (`[A]`)** — the author's position, synthesis or hypothesis. Marked `[A]` inline, NO Sources entry, outside the `[S#]` bijection. **Never dropped for lack of an external source**; external grounding is *sought*, not required. If found, it gains an `[S#]`.

- **Barred (no `[S#]`)** — a corpus file may never carry an `[S#]`. `barred:self` (self-authored/LLM prose) → its author-originated ideas become `[A]`. `barred:ephemera` (newsletters, event notices) → re-ground in a usable/external source or drop.

A note may still *discuss* a barred source as its subject via a plain-text pointer (never an `[S#]`) — "the corpus itself hosts …" — because "the corpus contains X" is self-evidencing. It becomes barred only when the note leans on the source's *content* as evidence about the world.
