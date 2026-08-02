# AGENTS.md

## Cursor Cloud specific instructions

This repository is **not a running application**. It is a book/essay publishing
project: a Markdown corpus plus Bash/Python build scripts that produce an EPUB,
a PDF, and a Hugging Face dataset. There are **no servers, ports, or daemons** —
every "service" is a one-shot CLI build. Authoritative build commands live in
[`README.md`](README.md) (book) and the header of
[`mk-hf-dataset.py`](mk-hf-dataset.py) (dataset); don't duplicate them, run them.

### Core products and how to build them

- **EPUB / PDF book:** `./mk-book.sh [epub|pdf|all] [--audio none|link|embed]`
  (defaults `all`, `none`). The EPUB build ends with a **hard `epubcheck`
  validation gate** — a non-conformant EPUB fails the build.
- **Hugging Face dataset:** `./mk-hf-dataset.py [-o OUT]` — pure Python + PyYAML.
  With no `-o` it writes to `hf-dataset/` (gitignored). Uploading needs `hf auth login`.
- **Indonesian edition** (`id/`) and **audiobook** (`mk-audiobook.sh`) are
  secondary; audiobook/`--audio link|embed` and Google-Cloud TTS need external
  audio/credentials that are not present here.

### Non-obvious gotchas

- **`mk-book.sh` pins `PATH=/usr/local/bin:/usr/bin:/bin`.** Every build tool
  must resolve from those locations; tools installed elsewhere are invisible to it.
- **`epubcheck` needs a wrapper.** The Ubuntu `epubcheck` package installs
  `/usr/bin/epubcheck` as a bare symlink to the jar, which is **not directly
  runnable** and breaks the validation gate. The update script installs a
  `/usr/local/bin/epubcheck` shim (`java -jar /usr/share/java/epubcheck.jar "$@"`);
  it wins in the pinned PATH. If the gate errors with a `PK\003\004`/syntax-error
  message, the shim is missing — recreate it.
- **Builds overwrite the tracked binary artifacts** `In-Search-of-Dharma_*.epub`
  and `In-Search-of-Dharma_*.pdf` at the repo root. Do **not** commit those binary
  diffs from a routine build; revert with
  `git checkout -- In-Search-of-Dharma_Biksu-Okusi_2026.epub In-Search-of-Dharma_Biksu-Okusi_2026.pdf`.
- **Fonts:** EB Garamond is vendored under `fonts/ebgaramond/`; Lato comes from
  the `fonts-lato` apt package (installed by the update script). A missing font
  aborts `mk-book.sh` immediately before any real work.
- **No lint / CI / pre-commit config** is committed. The shell scripts carry
  `#shellcheck disable=` hints, so `shellcheck *.sh` is the natural (optional)
  lint if you install it; there is no required lint step.
- **Deploy/publish** (`deploy.conf`, `sync-essays-to-db.sh`) is off by default and
  targets the author's external host — leave it disabled here.
