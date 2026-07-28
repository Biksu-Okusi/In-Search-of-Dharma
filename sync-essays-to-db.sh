#!/bin/bash
# Sync the In Search of Dharma essay files (0..9) into the `content`
# field of the matching essays rows — first in the local dev database,
# then (if dev succeeds) in the production database on the remote host.
#
# Mapping: <N>-<slug>.md  ->  url '<N>-in-search-of-dharma'
# The YAML frontmatter block and the leading H1 header are stripped;
# stored content begins at the first real body line.
#
# ⚠ Must be run from the dev machine named in deploy.conf. Production
#   data.db is updated in place via the remote launcher — it is excluded
#   from the file sync because it contains live runtime tables.
set -euo pipefail
shopt -s inherit_errexit nullglob
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION='1.3.0'
declare -- SCRIPT_DIR
SCRIPT_DIR=$(dirname -- "$(realpath -- "$0")")
readonly -- SCRIPT_DIR

# Host identities live in an untracked deploy.conf (copy deploy.conf.example)
# so no machine name is published with the source. Without it the script stops
# at the dev-machine check rather than guessing at a target.
if [[ -r $SCRIPT_DIR/deploy.conf ]]; then
  #shellcheck source=/dev/null
  source "$SCRIPT_DIR"/deploy.conf
fi
declare -r DEV_HOST=${DEV_HOST:-}
declare -r PROD_CMD=${PROD_CMD:-}
declare -r PROD_DB=${PROD_DB:-'/var/www/vhosts/garydean.id/data.db'}
declare -r URL_GLOB='[0-9]-in-search-of-dharma'
declare -ri REMOTE_TIMEOUT=120

# Research-note links. Each essay's "Sources & further reading" section links its
# notes by repo-relative path, which on the web resolves against /works/ and 404s.
# Rewritten to absolute GitHub URLs on the way into the database; the notes are
# all tracked, so every generated URL is live. main (not a tag) is deliberate:
# note IDs and filenames are stable, and readers should see current corrections.
declare -r REPO_BLOB='https://github.com/GaryDean/defining-dharma/blob/main'

declare -i DRY_RUN=1 DEV_ONLY=0
declare -- DB=''
declare -- TMPDIR_LOCAL='' TMPDIR_REMOTE=''

# Messaging
#bcscheck disable=BCS0806 # -v/-q intentionally omitted — K.I.S.S.
info()    { >&2 echo "◉ $*"; }
success() { >&2 echo "✓ $*"; }
error()   { >&2 echo "✗ $*"; }
die() { local -i ec=${1:-1}; shift; (($#)) && error "$@" ||:; exit "$ec"; }

usage() {
  cat <<USAGE
Usage: ${0##*/} [OPTIONS] [dev_database]

Copy essay files 0..9 into essays.content of the dev database
(default: $SCRIPT_DIR/www/data.db), then into production
($PROD_CMD:$PROD_DB) once the dev update has succeeded.

  -n, --dry-run       Trial run, no changes (default)
  -N, --not-dry-run   Execute the actual updates
      --dev-only      Update the dev database only; skip production
  -V, --version       Print version
  -h, --help          This help
USAGE
  exit "${1:-0}"
}

cleanup() {
  local -i ec=${1:-$?}
  trap - SIGINT SIGTERM EXIT
  [[ -n $TMPDIR_LOCAL ]] && rm -rf -- "$TMPDIR_LOCAL" ||:
  [[ -n $TMPDIR_REMOTE ]] && timeout "$REMOTE_TIMEOUT" "$PROD_CMD" "rm -rf -- '$TMPDIR_REMOTE'" ||:
  exit "$ec"
}

# Strip YAML frontmatter and the leading H1, rewrite research-note links to
# absolute GitHub URLs, then print the body. The optional "../" prefix is
# captured and discarded so both editions would yield the same URL; anchoring on
# the leading digit scopes the rule to the eight category directories, and
# excluding ":" from the path stops an already-absolute link being prefixed twice.
clean_essay() {
  local -- file=$1
  awk '
    NR==1 { if ($0=="---") { fm=1; next } fm=2 }
    fm==1 { if ($0=="---") fm=2; next }
    !body {
      if ($0 ~ /^[[:space:]]*$/) next
      if ($0 ~ /^# /) next
      body=1
    }
    { print }
  ' "$file" \
    | sed -E "s#\]\((\.\./)?([0-9]-[^):]*\.md)\)#]($REPO_BLOB/\2)#g"
}

essay_lengths() {  # $1 = sql source: 'dev' | 'prod'
  local -r sql="SELECT url, length(content) FROM essays WHERE url GLOB '$URL_GLOB' ORDER BY url;"
  if [[ $1 == dev ]]; then
    sqlite3 -- "$DB" "$sql"
  else
    echo "$sql" | timeout "$REMOTE_TIMEOUT" "$PROD_CMD" "sqlite3 '$PROD_DB'"
  fi
}

main() {
  local -- arg
  while (($#)); do
    arg=$1
    case $arg in
      -n|--dry-run)     DRY_RUN=1 ;;
      -N|--not-dry-run) DRY_RUN=0 ;;
      --dev-only)       DEV_ONLY=1 ;;
      -V|--version)     echo "${0##*/} $VERSION"; exit 0 ;;
      -h|--help)        usage 0 ;;
      -[nNVh]?*)        set -- "${arg:0:2}" "-${arg:2}" "${@:2}"; continue ;;
      -*)               error "Unknown option: ${arg@Q}"; usage 2 ;;
      *)                DB="$arg" ;;
    esac
    shift
  done
  [[ -n $DB ]] || DB="$SCRIPT_DIR/www/data.db"
  readonly -- DB DRY_RUN DEV_ONLY

  [[ -n $DEV_HOST ]] \
    || die 2 'DEV_HOST unset: create deploy.conf (see deploy.conf.example)'
  [[ $HOSTNAME == "$DEV_HOST" ]] \
    || die 1 "Must be run from the dev machine (host '$DEV_HOST'), not '$HOSTNAME'"
  command -v sqlite3 >/dev/null || die 18 'sqlite3 not installed'
  if ((!DEV_ONLY)); then
    [[ -n $PROD_CMD ]] \
      || die 2 'PROD_CMD unset: create deploy.conf (see deploy.conf.example)'
    command -v "$PROD_CMD" >/dev/null || die 18 "'$PROD_CMD' launcher not found"
  fi
  [[ -f $DB ]] || die 3 "Dev database not found: $DB"

  trap 'cleanup $?' SIGINT SIGTERM EXIT
  TMPDIR_LOCAL=$(mktemp -d) || die 1 'Failed to create local temp dir'

  # Clean essays locally
  local -i n bytes
  local -a files
  local -- prefix=''
  ((DRY_RUN)) && prefix='[DRY-RUN] ' ||:
  for n in {0..9}; do
    files=( "$SCRIPT_DIR/$n"-*.md )
    ((${#files[@]} == 1)) \
      || die 1 "Essay $n: expected exactly 1 file matching '$n-*.md', found ${#files[@]}"
    clean_essay "${files[0]}" > "$TMPDIR_LOCAL/$n.md" \
      || die 1 "Essay $n: failed to clean ${files[0]##*/}"
    bytes=$(stat -c %s "$TMPDIR_LOCAL/$n.md") \
      || die 1 "Essay $n: stat failed on cleaned file"
    ((bytes > 0)) || die 1 "Essay $n: cleaned content is empty (${files[0]##*/})"
    info "$prefix$n-in-search-of-dharma <- ${files[0]##*/} ($bytes bytes)"
  done

  if ((DRY_RUN)); then
    info "${prefix}Would update dev: $DB"
    ((DEV_ONLY)) || info "${prefix}Would update prod: $PROD_CMD:$PROD_DB"
    info 'Dry run only — no database modified. Use -N to execute.'
    return 0
  fi

  # Update dev database
  local -- changes
  for n in {0..9}; do
    changes=$(sqlite3 -- "$DB" \
      "UPDATE essays SET content = CAST(readfile('$TMPDIR_LOCAL/$n.md') AS TEXT)
       WHERE url = '$n-in-search-of-dharma';
       SELECT changes();") || die 1 "sqlite3 failed updating dev row $n"
    [[ $changes == 1 ]] || die 1 "Essay $n: no row with url '$n-in-search-of-dharma' in $DB"
  done
  success "Dev database updated: $DB"

  if ((DEV_ONLY)); then
    info '--dev-only: skipping production update.'
    return 0
  fi

  # Update production
  TMPDIR_REMOTE=$(timeout "$REMOTE_TIMEOUT" "$PROD_CMD" 'mktemp -d') \
    || die 1 'Failed to create remote temp dir'
  [[ -n $TMPDIR_REMOTE ]] || die 1 'Remote temp dir path is empty'
  tar -czf - -C "$TMPDIR_LOCAL" . \
      | timeout "$REMOTE_TIMEOUT" "$PROD_CMD" "tar -xzf - -C '$TMPDIR_REMOTE'" \
    || die 1 "Remote file transfer to $PROD_CMD failed"

  {
    echo '.bail on'
    echo 'BEGIN;'
    for n in {0..9}; do
      echo "UPDATE essays SET content = CAST(readfile('$TMPDIR_REMOTE/$n.md') AS TEXT)"
      echo "  WHERE url = '$n-in-search-of-dharma';"
    done
    echo 'COMMIT;'
  } | timeout "$REMOTE_TIMEOUT" "$PROD_CMD" "sqlite3 '$PROD_DB'" \
    || die 1 'Production update failed — transaction rolled back'

  # Verify production
  if diff <(essay_lengths dev) <(essay_lengths prod) >/dev/null; then
    success "Production database updated and verified: $PROD_CMD:$PROD_DB"
  else
    error 'Verification failed — prod essay lengths differ from dev:'
    diff <(essay_lengths dev) <(essay_lengths prod) >&2 ||:
    die 1
  fi
  return 0
}

main "$@"
#fin
