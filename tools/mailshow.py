#!/usr/bin/env python3
"""Print correspondence by subject, oldest first, with the quoted tail trimmed.

Read-only, like mailwatch.py. Folders are given relative to MAIL_BASE, in
Maildir form; "inbox" stands for the account's own cur/ and new/.

Usage:
  mailshow.py FOLDER... -- SUBJECT_REGEX [MM-DD ...]
  mailshow.py --save DIR FOLDER... -- SUBJECT_REGEX [MM-DD ...]

  mailshow.py .publisher/new -- 'typographic specs' 09-21
  mailshow.py --save /tmp/att inbox .Sent/cur -- 'cover text'

--save writes every image attachment of the matching messages into DIR, which
is how a marked-up screenshot gets looked at.
"""
import email
import email.policy
import glob
import os
import re
import sys
from email.utils import parsedate_to_datetime

import mailconf

QUOTED_TAIL = re.compile(r'\n(?:>? ?On .{10,80}wrote:|Begin forwarded message:)')


def main():
  args = sys.argv[1:]
  save = None
  if args[:1] == ['--save']:
    if len(args) < 2:
      sys.exit('✗ --save needs a directory')
    save, args = args[1], args[2:]
  if '--' not in args or args.index('--') == len(args) - 1:
    sys.exit(__doc__.strip())
  cut = args.index('--')
  wanted, pattern, days = args[:cut], args[cut + 1], args[cut + 2:]
  conf = mailconf.load()
  paths = []
  for folder in wanted:
    subs = ('cur', 'new') if folder == 'inbox' else (folder,)
    for sub in subs:
      paths += glob.glob(conf['MAIL_BASE'] + sub + '/*')
  hits = []
  for path in paths:
    try:
      with open(path, 'rb') as fh:
        msg = email.message_from_binary_file(fh, policy=email.policy.default)
      when = parsedate_to_datetime(msg['Date'])
    except (OSError, TypeError, ValueError):
      continue
    if not re.search(pattern, str(msg.get('Subject', '')), re.I):
      continue
    if days and f'{when:%m-%d}' not in days:
      continue
    hits.append((when, path, msg))
  if save:
    os.makedirs(save, exist_ok=True)
  for when, path, msg in sorted(hits, key=lambda h: h[0]):
    print('=' * 78)
    print(f"{when:%Y-%m-%d %H:%M %z} | {msg['From']}\nSubject: {msg['Subject']}\n{path}")
    print('=' * 78)
    body = msg.get_body(preferencelist=('plain', 'html'))
    text = body.get_content() if body else ''
    if body is not None and body.get_content_type() == 'text/html':
      text = re.sub(r'<[^>]+>', '', text)
    print(QUOTED_TAIL.split(text)[0].strip())
    files = [p.get_filename() for p in msg.walk() if p.get_filename()]
    print(f'\n[attachments] {files}')
    if not save:
      continue
    for n, part in enumerate(msg.walk()):
      if part.get_content_maintype() != 'image' or not part.get_filename():
        continue
      safe = re.sub(r'[^A-Za-z0-9._-]+', '_', part.get_filename())
      out = os.path.join(save, f'{when:%m%d-%H%M}-{n}-{safe}')
      with open(out, 'wb') as fh:
        fh.write(part.get_payload(decode=True))
      print(f'[saved] {out}')
  return 0


if __name__ == '__main__':
  sys.exit(main())
#fin
