# Contributing to *In Search of Dharma*

Thank you for taking the time. This is an unusual project, so a few words on what it is
will help your contribution land well.

## What this project is (and isn't)

*In Search of Dharma* is a research project and essay series with a single governing
principle: **every factual claim is traceable to a source.** It works in two stages —
cited research notes first, then essays written *from* those notes — so that the finished
prose, which hides its citations, still rests on evidence anyone can follow back. See the
[README](README.md) for the shape of it and [`METHODOLOGY.md`](METHODOLOGY.md) for how a
note is built.

It is a *curated, authored* work — one person looking hard at one large question — not an
open wiki or a collaborative encyclopaedia. The argument, the voice, and the editorial
direction are the author's. Within that, outside eyes are genuinely valuable: a series
that argues about where our ethics come from should be checkable by the people reading it.

A practical note: the primary research draws on a **private** knowledgebase the author
maintains, which you won't have access to. That's fine — the most useful contributions
don't need it. They work from the published text and from openly available sources.

## Ways to contribute

Roughly in order of usefulness:

1. **Corrections** — factual errors, misattributed or broken citations, dead links,
   typos, and inconsistencies *across* the series (a claim in one essay that contradicts
   another, or that drifts from the note it draws on).
2. **Sources** — a better or additional source for a claim, especially a **primary**
   source, and especially where a note already flags its evidence as thin, contested, or
   one-sided.
3. **Critical engagement** — reasoned disagreement, a missing perspective, a
   counter-example that the argument should have to answer. Open an issue.
4. **Clarity** — small readability fixes that don't change meaning or flatten the voice.

## How to contribute

- **Open an issue** for anything you're reporting or want to discuss first. Be specific:
  name the file and section, and for a sourcing issue, name the source you have in mind.
- **Open a pull request** for a concrete fix. Keep it small and focused — one issue per
  PR is far easier to review than a sweeping change.

## ▲ The one hard rule: cite everything

This is the project's whole reason for existing, so it is not negotiable.

- In a **research note**, every factual claim carries an inline `[S#]` reference tied to
  the note's **Sources** list. A claim with no capturable source does not belong in a
  note. The note's shape is fixed by
  [`1-foundational/_template.md`](1-foundational/_template.md).
- In an **essay**, sources are named in the running prose ("Boehm spent a career on the question, and his answer is
  bracing…") with **no** inline citation marks; the chain back to the
  notes and the original works is preserved in the closing **Sources & further reading**
  list. The essay shape and house style are fixed by
  [`_essay-template.md`](_essay-template.md).

If you add or change a claim, add or change its source in the same edit.

## Conventions to respect

- **Research notes** live under the numbered directories (`0-preface/` and the eight categories) and are tracked in
  the registry [`Questions.md`](Questions.md). They use the five-section template, `[S#]`
  citations, and `[[id-slug]]` wiki-links between related notes.
- **Essays** are the `N-<slug>.md` files at the repository root; the blueprint, with its status
  dashboard, is [`Essays.md`](Essays.md). Voice is first-person and evidence-led; a firm
  claim should read as confident, not superior.
- **Status vocabulary** (in note/essay frontmatter and both dashboards):
  `todo → in-progress → review → done`.
- **Candour about bias.** The sourcing has a known secular / evolutionary /
  Western-academic lean, and the notes name it where it shapes an answer. If your
  contribution touches a place where that lean is doing work — or helps balance it with a
  perspective the corpus under-weights — say so plainly.

## Tone

The subject touches religion, culture, and ethics, often people's living traditions.
Please engage in good faith, argue with evidence rather than assertion, and extend the
same **non-privileging** stance the project tries to hold throughout: no tradition,
secular or religious, is treated as automatically superior to another.

## Licence

By contributing, you agree that your contributions are licensed under the project's
licence, **[Creative Commons Attribution 4.0 International](LICENSE)**
(CC BY 4.0) — the same terms that cover the rest of the work.
