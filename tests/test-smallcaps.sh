#!/bin/bash
# tests/test-smallcaps.sh - the small-caps filter wraps the runs Tuwhiri's house
# style asks for, and leaves alone the places where a capital is not prose.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r SC=$TEST_DIR/../lib/smallcaps.py
declare -i FAILED=0

echo '== small caps =='

# check <name> <input> <expected substring>
check() {
  local -- name=$1 input=$2 want=$3 got
  got=$(printf '%s' "$input" | "$SC") || { printf '  ✗ %s: filter failed\n' "$name"; FAILED+=1; return; }
  if [[ $got == *"$want"* ]]; then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s\n      want: %s\n      got:  %s\n' "$name" "$want" "$got"
    FAILED+=1
  fi
}

# check_absent <name> <input> <substring that must NOT appear>
check_absent() {
  local -- name=$1 input=$2 unwanted=$3 got
  got=$(printf '%s' "$input" | "$SC") || { printf '  ✗ %s: filter failed\n' "$name"; FAILED+=1; return; }
  if [[ $got == *"$unwanted"* ]]; then
    printf '  ✗ %s\n      must not contain: %s\n      got: %s\n' "$name" "$unwanted" "$got"
    FAILED+=1
  else
    printf '  ✓ %s\n' "$name"
  fi
}

check 'a two-letter run is wrapped' \
  '<p>an AI system</p>' 'an <span class="caps">AI</span> system'

check 'a longer run is wrapped' \
  '<p>the WEIRD sample</p>' '<span class="caps">WEIRD</span>'

check 'initials are wrapped' \
  '<p>as BR Ambedkar wrote</p>' '<span class="caps">BR</span> Ambedkar'

# A plural keeps its lowercase s outside the span: AIs is small capitals plus a
# roman s, never a small-capital S.
check 'a plural keeps its s outside' \
  '<p>earlier AIs still</p>' '<span class="caps">AI</span>s still'

check 'trailing digits stay outside' \
  '<p>during COVID19 here</p>' '<span class="caps">COVID</span>19'

# A capital run that runs into lowercase is a word, not an acronym.
check_absent 'a run followed by lowercase is left alone' \
  '<p>the USAid programme</p>' 'class="caps"'

check_absent 'a single capital is left alone' \
  '<p>A dharma holds</p>' 'class="caps"'

check_absent 'attribute values are left alone' \
  '<p><a href="https://EXAMPLE.COM/">link</a></p>' 'class="caps"'

check_absent 'code spans are left alone' \
  '<p>set <code>LC_ALL</code> first</p>' 'class="caps"'

check_absent 'headings are left alone' \
  '<h1>An AI Chapter</h1>' 'class="caps"'

check_absent 'entities are left alone' \
  '<p>&Aacute; and &amp; alone</p>' 'class="caps"'

# The running heads are built from the h1 text, and the Sources lists carry
# titles in capitals, so both paths are exercised by the real book. A chapter
# with nothing to wrap must come through byte-for-byte.
declare -- plain='<p>nothing to wrap in this one</p>'
if [[ $(printf '%s' "$plain" | "$SC") == "$plain" ]]; then
  printf '  ✓ a fragment with no runs is unchanged\n'
else
  printf '  ✗ a fragment with no runs was altered\n'
  FAILED+=1
fi

((FAILED == 0)) || exit 1
exit 0
#fin
