#!/bin/bash
#shellcheck shell=bash
# lib/preprocess.sh - Markdown source preprocessing for the In Search of Dharma
# book builds.
#
# Sourced (never executed) by mk-book.sh and mk-print.sh, which render the same
# sources to different targets and so must agree exactly on what the sources
# mean. Extracted from mk-book.sh unchanged; the rules below are the record of
# why each rewrite exists, and are not to be reworded casually.
#
# Usage:
#   declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
#   declare -r REPO_BLOB="$REPO_URL"/blob/main
#   source "$SCRIPT_DIR"/lib/preprocess.sh
#   preprocess path/to/essay.md > staged.md
#
# Requires REPO_URL and REPO_BLOB to be declared by the caller before sourcing.

# Library only: it defines a function and does nothing on its own, so running it
# is always a mistake worth naming. No `set -euo pipefail` here -- that belongs
# to the calling script and must never be forced on its shell.
[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

# Convert one source file into pandoc-ready Markdown on stdout.
#   - drop a leading YAML frontmatter block (--- ... ---)
#   - <image ALIGN WIDTH "SRC" "ALT" "CAP"> -> ![ALT](SRC)
#   - "/images/..." web-root path -> "images/..." on-disk path
#   - image .webp/.png refs -> .jpg (build stages JPEG copies; see main)
#   - self-close bare <br> (raw <br> is invalid XHTML -> fatal EPUB parse error)
#   - drop obsolete <center> tags (not valid in EPUB3 XHTML; centring is done in
#     CSS via <div align="center"> -> [data-align="center"])
#   - a line containing only \newpage -> a hard page break (styled by .pagebreak)
#   - a lone <!--\newpage--> marker -> the same page break, blank-line-surrounded
#     so it forms its own raw-HTML block. (A raw <div>/<!-- --> directly abutting a
#     preceding `---` becomes an HTML block that runs to the next blank line, which
#     can swallow whole following chapters -> dropped headings, dangling TOC links.)
#   - strip any other stray HTML comments (e.g. <!--audio start/stop--> narration
#     markers); they render nothing and risk the same block-swallowing.
#   - research-note links -> absolute REPO_BLOB URLs. The optional "../" prefix
#     (Indonesian edition) is captured and dropped, so both editions produce the
#     same valid URL. Anchoring on the leading digit scopes the rule to the eight
#     category directories, and excluding ":" from the path means an
#     already-absolute link can never be prefixed twice. External https targets
#     do not trip epubcheck RSC-007, which governs dangling *internal* refs.
#   - the repo-URL link in the "published on GitHub" line gains a trailing span
#     carrying the bare URL, hidden in the EPUB and shown in the PDF (a hyperlink
#     is useless on paper). Keyed on the URL, not the prose, so it works in both
#     languages. Safe after the rule above, whose output ends in ".md)" and so
#     cannot match a pattern requiring ")" straight after the repo name.
#   - de-link /works/ prev-next nav, keeping the link text; those live outside the
#     book and would otherwise be dangling references (epubcheck RSC-007).
#   - spaced em dash " — " -> spaced en dash " – " (the typesetter's house style
#     for the book; British/NZ practice). Sources keep their em dashes -- this is
#     a book-build concern, not a change to the canonical essays. All source em
#     dashes are the spaced form, so this one rule covers every occurrence.
#   - "fj"/"ffj" -> wrapped in <span class="dlig"> so the stylesheets can switch
#     on the OpenType dlig feature for just that sequence. EB Garamond keeps its
#     f_j/f_f_j ligatures in dlig (off by default), unlike ff/fi/ffl which sit in
#     liga, so "Klingefjord" otherwise prints with the f hook colliding with the
#     j dot. Enabling dlig globally is not an option: it would also ligate Th,
#     ct, st, ch, ck throughout. Harmless under a face with no f_j in dlig: the
#     span then simply asks for a substitution the font does not offer. Caveat:
#     the rule is textual, so an fj inside a Markdown link *target* would break
#     that link -- no current source has one.
preprocess() {
  local -- src=$1
  # The <image r 40 "src" "alt" "cap"> shortcode, as an ERE. Built in two steps
  # so no line runs past 120 characters (BCS1201).
  local -- sp='[[:space:]]'
  local -- img_re="<image$sp+[a-z]+$sp+[0-9]+$sp+\"([^\"]*)\"$sp+\"([^\"]*)\"$sp+\"[^\"]*\"$sp*>"
  awk 'NR==1 && $0=="---"{fm=1; next} fm && $0=="---"{fm=0; next} !fm{print}' "$src" \
    | sed -E \
        -e "s#$img_re#![\\2](\\1)#" \
        -e 's#\]\(/images/#](images/#g' \
        -e 's#\.(webp|png)\)#.jpg)#g' \
        -e 's#<br[[:space:]]*/?>#<br/>#g' \
        -e 's#</?center>##g' \
        -e 's#^[[:space:]]*\\newpage[[:space:]]*$#<div class="pagebreak"></div>#' \
        -e 's#^[[:space:]]*<!--[[:space:]]*\\?newpage[[:space:]]*-->[[:space:]]*$#\n<div class="pagebreak"></div>\n#' \
        -e 's#<!--.*-->##g' \
        -e "s#\]\((\.\./)?([0-9]-[^):]*\.md)\)#]($REPO_BLOB/\2)#g" \
        -e "s#(\[[^]]+\]\($REPO_URL\))#\1<span class=\"repo-url\"> — $REPO_URL</span>#g" \
        -e 's#\[([^]]+)\]\(/works/[^)]*\)#\1#g' \
        -e 's# — # – #g' \
        -e 's#f?fj#<span class="dlig">&</span>#g'
}

#fin
