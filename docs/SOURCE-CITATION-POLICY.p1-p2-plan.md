# KB Source Citation Policy — P1+P2 Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Codify the KB source-citation policy (usable `[S#]` / author's-own `[A]` / barred) into the DD methodology, template and a new `SOURCES.md` register, then produce a read-only `AUDIT-REPORT.md` sizing every barred-source violation and unresolved filename across the notes — without editing any research note.

**Architecture:** Two phases. **P1** is documentation + a new register file (edits to `METHODOLOGY.md`, `1-foundational/_template.md`; new `SOURCES.md`). **P2** is tooling + a one-shot audit: a deterministic extractor (`scratch/audit_sources.py`) pulls every cited KB sourcedoc from the notes; a multi-agent classification workflow types + resolves + verifies each; a deterministic assembler writes the fully-populated `SOURCES.md` register and `AUDIT-REPORT.md`. A register-aware extension to `scratch/verify_notes.py` provides an independent, deterministic cross-check of the agent-produced findings.

**Tech Stack:** Python 3.12+ (stdlib only — `re`, `json`, `pathlib`, `collections`), `pytest` for the two scratch scripts, the `Workflow` tool for the 309-source classification fan-out, `WebSearch` for bibliographic verification, existing `yatti-api` corpus is read only via filename metadata (no queries needed for the audit itself).

## Global Constraints

Every task's requirements implicitly include these. Values copied verbatim from the spec (`SOURCE-CITATION-POLICY.design.md`) and org policy:

- **P3 is HELD.** This plan touches **zero** files under `1-foundational/`…`8-future/` *except* the single template file `1-foundational/_template.md`. No research note's body is edited.
- **Provenance markers:** `[S#]` = external/scholarly source (has a Sources-list entry). `[A]` = author's own position/synthesis/hypothesis (inline only, **no** Sources-list entry, outside the `[S#]` bijection). `[src:key]` = register pointer, resolver-safe (must NOT match `\[S\d+\]`).
- **Per-note `[S#]` numbering is unchanged.** Never renumber existing `[S#]`.
- **Register:** single file `SOURCES.md` at the DD project root. One entry per cited *work* (a work may span multiple sourcedocs). Entry keys are ascii-kebab-case.
- **Barred handling:** `barred:self` → author's-own `[A]` (seek grounding, not required — never drop for lack of a source). `barred:ephemera` → re-ground or drop (no `[A]`). *(These are P3 actions; P2 only records them.)*
- **Typography (DD notes ground truth):** straight ASCII quotes/apostrophes. Non-ASCII limited to `—` (U+2014), `–` (U+2013), `·` (U+00B7), `…` (U+2026), and `§ ö ü` where a name needs them. The `--`-not-em-dash rule is a Stage-2 *essay* invariant, NOT a notes rule.
- **Terminology:** always write "knowledgebase" as one word.
- **`scratch/` is gitignored** — `scratch/audit_sources.py` and `scratch/verify_notes.py` are NOT committed. Only tracked artifacts (`METHODOLOGY.md`, `1-foundational/_template.md`, `SOURCES.md`, `AUDIT-REPORT.md`) are committed.
- **Commits:** author `Biksu-Okusi <biksu@okusi.id>`; conventional-commit style; NEVER mention "claude"/"cl"; unquoted heredoc delimiters; never commit `CLAUDE.md` or `.claude/`. After commit, verify with `git log --oneline -n 3`.
- **Verification honesty:** spot-check any agent-reported classification against the real file before trusting it; report what was and wasn't verified.

---

## File Structure

- `SOURCES.md` (NEW, tracked, DD root) — the citation register. Schema header + entries.
- `1-foundational/_template.md` (MODIFY, tracked) — the canonical note template's `## Sources` block + `[A]` guidance.
- `METHODOLOGY.md` (MODIFY, tracked) — new "Source citation policy" section; amended step 4 and Definition-of-done.
- `AUDIT-REPORT.md` (NEW, tracked, DD root) — per-note per-`[S#]` audit table + summary. P2 deliverable.
- `scratch/audit_sources.py` (NEW, gitignored) — deterministic extractor + report assembler.
- `scratch/test_audit_sources.py` (NEW, gitignored) — its tests.
- `scratch/verify_notes.py` (MODIFY, gitignored) — add register-aware checks.
- `scratch/test_verify_register.py` (NEW, gitignored) — tests for the new checks.
- `scratch/worklist.json` (GENERATED, gitignored) — intermediate: extracted sourcedocs → note/`[S#]` backrefs.
- `scratch/classified.json` (GENERATED, gitignored) — intermediate: workflow classification output.

---

## P1 — Codify

### Task 1: Create the `SOURCES.md` register with verified seed entries

**Files:**
- Create: `SOURCES.md` (DD root)
- Create: `scratch/check_register.py` (gitignored parse-validator)

**Interfaces:**
- Produces: the register file + its per-entry schema, consumed by Tasks 2–7. Entry field set: `status` (usable|barred), `barred` (self|ephemera, only if barred), `medium` (text|transcript), `cite` (usable only), `kb` (backticked filename list), `verified`, optional `note`. Entry header: `### <ascii-kebab-key>`.

- [ ] **Step 1: Write the register file**

Create `SOURCES.md` with a schema header and five seed entries. Web-verify the two book ISBNs in Step 2 before trusting the values below.

````markdown
# SOURCES — DD citation register

One entry per cited **work**. Resolve once, reuse across every note. See
`SOURCE-CITATION-POLICY.design.md` for the policy this implements.

**Fields**

- `status:` `usable` | `barred`
- `barred:` `self` | `ephemera`  (present only when `status: barred`)
- `medium:` `text` | `transcript`
- `cite:` resolved human-readable reference (usable only). Transcripts:
  `Speaker, "Talk title" (platform, id/URL, year)`.
- `kb:` sourcedoc filename(s), backticked, comma-separated — the retrieval key(s).
- `verified:` `web (ISBN…/DOI…)` | `video-URL` | `unverified`.
- `note:` optional free text.

A note's `[S#]` line points here via `[src:<key>]`. No `[S#]` may point at a
`status: barred` entry. Author's-own claims use `[A]` and have NO entry here.

---

### boehm-1999-hierarchy
- status: usable
- medium: text
- cite: Christopher Boehm, *Hierarchy in the Forest: The Evolution of Egalitarian Behavior* (Harvard University Press, 1999)
- kb: `Christopher-Boehm_Hierarchy-in-the-Forest_The-Evolution-of-Egalitarian-Behavior_HarvardUP-1999.md`, `04-chapter.md`
- verified: web (ISBN 978-0-674-39031-7)
- note: reverse dominance hierarchy; foragers as moral communities.

### graeber-wengrow-2021-dawn
- status: usable
- medium: text
- cite: David Graeber & David Wengrow, *The Dawn of Everything: A New History of Humanity* (Farrar, Straus and Giroux, 2021)
- kb: `Dawn_of_Everything-David_Graeber.md`, `Dawn-of-Everything.md`
- verified: web (ISBN 978-0-374-15735-7)
- note: disputes a single "original condition"; egalitarian-forager baseline not uniform.

### sapolsky-behave-2017
- status: usable
- medium: text
- cite: Robert M. Sapolsky, *Behave: The Biology of Humans at Our Best and Worst* (Penguin Press, 2017)
- kb: `Behave_the-biology-of-humans-at-our-best-and-worst.md`
- verified: web (ISBN 978-1-59420-507-1)
- note: neurobiology of behaviour; frontal cortex, amygdala, gene-effect-size caveats.

### dharma-sangha-reunion-2020
- status: barred
- barred: ephemera
- medium: text
- kb: `dharma-sangha-reunion-2020.md`
- verified: unverified
- note: secular-Buddhist community event notice; no evidential weight.

### is-rationalism-a-form-of-autism-expanded
- status: barred
- barred: self
- medium: text
- kb: `is-rationalism-a-form-of-autism.expanded.txt`
- verified: unverified
- note: corpus-internal LLM-expanded provocation; author-originated ideas here move to [A], not [S#].
````

- [ ] **Step 2: Web-verify the three ISBNs**

Run three `WebSearch` queries and confirm the ISBN-13 matches the edition in `cite:`. Correct the file if any differs.

- `WebSearch`: `Boehm "Hierarchy in the Forest" Harvard University Press 1999 ISBN` → expect ISBN-13 `978-0-674-39031-7`.
- `WebSearch`: `Graeber Wengrow "The Dawn of Everything" 2021 ISBN` → expect `978-0-374-15735-7` (FSG US ed.).
- `WebSearch`: `Sapolsky "Behave" Penguin Press 2017 ISBN` → expect `978-1-59420-507-1`.

Expected: each ISBN confirmed (or the `cite:`/`verified:` line corrected to the confirmed value).

- [ ] **Step 3: Write the register parse-validator**

Create `scratch/check_register.py`:

```python
#!/usr/bin/env python3
"""Validate SOURCES.md: every entry has required fields; keys unique; kb non-empty."""
import re, sys
from pathlib import Path

ROOT = Path("/var/lib/vectordbs/seculardharma/projects/DD")
REQUIRED = {"status", "medium", "kb", "verified"}

def parse_register(text):
  entries, key, fields = {}, None, {}
  for line in text.splitlines():
    m = re.match(r'^### (\S+)\s*$', line)
    if m:
      if key: entries[key] = fields
      key, fields = m.group(1), {}
      continue
    if key:
      fm = re.match(r'^- (\w+):\s*(.*)$', line)
      if fm: fields[fm.group(1)] = fm.group(2).strip()
  if key: entries[key] = fields
  return entries

def main():
  text = (ROOT / "SOURCES.md").read_text(encoding="utf-8")
  entries = parse_register(text)
  errors = []
  for key, f in entries.items():
    if not re.fullmatch(r'[a-z0-9-]+', key):
      errors.append(f"{key}: key not ascii-kebab")
    missing = REQUIRED - f.keys()
    if missing:
      errors.append(f"{key}: missing {sorted(missing)}")
    if f.get("status") == "usable" and not f.get("cite"):
      errors.append(f"{key}: usable but no cite")
    if f.get("status") == "barred" and "barred" not in f:
      errors.append(f"{key}: barred but no reason")
    if not f.get("kb", "").strip():
      errors.append(f"{key}: empty kb")
  print(f"parsed {len(entries)} entries; {len(errors)} errors")
  for e in errors: print("  ERROR:", e)
  sys.exit(1 if errors else 0)

if __name__ == "__main__":
  main()
#fin
```

- [ ] **Step 4: Run the validator**

Run: `python3 scratch/check_register.py`
Expected: `parsed 5 entries; 0 errors` and exit 0.

- [ ] **Step 5: Commit the register**

```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
git add SOURCES.md
git commit -m "feat(sources): add citation register with verified seed entries" --author="Biksu-Okusi <biksu@okusi.id>"
git log --oneline -n 3
```

Expected: commit present at HEAD; `scratch/` files absent from the commit (gitignored).

---

### Task 2: Update the note template's Sources block

**Files:**
- Modify: `1-foundational/_template.md`

**Interfaces:**
- Consumes: the register schema from Task 1 (`[src:key]` form).
- Produces: the canonical `## Sources` block + `[A]` guidance that every future note copies.

- [ ] **Step 1: Replace the `## Sources` block**

Find this exact block in `1-foundational/_template.md`:

```markdown
## Sources
**Knowledgebase (yatti-api)**
- [S1] seculardharma · <doc / segment id or title> — <one-line note on what it supports>

**External**
- [S2] Author, *Title* (year), p./URL — <one-line note on what it supports>
```

Replace it with:

```markdown
## Sources
<Every [S#] here is an EXTERNAL/scholarly (usable) source. Author's-own claims use
[A] inline in Synthesis/Findings and get NO entry here. No [S#] may point at a
`status: barred` register entry (self-authored corpus prose or ephemera).>

**Knowledgebase (yatti-api)**
- [S1] <Author year, *Title*, loc> · kb:`<sourcedoc>:<seg>` [src:<register-key>] — <one-line note on what it supports>

**External**
- [S2] Author, *Title* (year), p./URL — <one-line note on what it supports>
```

- [ ] **Step 2: Add `[A]` guidance to the Findings instruction**

Find this exact two-line block:

```markdown
claim carries an inline source ref: [S1], [S2], ... matching the Sources list.
Prefer specific, attributable statements over vague summary.>
```

Replace with:

```markdown
claim carries inline provenance — either [S1], [S2], ... (external/scholarly, matching the
Sources list) or [A] (author's own position/synthesis; no Sources-list entry). Prefer
specific, attributable statements over vague summary.>
```

- [ ] **Step 3: Verify the template edits**

Run:
```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
grep -n 'src:<register-key>' 1-foundational/_template.md
grep -n '\[A\] (author' 1-foundational/_template.md
grep -c 'Prefer' 1-foundational/_template.md
grep -c 'specific, attributable' 1-foundational/_template.md
```
Expected: first two greps each return one line; the last two each return `1` (the replacement text wraps "Prefer" / "specific" across two lines, so both halves appear exactly once — no duplicated or incomplete replacement).

- [ ] **Step 4: Commit**

```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
git add 1-foundational/_template.md
git commit -m "feat(template): add [S#]/[A] provenance + register-pointer Sources form" --author="Biksu-Okusi <biksu@okusi.id>"
git log --oneline -n 3
```

---

### Task 3: Fold the policy into `METHODOLOGY.md`

**Files:**
- Modify: `METHODOLOGY.md`

**Interfaces:**
- Consumes: register + `[A]`/`[S#]` conventions from Tasks 1–2.
- Produces: the authoritative prose policy the whole project references.

- [ ] **Step 1: Amend step 4 (Synthesise)**

Find this exact line:

```markdown
inline `[S#]` ref to every claim, matched to the Sources list.
```

Replace with:

```markdown
inline provenance ref to every claim — `[S#]` (external/scholarly, matched to the
Sources list) or `[A]` (the author's own position/synthesis) — matched to the Sources list.
```

- [ ] **Step 2: Amend the Definition of done**

Find this exact line:

```markdown
- Every factual claim in Findings carries an `[S#]` ref.
```

Replace with:

```markdown
- Every factual claim in Findings carries explicit provenance: an `[S#]` (external/
  scholarly source) or `[A]` (author's own). No unmarked claim; no `[S#]` pointing at a
  barred register entry.
```

- [ ] **Step 3: Append the policy section**

Add this section at the end of `METHODOLOGY.md`, immediately before the final line if one exists (else at EOF):

```markdown

---

## Source citation policy (KB-internal sources)

The shared corpus mixes published scholarship, recorded speech, community ephemera, and
the author's own prose (some LLM-cleaned). A bare `filename:seg` is a *retrieval key*, not
a citation. Each cited source is typed once in [`SOURCES.md`](SOURCES.md):

- **Usable (`[S#]`)** — scholarly / attributable work (book, paper, named lecture or
  interview). Resolve to a proper reference and web-verify. Notes cite it as
  `[S#] <short cite> · kb:`file:seg` [src:<key>]`.
- **Author's own (`[A]`)** — the author's position, synthesis or hypothesis. Marked `[A]`
  inline, NO Sources entry, outside the `[S#]` bijection. **Never dropped for lack of an
  external source**; external grounding is *sought*, not required. If found, it gains an
  `[S#]`.
- **Barred (no `[S#]`)** — a corpus file may never carry an `[S#]`. `barred:self`
  (self-authored/LLM prose) → its author-originated ideas become `[A]`. `barred:ephemera`
  (newsletters, event notices) → re-ground in a usable/external source or drop.

A note may still *discuss* a barred source as its subject via a plain-text pointer (never
an `[S#]`) — "the corpus itself hosts …" — because "the corpus contains X" is
self-evidencing. It becomes barred only when the note leans on the source's *content* as
evidence about the world.
```

- [ ] **Step 4: Verify**

Run:
```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
grep -n 'Source citation policy' METHODOLOGY.md
grep -n '`\[A\]`' METHODOLOGY.md | head
grep -c 'carries an `\[S#\]` ref.' METHODOLOGY.md
```
Expected: policy heading found; `[A]` mentions present; the old exact "carries an `[S#]` ref." line count is `0` (it was replaced).

- [ ] **Step 5: Commit**

```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
git add METHODOLOGY.md
git commit -m "docs(methodology): codify [S#]/[A]/barred source citation policy" --author="Biksu-Okusi <biksu@okusi.id>"
git log --oneline -n 3
```

---

## P2 — Audit (read-only w.r.t. notes)

### Task 4: Add register-aware checks to `verify_notes.py`

**Files:**
- Modify: `scratch/verify_notes.py` (gitignored — NOT committed)
- Create: `scratch/test_verify_register.py`

**Interfaces:**
- Consumes: `parse_register()` logic (mirror Task 1's), the notes' `[S#]`/`[src:key]` lines.
- Produces: `check_register(notes_dir, register_path) -> list[str]` returning issue strings prefixed `ERROR:` or `WARN:`. Used by Task 7 for the independent violation count.

- [ ] **Step 0: Read the current file**

Run: `sed -n '1,40p' scratch/verify_notes.py` — note the existing note-iteration helper and `main()` structure so the new function is wired into the existing report flow (call `check_register(...)` from `main()` and print its results alongside existing checks).

- [ ] **Step 1: Write the failing test**

Create `scratch/test_verify_register.py`:

```python
import verify_notes as V

REGISTER = """### boehm-1999-hierarchy
- status: usable
- medium: text
- cite: Boehm 1999
- kb: `04-chapter.md`
- verified: web (ISBN x)

### is-rationalism-a-form-of-autism-expanded
- status: barred
- barred: self
- kb: `is-rationalism-a-form-of-autism.expanded.txt`
- verified: unverified
"""

def _note(tmp_path, name, body):
    d = tmp_path / "5-psychological"; d.mkdir(exist_ok=True)
    (d / name).write_text(body); return tmp_path / "SOURCES.md"

def test_flags_ref_to_barred(tmp_path):
    reg = tmp_path / "SOURCES.md"; reg.write_text(REGISTER)
    _note(tmp_path, "x.md", "- [S1] foo · kb:`is-rationalism-a-form-of-autism.expanded.txt:0` [src:is-rationalism-a-form-of-autism-expanded] — bad\n")
    issues = V.check_register(tmp_path, reg)
    assert any(i.startswith("ERROR:") and "barred" in i for i in issues)

def test_warns_missing_register_entry(tmp_path):
    reg = tmp_path / "SOURCES.md"; reg.write_text(REGISTER)
    _note(tmp_path, "y.md", "- [S1] foo · kb:`unknown-book.md:3` [src:unknown-book] — x\n")
    issues = V.check_register(tmp_path, reg)
    assert any(i.startswith("WARN:") and "no register entry" in i for i in issues)

def test_A_marker_not_flagged(tmp_path):
    reg = tmp_path / "SOURCES.md"; reg.write_text(REGISTER)
    _note(tmp_path, "z.md", "Some claim the author holds [A].\n")
    issues = V.check_register(tmp_path, reg)
    assert issues == []
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd scratch && python3 -m pytest test_verify_register.py -v`
Expected: FAIL — `AttributeError: module 'verify_notes' has no attribute 'check_register'`.

- [ ] **Step 3: Implement `check_register`**

Add to `scratch/verify_notes.py` (import `re`, `pathlib` if not already):

```python
def parse_register(text):
  import re
  entries, key, fields = {}, None, {}
  for line in text.splitlines():
    m = re.match(r'^### (\S+)\s*$', line)
    if m:
      if key: entries[key] = fields
      key, fields = m.group(1), {}
      continue
    if key:
      fm = re.match(r'^- (\w+):\s*(.*)$', line)
      if fm: fields[fm.group(1)] = fm.group(2).strip()
  if key: entries[key] = fields
  return entries

def check_register(notes_dir, register_path):
  import re
  from pathlib import Path
  reg = parse_register(Path(register_path).read_text(encoding="utf-8"))
  # map every kb filename -> (key, status) for lookup
  kb_index = {}
  for key, f in reg.items():
    for fn in re.findall(r'`([^`]+?)`', f.get("kb", "")):
      kb_index[fn] = (key, f.get("status"))
  issues = []
  # Notes live ONLY in category dirs (N-<category>/); never scan root docs
  # (METHODOLOGY.md, the design/plan docs, etc. carry example [S#] lines).
  for cat in sorted(Path(notes_dir).glob("[1-8]-*")):
    if not cat.is_dir():
      continue
    for note in sorted(cat.rglob("*.md")):
      if note.name == "_template.md":
        continue
      for ln in note.read_text(encoding="utf-8").splitlines():
        if not re.match(r'^\s*- \[S\d+\]', ln):
          continue
        srcm = re.search(r'\[src:([a-z0-9-]+)\]', ln)
        fnm = re.search(r'kb:`([^`]+?)(?::\d+)?`', ln)
        if srcm:
          key = srcm.group(1)
          entry = reg.get(key)
          if entry is None:
            issues.append(f"WARN: {note.name}: [src:{key}] has no register entry")
          elif entry.get("status") == "barred":
            issues.append(f"ERROR: {note.name}: [S#] points at barred entry '{key}'")
        elif fnm:
          fn = fnm.group(1)
          if fn not in kb_index:
            issues.append(f"WARN: {note.name}: kb:`{fn}` has no register entry")
          elif kb_index[fn][1] == "barred":
            issues.append(f"ERROR: {note.name}: [S#] cites barred file '{fn}'")
  for key, f in reg.items():
    if f.get("status") == "usable" and f.get("verified") == "unverified":
      issues.append(f"WARN: register '{key}' usable but unverified")
  return issues
```

Wire it into `main()`: after the existing checks, add
`for i in check_register(NOTES_DIR, ROOT / "SOURCES.md"): print(i)` (use whatever the file already names the notes root / DD root).

- [ ] **Step 4: Run tests to verify they pass**

Run: `cd scratch && python3 -m pytest test_verify_register.py -v`
Expected: 3 passed.

- [ ] **Step 5: No commit** (scratch is gitignored). Confirm: `git status --porcelain scratch/` prints nothing tracked.

---

### Task 5: Build the deterministic sourcedoc extractor

**Files:**
- Create: `scratch/audit_sources.py`
- Create: `scratch/test_audit_sources.py`

**Interfaces:**
- Produces: `extract(notes_dir) -> dict[sourcedoc -> list[(note_name, s_ref, rawline)]]` and a CLI that writes `scratch/worklist.json`. Consumed by Task 6 (classification) and Task 7 (assembly).

- [ ] **Step 1: Write the failing test**

Create `scratch/test_audit_sources.py`:

```python
import audit_sources as A

SAMPLE = '''## Sources
**Knowledgebase (yatti-api)**
- [S1] appliedanthropology · `04-chapter.md` (Boehm) — reverse dominance.
- [S10] seculardharma · `john-zerzan_the-catastrophe-of-postmodernism.md:1` — Said in passing.
- [S12] seculardharma/appliedanthropology · corpus-wide search (4 queries) — absence.
- [S2] Author, *Title* (2001), p.3 — external, no kb file.
'''

def _write(tmp_path):
    d = tmp_path / "1-foundational"; d.mkdir(exist_ok=True)
    (d / "n.md").write_text(SAMPLE)

def test_extracts_kb_files(tmp_path):
    _write(tmp_path)
    idx = A.extract(tmp_path)
    assert "04-chapter.md" in idx
    assert "john-zerzan_the-catastrophe-of-postmodernism.md" in idx  # :1 stripped
    # non-file KB line (corpus-wide search) and pure-external line are not sourcedocs
    assert all("corpus-wide" not in k for k in idx)
    assert "Title" not in idx

def test_backrefs_carry_note_and_sref(tmp_path):
    _write(tmp_path)
    idx = A.extract(tmp_path)
    refs = idx["04-chapter.md"]
    assert refs[0][0] == "n.md" and refs[0][1] == "S1"
```

- [ ] **Step 2: Run test to verify it fails**

Run: `cd scratch && python3 -m pytest test_audit_sources.py -v`
Expected: FAIL — `ModuleNotFoundError` / `AttributeError: no attribute 'extract'`.

- [ ] **Step 3: Implement the extractor**

Create `scratch/audit_sources.py`:

```python
#!/usr/bin/env python3
"""Extract every KB sourcedoc cited across DD notes -> worklist.json.

A KB source line looks like:
  - [S1] <kbname> · `<sourcedoc>[:seg]` — gloss
Only lines with a backticked filename after the ' · ' are sourcedocs. External
lines (no ' · `file` ') and prose KB lines ("corpus-wide search …") are skipped.
"""
import json, re, sys
from collections import defaultdict
from pathlib import Path

ROOT = Path("/var/lib/vectordbs/seculardharma/projects/DD")
KB_NAMES = r'(?:seculardharma|appliedanthropology|prosocial(?:\.world)?)'
# [S#] ... <kbname>[/...] · `sourcedoc[:seg]`
LINE = re.compile(
    r'^\s*- \[(S\d+)\][^`]*?' + KB_NAMES + r'[\w./-]*\s*·\s*`([^`]+?)(?::\d+)?`')

def extract(notes_dir):
  idx = defaultdict(list)
  # Notes live ONLY in category dirs (N-<category>/); skip root docs, which
  # carry example [S#] lines (METHODOLOGY.md, the design/plan docs, etc.).
  for cat in sorted(Path(notes_dir).glob("[1-8]-*")):
    if not cat.is_dir():
      continue
    for note in sorted(cat.rglob("*.md")):
      if note.name == "_template.md":
        continue
      for ln in note.read_text(encoding="utf-8").splitlines():
        m = LINE.match(ln)
        if m:
          s_ref, sourcedoc = m.group(1), m.group(2)
          idx[sourcedoc].append((note.name, s_ref, ln.strip()))
  return dict(idx)

def main():
  notes_dir = ROOT
  idx = extract(notes_dir)
  out = {k: [{"note": n, "sref": s, "line": l} for n, s, l in v]
         for k, v in sorted(idx.items())}
  (ROOT / "scratch" / "worklist.json").write_text(
      json.dumps(out, indent=2, ensure_ascii=False), encoding="utf-8")
  print(f"{len(out)} distinct sourcedocs across "
        f"{sum(len(v) for v in out.values())} citations -> scratch/worklist.json")

if __name__ == "__main__":
  main()
#fin
```

- [ ] **Step 4: Run tests to verify they pass**

Run: `cd scratch && python3 -m pytest test_audit_sources.py -v`
Expected: 2 passed.

- [ ] **Step 5: Run the extractor on the real notes**

Run: `cd /var/lib/vectordbs/seculardharma/projects/DD && python3 scratch/audit_sources.py`
Expected: `NNN distinct sourcedocs across MMM citations -> scratch/worklist.json`, where `NNN` is ≈ 309 (the read-only sizing). If `NNN` is wildly off (e.g. < 200 or > 400), inspect a few unmatched KB lines with `grep -n ' · \`' <a note>` and widen the `LINE` regex before proceeding.

- [ ] **Step 6: No commit** (scratch gitignored).

---

### Task 6: Classify + resolve + verify via a workflow; write register + report

**Files:**
- Read: `scratch/worklist.json`
- Modify: `SOURCES.md` (append the resolved/typed entries for all cited works)
- Create: `AUDIT-REPORT.md` (DD root, tracked)
- Create: `scratch/classified.json` (workflow output, gitignored)

**Interfaces:**
- Consumes: `worklist.json` (sourcedoc → backrefs).
- Produces: one classified record per sourcedoc: `{sourcedoc, status, barred?, medium, key, cite?, verified, note}`; the appended `SOURCES.md` entries; and `AUDIT-REPORT.md`.

- [ ] **Step 1: Chunk the worklist for fan-out**

Run a short Python one-liner to split `worklist.json`'s keys into ~20 batches of ~15 sourcedocs (pass each batch's filenames to one agent). Keep the backref map for the assembler.

- [ ] **Step 2: Run the classification workflow**

Invoke the `Workflow` tool. The script pipelines each batch through classify → verify. Classification rules the agent MUST follow (from the spec):
- **usable** — a real book / paper / named lecture / interview. Parse `author_title[_subtitle][_publisher][_year]` from the filename; `.transcript.txt` ⇒ `medium: transcript`, else `text`. Resolve `cite:` and web-verify (ISBN/DOI/video-URL). Filenames with no author prefix that are nonetheless known works (e.g. `04-chapter.md` = Boehm ch.4, `After-Buddhism.md` = Batchelor) must be recognised by content, not rejected for opaque names.
- **barred:self** — self-authored / LLM prose. Signals: `.expanded.txt`; descriptive-slug `.md`/`.txt` with no author prefix that read as personal dharma notes/summaries (`dharma-summary.md`, `a-secular-dharma-my-dharma-004.txt`, `Dharma-according-to-Grok-4.md`).
- **barred:ephemera** — newsletters, event notices, promos (`2019-programme-now-ready-for-booking.md`, `dharma-sangha-reunion-2020.md`, `dutch-documentary.md`).
- **Namespace guard:** if a filename matches a DD project file (`defining-definition.md`, `_template.md`, `_essay-template.md`, or any `N.N-*` note slug), mark `status: project-file` (NOT a corpus source) and exclude from the register.
- Ambiguous ⇒ `status: usable` tentatively with `verified: unverified` AND `note: NEEDS-HUMAN` so it surfaces in the report.

Workflow schema (per sourcedoc): `{sourcedoc, status, barred, medium, key, cite, verified, note}`. A second pipeline stage independently re-checks each `usable` classification against a web lookup (adversarial: "is this really an attributable published work, and is the ISBN/DOI right?"), downgrading to `verified: unverified` + `NEEDS-HUMAN` on doubt. The workflow writes `scratch/classified.json`.

```
Workflow meta: name 'dd-source-audit', phases [{title:'Classify'},{title:'Verify'}].
pipeline(batches,
  b => agent(classify_prompt(b), {phase:'Classify', schema: BATCH_SCHEMA}),
  c => agent(verify_prompt(c),   {phase:'Verify',   schema: BATCH_SCHEMA}))
→ flatten → write scratch/classified.json
```

- [ ] **Step 3: Spot-check the classification (org rule)**

Pick 8 records spanning each status. For each, open the real corpus file to confirm the type:
`sqlite3 /var/lib/vectordbs/seculardharma/seculardharma.db "SELECT substr(originaltext,1,300) FROM docs WHERE sourcedoc LIKE '%<sourcedoc>%' AND sid=0;"`
Expected: the sampled content matches its assigned status (a book reads like a book; a newsletter like a newsletter). Fix any misclassification in `classified.json` before assembling.

- [ ] **Step 4: Assemble the register + report**

Add an `assemble()` to `scratch/audit_sources.py` that reads `classified.json` + `worklist.json` and:
1. Appends one `### key` entry per non-`project-file` work to `SOURCES.md` (dedup by `key`; merge multiple `kb:` files under one key; do NOT duplicate the 5 seed keys — skip keys already present).
2. Writes `AUDIT-REPORT.md`:

```markdown
# AUDIT-REPORT — KB source citations (read-only; notes unchanged)

Generated <DATE>. P2 of SOURCE-CITATION-POLICY.design.md. No note edited.

## Summary
- distinct sourcedocs cited: N
- usable: A · barred:self: B · barred:ephemera: C · project-file: D · NEEDS-HUMAN: E
- barred-source violations (an [S#] pointing at a barred file): V, across W notes

## Violations — [S#] citing a barred source  (P3: self→[A], ephemera→re-ground/drop)
| note | [S#] | sourcedoc | barred | action |
|------|------|-----------|--------|--------|
| 5.6.1-autism.md | S11 | is-rationalism-a-form-of-autism.expanded.txt | self | → [A] |

## Unresolved / NEEDS-HUMAN
| sourcedoc | tentative status | why |
|-----------|------------------|-----|

## Full classification
| sourcedoc | status | key | cited by |
|-----------|--------|-----|----------|
```

Pass `DATE` as an argument (do not call `Date.now()`); use the shell date at run time: `date +%F`.

- [ ] **Step 5: Cross-check report against the deterministic verifier**

Run: `cd scratch && python3 -c "import verify_notes as V; [print(i) for i in V.check_register('/var/lib/vectordbs/seculardharma/projects/DD', '/var/lib/vectordbs/seculardharma/projects/DD/SOURCES.md') if i.startswith('ERROR')]" | wc -l`
Expected: the ERROR count equals the report's "barred-source violations" `V`. If they differ, reconcile (the deterministic verifier is authoritative for the count) before committing.

- [ ] **Step 6: Run the register validator over the now-full register**

Run: `python3 scratch/check_register.py`
Expected: `parsed <5+K> entries; 0 errors`.

- [ ] **Step 7: Commit register + report**

```bash
cd /var/lib/vectordbs/seculardharma/projects/DD
git add SOURCES.md AUDIT-REPORT.md
git commit -m "docs(sources): populate register and add read-only citation audit report" --author="Biksu-Okusi <biksu@okusi.id>"
git log --oneline -n 3
```

Expected: both tracked files committed; no `scratch/` content in the commit.

---

### Task 7: Report the outcome to the author

**Files:** none (reporting only).

- [ ] **Step 1: Summarise for the author**

Report, in the chat: total sourcedocs; counts per status; number of barred-source violations and which notes; how many `usable` sources resolved+verified vs `NEEDS-HUMAN`; and the explicit statement that **no research note was edited** and **P3 remains held pending sign-off**. Link `AUDIT-REPORT.md`. State what was verified (the 8 spot-checks + the deterministic cross-check) and what was not (the bulk agent classifications beyond the sample).

---

## Self-Review (completed while writing)

- **Spec coverage:** Usable/`[A]`/barred policy → Tasks 1–3. Register schema + `SOURCES.md` → Task 1, populated Task 6. Note Sources form (`kb:` + `[src:key]`, `[A]` inline, KB/External split, `[S#]` bijection intact) → Task 2. Carve-out (discuss-not-cite) → Task 3. Tooling (register-aware checks; `[A]` not flagged; error on barred `[S#]`; warn unverified) → Task 4. P2 extract + classify + resolve + verify + `AUDIT-REPORT.md` → Tasks 5–6. Per-status action semantics → Task 6 report columns. P3 held; no note edited → Global Constraints + Task 6 (append register / write report only). Author-idea-never-dropped → encoded as the `self → [A]` action, not a drop.
- **Placeholder scan:** none — all scripts and edits are complete; `<DATE>` is explicitly sourced from `date +%F`; `NNN`/`N`/`V` are runtime *outputs*, not unfilled plan values.
- **Type consistency:** `parse_register` schema identical in Task 1 and Task 4; `extract()` return shape matches Task 6's consumption; register field names (`status`,`barred`,`medium`,`cite`,`kb`,`verified`,`note`) consistent across Tasks 1/4/6; `[src:key]` / `kb:` regexes consistent between `verify_notes.py` and `audit_sources.py`.
