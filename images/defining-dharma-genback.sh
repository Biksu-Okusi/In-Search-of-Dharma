#!/bin/bash
# defining-dharma-genback.sh - lay the back-cover blurb over the back art.
#
# Reads images/defining-dharma-back.png (the watercolour, no type) and the
# blurb from BACKCOVER_In-Search-of-Dharma.md, and writes
# images/defining-dharma-back-text.png (the same art, lettered).
#
# The blurb file is the single source of truth: paragraphs are parsed out of
# the Markdown, *emphasis* becomes italic type, and " -- " is set as an em
# dash, so editing the blurb re-letters the back cover with no edits here.
#
# The type matches the front cover and the interior: EB Garamond throughout,
# in the same navy, with the title line fitted to a target width exactly as
# defining-dharma-gentitle.sh fits the front. Body paragraphs are set with
# pango, which wraps and justifies and honours the italic spans.
set -euo pipefail
shopt -s inherit_errexit

#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}
declare -r PROJECT_DIR=${SCRIPT_DIR%/*}

declare -r BLURB="$PROJECT_DIR"/BACKCOVER_In-Search-of-Dharma.md
declare -r BACK_IN="$SCRIPT_DIR"/defining-dharma-back.png
declare -r BACK_OUT="$SCRIPT_DIR"/defining-dharma-back-text.png

# The book's navy, as used for links in the EPUB and PDF stylesheets and for
# the front-cover type (defining-dharma-gentitle.sh).
declare -r INK='#0b295a'

# Fontconfig descriptions; pango resolves these against the same EB Garamond
# files the front cover uses.
declare -r FACE='EB Garamond 12'

# Layout on the 864x1152 back, in pixels. The title is fitted to TITLE_WIDTH;
# body paragraphs wrap inside TEXT_WIDTH; the bio is anchored to the foot.
declare -ri TITLE_WIDTH=380 TITLE_TOP=84
declare -ri RULE_WIDTH=104 RULE_GAP=26 RULE_UNDER=34
declare -ri TEXT_WIDTH=672 BLOCK_GAP=28
declare -ri BIO_FOOT=64

# Body and bio point sizes (pango font sizes; iterate these for fit).
declare -ri BODY_PT=19 BIO_PT=16

# Title tracking, in pango letter-spacing units per point of type
# (1024 units = 1pt; 123 = 0.12pt of tracking per point, as on the front).
declare -ri TRACK_TITLE=123

declare -- TMP=''

die() {
  local -i code=${1:-1}
  (($# < 2)) || >&2 printf '%s: error: %s\n' "$SCRIPT_NAME" "${*:2}"
  exit "$code"
}
cleanup() { [[ -z $TMP ]] || rm -rf -- "$TMP"; }

# Turn one Markdown paragraph into pango markup: escape, then *x* -> <i>x</i>,
# then " -- " -> an em dash. Escaping first keeps the asterisks intact.
markup() {
  local -- text="${1:?}"
  text=${text//&/&amp;}
  text=${text//</&lt;}
  text=${text//>/&gt;}
  while [[ $text =~ ^(.*)\*([^*]+)\*(.*)$ ]]; do
    text="${BASH_REMATCH[1]}<i>${BASH_REMATCH[2]}</i>${BASH_REMATCH[3]}"
  done
  text=${text// -- / — }
  text=${text//\'/’}
  printf '%s' "$text"
}

# A soft white glow copy of a rendered block, laid under the ink so the type
# stays legible where the art runs dark, without boxing the watercolour.
halo() {
  local -- src="${1:?}" out="${2:?}"
  convert "$src" -fill white -colorize 100 \
      -channel A -blur 0x5 -evaluate multiply 2.2 +channel \
      "$out" \
    || die 1 "halo render failed for ${src##*/}"
}

# Render a wrapped, justified block of pango markup to a transparent PNG.
render_block() {
  local -- text="${1:?}" out="${2:?}"
  local -i pt="${3:?}" width="${4:?}"
  convert -background none \
      -define pango:wrap=word -define pango:justify=true \
      -size "${width}x" \
      pango:"<span foreground='$INK' font='$FACE $pt'>$text</span>" \
      "$out" \
    || die 1 "pango render failed for block ${out##*/}"
}

draw_title() {
  local -- text="${1:?}" out="${3:?}"
  local -i pt="${2:?}" ls=0
  ls=$(( pt * TRACK_TITLE ))
  convert -background none \
      pango:"<span foreground='$INK' font='$FACE $pt' letter_spacing='$ls'>$text</span>" \
      "$out" \
    || die 1 'pango render failed for title'
}

# Render the title line fitted to TITLE_WIDTH: probe once, measure, re-render
# at the size that lands on the target (tracking scales with the point size,
# so rendered width is linear in it and one measurement gives the fit).
render_title() {
  local -- text="${1:?}" out="${2:?}"
  local -i probe=100 pt=0 w=0
  local -- probe_png="$TMP"/title-probe.png

  draw_title "$text" "$probe" "$probe_png"
  w=$(identify -format '%w' "$probe_png") || die 1 'could not measure title'
  ((w > 0)) || die 1 "degenerate title measurement for ${text@Q}"
  pt=$(( probe * TITLE_WIDTH / w ))
  ((pt > 0)) || die 1 "degenerate title point size for ${text@Q}"
  draw_title "$text" "$pt" "$out"
}

main() {
  local -a paras=()
  local -- line='' cur=''

  local -- cmd
  for cmd in convert identify; do
    command -v "$cmd" &>/dev/null || die 18 "$cmd not found (apt install imagemagick)"
  done
  [[ -f $BACK_IN ]] || die 3 "back art missing ${BACK_IN@Q}"
  [[ -f $BLURB ]] || die 3 "blurb missing ${BLURB@Q}"

  trap cleanup EXIT
  TMP=$(mktemp -d) || die 1 'could not create temp dir'

  # Split the blurb into paragraphs; HTML comment lines are dropped.
  while IFS= read -r line; do
    [[ $line == '<!--'* ]] && continue
    if [[ -z ${line//[[:space:]]/} ]]; then
      [[ -z $cur ]] || { paras+=("$cur"); cur=''; }
    else
      cur+="${cur:+ }$line"
    fi
  done <"$BLURB"
  [[ -z $cur ]] || paras+=("$cur")
  (( ${#paras[@]} >= 3 )) || die 1 "unexpected blurb structure in ${BLURB@Q}"

  # First paragraph is the title line; last is the bio; the rest are body.
  local -- title='' bio=''
  title=${paras[0]//\*/}
  bio=$(markup "${paras[-1]}")

  local -- title_png="$TMP"/title.png rule_png="$TMP"/rule.png
  local -- bio_png="$TMP"/bio.png
  render_title "${title^^}" "$title_png"
  render_block "$bio" "$bio_png" "$BIO_PT" "$TEXT_WIDTH"

  # The same hairline rule as the front, held back to 55%.
  convert -size "${RULE_WIDTH}"x1 "xc:$INK" \
      -alpha set -channel A -evaluate set 55% +channel "$rule_png" \
    || die 1 'rule render failed'

  # Body paragraphs, rendered and measured, then stacked beneath the rule.
  local -a body_pngs=() composite_args=()
  local -- para='' png=''
  local -i i=0 y=0 h=0

  for (( i = 1; i < ${#paras[@]} - 1; i+=1 )); do
    png="$TMP"/body-"$i".png
    para=$(markup "${paras[$i]}")
    render_block "$para" "$png" "$BODY_PT" "$TEXT_WIDTH"
    body_pngs+=("$png")
  done

  h=$(identify -format '%h' "$title_png") || die 1 'could not measure title'
  y=$(( TITLE_TOP + h + RULE_GAP ))
  halo "$title_png" "$TMP"/title-halo.png
  composite_args+=("$TMP"/title-halo.png -gravity north -geometry +0+"$TITLE_TOP" -composite)
  composite_args+=("$title_png" -gravity north -geometry +0+"$TITLE_TOP" -composite)
  composite_args+=("$rule_png" -gravity north -geometry +0+"$y" -composite)
  y=$(( y + 1 + RULE_UNDER ))

  for png in "${body_pngs[@]}"; do
    halo "$png" "${png%.png}"-halo.png
    composite_args+=("${png%.png}"-halo.png -gravity north -geometry +0+"$y" -composite)
    composite_args+=("$png" -gravity north -geometry +0+"$y" -composite)
    h=$(identify -format '%h' "$png") || die 1 "could not measure ${png##*/}"
    y=$(( y + h + BLOCK_GAP ))
  done
  halo "$bio_png" "$TMP"/bio-halo.png
  composite_args+=("$TMP"/bio-halo.png -gravity south -geometry +0+"$BIO_FOOT" -composite)
  composite_args+=("$bio_png" -gravity south -geometry +0+"$BIO_FOOT" -composite)

  convert "$BACK_IN" "${composite_args[@]}" "$BACK_OUT" \
    || die 1 'compositing failed'

  >&2 printf '%s: wrote %s (%s)\n' \
      "$SCRIPT_NAME" "$BACK_OUT" "$(identify -format '%wx%h' "$BACK_OUT")"
}

main "$@"

#fin
