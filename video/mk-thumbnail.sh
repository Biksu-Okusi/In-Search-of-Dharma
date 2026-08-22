#!/usr/bin/bash
# mk-thumbnail.sh - the playlist thumbnail for the In Search of Dharma videos.
#
# Takes the book's cover watercolour (portrait, no type), crops a 16:9 band out
# of it, and centres the book's title, tagline and author over the result --
# one 1920x1080 PNG, YouTube's thumbnail aspect.
#
# The subtitle is left off: at playlist-card size only three lines survive, so
# the type that stays is set large enough to be read at 360px wide.
#
# The type is set as images/defining-dharma-gentitle.sh sets the book cover: EB
# Garamond for the title and tagline, Lato for the author, all in the book's
# navy, every line fitted to a target width rather than set at a fixed point
# size. The strings are lifted out of mk-book.sh, so retitling the book
# re-letters the thumbnail with no edits here.
#
# Unlike the cover, the whole block is centred vertically as well as
# horizontally: the playlist card is read small, so the type owns the middle of
# the frame and the terraces read as ground behind it.
set -euo pipefail
shopt -s inherit_errexit

# --- Script Metadata ---
declare -r VERSION='1.0.0'
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

# --- Configuration ---
declare -r BOOK_DIR=${SCRIPT_DIR%/*}
declare -r MK_BOOK=$BOOK_DIR/mk-book.sh
declare -r ART_DEFAULT=$BOOK_DIR/images/defining-dharma-cover.png
declare -r OUT_DEFAULT=$SCRIPT_DIR/out/playlist-thumbnail.png

# The book's navy, as used for links in the EPUB and PDF stylesheets (mk-book.sh).
# FITTYPE_INK is read by the shared type library.
declare -rx FITTYPE_INK='#0b295a'

declare -r FONT_TITLE=/usr/share/fonts/opentype/ebgaramond/EBGaramond12-Regular.otf
declare -r FONT_SUB=/usr/share/fonts/opentype/ebgaramond/EBGaramond12-Italic.otf
declare -r FONT_AUTHOR=/usr/share/fonts/truetype/lato/Lato-Regular.ttf

# Canvas. 1920x1080 is YouTube's thumbnail aspect at a size that survives being
# scaled down to the 360px-wide playlist card.
declare -ri WIDTH=1920 HEIGHT=1080

# Where the 16:9 band is cut from a portrait source, as a fraction of the
# source height after it has been scaled to WIDTH. 0.575 keeps the mist across
# the top for the type and holds the walking figure on the ridge below it.
declare -- CROP_AT=0.575

# A white veil over the art, in percent, so the navy holds against the darker
# terrace walls. 0 disables it.
declare -i VEIL=22

# Layout, in pixels on the 1920x1080 canvas. The *_WIDTH values are the widths
# each line is fitted to; the gaps stack the block, which is then centred as a
# whole on the canvas.
declare -ri TITLE_WIDTH=1560
declare -ri RULE_WIDTH=260 RULE_GAP=62      # blank space above the hairline rule
declare -ri TAG_WIDTH=880 TAG_GAP=54        # blank space below it, above the tagline
declare -ri AUTHOR_WIDTH=700 AUTHOR_GAP=92  # blank space above the author

# Tracking (letter-spacing), as a fraction of the point size.
declare -r TRACK_TITLE=0.10 TRACK_TAG=0.01 TRACK_AUTHOR=0.20

declare -- ART=$ART_DEFAULT OUT=$OUT_DEFAULT TMP=''

# --- Messaging Functions ---
declare -i VERBOSE=1
_msg() { >&2 printf "$SCRIPT_NAME: $1 %s\n" "${@:2}"; }
success() { ((VERBOSE)) || return 0; _msg '✓' "$@"; }
die()     { (($# < 2)) || _msg '✗' "${@:2}"; exit "${1:-0}"; }
noarg()   { (($# > 1)) || die 22 "Option ${1@Q} requires an argument"; }
cleanup() {
  local -i exitcode=${1:-$?}
  trap - SIGINT SIGTERM EXIT
  [[ -z ${TMP:-} ]] || rm -rf -- "$TMP"
  exit "$exitcode"
}

declare -r FITTYPE_LIB=$SCRIPT_DIR/../lib/fitted-type.sh
[[ -f $FITTYPE_LIB ]] || die 3 "missing library ${FITTYPE_LIB@Q}"
#shellcheck source=/dev/null
source "$FITTYPE_LIB" || die 1 "failed to source ${FITTYPE_LIB@Q}"

usage() {
  cat <<USAGE
Usage: $SCRIPT_NAME [OPTIONS]

Write the ${WIDTH}x${HEIGHT} playlist thumbnail: the cover watercolour cropped to
16:9, with the book's title, tagline and author centred large over it.

Options:
  -i, --image FILE   cover art to letter (default: $ART_DEFAULT)
                     a 16:9 source is used whole; a portrait one is cropped
  -o, --output FILE  output PNG (default: $OUT_DEFAULT)
  -c, --crop-at F    crop centre as a fraction of source height (default: $CROP_AT)
  -e, --veil PCT     white veil over the art, 0-100 (default: $VEIL)
  -q, --quiet        suppress progress output
  -V, --version      print version
  -h, --help         this help
USAGE
}

# --- Helpers ---

# Pull a `declare -r NAME='value'` string out of mk-book.sh, so that the
# thumbnail and the book cannot drift apart.
mk_book_value() {
  local -- key=${1:?} line=''
  line=$(grep -m1 -E "^declare -r $key=" "$MK_BOOK") \
    || die 2 "$key not found in ${MK_BOOK@Q}"
  line=${line#*=}
  line=${line#\'}
  line=${line%\'}
  [[ -n $line ]] || die 2 "$key is empty in ${MK_BOOK@Q}"
  printf '%s' "$line"
}

# Scale the art to WIDTH and cut a WIDTHxHEIGHT band out of it, centred on
# CROP_AT. A source already at or below 16:9 is simply filled and centred.
build_ground() {
  local -- out=${1:?}
  local -i sh=0 y=0
  convert "$ART" -resize "${WIDTH}x" "$TMP"/scaled.png \
    || die 1 "could not scale ${ART@Q}"
  sh=$(identify -format '%h' "$TMP"/scaled.png) || die 1 'could not measure the scaled art'
  ((sh > 0)) || die 1 'scaled art measured empty'
  if ((sh <= HEIGHT)); then
    convert "$TMP"/scaled.png -resize "${WIDTH}x${HEIGHT}^" \
        -gravity center -extent "${WIDTH}x${HEIGHT}" "$out" \
      || die 1 'could not fit the art to the canvas'
  else
    y=$(awk -v h="$sh" -v c="$CROP_AT" -v t="$HEIGHT" \
        'BEGIN{ y = h*c - t/2; if (y < 0) y = 0; if (y > h-t) y = h-t; printf "%d", y }')
    convert "$TMP"/scaled.png -crop "${WIDTH}x${HEIGHT}+0+${y}" +repage "$out" \
      || die 1 'could not crop the art to 16:9'
  fi
  ((VEIL)) || return 0
  convert "$out" \
      \( -size "${WIDTH}x${HEIGHT}" xc:white -alpha set \
         -channel A -evaluate set "$VEIL%" +channel \) \
      -composite "$out" \
    || die 1 'could not veil the art'
}

# --- Main ---
main() {
  while (($#)); do case $1 in
    -i|--image)   noarg "$@"; shift; ART=$1 ;;
    -o|--output)  noarg "$@"; shift; OUT=$1 ;;
    -c|--crop-at) noarg "$@"; shift; CROP_AT=$1 ;;
    -e|--veil)    noarg "$@"; shift; VEIL=$1 ;;
    -q|--quiet)   VERBOSE=0 ;;
    -V|--version) printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; exit 0 ;;
    -h|--help)    usage; exit 0 ;;
    --)           shift; break ;;
    -[iocevqVh]?*) set -- "${1:0:2}" "-${1:2}" "${@:2}"; continue ;;
    -*)           die 22 "Invalid option ${1@Q}" ;;
    *)            die 2 "Unexpected argument ${1@Q}" ;;
  esac; shift; done
  readonly ART OUT CROP_AT VEIL VERBOSE

  local -- cmd
  for cmd in convert identify awk; do
    command -v "$cmd" >/dev/null || die 1 "$cmd not found (apt install imagemagick)"
  done
  [[ -f $ART ]] || die 2 "cover art missing ${ART@Q}"
  [[ -f $MK_BOOK ]] || die 2 "mk-book.sh missing ${MK_BOOK@Q}"
  local -- font
  for font in "$FONT_TITLE" "$FONT_SUB" "$FONT_AUTHOR"; do
    [[ -f $font ]] || die 2 "font missing ${font@Q}"
  done
  ((VEIL >= 0 && VEIL <= 100)) || die 22 "veil must be 0-100, got ${VEIL}"

  trap 'cleanup $?' SIGINT SIGTERM EXIT
  TMP=$(mktemp -d) || die 1 'could not create temp dir'
  mkdir -p "${OUT%/*}"

  local -- title tagline author
  title=$(mk_book_value TITLE)
  tagline=$(mk_book_value TAGLINE)
  author=$(mk_book_value AUTHOR)

  # Display caps for the title and author; the tagline stays italic, mirroring
  # the title page in cover.md.
  fittype_line "$FONT_TITLE"  "${title^^}"  "$TRACK_TITLE"  "$TMP"/title.png  "$TITLE_WIDTH" \
    || die 1 'could not set the title'
  fittype_line "$FONT_SUB"    "$tagline"    "$TRACK_TAG"    "$TMP"/tag.png    "$TAG_WIDTH" \
    || die 1 'could not set the tagline'
  fittype_line "$FONT_AUTHOR" "${author^^}" "$TRACK_AUTHOR" "$TMP"/author.png "$AUTHOR_WIDTH" \
    || die 1 'could not set the author'

  fittype_rule "$RULE_WIDTH" "$TMP"/rule.png || die 1 'could not draw the rule'

  # Stack the block on a transparent strip, then centre the strip on the canvas.
  convert -background none -gravity center \
      "$TMP"/title.png \
      \( -size 1x"$RULE_GAP" xc:none \) \
      "$TMP"/rule.png \
      \( -size 1x"$TAG_GAP" xc:none \) \
      "$TMP"/tag.png \
      \( -size 1x"$AUTHOR_GAP" xc:none \) \
      "$TMP"/author.png \
      -append "$TMP"/block.png \
    || die 1 'could not stack the type block'

  build_ground "$TMP"/ground.png
  convert "$TMP"/ground.png "$TMP"/block.png \
      -gravity center -composite -depth 8 "$OUT" \
    || die 1 'compositing failed'

  success "$OUT ($(identify -format '%wx%h, %b' "$OUT"))"
}

main "$@"

#fin
