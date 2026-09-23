#!/bin/bash
# tests/test-presend-check.sh - tools/presend-check.sh passes what is not a
# print interior, and refuses an interior older than the book it is built from.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r CHECK=$TEST_DIR/../tools/presend-check.sh
declare -i FAILED=0
declare -- TMP='' err=''

trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== presend check =='

printf 'doc\n' >"$TMP"/cover.docx
if "$CHECK" "$TMP"/cover.docx; then
  printf '  ✓ an attachment that is not a print interior passes\n'
else
  printf '  ✗ a non-interior attachment was refused\n'; FAILED+=1
fi

printf '%%PDF-1.4 stale\n' >"$TMP"/Book_interior_152x229.pdf
touch -d '2000-01-01' "$TMP"/Book_interior_152x229.pdf
if err=$("$CHECK" "$TMP"/Book_interior_152x229.pdf 2>&1); then
  printf '  ✗ a stale interior was accepted\n'; FAILED+=1
elif [[ $err == *'rebuild with mk-print.sh'* ]]; then
  printf '  ✓ an interior older than its sources is refused\n'
else
  printf '  ✗ a stale interior: refused, but said: %s\n' "$err"; FAILED+=1
fi

if err=$("$CHECK" 2>&1); then
  printf '  ✗ no argument was accepted\n'; FAILED+=1
elif [[ $err == *usage* ]]; then
  printf '  ✓ no argument is a usage error\n'
else
  printf '  ✗ no argument: refused, but said: %s\n' "$err"; FAILED+=1
fi

((FAILED == 0)) || exit 1
exit 0
#fin
