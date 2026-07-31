# GitHub source links in essay Sources sections

**Date:** 2026-07-21
**Status:** approved, ready for implementation

## Problem

Each essay ends with a *Sources & further reading* section listing the research
notes it draws on. Those listings link to the notes with repo-relative paths —
`[1.1 Core Etymology](1-foundational/1.1-etymology.md)` in the English edition,
`../1-foundational/…` in the Indonesian. There are 58 such links per edition,
116 in total, across 41 distinct note files. None appear in the preface or coda.

The links resolve for exactly one class of reader:

| Target | Behaviour today |
|---|---|
| GitHub repo browsing | ✓ works — relative paths resolve in both editions |
| garydean.id `/works/N-in-search-of-dharma` | ✗ 404 — path resolves against `/works/` |
| EPUB | ✗ silently de-linked to plain text |
| PDF | ✗ silently de-linked to plain text |

Two different mechanisms produce the two failures. `sync-essays-to-db.sh:65`
(`clean_essay`) strips only frontmatter and the H1, so `.md` paths pass through
to the web unchanged and 404. `mk-book.sh:197` deliberately strips the link and
keeps the link text, to avoid dangling references failing epubcheck (RSC-007).

Every note is tracked in git, so the material a reader wants is publicly
available at `https://github.com/Biksu-Okusi/In-Search-of-Dharma` — the essays already
say so in a one-line pointer above each list. The links themselves just do not
point there.

## Decisions

1. **Web, EPUB and PDF all get working links.** In-repo relative browsing must
   not regress; absolute GitHub URLs satisfy it incidentally.
2. **Rewrite happens at build/publish time.** The canonical essay `.md` files
   keep their repo-relative links. No content file is modified.
3. **The PDF additionally prints one visible repo URL** per essay, on the
   existing "published on GitHub" line. Per-bullet URLs were rejected as
   visually heavy (~90 characters × up to 10 bullets per essay).
4. **All URLs point at `blob/main`.** Note IDs and filenames are declared stable
   in `CLAUDE.md`, so the main breakage risk — a renamed note — is ruled out by
   convention. Tracking `main` means later corrections reach readers holding
   older EPUBs.

## Design

### The rewrite rule

All 116 links share one shape: `](` + optional `../` + `N-category/….md` + `)`.
A single rule covers them:

```sed
s#\]\((\.\./)?([0-9]-[^):]*\.md)\)#](https://github.com/Biksu-Okusi/In-Search-of-Dharma/blob/main/\2)#g
```

- The `(\.\./)?` capture is discarded — the replacement uses `\2`. This is what
  normalises the Indonesian edition: `../1-foundational/…` and
  `1-foundational/…` both yield the same valid blob URL.
- `[^):]*` excludes any target containing a colon, so an already-absolute
  `https://…md` link can never be double-prefixed.
- Anchoring on `[0-9]-` scopes the rule to the eight category directories,
  leaving `defining-definition.md` and any future non-category link untouched.

### Book builds — `mk-book.sh` and `id/mk-book.sh`

In `preprocess()`, the de-link rule

```sed
s#\[([^]]+)\]\([^)]*\.md\)#\1#g
```

is **replaced** by the rewrite rule. Its stated purpose is satisfied by
construction: RSC-007 governs dangling *internal* references, and these targets
become external `https://` hrefs, which EPUB3 permits. The adjacent `/works/`
de-link rule stays — that is site-internal navigation with no GitHub equivalent.
The accompanying comment block (`mk-book.sh:171-173`) is updated to describe
rewriting rather than de-linking.

For the print-visible repo URL, a second rule appends a span to the existing
"published on GitHub" link, keyed on the URL rather than the prose so it works
in both languages:

```sed
s#(\[[^]]+\]\(https://github\.com/GaryDean/defining-dharma\))#\1<span class="repo-url"> — https://github.com/Biksu-Okusi/In-Search-of-Dharma</span>#g
```

`book.css` gains `.repo-url{display:none}`; the PDF shows it by default, so
`pdf.css` needs no rule. This mirrors the audio-link idiom already in the
script: `mk-book.sh:226-227` emits both a "Listen" label and a bare URL, and
`book.css:537` / `pdf.css:630` each hide the one they do not want.

The two rules are order-safe. Rule 1 runs first and produces
`…/defining-dharma/blob/main/…` URLs; rule 2's pattern requires `)` immediately
after the repo name, so it cannot match them. The existing em-dash rule
(`s# — # – #g`) runs after both and converts the inserted em dash to the book's
house en dash, which is the desired result.

### Web sync — `sync-essays-to-db.sh`

`clean_essay()` gains rule 1 only. No span: the web page renders the link
normally. This is the only target currently emitting *broken* links rather than
no links, so it carries the most value.

### Out of scope

`mk-hf-dataset.py` ships the research notes as dataset rows alongside the
essays, so relative paths there are internally coherent. It is not modified.

No canonical `.md` file is modified by any part of this work.

## Verification

- `./mk-book.sh all` — epubcheck clean; staged markdown has zero remaining
  `](N-…md)` targets and 58 `blob/main` URLs; the span renders in the PDF and
  not in the EPUB.
- `./id/mk-book.sh all` — same counts.
- `./sync-essays-to-db.sh` dry run, then inspect a dev DB row for `blob/main`
  and the absence of bare `.md)` targets.
- Spot-fetch two generated URLs — one top-level, one from the nested
  `3-philosophical/3.5-sumarah/` path — and confirm HTTP 200.
- `shellcheck` and `bcscheck` on all three modified scripts.
