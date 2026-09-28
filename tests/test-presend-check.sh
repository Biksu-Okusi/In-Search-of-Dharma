#!/bin/bash
# tests/test-presend-check.sh - tools/presend-check.sh passes what is not a
# print interior, and refuses an interior older than the book it is built from.
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -r CHECK=$TEST_DIR/../tools/presend-check.sh
declare -i FAILED=0
declare -- TMP='' ERR='' TREE='' NAME=''

trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d) || { >&2 echo 'test-presend-check: ✗ cannot create a temp dir'; exit 5; }

echo '== presend check =='

printf 'doc\n' >"$TMP"/cover.docx
if "$CHECK" "$TMP"/cover.docx; then
  printf '  ✓ an attachment that is not a print interior passes\n'
else
  printf '  ✗ a non-interior attachment was refused\n'; FAILED+=1
fi

printf '%%PDF-1.4 stale\n' >"$TMP"/Book_interior_152x229.pdf
touch -d '2000-01-01' -- "$TMP"/Book_interior_152x229.pdf
if ERR=$("$CHECK" "$TMP"/Book_interior_152x229.pdf 2>&1); then
  printf '  ✗ a stale interior was accepted\n'; FAILED+=1
elif [[ $ERR == *'rebuild with mk-print.sh'* ]]; then
  printf '  ✓ an interior older than its sources is refused\n'
else
  printf '  ✗ a stale interior: refused, but said: %s\n' "$ERR"; FAILED+=1
fi

# The imprint and the endorsements are part of what the interior is built from.
# Run against a copy of the script in a tree of its own, where each file's age
# can be set without touching the book: every source older than the interior
# but the one named.
# broken WHAT : the tree could not be set up, so nothing it would show is known.
broken() { >&2 printf 'test-presend-check: ✗ %s\n' "$1"; exit 5; }

TREE=$TMP/tree
mkdir -p -- "$TREE"/tools "$TREE"/lib || broken "cannot create ${TREE@Q}"
cp -- "$CHECK" "$TREE"/tools/presend-check.sh || broken "cannot copy ${CHECK@Q}"
printf '#!/bin/bash\nexit 0\n' >"$TREE"/mk-print.sh || broken 'cannot write the stand-in mk-print.sh'
chmod -- +x "$TREE"/mk-print.sh || broken 'cannot mark the stand-in mk-print.sh executable'
printf 'x\n' | tee -- "$TREE"/1-part.md "$TREE"/the-better-ones.md "$TREE"/lib/a.sh "$TREE"/lib/a.py \
  "$TREE"/print-imprint.md "$TREE"/print-endorsements.md >/dev/null || broken 'cannot write the sources'
printf '%%PDF-1.4\n' >"$TREE"/Book_interior_152x229.pdf || broken 'cannot write the interior'
for NAME in print-imprint.md print-endorsements.md; do
  find -- "$TREE" -type f -exec touch -d '2001-01-01' -- {} + || broken 'cannot age the sources'
  touch -d '2002-01-01' -- "$TREE"/Book_interior_152x229.pdf || broken 'cannot date the interior'
  # What the check says when it refuses is read in the next step; here only
  # its verdict is wanted.
  if ! "$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229.pdf 2>/dev/null; then
    printf '  ✗ an interior newer than all its sources was refused\n'; FAILED+=1; continue
  fi
  touch -d '2003-01-01' -- "$TREE/$NAME" || broken "cannot date ${NAME@Q}"
  if ERR=$("$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229.pdf 2>&1); then
    printf '  ✗ an interior older than %s was accepted\n' "$NAME"; FAILED+=1
  elif [[ $ERR == *"older than $NAME"* ]]; then
    printf '  ✓ an interior older than %s is refused\n' "$NAME"
  else
    printf '  ✗ an interior older than %s: refused, but said: %s\n' "$NAME" "$ERR"; FAILED+=1
  fi
done
rm -f -- "$TREE"/print-imprint.md "$TREE"/print-endorsements.md
# As above: only the verdict is wanted.
if "$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229.pdf 2>/dev/null; then
  printf '  ✓ a book with no imprint or endorsements file still passes\n'
else
  printf '  ✗ a book with no imprint or endorsements file was refused\n'; FAILED+=1
fi

if ERR=$("$CHECK" 2>&1); then
  printf '  ✗ no argument was accepted\n'; FAILED+=1
elif [[ $ERR == *usage* ]]; then
  printf '  ✓ no argument is a usage error\n'
else
  printf '  ✗ no argument: refused, but said: %s\n' "$ERR"; FAILED+=1
fi

((FAILED == 0)) || exit 1
exit 0
#fin
