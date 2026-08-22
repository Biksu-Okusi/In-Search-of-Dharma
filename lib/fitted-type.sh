#!/usr/bin/bash
# fitted-type.sh - set a line of display type to an exact pixel width.
#
# LIBRARY. Source it; do not execute it.
#
# Every lettered surface in this project (the book cover, the playlist
# thumbnail, the channel banner) sizes its type the same way: a line is fitted
# to a target *width* rather than given a point size, so that retitling the book
# re-letters every surface correctly with no layout edits anywhere.
#
# The fit is exact rather than iterative. Tracking is expressed as a fraction of
# the point size, so rendered width is linear in point size: render once at a
# probe size, measure, and the size that lands on the target is
#
#     pt = probe * target / measured
#
# One measurement, no search loop. The measurement is taken with `info:`, which
# reports the rendered width without writing a file -- ImageMagick's `label:`
# has already trimmed to the glyph bounding box by then, so the width is the
# same one a written PNG would report (verified identical).
#
# Configuration, overridable before or after sourcing:
#   FITTYPE_INK   fill colour for the type (default: black)
#
# Usage:
#   source "$SCRIPT_DIR"/../lib/fitted-type.sh
#   FITTYPE_INK='#0b295a'
#   fittype_line "$FONT" 'IN SEARCH OF DHARMA' 0.10 out.png 1560 \
#     || die 1 'could not set the title'
#
# Both functions return non-zero and print to stderr on failure; they never
# exit, so the caller keeps control of its own error handling.

[[ ${BASH_SOURCE[0]} != "$0" ]] || {
  >&2 printf 'Error: %s must be sourced, not executed\n' "${0@Q}"
  exit 1
}

declare -rx LIB_FITTED_TYPE_VERSION=1.0.0

# Caller may set this before sourcing; the default keeps the library usable
# on its own.
: "${FITTYPE_INK:=black}"

# fittype_draw FONT TEXT TRACK POINTSIZE OUT
#
# Render TEXT once at an explicit POINTSIZE. TRACK is letter-spacing as a
# fraction of the point size (0.10 = 10% of the em).
#
# `label:` trims to the glyph bounding box, so the tracking leaves no trailing
# gap to compensate for and the line centres true as rendered.
fittype_draw() {
  local -- font=${1:?} text=${2:?} track=${3:?} out=${5:?}
  local -i pt=${4:?}
  local -- kern
  kern=$(awk -v p="$pt" -v t="$track" 'BEGIN{ printf "%.2f", p * t }') || return 1
  convert -background none -fill "$FITTYPE_INK" \
      -font "$font" -pointsize "$pt" -kerning "$kern" \
      label:"$text" "$out"
}

# fittype_measure FONT TEXT TRACK POINTSIZE -> rendered width in pixels
fittype_measure() {
  local -- font=${1:?} text=${2:?} track=${3:?}
  local -i pt=${4:?}
  local -- kern
  kern=$(awk -v p="$pt" -v t="$track" 'BEGIN{ printf "%.2f", p * t }') || return 1
  convert -background none -fill "$FITTYPE_INK" \
      -font "$font" -pointsize "$pt" -kerning "$kern" \
      label:"$text" -format '%w' info:
}

# fittype_line FONT TEXT TRACK OUT TARGET_WIDTH
#
# Write TEXT to OUT as a transparent PNG whose width is TARGET_WIDTH pixels.
fittype_line() {
  local -- font=${1:?} text=${2:?} track=${3:?} out=${4:?}
  local -i target=${5:?}
  local -i probe=100 pt=0 w=0

  w=$(fittype_measure "$font" "$text" "$track" "$probe") \
    || { >&2 printf 'fitted-type: could not measure %s\n' "${text@Q}"; return 1; }
  ((w > 0)) \
    || { >&2 printf 'fitted-type: %s measured zero-width\n' "${text@Q}"; return 1; }

  pt=$(( probe * target / w ))
  ((pt > 0)) \
    || { >&2 printf 'fitted-type: degenerate point size for %s\n' "${text@Q}"; return 1; }
  fittype_draw "$font" "$text" "$track" "$pt" "$out"
}

# fittype_rule WIDTH OUT [OPACITY_PCT]
#
# A hairline rule in the same ink, held back by default to 55% so it reads as a
# pause and not a divider.
fittype_rule() {
  local -i width=${1:?}
  local -- out=${2:?} opacity=${3:-55}
  convert -size "$width"x1 "xc:$FITTYPE_INK" \
      -alpha set -channel A -evaluate set "$opacity%" +channel "$out"
}

declare -fx fittype_draw fittype_measure fittype_line fittype_rule

#fin
