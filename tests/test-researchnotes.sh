#!/bin/bash
#shellcheck disable=SC2015  # pass() only prints, so A && pass || fail is safe here
# tests/test-researchnotes.sh - the print interior sets each chapter's Research
# notes block as Ramsey asked (2026-09-28): its first two lines exactly
#   Research notes used in this book are published on GitHub:
#   https://github.com/Biksu-Okusi/In-Search-of-Dharma
# the URL never broken, no hyphenation, and the bullet indent 5mm, not 10mm.
set -euo pipefail
shopt -s inherit_errexit

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r RN=$ROOT/lib/researchnotes.py
declare -r URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r LINE1='Research notes used in this book are published on GitHub:'
declare -i FAILED=0

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n' "$1"; FAILED+=1; }

# What pandoc makes of a chapter's Research notes, after mk-print.sh has marked
# the bold label paragraph p.label: the intro wrapped at 72 columns, as pandoc
# wraps it.
declare -r BLOCK="<h2 id=\"sources-further-reading\">Sources &amp; further reading</h2>
<p><em>This part is built from the project's research notes.</em></p>
<p class=\"label\">Research notes</p>
<p>Research notes used in this book are published on <a
href=\"$URL\">GitHub</a><span
class=\"repo-url\"> –
$URL</span>.</p>
<ul>
<li><a href=\"$URL/blob/main/1-foundational/1.1-etymology.md\">1.1
Core Etymology</a> – the root.</li>
<li>2.4 Institutionalisation – incomprehensibilities, internationalisation,
institutionalisation, characteristically, disproportionately, incontrovertibly,
counterrevolutionaries, unrepresentativeness, interdenominationalism,
incomprehensibilities, internationalisation.</li>
</ul>
<p class=\"label\">Key works</p>
<ul>
<li>Kane, P. V. (1930). History of Dharmaśāstra.</li>
</ul>
"

echo '== research notes: filter =='
declare -- got
got=$(printf '%s' "$BLOCK" | "$RN") || { fail 'the filter failed on a normal block'; got=''; }

[[ $got == *"<p class=\"rn-intro\">$LINE1<br />"* ]] \
  && pass 'the first line ends "on GitHub:" and breaks' \
  || fail "the first line is not \"$LINE1\" followed by a break"
[[ $got == *"<span class=\"repo-url\"><a href=\"$URL\">$URL</a></span></p>"* ]] \
  && pass 'the second line is the bare URL, with no full stop after it' \
  || fail 'the second line is not the bare URL'
[[ -n $got && $got != *'repo-url"> –'* && $got != *'GitHub</a>'* ]] \
  && pass 'the old "GitHub – URL." form is gone' \
  || fail 'the old "GitHub – URL." form survives'
# The block runs from the label through the notes list, and stops there: Key
# works is a separate block with the ordinary indent.
python3 - "$got" <<'PY' && pass 'div.rn holds the label, the intro and the notes list, and nothing after' || fail 'div.rn is misplaced'
import re, sys
s = sys.argv[1]
m = re.search(r'<div class="rn">\n(.*?)\n</div>', s, re.S)
assert m, 'no div.rn'
inner = m.group(1)
assert inner.startswith('<p class="label">Research notes</p>'), inner[:60]
assert inner.rstrip().endswith('</ul>'), inner[-60:]
assert 'Key works' not in inner
assert s.count('<div class="rn">') == 1
PY

declare -r PLAIN='<h1 id="coda">Coda</h1>
<p>A <strong>dharma</strong> is a way of living.</p>
'
# $(...) drops the fragment's final newline, so compare without it.
got=$(printf '%s' "$PLAIN" | "$RN") && [[ $got == "${PLAIN%$'\n'}" ]] \
  && pass 'a chapter with no Research notes passes through unchanged' \
  || fail 'a chapter with no Research notes was altered'

# The Preface's sentence runs on after the link. The URL carries no full stop,
# so what follows it starts a line of its own.
got=$(printf '%s' "${BLOCK/"$URL</span>.</p>"/"$URL</span>. The Part-0
notes appear there in redacted public editions.</p>"}" | "$RN") || got=''
[[ $got == *"<a href=\"$URL\">$URL</a></span><br />"$'\n'"The Part-0"$'\n'"notes appear there in redacted public editions.</p>"* ]] \
  && pass 'text after the link starts a new line under the URL' \
  || fail "text after the link does not follow the URL on a new line: $(grep -A2 rn-intro <<<"$got")"

# A source edit that changes the intro must stop the build, not ship the old
# form quietly.
declare -- err
if err=$(printf '%s' "${BLOCK/published on/kept on}" | "$RN" 2>&1 >/dev/null); then
  fail 'an unrecognised intro under a Research notes label was let through'
elif [[ $err == *'Research notes'* ]]; then
  pass 'an unrecognised intro under a Research notes label is refused, and says why'
else
  fail "an unrecognised intro was refused without saying why: ${err:0:80}"
fi

echo '== research notes: every Part =='
declare -r REPO_URL=$URL
declare -r REPO_BLOB="$REPO_URL"/blob/main
#shellcheck source=SCRIPTDIR/../lib/preprocess.sh
source "$ROOT"/lib/preprocess.sh
declare -- src
for src in "$ROOT"/[0-8]-*.md; do
  got=$( cd -- "$ROOT" && preprocess "${src##*/}" \
    | pandoc --from=markdown-yaml_metadata_block --to=html5 \
    | sed -E 's|^<p><strong>([^<]*)</strong></p>$|<p class="label">\1</p>|' \
    | "$RN" ) || { fail "${src##*/}: the filter failed"; continue; }
  [[ $got == *"<div class=\"rn\">"* && $got == *"$LINE1<br />"* ]] \
    && pass "${src##*/}" || fail "${src##*/}: Research notes not rewritten"
done

echo '== research notes: as printed =='
declare -- TMP=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)
#shellcheck source=SCRIPTDIR/../lib/fonts.sh
source "$ROOT"/lib/fonts.sh
font_set_load bonanova-worksans "$ROOT"/fonts
#shellcheck source=SCRIPTDIR/../lib/print-style.sh
source "$ROOT"/lib/print-style.sh
print_geom_load
{ font_faces_css pdf; print_page_css; } >"$TMP"/print.css
{
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8">'
  printf '<link rel="stylesheet" href="print.css"></head><body><section class="chapter">'
  printf '<div class="sources">%s</div></section></body></html>\n' "$(printf '%s' "$BLOCK" | "$RN")"
} >"$TMP"/rn.html
weasyprint "$TMP"/rn.html "$TMP"/rn.pdf 2>/dev/null
declare -- lines
lines=$("$ROOT"/lib/pdfcheck.py baselines "$TMP"/rn.pdf --page 1)

# The two lines follow the label, each a line of its own.
jq -e --arg a "$LINE1" --arg b "$URL" '
  [.lines[].text] | (index($a)) as $i | $i != null and .[$i + 1] == $b' <<<"$lines" >/dev/null \
  && pass 'printed: the intro and the URL stand as two whole lines' \
  || fail "printed: the two lines are not as Ramsey wrote them: $(jq -c '[.lines[].text]' <<<"$lines")"

# The bullet hangs at the margin and the note text stands in 5mm from it.
declare -- indent
indent=$(jq -r '[.lines[] | select(.text | startswith("• 1.1"))][0]
  | if . == null then "none" else (.words[1].x0_mm - .words[0].x0_mm) end' <<<"$lines")
awk -v d="$indent" 'BEGIN{exit !(d > 4.9 && d < 5.1)}' \
  && pass "printed: the note text stands ${indent}mm in from its bullet" \
  || fail "printed: the note text stands ${indent}mm in from its bullet, want 5mm"

# Hyphenation off: no line of the notes ends in a hyphen. The second note is
# made of long words so that, hyphenated, some line would break inside one.
# WeasyPrint sets its hyphen as U+2010, not the ASCII hyphen-minus.
declare -- broken
broken=$(jq -r '[.lines[] | select(.text | test("[a-z][-‐]$")) | .text] | join(" | ")' <<<"$lines")
[[ -z $broken ]] && pass 'printed: no word in the notes is hyphenated' \
  || fail "printed: hyphenated in the notes: $broken"

((FAILED == 0)) || exit 1
#fin
