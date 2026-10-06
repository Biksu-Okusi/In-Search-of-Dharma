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

# broken WHAT : a fixture could not be set up, so nothing it would show is
# known. Exit 5, which no failed check gives.
broken() { >&2 printf 'test-presend-check: ✗ %s\n' "$1"; exit 5; }

TMP=$(mktemp -d) || broken 'cannot create a temp dir'

echo '== presend check =='

printf 'doc\n' >"$TMP"/cover.docx || broken 'cannot write the attachment'
if "$CHECK" "$TMP"/cover.docx; then
  printf '  ✓ an attachment that is not a print interior passes\n'
else
  printf '  ✗ a non-interior attachment was refused\n'; FAILED+=1
fi

printf '%%PDF-1.4 stale\n' >"$TMP"/Book_interior_152x229.pdf || broken 'cannot write the stale interior'
touch -d '2000-01-01' -- "$TMP"/Book_interior_152x229.pdf || broken 'cannot date the stale interior'
if ERR=$("$CHECK" "$TMP"/Book_interior_152x229.pdf 2>&1); then
  printf '  ✗ a stale interior was accepted\n'; FAILED+=1
elif [[ $ERR == *'rebuild with mk-print.sh'* ]]; then
  printf '  ✓ an interior older than its sources is refused\n'
else
  printf '  ✗ a stale interior: refused, but said: %s\n' "$ERR"; FAILED+=1
fi

# The imprint and the dedication are part of what the interior is built from.
# Run against a copy of the script in a tree of its own, where each file's age
# can be set without touching the book: every source older than the interior
# but the one named.
TREE=$TMP/tree
mkdir -p -- "$TREE"/tools "$TREE"/lib || broken "cannot create ${TREE@Q}"
cp -- "$CHECK" "$TREE"/tools/presend-check.sh || broken "cannot copy ${CHECK@Q}"
printf '#!/bin/bash\nexit 0\n' >"$TREE"/mk-print.sh || broken 'cannot write the stand-in mk-print.sh'
chmod -- +x "$TREE"/mk-print.sh || broken 'cannot mark the stand-in mk-print.sh executable'
printf 'x\n' | tee -- "$TREE"/1-part.md "$TREE"/the-better-ones.md "$TREE"/lib/a.sh "$TREE"/lib/a.py \
  "$TREE"/print-imprint.md "$TREE"/print-dedication.md >/dev/null || broken 'cannot write the sources'
printf '%%PDF-1.4\n' >"$TREE"/Book_interior_152x229.pdf || broken 'cannot write the interior'
for NAME in print-imprint.md print-dedication.md; do
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
rm -f -- "$TREE"/print-imprint.md "$TREE"/print-dedication.md \
  || broken 'cannot remove the imprint and the dedication'
# As above: only the verdict is wanted.
if "$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229.pdf 2>/dev/null; then
  printf '  ✓ a book with no imprint or dedication file still passes\n'
else
  printf '  ✗ a book with no imprint or dedication file was refused\n'; FAILED+=1
fi

# A copy with crop marks is judged by the interior beside it: it passes when
# that interior does and is no newer than the copy, and is refused when the
# interior is missing or was rebuilt after the copy was made.
printf '%%PDF-1.4\n' >"$TREE"/Book_interior_152x229_cropmarks.pdf || broken 'cannot write the copy with crop marks'
touch -d '2004-01-01' -- "$TREE"/Book_interior_152x229_cropmarks.pdf || broken 'cannot date the copy with crop marks'
if "$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229_cropmarks.pdf 2>/dev/null; then
  printf '  ✓ a copy with crop marks passes with the interior it was made from\n'
else
  printf '  ✗ a copy with crop marks beside a good interior was refused\n'; FAILED+=1
fi
touch -d '2005-01-01' -- "$TREE"/Book_interior_152x229.pdf || broken 'cannot date the interior'
if ERR=$("$TREE"/tools/presend-check.sh "$TREE"/Book_interior_152x229_cropmarks.pdf 2>&1); then
  printf '  ✗ a copy with crop marks older than its interior was accepted\n'; FAILED+=1
elif [[ $ERR == *'older than the interior beside it'* ]]; then
  printf '  ✓ a copy with crop marks older than its interior is refused\n'
else
  printf '  ✗ an old copy with crop marks: refused, but said: %s\n' "$ERR"; FAILED+=1
fi
printf '%%PDF-1.4\n' >"$TREE"/Other_interior_152x229_cropmarks.pdf || broken 'cannot write the lone copy'
if ERR=$("$TREE"/tools/presend-check.sh "$TREE"/Other_interior_152x229_cropmarks.pdf 2>&1); then
  printf '  ✗ a copy with crop marks and no interior was accepted\n'; FAILED+=1
elif [[ $ERR == *'no interior beside it'* ]]; then
  printf '  ✓ a copy with crop marks and no interior beside it is refused\n'
else
  printf '  ✗ a lone copy with crop marks: refused, but said: %s\n' "$ERR"; FAILED+=1
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
