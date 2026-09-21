#!/bin/bash
# tests/test-mailwatch.sh - tools/mailwatch.py reports a message once, and goes
# on recognising it however the server renames the file afterwards.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r WATCH=$TEST_DIR/../tools/mailwatch.py
declare -i FAILED=0
declare -- TMP='' OUT=''

trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== mail watch =='

mkdir -p "$TMP"/box/{cur,new} "$TMP"/box/.pub/{cur,new} "$TMP"/box/.Sent/{cur,new}
cat >"$TMP"/mail.conf <<CONF
MAIL_BASE=$TMP/box/
MAIL_FOLDERS=.pub
SENT_FOLDER=.Sent
WHO_REGEX=publisher\.example
TOPIC_REGEX=the book
CONF
export MAIL_CONF=$TMP/mail.conf

# deliver <path> <from> <to> <subject>
deliver() {
  printf 'From: %s\nTo: %s\nSubject: %s\nDate: Mon, 21 Sep 2026 10:00:00 +1200\n\nbody\n' \
    "$2" "$3" "$4" >"$1"
}

# expect <name> <count> : the watcher's next run reports exactly <count> messages
expect() {
  local -- name=$1
  local -i want=$2 got
  OUT=$("$WATCH")
  got=$(grep -c '^NEW ' <<<"$OUT" || true)
  if ((got == want)); then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s: reported %d, wanted %d\n%s\n' "$name" "$got" "$want" "$OUT"; FAILED+=1
  fi
}

deliver "$TMP"/box/.pub/new/100.M1P1.host 'pat@publisher.example' 'author@example.org' 'notes'
expect 'a new message is reported'                  1
expect 'and only once'                              0

mv -- "$TMP"/box/.pub/new/100.M1P1.host "$TMP/box/.pub/cur/100.M1P1.host,S=90,W=95:2,"
expect 'moving it from new/ to cur/ is not news'    0
mv -- "$TMP/box/.pub/cur/100.M1P1.host,S=90,W=95:2," "$TMP/box/.pub/cur/100.M1P1.host,S=90,W=95:2,RS"
expect 'nor is reading and answering it'            0
# Dovecot appends ",U=<uid>" INSIDE the name once it assigns an IMAP UID.
mv -- "$TMP/box/.pub/cur/100.M1P1.host,S=90,W=95:2,RS" "$TMP/box/.pub/cur/100.M1P1.host,S=90,W=95,U=7:2,RS"
expect 'nor is the server adding a key to the name' 0

deliver "$TMP"/box/new/101.M1P1.host 'someone@elsewhere.example' 'author@example.org' 'lunch?'
expect 'unrelated inbox mail is ignored'            0
deliver "$TMP"/box/new/102.M1P1.host 'someone@elsewhere.example' 'author@example.org' 'about the book'
expect 'a relevant subject from anyone is reported' 1

deliver "$TMP"/box/.Sent/cur/103.M1P1.host 'author@example.org' 'friend@elsewhere.example' 'the book'
expect 'sent mail to a non-correspondent is ignored' 0
deliver "$TMP"/box/.Sent/cur/104.M1P1.host 'author@example.org' 'pat@publisher.example' 're: notes'
expect 'sent mail to a correspondent is reported'   1

if [[ -e $TMP/box/new/102.M1P1.host ]]; then
  printf '  ✓ nothing was moved out of new/\n'
else
  printf '  ✗ a message was moved out of new/\n'; FAILED+=1
fi

((FAILED == 0)) || exit 1
exit 0
#fin
