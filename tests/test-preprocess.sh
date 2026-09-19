#!/bin/bash
# tests/test-preprocess.sh - lib/preprocess.sh reproduces, byte for byte, what
# mk-book.sh produced before the function was extracted.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r ROOT=$TEST_DIR/..
declare -r GOLDEN=$TEST_DIR/golden/preprocess.sha256
declare -i FAILED=0

declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main
#shellcheck source=SCRIPTDIR/../lib/preprocess.sh
source "$ROOT"/lib/preprocess.sh

echo '== preprocess parity =='
[[ -f $GOLDEN ]] || { printf '  ✗ missing golden file %s\n' "$GOLDEN"; exit 1; }

declare -- want file got
while read -r want file; do
  got=$( cd -- "$ROOT" && preprocess "$file" | sha256sum | cut -d' ' -f1 )
  if [[ $got == "$want" ]]; then
    printf '  ✓ %s\n' "$file"
  else
    printf '  ✗ %s: got %s want %s\n' "$file" "${got:0:12}" "${want:0:12}"
    FAILED+=1
  fi
done < "$GOLDEN"

((FAILED == 0)) || exit 1
#fin
