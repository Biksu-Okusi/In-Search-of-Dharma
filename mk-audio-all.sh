#!/bin/bash
set -euo pipefail

declare -- WEBDEST=/var/www/vhosts/garydean.id/html/audio

cd /var/lib/vectordbs/seculardharma/projects/DD

gentts -T -O "$WEBDEST" {0..9}-*.md 

./mk-audiobook.sh -q -g 0 -G audio-assets/dharmic-ai.mp3

rsync -avl "$WEBDEST"/ okusi3:"$WEBDEST"/

#fin
