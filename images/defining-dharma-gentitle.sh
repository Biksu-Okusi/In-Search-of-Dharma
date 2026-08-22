#!/bin/bash
# defining-dharma-gentitle.sh - lay the book's title, subtitle, tagline and
# author over the cover art.
#
# Reads images/defining-dharma-cover.png (the watercolour, no type) and writes
# images/defining-dharma-cover-title.png (the same art, lettered).
#
# The type is set in the book's own faces and colour, so the cover matches the
# interior: EB Garamond for the title, subtitle and tagline (the subtitle
# upright, the tagline italic, mirroring the title page in cover.md), Lato for
# the author, all in the navy that mk-book.sh gives links in both stylesheets.
#
# The title/subtitle/tagline/author strings are lifted out of mk-book.sh rather
# than duplicated here, and every line is fitted to a target width rather than
# set at a fixed point size -- so retitling the book in mk-book.sh re-letters
# the cover correctly with no edits to this script.
set -euo pipefail

#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}
declare -r PROJECT_DIR=${SCRIPT_DIR%/*}

declare -r MK_BOOK="$PROJECT_DIR"/mk-book.sh
declare -r COVER_IN="$SCRIPT_DIR"/defining-dharma-cover.png
declare -r COVER_OUT="$SCRIPT_DIR"/defining-dharma-cover-title.png

# The book's navy, as used for links in the EPUB and PDF stylesheets (mk-book.sh).
# FITTYPE_INK is read by the shared type library.
declare -rx FITTYPE_INK='#0b295a'

declare -r FONT_TITLE=/usr/share/fonts/opentype/ebgaramond/EBGaramond12-Regular.otf
declare -r FONT_SUB=/usr/share/fonts/opentype/ebgaramond/EBGaramond12-Italic.otf
declare -r FONT_AUTHOR=/usr/share/fonts/truetype/lato/Lato-Regular.ttf

# Layout on the 864x1152 cover, in pixels. The *_WIDTH values are the widths each
# line is fitted to; the vertical offsets stack from the measured height of the
# line above, so the block stays balanced whatever the text turns out to be.
declare -ri TITLE_WIDTH=640 TITLE_TOP=205
declare -ri RULE_WIDTH=104 RULE_GAP=38     # blank space above the hairline rule
declare -ri SUB_WIDTH=470 SUB_GAP=34       # blank space below it
declare -ri TAG_WIDTH=300 TAG_GAP=26       # blank space above the tagline
declare -ri AUTHOR_WIDTH=250 AUTHOR_FOOT=104

# Tracking (letter-spacing), as a fraction of the point size. Large display caps
# need it opened up; the subtitle and italic tagline need almost none.
declare -r TRACK_TITLE=0.12 TRACK_SUB=0.01 TRACK_TAG=0.01 TRACK_AUTHOR=0.22

declare -- TMP=''

die() { >&2 printf '%s: error: %s\n' "$SCRIPT_NAME" "$*"; exit 1; }
cleanup() { [[ -n $TMP ]] && rm -rf -- "$TMP"; }

declare -r FITTYPE_LIB=$PROJECT_DIR/lib/fitted-type.sh
[[ -f $FITTYPE_LIB ]] || die "missing library ${FITTYPE_LIB@Q}"
#shellcheck source=/dev/null
source "$FITTYPE_LIB" || die "failed to source ${FITTYPE_LIB@Q}"

# Pull a `declare -r NAME='value'` string out of mk-book.sh, so that the cover
# and the book cannot drift apart.
mk_book_value() {
  local -- key="${1:?}" line=''
  line=$(grep -m1 -E "^declare -r $key=" "$MK_BOOK") \
    || die "$key not found in ${MK_BOOK@Q}"
  line=${line#*=}
  line=${line#\'}
  line=${line%\'}
  [[ -n $line ]] || die "$key is empty in ${MK_BOOK@Q}"
  printf '%s' "$line"
}

main() {
  local -- title='' subtitle='' tagline='' author=''
  local -- title_png='' sub_png='' tag_png='' author_png='' rule_png=''
  local -i title_h=0 sub_h=0 sub_y=0 tag_y=0 rule_y=0

  local -- cmd
  for cmd in convert identify awk; do
    command -v "$cmd" >/dev/null || die "$cmd not found (apt install imagemagick)"
  done
  [[ -f $COVER_IN ]] || die "cover art missing ${COVER_IN@Q}"
  [[ -f $MK_BOOK ]] || die "mk-book.sh missing ${MK_BOOK@Q}"

  local -- font
  for font in "$FONT_TITLE" "$FONT_SUB" "$FONT_AUTHOR"; do
    [[ -f $font ]] || die "font missing ${font@Q}"
  done

  TMP=$(mktemp -d) || die 'could not create temp dir'
  trap cleanup EXIT

  title=$(mk_book_value TITLE)
  subtitle=$(mk_book_value SUBTITLE)
  tagline=$(mk_book_value TAGLINE)
  author=$(mk_book_value AUTHOR)

  title_png="$TMP"/title.png
  sub_png="$TMP"/sub.png
  tag_png="$TMP"/tag.png
  author_png="$TMP"/author.png
  rule_png="$TMP"/rule.png

  # Display caps for the title and author; the subtitle and tagline keep their
  # sentence case -- the subtitle upright, the tagline italic, as in cover.md.
  fittype_line "$FONT_TITLE" "${title^^}" "$TRACK_TITLE" "$title_png" "$TITLE_WIDTH" \
    || die 'could not set the title'
  fittype_line "$FONT_TITLE" "$subtitle" "$TRACK_SUB" "$sub_png" "$SUB_WIDTH" \
    || die 'could not set the subtitle'
  fittype_line "$FONT_SUB" "$tagline" "$TRACK_TAG" "$tag_png" "$TAG_WIDTH" \
    || die 'could not set the tagline'
  fittype_line "$FONT_AUTHOR" "${author^^}" "$TRACK_AUTHOR" "$author_png" "$AUTHOR_WIDTH" \
    || die 'could not set the author'

  fittype_rule "$RULE_WIDTH" "$rule_png" || die 'could not draw the rule'

  # Stack the block downwards from the measured height of the title.
  title_h=$(identify -format '%h' "$title_png")
  rule_y=$(( TITLE_TOP + title_h + RULE_GAP ))
  sub_y=$(( rule_y + 1 + SUB_GAP ))
  sub_h=$(identify -format '%h' "$sub_png")
  tag_y=$(( sub_y + sub_h + TAG_GAP ))

  convert "$COVER_IN" \
      "$title_png"  -gravity north -geometry +0+"$TITLE_TOP" -composite \
      "$rule_png"   -gravity north -geometry +0+"$rule_y" -composite \
      "$sub_png"    -gravity north -geometry +0+"$sub_y" -composite \
      "$tag_png"    -gravity north -geometry +0+"$tag_y" -composite \
      "$author_png" -gravity south -geometry +0+"$AUTHOR_FOOT" -composite \
      "$COVER_OUT" \
    || die 'compositing failed'

  printf '%s: wrote %s (%s)\n' \
      "$SCRIPT_NAME" "$COVER_OUT" "$(identify -format '%wx%h' "$COVER_OUT")"
}

main "$@"

#fin
