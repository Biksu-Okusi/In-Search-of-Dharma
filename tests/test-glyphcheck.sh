#!/bin/bash
# tests/test-glyphcheck.sh - the glyph gate passes the real sources and fails a
# fixture using a character Bona Nova does not carry.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r GC=$ROOT/lib/glyphcheck.py
declare -i FAILED=0
declare -- TMP=''

# Trap before mktemp, so a signal landing between the two cannot leak the dir.
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== glyph gate =='

# The real sources, against the faces the book is actually set in.
if "$GC" "$ROOT"/fonts/bonanova/BonaNova-Regular.ttf \
         "$ROOT"/fonts/bonanova/BonaNova-Italic.ttf \
         "$ROOT"/fonts/bonanova/BonaNova-Bold.ttf \
         -- "$ROOT"/[0-9]-*.md &>/dev/null; then
  printf '  ✓ current sources pass\n'
else
  printf '  ✗ current sources failed the gate\n'
  FAILED+=1
fi

# U+1E41 (m with dot above) is genuinely absent from Bona Nova.
printf 'The word saṁsara uses a character Bona Nova lacks.\n' >"$TMP"/bad.md
if "$GC" "$ROOT"/fonts/bonanova/BonaNova-Regular.ttf -- "$TMP"/bad.md 2>"$TMP"/err; then
  printf '  ✗ gate accepted a missing glyph\n'
  FAILED+=1
else
  printf '  ✓ gate rejects a missing glyph\n'
  if grep -q '1E41' "$TMP"/err; then
    printf '  ✓ the message names the character\n'
  else
    printf '  ✗ the message does not name the character\n'
    FAILED+=1
  fi
  if grep -q 'bad.md:1' "$TMP"/err; then
    printf '  ✓ the message names the file and line\n'
  else
    printf '  ✗ the message does not locate the character\n'
    FAILED+=1
  fi
fi

# Coverage is the intersection: a character in only one face is still a hole.
# Work Sans has no Devanagari, Bona Nova has no Devanagari either, so use a
# character one face has and another does not.
if "$GC" "$ROOT"/fonts/bonanova/BonaNova-Regular.ttf \
         "$ROOT"/fonts/opensans/OpenSans-Regular.ttf \
         -- "$ROOT"/1-defining-dharma.md &>/dev/null; then
  printf '  ✗ intersection not enforced (Open Sans lacks IAST the sources use)\n'
  FAILED+=1
else
  printf '  ✓ coverage is the intersection of the faces, not the union\n'
fi

((FAILED == 0)) || exit 1
#fin
