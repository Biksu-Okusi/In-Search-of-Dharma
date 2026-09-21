#!/usr/bin/env python3
"""Shared configuration for the correspondence tools.

Where the mail lives and whose mail counts are facts about one person's
mailbox, and this repository is public. So they are read from tools/mail.conf,
which is never tracked; tools/mail.conf.example shows the shape.

  MAIL_BASE      the account's Maildir root
  MAIL_FOLDERS   extra Maildir folders to watch, space-separated (".name" form)
  SENT_FOLDER    the Sent folder; watched only for mail TO a correspondent
  WHO_REGEX      matches a correspondent in From/To/Cc
  TOPIC_REGEX    matches a relevant Subject from anyone

mailsend.py needs three more, and may take two optional ones:

  SEND_FROM      the From header, e.g. Name <user@example.org>
  SEND_ENVELOPE  the envelope sender address, where a bounce returns
  MSGID_DOMAIN   the domain part of generated Message-IDs
  SEND_CC        optional: copied on everything sent
  SENDMAIL       optional: the sendmail binary (default /usr/sbin/sendmail)
  MAIL_LOG       optional: the MTA log read after sending (default /var/log/mail.log)

MAIL_CONF in the environment names a different settings file, which is how the
test suite runs these tools against a fixture instead of a real mailbox.
"""
import os
import sys

HERE = os.path.dirname(os.path.abspath(__file__))
CONF = os.environ.get('MAIL_CONF') or os.path.join(HERE, 'mail.conf')
REQUIRED = ('MAIL_BASE', 'MAIL_FOLDERS', 'SENT_FOLDER', 'WHO_REGEX', 'TOPIC_REGEX')


def load():
  """Return the settings as a dict, or exit naming what is missing."""
  if not os.path.isfile(CONF):
    sys.exit(f'✗ {CONF} not found: copy mail.conf.example to mail.conf and fill it in')
  conf = {}
  with open(CONF, encoding='utf-8') as fh:
    for n, line in enumerate(fh, 1):
      line = line.strip()
      if not line or line.startswith('#'):
        continue
      key, sep, value = line.partition('=')
      if not sep:
        sys.exit(f'✗ {CONF}:{n}: expected KEY=VALUE')
      conf[key.strip()] = value.strip().strip('"\'')
  missing = [k for k in REQUIRED if not conf.get(k)]
  if missing:
    sys.exit(f"✗ {CONF}: missing {', '.join(missing)}")
  conf['MAIL_BASE'] = conf['MAIL_BASE'].rstrip('/') + '/'
  if not os.path.isdir(conf['MAIL_BASE']):
    sys.exit(f"✗ MAIL_BASE is not a directory: {conf['MAIL_BASE']}")
  return conf


def folders(conf):
  """Map each Maildir subdirectory to watch onto a label: inbox, sent or the folder name."""
  out = {'cur': 'Inbox', 'new': 'Inbox'}
  for name in conf['MAIL_FOLDERS'].split():
    for sub in ('cur', 'new'):
      out[f'{name}/{sub}'] = name.lstrip('.')
  for sub in ('cur', 'new'):
    out[f"{conf['SENT_FOLDER']}/{sub}"] = 'Sent'
  return out
#fin
