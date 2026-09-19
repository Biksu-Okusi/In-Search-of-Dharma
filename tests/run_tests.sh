#!/bin/bash
# tests/run_tests.sh - run every tests/test-*.sh, report a pass count.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -i PASS=0 FAIL=0
declare -a FAILED=()
declare -- t

for t in "$TEST_DIR"/test-*.sh; do
  [[ -f $t ]] || continue
  if bash "$t"; then
    PASS+=1
  else
    FAIL+=1
    FAILED+=("${t##*/}")
  fi
done

printf '\n%d/%d test files passed\n' "$PASS" "$((PASS + FAIL))"
((FAIL == 0)) || { printf '✗ failed: %s\n' "${FAILED[*]}"; exit 1; }
printf '✓ all green\n'
#fin
