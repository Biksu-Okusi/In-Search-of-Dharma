#!/bin/bash
# tests/run_tests.sh - run every tests/test-*.sh, report a pass count.
set -euo pipefail
shopt -s inherit_errexit
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${SCRIPT_PATH%/*}
declare -i PASS=0 FAIL=0
declare -a FAILED=()
declare -- TEST_FILE

for TEST_FILE in "$TEST_DIR"/test-*.sh; do
  [[ -f $TEST_FILE ]] || continue
  if bash -- "$TEST_FILE"; then
    PASS+=1
  else
    FAIL+=1
    FAILED+=("${TEST_FILE##*/}")
  fi
done

# No test found is a failure, never a green run.
((PASS + FAIL)) || { >&2 printf '✗ no test files found in %s\n' "$TEST_DIR"; exit 1; }
printf '\n%d/%d test files passed\n' "$PASS" "$((PASS + FAIL))"
((FAIL == 0)) || { printf '✗ failed: %s\n' "${FAILED[*]}"; exit 1; }
printf '✓ all green\n'
#fin
