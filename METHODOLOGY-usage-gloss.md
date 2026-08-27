# METHODOLOGY — The *usage-gloss* workflow

A companion to [METHODOLOGY.md](METHODOLOGY.md). That recipe answers *one DD question* and produces *one cited Stage-1 note*. This one is different in kind: it is a reusable, multi-source pass for characterising **how the author actually uses a term** (his idiolect), so a short Stage-2 gloss can be written in his own voice, flush with the existing essays.

It was first used to gloss **dharma / dharmas** for the Part-0 section "A note on two words" in [0-preface.md](0-preface.md). The same pattern fits any "what do I mean by *X*, exactly?" question (e.g. *sangha*, *secular*, *holds*, *the good*).

This is **Stage-2 support**, not a registry note: no [Questions.md](Questions.md) row, no per-claim `[S#]` rule, and its product is candidate prose plus a sourcing trail.

---

## The principle: epistemically ranked sources

The legs are ranked strongest first. The author's own words *define* the target; everything else only *corroborates or complicates* it. This mirrors the project's source policy (knowledgebase-primary, bias flagged) and the preface's *isnad* discipline — model knowledge is the weakest leg, flagged so it can never silently become the source.

1. **Idiolect (primary).** The author's own corpus: the eight essays, the preface, the research notes, the companion essays, his correspondence (`0-preface/.mail/` — grep-and-sample, do **not** read whole), and `../DefiningDharma` prior art. Extract the distinct senses he gives the term, each with a **verbatim quote and `file:line`**.

2. **Knowledgebase.** Scholarly framing from the shared corpus via `yatti-api` (query the corpus **once** — see the shared-corpus fact in METHODOLOGY.md; `prosocial` is a separate corpus). Capture source ids.

3. **Web.** Philology, primary texts, and cross-tradition comparison where the corpus is thin or slanted — `WebSearch` or `deep-research`. Capture URLs.

4. **Model knowledge (flagged).** A no-tools synthesis from training data, used **only where legs 1–3 corroborate it**. Every claim marked unverified.

Then a **synthesis** leg reconciles all four into: a plain idiolect statement; two or three candidate gloss paragraphs (tuned per placement); a **sourcing appendix** tagging each element (own-quote / KB-cite / web-URL / model-knowledge); and a flag for any collision with the essays as written.

---

## Running it

Run as a single background **Workflow**: the four legs under one `parallel()` barrier (the synthesis genuinely needs all four), then one synthesis `agent()`. Each leg returns **structured JSON**, so the synthesis — and the author — consume taggable evidence, not prose to re-parse.

The recipe above is the source of truth; the Workflow script is re-authorable from it. To keep a concrete script around, copy the last run's script (it is saved in the session transcript) into a `workflows/` dir in the repo (create it if absent) and re-run with `Workflow({scriptPath: …})`.

For a manual pass without the Workflow tool: run the four legs as separate subagents (or by hand with `grep`/`Read`, `yatti-api`, and `WebSearch`), then synthesise.

---

## House-style finish (do not skip)

The workflow *gathers and drafts*; the author *finishes*. Refine the chosen candidate into final prose in the house voice and **measure** the invariants defined in [`_essay-template.md`](_essay-template.md): em dashes sparing (zero to two in the paragraph), no run of three or more very short (six words or fewer) sentences, first-person guide voice. Verify every load-bearing quote against the cited `file:line` before trusting it.

If the gloss is inserted into an essay or the preface, **re-measure that file's word count with the file's own method** and update the frontmatter `words:` and `updated:` — measure, never guess.

The hardest trap, learned on *dharma*: do not let a term's reflective / intentional sense harden into a necessary-and-sufficient definition. For dharma it is one of four family-resemblance features, "not a border guard" (`1-defining-dharma.md`); the gloss keeps the modal ("the kind of path that *can* be…") plus an available-not-required counterweight. Watch for the analogous over-claim with any term.

---

## Definition of done

- Idiolect leg covers the essays, preface, notes, and companion essays, plus at least a grep-sample of `.mail/` and `../DefiningDharma`.

- Every candidate element is traceable in the sourcing appendix; any model-knowledge line is flagged for an explicit **keep / reword / cut** decision by the author.

- Candidates sit flush with the existing essays (collisions flagged), and pass the house-style invariant **measurement**.

- If inserted: frontmatter `words:` / `updated:` reconciled by measurement, not guess.

