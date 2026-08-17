#!/bin/bash
# mk-audio-all.sh - regenerate the chapter narrations (gentts over each part's
# audio: frontmatter), rebuild the audiobook, and mirror the web-root audio
# directory to the remote host.
set -euo pipefail

#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*}

declare -r WEBDEST=/var/www/vhosts/garydean.id/html/audio

# The remote mirror target comes from the untracked deploy.conf (copy
# deploy.conf.example), so no machine name is published with the source.
# Unset, the mirror step is skipped and the MP3s stay on this host.
if [[ -r $SCRIPT_DIR/deploy.conf ]]; then
  #shellcheck source=/dev/null
  source "$SCRIPT_DIR"/deploy.conf
fi
declare -r DEPLOY_HOST=${DEPLOY_HOST:-}

cd "$SCRIPT_DIR"

gentts -T -O "$WEBDEST" {0..9}-*.md

./mk-audiobook.sh -q -g 0 -G audio-assets/dharmic-ai.mp3

if [[ -n $DEPLOY_HOST ]]; then
  rsync -avl "$WEBDEST"/ "$DEPLOY_HOST":"$WEBDEST"/
else
  echo '◉ remote mirror skipped: DEPLOY_HOST unset (see deploy.conf.example)'
fi

#fin
