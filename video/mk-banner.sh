#!/usr/bin/bash
# mk-banner.sh - the YouTube channel banner for 'a secular dharma?'.
#
# Writes one 2560x1440 PNG: the wide terraces watercolour
# (../images/channel-banner-art.png) with the channel name centred inside
# YouTube's safe area. The name is the only type on it -- the book's tagline
# belongs to the audiobook, not to the channel.
#
# A banner is not one image, it is four crops of one image. YouTube shows the
# full 2560x1440 only on a television; desktop crops to 2560x423, mobile to
# 1546x423, and the region guaranteed visible everywhere is the centre
# 1235x338. So the type must sit inside that centre box while the art still
# reads as composed in the wider bands. --guides draws all three regions over
# the output and --proofs writes the actual device crops, so a layout change
# can be judged against the real thing rather than guessed at.
#
# Type is set as the book cover sets it (see images/defining-dharma-gentitle.sh
# and mk-thumbnail.sh): EB Garamond in the book's navy, fitted to a target width
# rather than given a point size.
set -euo pipefail
shopt -s inherit_errexit

# --- Script Metadata ---
declare -r VERSION='1.0.0'
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

# --- Configuration ---
declare -r BOOK_DIR=${SCRIPT_DIR%/*}
declare -r ART_DEFAULT=$BOOK_DIR/images/channel-banner-art.png
declare -r OUT_DEFAULT=$SCRIPT_DIR/out/channel-banner.png

# The channel's own title, set exactly as written: lower case, question mark
# included. It was chosen "deliberately unsure" (see ../0-preface.md), and
# capitalising it into display caps throws that away.
declare -r CHANNEL_NAME='a secular dharma?'

# The book's navy, as used for links in the EPUB and PDF stylesheets (mk-book.sh).
declare -r INK='#0b295a'

declare -r FONT_TITLE=/usr/share/fonts/opentype/ebgaramond/EBGaramond12-Regular.otf

# Canvas. YouTube accepts from 2048x1152; 2560x1440 is the recommended size and
# the one a television actually displays in full.
declare -ri WIDTH=2560 HEIGHT=1440

# The three regions YouTube crops to, centred on the canvas. SAFE is visible on
# every device and is where the type must live; DESKTOP is what most viewers
# see; MOBILE is the narrowest crop of that band.
declare -ri SAFE_W=1235 SAFE_H=338
declare -ri MOBILE_W=1546 BAND_H=423
declare -ri DESKTOP_W=2560

# A white veil over the art, in percent, so the navy holds against the terraces.
declare -i VEIL=20

# Vertical framing. The art is very nearly 16:9 already, so filling the canvas
# leaves no slack to slide it in: SHIFT buys that slack by over-scaling to
# HEIGHT + 2*|SHIFT| first, then cropping off centre. Positive moves the visible
# content down (more sky, terraces rise into the frame); negative moves it up.
# The cost is a slightly harder upscale, so keep it small. -140 is what puts the
# walking figure whole inside the 423px desktop band instead of slicing it: at 0
# the figure lands exactly on the band's bottom edge.
declare -i SHIFT=-140

# Layout, in pixels. NAME_WIDTH is the width the line is fitted to; it is
# centred on the canvas, which centres it in the safe area too. Keep it inside
# SAFE_W with margin to spare -- the script refuses to write an overflow.
declare -ri NAME_WIDTH=1120

# Tracking (letter-spacing), as a fraction of the point size.
declare -r TRACK_NAME=0.08

declare -- ART=$ART_DEFAULT OUT=$OUT_DEFAULT TMP=''
declare -i GUIDES=0 PROOFS=0

# --- Messaging Functions ---
declare -i VERBOSE=1
_msg() { >&2 printf "$SCRIPT_NAME: $1 %s\n" "${@:2}"; }
info()    { ((VERBOSE)) || return 0; _msg '◉' "$@"; }
success() { ((VERBOSE)) || return 0; _msg '✓' "$@"; }
die()     { (($# < 2)) || _msg '✗' "${@:2}"; exit "${1:-0}"; }
noarg()   { (($# > 1)) || die 22 "Option ${1@Q} requires an argument"; }
cleanup() {
  local -i exitcode=${1:-$?}
  trap - SIGINT SIGTERM EXIT
  [[ -z ${TMP:-} ]] || rm -rf -- "$TMP"
  exit "$exitcode"
}

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME [OPTIONS]

Write the ${WIDTH}x${HEIGHT} channel banner: the wide terraces watercolour with
'$CHANNEL_NAME' centred in YouTube's ${SAFE_W}x${SAFE_H} safe area.

Options:
  -i, --image FILE   banner art (default: $ART_DEFAULT)
  -o, --output FILE  output PNG (default: $OUT_DEFAULT)
  -e, --veil PCT     white veil over the art, 0-100 (default: $VEIL)
  -y, --shift PX     slide the art down (+) or up (-) in frame (default: $SHIFT)
  -g, --guides       draw the safe / mobile / desktop regions over the output
  -p, --proofs       also write the three device crops beside the output
  -q, --quiet        suppress progress output
  -V, --version      print version
  -h, --help         this help
USAGE
}

# --- Helpers ---

draw_line() {
  local -- font=${1:?} text=${2:?} track=${3:?} out=${5:?}
  local -i pt=${4:?}
  local -- kern
  kern=$(awk -v p="$pt" -v t="$track" 'BEGIN{ printf "%.2f", p * t }')
  # label: trims to the glyph bounding box, so the tracking leaves no trailing
  # gap to compensate for and the line centres true as rendered.
  convert -background none -fill "$INK" \
      -font "$font" -pointsize "$pt" -kerning "$kern" \
      label:"$text" "$out"
}

# Render one line of type to a transparent PNG, fitted to a target width.
#
# Point size is derived, not passed in: the line is rendered once at a probe
# size, measured, and re-rendered at the size that lands on the target. Tracking
# is a fraction of the point size, so rendered width is linear in point size and
# a single measurement gives the exact fit.
render_line() {
  local -- font=${1:?} text=${2:?} track=${3:?} out=${4:?}
  local -i target=${5:?}
  local -i probe=100 pt=0 w=0
  local -- probe_png=$TMP/probe.png

  draw_line "$font" "$text" "$track" "$probe" "$probe_png"
  w=$(identify -format '%w' "$probe_png")
  ((w > 0)) || die 1 "could not measure ${text@Q}"

  pt=$(( probe * target / w ))
  ((pt > 0)) || die 1 "degenerate point size for ${text@Q}"
  draw_line "$font" "$text" "$track" "$pt" "$out"
}

# Fill the canvas with the art (cropping the overflow), then veil it.
build_ground() {
  local -- out=${1:?}
  local -i fill_h=$(( HEIGHT + 2 * (SHIFT < 0 ? -SHIFT : SHIFT) ))
  convert "$ART" -filter Lanczos -resize "${WIDTH}x${fill_h}^" \
      -gravity center -extent "${WIDTH}x${HEIGHT}+0+$(( -SHIFT ))" "$out" \
    || die 1 "could not fit ${ART@Q} to the canvas"
  ((VEIL)) || return 0
  convert "$out" \
      \( -size "${WIDTH}x${HEIGHT}" xc:white -alpha set \
         -channel A -evaluate set "$VEIL%" +channel \) \
      -composite "$out" \
    || die 1 'could not veil the art'
}

# rect_args W H -> "x0,y0 x1,y1" for a WxH box centred on the canvas
rect_args() {
  local -i w=${1:?} h=${2:?}
  printf '%d,%d %d,%d' \
    $(( (WIDTH - w) / 2 )) $(( (HEIGHT - h) / 2 )) \
    $(( (WIDTH + w) / 2 - 1 )) $(( (HEIGHT + h) / 2 - 1 ))
}

# Draw the three crop regions over a copy of the banner, for eyeballing only.
draw_guides() {
  local -- img=${1:?}
  convert "$img" -fill none -strokewidth 4 \
      -stroke '#cc0000' -draw "rectangle $(rect_args "$SAFE_W" "$SAFE_H")" \
      -stroke '#0055cc' -draw "rectangle $(rect_args "$MOBILE_W" "$BAND_H")" \
      -stroke '#00883c' -draw "rectangle $(rect_args "$DESKTOP_W" "$BAND_H")" \
      "$img" \
    || die 1 'could not draw the guides'
  info "guides: red=safe ${SAFE_W}x${SAFE_H}  blue=mobile ${MOBILE_W}x${BAND_H}" \
       " green=desktop ${DESKTOP_W}x${BAND_H}"
}

# Write the crops YouTube actually shows, so the banner can be judged as seen.
write_proofs() {
  local -- img=${1:?}
  local -- stem=${img%.png}
  local -a crops=("$DESKTOP_W"x"$BAND_H":desktop "$MOBILE_W"x"$BAND_H":mobile
                  "$SAFE_W"x"$SAFE_H":safe)
  local -- crop name geom
  for crop in "${crops[@]}"; do
    geom=${crop%:*}; name=${crop#*:}
    convert "$img" -gravity center -crop "$geom+0+0" +repage "$stem-$name.png" \
      || die 1 "could not write the $name proof"
    success "  proof  $stem-$name.png ($geom)"
  done
}

# --- Main ---
main() {
  while (($#)); do case $1 in
    -i|--image)     noarg "$@"; shift; ART=$1 ;;
    -o|--output)    noarg "$@"; shift; OUT=$1 ;;
    -e|--veil)      noarg "$@"; shift; VEIL=$1 ;;
    -y|--shift)     noarg "$@"; shift; SHIFT=$1 ;;
    -g|--guides)    GUIDES=1 ;;
    -p|--proofs)    PROOFS=1 ;;
    -q|--quiet)     VERBOSE=0 ;;
    -V|--version)   printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; exit 0 ;;
    -h|--help)      usage; exit 0 ;;
    --)             shift; break ;;
    -[ioeygpqVh]?*) set -- "${1:0:2}" "-${1:2}" "${@:2}"; continue ;;
    -*)             die 22 "Invalid option ${1@Q}" ;;
    *)              die 2 "Unexpected argument ${1@Q}" ;;
  esac; shift; done
  readonly ART OUT VEIL SHIFT GUIDES PROOFS VERBOSE

  local -- cmd
  for cmd in convert identify awk; do
    command -v "$cmd" >/dev/null || die 1 "$cmd not found (apt install imagemagick)"
  done
  [[ -f $ART ]] || die 2 "banner art missing ${ART@Q}"
  [[ -f $FONT_TITLE ]] || die 2 "font missing ${FONT_TITLE@Q}"
  ((VEIL >= 0 && VEIL <= 100)) || die 22 "veil must be 0-100, got ${VEIL}"

  trap 'cleanup $?' SIGINT SIGTERM EXIT
  TMP=$(mktemp -d) || die 1 'could not create temp dir'
  mkdir -p "${OUT%/*}"

  render_line "$FONT_TITLE" "$CHANNEL_NAME" "$TRACK_NAME" "$TMP"/block.png "$NAME_WIDTH"

  # The line has to clear the safe box, or the type is cropped off on a phone.
  local -i block_w=0 block_h=0
  block_w=$(identify -format '%w' "$TMP"/block.png) || die 1 'could not measure the type'
  block_h=$(identify -format '%h' "$TMP"/block.png) || die 1 'could not measure the type'
  ((block_w > 0 && block_h > 0)) || die 1 'type measured empty'
  ((block_w <= SAFE_W && block_h <= SAFE_H)) \
    || die 1 "type ${block_w}x${block_h} does not fit the ${SAFE_W}x${SAFE_H} safe area"

  build_ground "$TMP"/ground.png
  convert "$TMP"/ground.png "$TMP"/block.png \
      -gravity center -composite -depth 8 "$OUT" \
    || die 1 'compositing failed'

  ((PROOFS)) && write_proofs "$OUT" ||:
  ((GUIDES)) && draw_guides "$OUT" ||:
  success "$OUT ($(identify -format '%wx%h, %b' "$OUT"))" \
          "type ${block_w}x${block_h} inside ${SAFE_W}x${SAFE_H}"
}

main "$@"

#fin
