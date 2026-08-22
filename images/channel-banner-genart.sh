#!/bin/bash
# channel-banner-genart.sh - the watercolour behind the YouTube channel banner.
#
# A sibling of the book cover, not a crop of it: a channel banner is cropped to
# 2560x423 on desktop and 1546x423 on mobile, so the art has to be composed as a
# wide band -- terraces along the bottom rising into the visible strip at both
# sides, mist through the middle for the type, empty sky above. The portrait
# cover cannot be cropped into that shape.
#
# Same model and style as defining-dharma-gencover.sh, so the palette matches
# the book. Four candidates were generated and the fourth chosen: it was the
# only one whose terraces reach into the 423px desktop band, which is the crop
# almost every viewer sees. The chosen image, deckle trimmed, is committed as
# images/channel-banner-art.png; video/mk-banner.sh letters it.
#
# Note: gemini-3-pro-image would give native 4K, but the Google project is not
# billing-enabled, so all Gemini models return a zero free-tier quota. Grok's
# 1280x720 output upscales to 2560x1440 cleanly enough under Lanczos -- there
# are no hard edges in a watercolour to smear.
set -euo pipefail

declare -- model=grok-imagine-image-quality

declare -- prompt_banner="Terraced rice fields in early morning mist, seen from a low distant vantage so the horizon sits low in the frame. The terrace walls form a few calm concentric contour lines along the bottom of the image, one tiny distant figure walking a ridge. A wide horizontal band of mist fills the middle of the frame, and the upper half is empty pale sky. The centre of the image is almost entirely mist and negative space. Restrained palette of soft green, grey and pale gold. Serene, spare, mostly empty. No words, no letters, no signs, no borders."

genimage -m "$model" -s watercolor -r 16:9 --num-images 4 -t channel-banner "$prompt_banner"

#fin
