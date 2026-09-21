#!/usr/bin/env python3
"""Compose a plain-text message to a correspondent, check it, and send it.

Sending is the one step in the correspondence workflow that cannot be taken
back, so the default is a DRY RUN: the message is built, every check is run,
the result is written beside the body as FILE.eml, and nothing leaves. Only
--send hands it to the MTA, and only if every check passed.

Usage:
  mailsend.py --body FILE --reply-to MSGFILE [--attach PATH[=NAME]]... [--send]
  mailsend.py --body FILE --to ADDR --subject TEXT [--attach ...]... [--send]

  --reply-to MSGFILE  the Maildir file being answered, as mailwatch.py and
                      mailshow.py print it. Sets To, Subject and the threading
                      headers, so the reply lands in the correspondent's thread.
  --attach PATH=NAME  attach PATH under the name NAME.
  --allow-md          let a Markdown attachment through (a correspondent may
                      not be able to open one).
  --again             send although an identical message went out before.
  --no-wait           do not wait on the MTA log after sending.

The checks, each of which refuses the send:
  - the body is plain text with something in it, and its opening names the
    sender, so the reader knows at once what is writing to them
  - every recipient is a known correspondent (WHO_REGEX)
  - every attachment exists and is not empty; none is Markdown; the total
    stays under 20MB
  - an attached print interior is newer than everything it is built from,
    and passes mk-print.sh --preflight
  - the finished message parses back with the headers and parts intended
  - the same body has not already gone to the same recipients

Exit status: 0 sent or dry run clean, 1 a check failed, 2 usage or settings.
"""
import argparse
import email
import email.policy
import glob
import hashlib
import os
import re
import subprocess
import sys
import time
from email.message import EmailMessage
from email.utils import formatdate, getaddresses, make_msgid

import mailconf

ROOT = os.path.dirname(mailconf.HERE)
# Beside the settings file, so a fixture's sends never touch the real record.
SENT_LOG = os.path.join(os.path.dirname(mailconf.CONF), '.mailsend.log')
MAX_BYTES = 20 * 1024 * 1024
INTERIOR = re.compile(r'_interior_.*\.pdf$')
# What the print interior is built from. A PDF older than any of these is a
# proof of a book that has since changed.
BUILT_FROM = ('[0-9]-*.md', 'the-better-ones.md', 'mk-print.sh', 'lib/*.sh', 'lib/*.py')
TYPES = {
  '.pdf': ('application', 'pdf'),
  '.docx': ('application', 'vnd.openxmlformats-officedocument.wordprocessingml.document'),
  '.rtf': ('application', 'rtf'),
  '.png': ('image', 'png'),
  '.jpg': ('image', 'jpeg'),
  '.txt': ('text', 'plain'),
}


class Refused(Exception):
  """A check failed. The message must not go."""


def parse_attach(spec):
  path, sep, name = spec.partition('=')
  return path, (name if sep and name else os.path.basename(path))


def check_body(text, sender_name):
  if not text.strip():
    raise Refused('the body is empty')
  if re.search(r'<(html|body|div|p|br)\b', text, re.I):
    raise Refused('the body looks like HTML; messages go as plain text only')
  if sender_name and sender_name.lower() not in text[:600].lower():
    raise Refused(f'the opening does not say the message is from {sender_name}')


def check_recipients(addrs, who):
  if not addrs:
    raise Refused('no recipient')
  for _, addr in addrs:
    if not who.search(addr):
      raise Refused(f'{addr} is not a known correspondent (WHO_REGEX)')


def check_attachments(attachments, allow_md):
  total = 0
  for path, name in attachments:
    if not os.path.isfile(path):
      raise Refused(f'attachment not found: {path}')
    size = os.path.getsize(path)
    if size == 0:
      raise Refused(f'attachment is empty: {path}')
    total += size
    for n in (path, name):
      if n.lower().endswith(('.md', '.markdown')) and not allow_md:
        raise Refused(f'{n} is Markdown, which a correspondent may not be able to open; '
                      'convert it (pandoc -t docx) or pass --allow-md')
    if INTERIOR.search(os.path.basename(path)):
      check_interior(path)
  if total > MAX_BYTES:
    raise Refused(f'attachments total {total // 1024 // 1024}MB, over the 20MB limit')


def check_interior(path):
  """The print interior must be of the book as it now stands, and conform."""
  built = os.path.getmtime(path)
  for pattern in BUILT_FROM:
    for src in glob.glob(os.path.join(ROOT, pattern)):
      if os.path.getmtime(src) > built:
        raise Refused(f'{os.path.basename(path)} is older than {os.path.relpath(src, ROOT)}: '
                      'rebuild with mk-print.sh before sending')
  builder = os.path.join(ROOT, 'mk-print.sh')
  try:
    run = subprocess.run([builder, '--preflight', path], capture_output=True, text=True,
                         timeout=300, check=False)
  except (OSError, subprocess.TimeoutExpired) as e:
    raise Refused(f'preflight could not be run: {e}') from e
  if run.returncode != 0:
    tail = (run.stdout + run.stderr).strip().splitlines()[-3:]
    raise Refused('the interior fails preflight: ' + ' / '.join(tail))


def load_parent(path):
  try:
    with open(path, 'rb') as fh:
      return email.message_from_binary_file(fh, policy=email.policy.default)
  except OSError as e:
    sys.exit(f'✗ cannot read the message being answered: {e}')


def build(conf, args, body, attachments):
  msg = EmailMessage(policy=email.policy.SMTP)
  msg['From'] = conf['SEND_FROM']
  if args.reply_to:
    parent = load_parent(args.reply_to)
    msg['To'] = args.to or str(parent.get('Reply-To') or parent['From'])
    subject = str(parent.get('Subject', '')).strip()
    msg['Subject'] = args.subject or (subject if re.match(r're:', subject, re.I) else f'Re: {subject}')
    parent_id = str(parent.get('Message-ID', '')).strip()
    if not parent_id:
      raise Refused('the message being answered has no Message-ID to thread on')
    msg['In-Reply-To'] = parent_id
    msg['References'] = f"{str(parent.get('References', '')).strip()} {parent_id}".strip()
  else:
    msg['To'] = args.to
    msg['Subject'] = args.subject
  if conf.get('SEND_CC'):
    msg['Cc'] = conf['SEND_CC']
  msg['Date'] = formatdate(localtime=True)
  msg['Message-ID'] = make_msgid(domain=conf['MSGID_DOMAIN'])
  msg.set_content(body, cte='quoted-printable')
  for path, name in attachments:
    maintype, subtype = TYPES.get(os.path.splitext(name)[1].lower(), ('application', 'octet-stream'))
    with open(path, 'rb') as fh:
      msg.add_attachment(fh.read(), maintype=maintype, subtype=subtype, filename=name)
  return msg


def check_roundtrip(msg, attachments):
  back = email.message_from_bytes(msg.as_bytes(), policy=email.policy.default)
  for header in ('From', 'To', 'Subject', 'Date', 'Message-ID'):
    if not back[header]:
      raise Refused(f'the finished message has no {header}')
  names = [p.get_filename() for p in back.walk() if p.get_filename()]
  wanted = [name for _, name in attachments]
  if names != wanted:
    raise Refused(f'attachments came back as {names}, wanted {wanted}')
  kinds = [p.get_content_type() for p in back.walk() if not p.is_multipart() and not p.get_filename()]
  if kinds != ['text/plain']:
    raise Refused(f'the body parts are {kinds}, wanted plain text alone')
  return back


def fingerprint(msg, body):
  rcpts = sorted(a for _, a in getaddresses([str(msg['To'])]))
  return hashlib.sha256(('\n'.join(rcpts) + '\n' + body).encode()).hexdigest()


def check_not_sent(mark):
  if not os.path.exists(SENT_LOG):
    return
  with open(SENT_LOG, encoding='utf-8') as fh:
    for line in fh:
      if line.split('\t')[0] == mark:
        raise Refused(f"this body already went to these recipients ({line.split(chr(9))[1]}); "
                      'pass --again to send it regardless')


def delivery_report(conf, message_id, wait):
  """Follow the message through the MTA log. As far as the relay, no further."""
  log = conf.get('MAIL_LOG', '/var/log/mail.log')
  token = message_id.strip('<>')
  deadline = time.time() + (20 if wait else 0)
  while True:
    lines = []
    try:
      with open(log, encoding='utf-8', errors='replace') as fh:
        lines = fh.readlines()[-4000:]
    except OSError:
      return [f'(cannot read {log}; delivery not confirmed)']
    queue = next((m.group(1) for row in lines if token in row
                  for m in [re.search(r'\b([0-9A-F]{6,}):', row)] if m), None)
    status = [row for row in lines if queue and f'{queue}:' in row and 'status=' in row]
    if status or time.time() >= deadline:
      break
    time.sleep(2)
  if not status:
    return ['(no status in the MTA log yet; check it before assuming delivery)']
  out = []
  for row in status:
    m = re.search(r'to=<([^>]+)>.*?status=(\w+)', row)
    out.append(f'{m.group(1)}: {m.group(2)}' if m else row.strip())
  return out


def main():
  ap = argparse.ArgumentParser(description=__doc__.split('\n\n')[0], add_help=True)
  ap.add_argument('--body', required=True)
  ap.add_argument('--reply-to')
  ap.add_argument('--to')
  ap.add_argument('--subject')
  ap.add_argument('--attach', action='append', default=[])
  ap.add_argument('--send', action='store_true')
  ap.add_argument('--again', action='store_true')
  ap.add_argument('--allow-md', action='store_true')
  ap.add_argument('--no-wait', action='store_true')
  args = ap.parse_args()
  if not args.reply_to and not (args.to and args.subject):
    ap.error('give --reply-to MSGFILE, or both --to and --subject')

  conf = mailconf.load()
  missing = [k for k in ('SEND_FROM', 'SEND_ENVELOPE', 'MSGID_DOMAIN') if not conf.get(k)]
  if missing:
    sys.exit(f"✗ {mailconf.CONF}: missing {', '.join(missing)}")
  try:
    with open(args.body, encoding='utf-8') as fh:
      body = fh.read()
  except OSError as e:
    sys.exit(f'✗ cannot read the body: {e}')
  attachments = [parse_attach(a) for a in args.attach]
  sender_name = getaddresses([conf['SEND_FROM']])[0][0]

  try:
    check_body(body, sender_name)
    check_attachments(attachments, args.allow_md)
    msg = build(conf, args, body, attachments)
    check_recipients(getaddresses([str(msg['To'])]), re.compile(conf['WHO_REGEX'], re.I))
    back = check_roundtrip(msg, attachments)
    mark = fingerprint(msg, body)
    if not args.again:
      check_not_sent(mark)
  except Refused as e:
    print(f'✗ refused: {e}', file=sys.stderr)
    return 1

  eml = args.body + '.eml'
  with open(eml, 'wb') as fh:
    fh.write(msg.as_bytes())
  for header in ('From', 'To', 'Cc', 'Subject', 'In-Reply-To'):
    if back[header]:
      print(f'{header + ":":13}{back[header]}')
  print(f"{'Attached:':13}{[n for _, n in attachments] or 'nothing'}")
  print(f"{'Body:':13}{len(body.split())} words, plain text")
  print(f"{'Written:':13}{eml} ({os.path.getsize(eml)} bytes)")
  if not args.send:
    print('✓ every check passed. DRY RUN: nothing was sent. Pass --send to send it.')
    return 0

  sendmail = conf.get('SENDMAIL', '/usr/sbin/sendmail')
  try:
    run = subprocess.run([sendmail, '-t', '-oi', '-f', conf['SEND_ENVELOPE']],
                         input=msg.as_bytes(), capture_output=True, timeout=120, check=False)
  except (OSError, subprocess.TimeoutExpired) as e:
    print(f'✗ could not hand the message to {sendmail}: {e}', file=sys.stderr)
    return 1
  if run.returncode != 0:
    print(f'✗ {sendmail} refused it: {run.stderr.decode(errors="replace").strip()}', file=sys.stderr)
    return 1
  with open(SENT_LOG, 'a', encoding='utf-8') as fh:
    fh.write(f"{mark}\t{formatdate(localtime=True)}\t{msg['To']}\t{msg['Subject']}\t{msg['Message-ID']}\n")
  print('✓ handed to the MTA')
  for line in delivery_report(conf, str(msg['Message-ID']), not args.no_wait):
    print(f'  {line}')
  print('  Delivery is confirmed only as far as the relay; a bounce returns to the envelope sender.')
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
