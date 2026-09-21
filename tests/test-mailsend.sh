#!/bin/bash
# tests/test-mailsend.sh - tools/mailsend.py refuses what it should, threads a
# reply, and sends only when told to. Runs against a fixture mailbox with a
# stub standing in for sendmail, so no mail ever leaves.
set -euo pipefail
shopt -s inherit_errexit

declare -r TEST_DIR=${BASH_SOURCE[0]%/*}
declare -r SEND=$TEST_DIR/../tools/mailsend.py
declare -i FAILED=0
declare -- TMP=''

trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT
TMP=$(mktemp -d)

echo '== mail send =='

mkdir -p "$TMP"/box/cur "$TMP"/box/new "$TMP"/box/.Sent/cur
cat >"$TMP"/box/cur/1.host:2,S <<'MSG'
From: Pat Publisher <pat@publisher.example>
To: author@example.org
Subject: proof notes
Message-ID: <parent-1@publisher.example>
References: <root-0@publisher.example>
Date: Mon, 21 Sep 2026 09:59:00 +1200

Please fix the logo.
MSG

# The stub records what it was given instead of sending it.
cat >"$TMP"/sendmail <<STUB
#!/bin/bash
cat >"$TMP"/outbox.eml
printf '%s\n' "\$*" >"$TMP"/outbox.args
STUB
chmod +x "$TMP"/sendmail

cat >"$TMP"/mail.conf <<CONF
MAIL_BASE=$TMP/box/
MAIL_FOLDERS=.none
SENT_FOLDER=.Sent
WHO_REGEX=publisher\.example
TOPIC_REGEX=proof
SEND_FROM=BookBot <author@example.org>
SEND_ENVELOPE=author@example.org
MSGID_DOMAIN=example.org
SEND_CC=author@example.org
SENDMAIL=$TMP/sendmail
MAIL_LOG=$TMP/no-such-log
CONF
export MAIL_CONF=$TMP/mail.conf

printf 'Hello Pat\n\nThis message is from BookBot, the agent working on the book.\n\nThe logo is fixed.\n' >"$TMP"/body.txt
printf 'Hello Pat\n\nThe logo is fixed.\n' >"$TMP"/anon.txt
: >"$TMP"/empty.txt
printf 'notes\n' >"$TMP"/notes.md
printf 'doc\n' >"$TMP"/notes.docx
printf '%%PDF-1.4 stale\n' >"$TMP"/Book_interior_152x229.pdf
touch -d '2000-01-01' "$TMP"/Book_interior_152x229.pdf

declare -r PARENT=$TMP/box/cur/1.host:2,S

# refuses <name> <expected message fragment> <mailsend args...>
refuses() {
  local -- name=$1 want=$2 err
  shift 2
  if err=$("$SEND" "$@" 2>&1 >/dev/null); then
    printf '  ✗ %s: was not refused\n' "$name"; FAILED+=1
  elif [[ $err == *"$want"* ]]; then
    printf '  ✓ %s\n' "$name"
  else
    printf '  ✗ %s: refused, but said: %s\n' "$name" "$err"; FAILED+=1
  fi
  if [[ -e $TMP/outbox.eml ]]; then
    printf '  ✗ %s: the message reached sendmail anyway\n' "$name"; FAILED+=1
    rm -f -- "$TMP"/outbox.eml
  fi
}

# ok <name> <condition command...>
ok() {
  local -- name=$1
  shift
  if "$@"; then printf '  ✓ %s\n' "$name"; else printf '  ✗ %s\n' "$name"; FAILED+=1; fi
}

refuses 'an empty body'                 'body is empty' \
  --body "$TMP"/empty.txt --reply-to "$PARENT" --send
refuses 'a body that does not say who is writing' 'does not say the message is from BookBot' \
  --body "$TMP"/anon.txt --reply-to "$PARENT" --send
refuses 'a recipient who is not a correspondent' 'not a known correspondent' \
  --body "$TMP"/body.txt --to stranger@elsewhere.example --subject hello --send
refuses 'a Markdown attachment'         'is Markdown' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/notes.md --send
refuses 'a Markdown name on another file' 'is Markdown' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/notes.docx=notes.md --send
refuses 'a missing attachment'          'attachment not found' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/nowhere.pdf --send
refuses 'an empty attachment'           'attachment is empty' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/empty.txt --send
refuses 'a print interior older than its sources' 'rebuild with mk-print.sh' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/Book_interior_152x229.pdf --send

# A dry run passes every check and still sends nothing.
declare -- out
out=$("$SEND" --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/notes.docx='cover text.docx')
ok 'a dry run says so'            grep -q 'DRY RUN: nothing was sent' <<<"$out"
ok 'a dry run sends nothing'      test ! -e "$TMP"/outbox.eml
ok 'a dry run writes the .eml'    test -s "$TMP"/body.txt.eml

# The real thing, into the stub.
"$SEND" --body "$TMP"/body.txt --reply-to "$PARENT" \
  --attach "$TMP"/notes.docx='cover text.docx' --send --no-wait >/dev/null
ok 'sending reaches sendmail'     test -s "$TMP"/outbox.eml
ok 'the envelope sender is set'   grep -q -- '-f author@example.org' "$TMP"/outbox.args
ok 'To is the parent'"'"'s sender' grep -q '^To: Pat Publisher <pat@publisher.example>' "$TMP"/outbox.eml
ok 'the subject gains Re:'        grep -q '^Subject: Re: proof notes' "$TMP"/outbox.eml
ok 'In-Reply-To threads it'       grep -q '^In-Reply-To: <parent-1@publisher.example>' "$TMP"/outbox.eml
ok 'References carries the chain' grep -q '^References: <root-0@publisher.example> <parent-1@publisher.example>' "$TMP"/outbox.eml
ok 'the author is copied'         grep -q '^Cc: author@example.org' "$TMP"/outbox.eml
ok 'the attachment is renamed'    grep -q 'filename="cover text.docx"' "$TMP"/outbox.eml
ok 'there is no HTML part'        bash -c "! grep -qi 'text/html' '$TMP/outbox.eml'"

rm -f -- "$TMP"/outbox.eml
refuses 'the same message a second time' 'already went to these recipients' \
  --body "$TMP"/body.txt --reply-to "$PARENT" --attach "$TMP"/notes.docx='cover text.docx' --send
"$SEND" --body "$TMP"/body.txt --reply-to "$PARENT" --send --again --no-wait >/dev/null
ok '--again overrides that'       test -s "$TMP"/outbox.eml

((FAILED == 0)) || exit 1
exit 0
#fin
