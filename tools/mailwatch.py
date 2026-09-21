#!/usr/bin/env python3
"""Report correspondence about the book that has not been seen before.

Watches the Inbox, the configured folders, and Sent -- Sent only when the mail
is addressed to a correspondent. Read-only: nothing is ever moved out of new/,
so nothing is marked read. What has been seen is remembered by each message's
Maildir unique name, the part before ":2,", which survives both the move from
new/ to cur/ and any change of flags.

Usage:
  mailwatch.py --seed   record everything present now, print nothing
  mailwatch.py          print one NEW line per unseen message, then record it

Silence means no news. Settings come from tools/mail.conf (see mailconf.py).
"""
import email
import email.policy
import glob
import os
import re
import sys
import time
from email.utils import parsedate_to_datetime

import mailconf

STATE = os.path.join(mailconf.HERE, '.mailwatch.seen')
# Only files this recent are opened: a Sent folder can hold many thousands.
WINDOW = 14 * 86400


def uniq(path):
  return os.path.basename(path).split(':2,')[0]


def main():
  conf = mailconf.load()
  who = re.compile(conf['WHO_REGEX'], re.I)
  topic = re.compile(conf['TOPIC_REGEX'], re.I)
  seed = '--seed' in sys.argv[1:]
  seen = set()
  if os.path.exists(STATE):
    with open(STATE, encoding='utf-8') as fh:
      seen = set(fh.read().split())
  cut = time.time() - WINDOW
  fresh = []
  for folder, label in mailconf.folders(conf).items():
    for path in glob.glob(conf['MAIL_BASE'] + folder + '/*'):
      name = uniq(path)
      try:
        if name in seen or os.path.getmtime(path) < cut:
          continue
        with open(path, 'rb') as fh:
          msg = email.message_from_binary_file(fh, policy=email.policy.default)
      except OSError:
        continue                      # delivered-and-moved between glob and open
      sender = str(msg.get('From', ''))
      rcpt = ' '.join(str(msg.get(h, '')) for h in ('To', 'Cc'))
      subject = str(msg.get('Subject', ''))
      if label == 'Sent':
        hit = who.search(rcpt)
      else:
        hit = who.search(sender + rcpt) or topic.search(subject)
      seen.add(name)
      if not hit or seed:
        continue
      try:
        when = parsedate_to_datetime(msg['Date'])
      except (TypeError, ValueError):
        when = None
      files = [p.get_filename() for p in msg.walk() if p.get_filename()]
      fresh.append((when, label, sender, subject, files, path))
  with open(STATE, 'w', encoding='utf-8') as fh:
    fh.write('\n'.join(sorted(seen)) + '\n')
  for when, label, sender, subject, files, path in sorted(
      fresh, key=lambda r: (r[0] is None, r[0])):
    stamp = f'{when:%Y-%m-%d %H:%M %z}' if when else 'undated'
    print(f'NEW [{label}] {stamp} | {sender} | {subject} | attachments={files} | {path}')
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
