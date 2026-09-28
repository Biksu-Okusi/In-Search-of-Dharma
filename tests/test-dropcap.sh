#!/bin/bash
# tests/test-dropcap.sh - lib/dropcap.py puts the drop cap on a chapter's first
# paragraph, whatever that paragraph opens with, and never on a later one.
#
# The proof of 23 Sep had the Coda's cap on its second paragraph and the
# Appendix's on a one-line paragraph mid-section: the filter moved on whenever
# the second word was inline markup ("A <strong>dharma</strong>", "Throughout
# <em>in search of dharma</em>").
set -euo pipefail
shopt -s inherit_errexit

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r DC=$ROOT/lib/dropcap.py
declare -i FAILED=0

echo '== drop cap =='

# check <name> <input> <expected substring>
check() {
  local -- name=$1 input=$2 want=$3 got
  got=$(printf '%s' "$input" | "$DC" 2>/dev/null) \
    || { printf '  ✗ %s: filter failed\n' "$name"; FAILED+=1; return; }
  if [[ $got == *"$want"* ]]; then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s\n      want: %s\n      got:  %s\n' "$name" "$want" "$got"
    FAILED+=1
  fi
}

# check_count <name> <input> <substring> <count> : the substring occurs exactly
# <count> times in the output.
check_count() {
  local -- name=$1 input=$2 needle=$3 got
  local -i want=$4 n
  got=$(printf '%s' "$input" | "$DC" 2>/dev/null) \
    || { printf '  ✗ %s: filter failed\n' "$name"; FAILED+=1; return; }
  # grep exits 1 on no match, which pipefail would turn into an abort.
  n=$({ grep -o -F -- "$needle" <<<"$got" || true; } | wc -l)
  if ((n == want)); then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s: %s occurs %d times, want %d\n' "$name" "$needle" "$n" "$want"
    FAILED+=1
  fi
}

declare -r EPIGRAPH='<blockquote>
<p><em>Eight parts of searching have earned one plain definition.</em></p>
</blockquote>
'

declare -r CODA="<h1 id=\"coda\">Coda</h1>
${EPIGRAPH}<p>A <strong>dharma</strong> is a way of living that tells a person or
group how to act.</p>
<p>A dharma is not necessarily a religion.</p>
"
check 'Coda: the cap is on the first paragraph' \
  "$CODA" '<p class="op"><span class="dc">A</span><span class="sc"> <strong>dharma</strong></span> is a way'
check_count 'Coda: only one paragraph carries the cap' "$CODA" 'class="op"' 1

declare -r APPENDIX='<h1 id="appendix">Appendix: Dharmas, the better ones</h1>
<p>Throughout <em>in search of dharma</em> I have insisted that dharmas
are <em>made</em>, plural, and unprivileged.</p>
<p>Part 8 answers this.</p>
<p>A dharma is to be judged by two tests.</p>
'
check 'Appendix: a multi-word italic title leaves the lead-in at one word' \
  "$APPENDIX" '<p class="op"><span class="dc">T</span><span class="sc">hroughout</span> <em>in search of dharma</em> I have'
check_count 'Appendix: only one paragraph carries the cap' "$APPENDIX" 'class="op"' 1

check 'Part 8: a one-letter first word is the whole cap' \
  '<h1 id="part-8">Part 8</h1>
<p>A woman sits on a cushion in a small flat.</p>
' '<p class="op"><span class="dc">A</span><span class="sc"> woman</span> sits'

check 'Preface: two plain words take the lead-in' \
  '<h1 id="preface">Preface</h1>
<p>Most books that refer to the word dharma.</p>
' '<p class="op"><span class="dc">M</span><span class="sc">ost books</span> that'

check 'a second word in emphasis joins the lead-in' \
  '<p>Nothing <em>stays</em> put for long.</p>
' '<span class="dc">N</span><span class="sc">othing <em>stays</em></span> put'

check 'a one-word paragraph takes the cap on its only word' \
  '<p>Enough.</p>
' '<p class="op"><span class="dc">E</span><span class="sc">nough</span>.</p>'

# An opening that is not a letter gets no cap -- a cap on a quotation mark
# reads as a mistake -- but it still marks the first paragraph, so the cap
# never lands on a later one.
declare -r QUOTED="<p>‘Quoted’ is how this one opens.</p>
<p>Plain words follow here.</p>
"
check 'a quotation-mark opening is marked, without a cap' \
  "$QUOTED" "<p class=\"op\">‘Quoted’ is how"
check_count 'a quotation-mark opening keeps the cap off the next paragraph' \
  "$QUOTED" 'class="dc"' 0

check 'a paragraph inside a figure or blockquote is passed over' \
  "${EPIGRAPH}<figure>
<p>caption text</p>
</figure>
<p>Here it begins.</p>
" '<p class="op"><span class="dc">H</span><span class="sc">ere it</span> begins'

# The whole book, through the same pipe mk-print.sh runs: in every chapter the
# first body paragraph (a bare <p>, not a label or a figure's) is the one
# carrying the cap.
echo '== drop cap: every chapter =='
declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main
#shellcheck source=SCRIPTDIR/../lib/preprocess.sh
source "$ROOT"/lib/preprocess.sh

declare -- src verdict
for src in "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md; do
  verdict=$( cd -- "$ROOT" && preprocess "${src##*/}" \
    | pandoc --from=markdown-yaml_metadata_block --to=html5 \
    | "$DC" \
    | python3 -c '
import re, sys
depth = 0
for line in sys.stdin:
  depth += len(re.findall(r"<(figure|blockquote|table|ul|ol|div)\b", line))
  depth -= len(re.findall(r"</(figure|blockquote|table|ul|ol|div)>", line))
  depth = max(depth, 0)
  if depth == 0 and re.match(r"\s*<p( class=\"op\")?>", line):
    ok = line.lstrip().startswith("<p class=\"op\"><span class=\"dc\">")
    print("ok" if ok else "first paragraph unmarked: " + line.strip()[:60])
    break
else:
  print("no paragraph found")
' )
  if [[ $verdict == ok ]]; then
    printf '  ✓ %s\n' "${src##*/}"
  else
    printf '  ✗ %s: %s\n' "${src##*/}" "$verdict"; FAILED+=1
  fi
done

((FAILED == 0)) || exit 1
#fin
