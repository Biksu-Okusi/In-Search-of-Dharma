#!/bin/bash
# mk-print.sh - Build the print-ready interior PDF of "In Search of Dharma"
# for Tuwhiri's printer.
#
#   ./mk-print.sh [--size PT] [--lead PT] [--fonts SET] [--quiet] [--keep-temp]
#   ./mk-print.sh --preflight FILE     # check an existing PDF and stop
#
# The interior only. A print cover is a separate artefact and a separate design
# job, and IngramSpark requires it uploaded as a separate file.
#
# Renders essays 0..9 plus the companion essay as the appendix, through pandoc
# and WeasyPrint, at the 152 x 229mm trim of Tuwhiri's "The secular path to
# well-being", on that book's measured baseline grid (see lib/print-style.sh).
# The result is then hardened to IngramSpark's interior rules: even page count,
# blank final page, DeviceGray throughout, every font embedded, no crop marks.
# lib/pdfcheck.py asserts all of that against the finished file, and the build
# refuses to write a non-conforming PDF.
#
# Sources, preprocessing and typefaces are shared with mk-book.sh through
# lib/preprocess.sh and lib/fonts.sh: one set of sources, one reading of them.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (pandoc, weasyprint, gs, convert, pdfunite,
# pdfinfo, jq) must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION=1.0.0
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='In search of dharma'
declare -r SUBTITLE='What holds a life, a people, a world together'
declare -r AUTHOR='Biksu Okusi'
declare -r PUBLISHER='The Tuwhiri Project'
declare -r LICENSE_NAME='Creative Commons Attribution 4.0 International (CC BY 4.0)'
declare -r LICENSE_URL='https://creativecommons.org/licenses/by/4.0/'
# preprocess() rewrites research-note links to absolute repository URLs and
# needs both of these declared before lib/preprocess.sh is sourced.
declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main
# Staged images are JPEG. 92 rather than mk-book.sh's 80: a print interior is
# rendered at 300ppi and compression artefacts that vanish on a screen survive
# on paper.
declare -ir JPEG_QUALITY=92

declare -r OUTPUT_PDF="$SCRIPT_DIR"/In-Search-of-Dharma_interior_152x229.pdf
# Optional imprint copy from Tuwhiri. Absent, a deliberately visible placeholder
# is set instead, so a proof cannot be sent without the omission being obvious.
declare -r IMPRINT_SRC="$SCRIPT_DIR"/print-imprint.md
# The Okusi mark, set on the rule above each chapter title in place of the
# roundel Tuwhiri uses in its own books.
declare -r LOGO_SRC="$SCRIPT_DIR"/images/dharma-eye.svg

# Script-scope state, declared before any function (BCS0105).
declare -i VERBOSE=1 KEEP_TEMP=0
declare -- TMP_DIR=''

# Messaging (BCS0703). warn() and error() are unconditional; die() takes the
# exit code first, then an optional message.
_msg()  { >&2 printf '%s: %s %s\n' "$SCRIPT_NAME" "$1" "${*:2}"; }
info()  { ((VERBOSE)) || return 0; _msg '◉' "$@"; }
warn()  { _msg '▲' "$@"; }
error() { _msg '✗' "$@"; }
die()   { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }

declare -r FONT_LIB="$SCRIPT_DIR"/lib/fonts.sh
declare -r PREPROCESS_LIB="$SCRIPT_DIR"/lib/preprocess.sh
declare -r STYLE_LIB="$SCRIPT_DIR"/lib/print-style.sh
declare -r PDFCHECK="$SCRIPT_DIR"/lib/pdfcheck.py

declare -- _lib
for _lib in "$FONT_LIB" "$PREPROCESS_LIB" "$STYLE_LIB"; do
  [[ -f $_lib ]] || { >&2 echo "✗ missing library ${_lib@Q}"; exit 3; }
done
#shellcheck source=lib/fonts.sh
source "$FONT_LIB"       || { >&2 echo "✗ failed to source ${FONT_LIB@Q}"; exit 1; }
#shellcheck source=lib/preprocess.sh
source "$PREPROCESS_LIB" || { >&2 echo "✗ failed to source ${PREPROCESS_LIB@Q}"; exit 1; }
#shellcheck source=lib/print-style.sh
source "$STYLE_LIB"      || { >&2 echo "✗ failed to source ${STYLE_LIB@Q}"; exit 1; }

show_help() {
  cat <<HELP
$SCRIPT_NAME $VERSION - build the print-ready interior PDF

Usage:
  $SCRIPT_NAME [options]
  $SCRIPT_NAME --preflight FILE

Options:
  --size PT        body type size (default 10)
  --lead PT        leading (default 16)
  --fonts SET      typeface set from lib/fonts.sh (default ${FONT_SETS[0]})
  --preflight FILE check an existing PDF against the printer's rules and stop
  -q, --quiet      suppress progress messages
  --keep-temp      leave the build directory in place for inspection
  -h, --help       this message
  -V, --version    print the version

The interior only: IngramSpark requires the cover uploaded as a separate file.
Output: ${OUTPUT_PDF##*/}
HELP
}

# Mirror pandoc's auto-identifier algorithm for a heading: downcase, drop
# anything outside [a-z0-9 ._-], spaces to hyphens, then strip leading
# characters until the first is a letter. Contents links are built from this,
# so it must track pandoc's behaviour exactly. Duplicated from mk-book.sh
# rather than shared: it mirrors a renderer's behaviour, which is not what
# lib/preprocess.sh is for.
slugify() {
  local -- s=${1,,}
  s=${s//[^a-z0-9 ._-]/}
  s=${s// /-}
  while [[ -n $s && ! $s =~ ^[a-z] ]]; do s=${s:1}; done
  printf '%s' "$s"
}

# Escape the five XML metacharacters, for text interpolated into raw HTML.
xml_escape() {
  local -- s=$1
  s=${s//&/&amp;}; s=${s//</&lt;}; s=${s//>/&gt;}
  s=${s//\"/&quot;}; s=${s//\'/&#39;}
  printf '%s' "$s"
}

# Stage greyscale JPEG copies of every source image, mirroring the on-disk
# layout so the .webp/.png -> .jpg rewrites that preprocess() performs resolve
# against --base-url. Source files are never modified.
#
# A black-and-white IngramSpark interior needs greyscale images carrying no ICC
# profile. Plain desaturation flattens a watercolour; the level and sigmoidal
# curve restore the tonal separation that press dot-gain would otherwise close
# up. -strip removes the colour profile IngramSpark rejects.
stage_images() {
  local -- stage=$1
  local -- src rel
  mkdir -p "$stage"/images || die 5 "failed to create image staging dir ${stage@Q}"
  while IFS= read -r -d '' src; do
    rel=${src#"$SCRIPT_DIR"/}
    mkdir -p "$stage/${rel%/*}" || die 5 "failed to create ${stage@Q}/${rel%/*}"
    convert "$src" -colorspace Gray -level 5%,95% -sigmoidal-contrast 3,50% \
      -strip -quality "$JPEG_QUALITY" "$stage/${rel%.*}.jpg" \
      || die 5 "greyscale conversion failed ${src@Q}"
  done < <(find "$SCRIPT_DIR"/images -maxdepth 2 \
             \( -name '*.webp' -o -name '*.png' \) -print0)
  # The Okusi mark for chapter openers, in the house navy. A black-and-white
  # interior wants 100% K, not a navy that the greyscale pass would render as
  # a dark grey, so a blackened copy is staged. The source SVG is untouched.
  [[ -f $LOGO_SRC ]] || die 3 "logo missing ${LOGO_SRC@Q}"
  sed 's/#0b295a/#000000/g' "$LOGO_SRC" >"$stage"/images/"${LOGO_SRC##*/}" \
    || die 5 "logo blackening failed ${LOGO_SRC@Q}"
}

# The four front-matter pages: half-title, title, imprint, contents. Roman
# folios, no running heads; the arabic sequence restarts at the Preface. The
# contents entries carry no page numbers here -- target-counter in
# lib/print-style.sh resolves them at render time, so they cannot drift from
# the pages they point at.
front_matter() {
  local -n _titles=$1
  local -- t id
  printf '<section class="front">\n'
  printf '<div class="halftitle"><p class="ht-title">%s</p></div>\n' "$(xml_escape "$TITLE")"
  printf '<div class="titlepage">\n'
  printf '<p class="tp-title">%s</p>\n' "$(xml_escape "$TITLE")"
  printf '<p class="tp-sub">%s</p>\n' "$(xml_escape "$SUBTITLE")"
  printf '<p class="tp-author">%s</p>\n' "$(xml_escape "$AUTHOR")"
  printf '<p class="tp-imprint">%s</p>\n' "$(xml_escape "$PUBLISHER")"
  printf '</div>\n'
  printf '<div class="imprint">\n'
  if [[ -f $IMPRINT_SRC ]]; then
    pandoc --from=markdown --to=html5 "$IMPRINT_SRC" \
      || die 1 "imprint conversion failed ${IMPRINT_SRC@Q}"
  else
    # Deliberately loud and deliberately on the page: a proof must not be sent
    # without the omission being impossible to miss.
    printf '<p class="placeholder">[IMPRINT COPY TO COME FROM TUWHIRI: print ISBN, '
    printf 'Tuwhiri&#39;s details, printing history, and the %s statement.]</p>\n' \
      "$(xml_escape "$LICENSE_NAME")"
    printf '<p class="placeholder">[%s]</p>\n' "$(xml_escape "$LICENSE_URL")"
  fi
  printf '</div>\n'
  # The entries sit inside their own div, so the contents heading is never
  # immediately followed by a <p>. The drop-cap rule is `h1 + p::first-letter`,
  # and a floated first letter inside a paragraph carrying a leader() and a
  # target-counter() crashes WeasyPrint's float layout outright. Keeping the
  # adjacency from ever arising here is structural, not cosmetic.
  printf '<nav class="contents"><h1>Contents</h1>\n<div class="toc-entries">\n'
  for t in "${_titles[@]}"; do
    id=$(slugify "$t")
    printf '<p><a href="#%s">%s</a></p>\n' "$id" "$(xml_escape "$t")"
  done
  printf '</div>\n</nav>\n</section>\n'
}

main() {
  local -- font_set=${FONT_SETS[0]} size='' lead='' preflight=''
  while (($#)); do
    case $1 in
      --size)      [[ -n ${2:-} ]] || die 2 '--size needs a value';  size=$2;      shift 2 ;;
      --lead)      [[ -n ${2:-} ]] || die 2 '--lead needs a value';  lead=$2;      shift 2 ;;
      --fonts)     [[ -n ${2:-} ]] || die 2 '--fonts needs a value'; font_set=$2;  shift 2 ;;
      --preflight) [[ -n ${2:-} ]] || die 2 '--preflight needs a file'; preflight=$2; shift 2 ;;
      -q|--quiet)  VERBOSE=0;   shift ;;
      --keep-temp) KEEP_TEMP=1; shift ;;
      -h|--help)   show_help; return 0 ;;
      -V|--version) printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; return 0 ;;
      *) die 2 "unknown option ${1@Q} (try --help)" ;;
    esac
  done

  if [[ -n $preflight ]]; then
    [[ -f $preflight ]] || die 3 "no such file ${preflight@Q}"
    "$PDFCHECK" check "$preflight" \
      --trim "${PRINT_TRIM_W_MM}x${PRINT_TRIM_H_MM}" \
      --require-even --require-blank-last
    return $?
  fi

  local -- tool
  for tool in pandoc weasyprint gs convert pdfunite pdfinfo jq; do
    command -v "$tool" &>/dev/null || die 18 "$tool not found"
  done
  [[ -x $PDFCHECK ]] || die 3 "missing or non-executable ${PDFCHECK@Q}"

  font_set_load "$font_set" "$SCRIPT_DIR"/fonts
  print_geom_load ${size:+"$size"} ${lead:+"$lead"}
  local -- font
  for font in "${FONT_FILES[@]}"; do
    [[ -f $font ]] || die 3 "font missing ${font@Q}"
  done

  # Essays 0..9 by numeric prefix, then the companion essay as the appendix.
  # Unlike mk-book.sh there is no cover.md: a print interior carries no cover.
  local -a sources=()
  local -i n
  local -a match
  for n in {0..9}; do
    match=("$SCRIPT_DIR/$n"-*.md)
    (( ${#match[@]} == 1 )) \
      || die 3 "expected exactly one file for essay $n, found ${#match[@]}"
    [[ -f ${match[0]} ]] || die 3 "essay $n source not found: ${match[0]}"
    sources+=("${match[0]}")
  done
  local -r APPENDIX="$SCRIPT_DIR"/the-better-ones.md
  [[ -f $APPENDIX ]] || die 3 "appendix source not found: ${APPENDIX@Q}"
  sources+=("$APPENDIX")

  # Install the cleanup trap before creating the temp dir, so a signal landing
  # between the two cannot leak it.
  trap '((KEEP_TEMP)) || rm -rf -- "$TMP_DIR"' EXIT
  trap 'exit 130' SIGINT
  trap 'exit 143' SIGTERM
  TMP_DIR=$(mktemp -d -t mkprint.XXXXXX) || die 5 'failed to create temp dir'
  local -r img_stage="$TMP_DIR"/img

  info 'checking glyph coverage'
  if [[ -x "$SCRIPT_DIR"/lib/glyphcheck.py ]]; then
    "$SCRIPT_DIR"/lib/glyphcheck.py "${FONT_FILES[@]}" -- "${sources[@]}" \
      || die 1 'a source character is missing from the bound faces'
  fi

  info 'staging greyscale images'
  stage_images "$img_stage"

  # Preprocess into ordered temp files so chapter order survives the glob.
  local -a inputs=() titles=()
  local -i i=0
  local -- src dst title
  for src in "${sources[@]}"; do
    printf -v dst '%s/%02d-%s' "$TMP_DIR" "$i" "${src##*/}"
    preprocess "$src" >"$dst" || die 1 "preprocessing failed for ${src@Q}"
    if [[ $src == "$APPENDIX" ]]; then
      # Same appendix treatment as mk-book.sh: label it, strip the repo-surface
      # headnote. Exact-match rewrite plus check, so a future title change
      # fails the build loudly instead of shipping unlabelled.
      sed -i 's/^# Dharmas: The Better Ones$/# Appendix: Dharmas, the Better Ones/' "$dst" \
        || die 1 "appendix H1 rewrite failed for ${dst@Q}"
      grep -q '^# Appendix: ' "$dst" \
        || die 1 "appendix H1 not rewritten in ${dst@Q} (title changed in ${APPENDIX@Q}?)"
      sed -i -e '/^\*A discussion piece /d' -e '0,/^---$/{/^---$/d}' "$dst" \
        || die 1 "appendix headnote strip failed for ${dst@Q}"
    fi
    # The print interior carries no audio links: a hyperlink is useless on
    # paper, and the bare URL belongs to the reading PDF, not a printed book.
    sed -i '/^<p class="audio">/d' "$dst" || die 1 "audio strip failed for ${dst@Q}"
    title=$(sed -n 's/^# //p' "$dst" | head -1)
    [[ -n $title ]] || die 1 "no H1 heading found in ${dst@Q}"
    titles+=("$title")
    inputs+=("$dst")
    i+=1
  done

  # One <section class="chapter"> per source, so the stylesheet can give each
  # chapter's opener its own page rules without guessing where chapters begin.
  # pandoc is run per file rather than once over all of them, because a single
  # invocation emits one flat document with no chapter boundary to target.
  info "rendering ${#inputs[@]} chapters"
  local -- frag
  local -i chapter_n=0
  local -r body_html="$TMP_DIR"/body.html
  : >"$body_html"
  for dst in "${inputs[@]}"; do
    frag=$(pandoc --from=markdown-yaml_metadata_block --to=html5 "$dst" \
             | "$SCRIPT_DIR"/lib/dropcap.py) \
      || die 1 "pandoc failed for ${dst@Q}"
    # The first chapter carries an extra class: the stylesheet restarts the
    # arabic page sequence there, and no CSS selector can find "the first
    # section that is a chapter" on its own, because section.front is also a
    # <section> and so takes :first-of-type.
    printf '<section class="chapter%s">\n%s\n</section>\n' \
      "$( ((chapter_n == 0)) && printf ' first' )" "$frag" >>"$body_html"
    chapter_n+=1
  done

  # Sources & further reading sets smaller. Wrap from that h2 to the end of its
  # own section: open a div at the heading, and close it only in sections that
  # opened one (awk, because the close must be conditional -- a blanket sed
  # would close a div in every chapter whether or not one was opened).
  awk '
    /^<section class="chapter">/ { insec = 1; opened = 0 }
    /<h2 id="sources/            { if (insec && !opened) { print "<div class=\"sources\">"; opened = 1 } }
    /^<\/section>/               { if (opened) { print "</div>"; opened = 0 }; insec = 0 }
    { print }
  ' "$body_html" >"$body_html".wrapped || die 1 'sources wrap failed'
  mv -- "$body_html".wrapped "$body_html" || die 5 'sources wrap move failed'

  local -- css="$TMP_DIR"/print.css
  { font_faces_css pdf; print_page_css; } >"$css" \
    || die 5 "failed to write ${css@Q}"
  cp -- "$css" "$img_stage"/print.css || die 5 'failed to stage the stylesheet'

  local -- front="$TMP_DIR"/front.html
  front_matter titles >"$front" || die 5 "failed to write ${front@Q}"

  local -- doc="$img_stage"/book.html
  {
    printf '<!doctype html><html lang="en"><head><meta charset="utf-8">\n'
    printf '<title>%s</title><link rel="stylesheet" href="print.css"></head><body>\n' \
      "$(xml_escape "$TITLE")"
    cat "$front"
    cat "$body_html"
    printf '</body></html>\n'
  } >"$doc" || die 5 "failed to write ${doc@Q}"

  local -r raw_pdf="$TMP_DIR"/raw.pdf
  info "typesetting at ${PRINT_SIZE_PT}pt on ${PRINT_LEAD_PT}pt"
  weasyprint --base-url "$img_stage"/ "$doc" "$raw_pdf" \
    || die 1 'weasyprint failed'

  local -r padded="$TMP_DIR"/padded.pdf
  pad_to_even "$raw_pdf" "$padded"

  # WeasyPrint writes black as DeviceRGB 0 0 0. The model book sets its text in
  # 100% K, and IngramSpark's B&W interior rules forbid ICC profiles.
  # Ghostscript converts the whole file to DeviceGray while keeping every font
  # embedded and subset, and preserves the trim to two decimals.
  info 'converting to DeviceGray'
  gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite \
     -dProcessColorModel=/DeviceGray -sColorConversionStrategy=Gray \
     -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress \
     -dSubsetFonts=true -dEmbedAllFonts=true -dAutoRotatePages=/None \
     -dDetectDuplicateImages=true \
     -sOutputFile="$OUTPUT_PDF" "$padded" \
    || die 1 'greyscale conversion failed'

  info 'running preflight'
  "$PDFCHECK" check "$OUTPUT_PDF" \
    --trim "${PRINT_TRIM_W_MM}x${PRINT_TRIM_H_MM}" \
    --require-even --require-blank-last \
    || { rm -f -- "$OUTPUT_PDF"
         die 1 'preflight failed; no file was written for upload'; }

  info "done: $OUTPUT_PDF ($(du -h --apparent-size "$OUTPUT_PDF" | cut -f1))"
  ((KEEP_TEMP)) && info "build directory kept: $TMP_DIR"
  return 0
}

# IngramSpark: "The final page should be blank. If there is no blank page,
# we'll add one for you." Adding it here keeps the page count ours to control,
# and Tuwhiri requires a multiple of 2.
#
# Forcing chapter openers onto rectos already leaves blank versos, so the book
# often ends blank and even with nothing to do. Four cases, in order:
#   even + last blank -> nothing to add
#   odd  + last blank -> one blank (even, still ends blank)
#   even + last inked -> two blanks (even, ends blank)
#   odd  + last inked -> one blank (even, ends blank)
pad_to_even() {
  local -- src=$1 out=$2
  local -i pages last_blank=0 add=0
  pages=$(pdfinfo "$src" | awk '/^Pages:/{print $2}')
  # blank_pages is a pretty-printed JSON array, so it spans lines; grep with .*
  # cannot match across them. Ask jq whether the last page is in the list.
  if "$PDFCHECK" measure "$src" \
       | jq --argjson p "$pages" -e '.blank_pages | index($p)' >/dev/null; then
    last_blank=1
  fi
  if ((last_blank)); then
    add=$(( pages % 2 ))
  else
    add=$(( pages % 2 == 0 ? 2 : 1 ))
  fi
  if ((add == 0)); then
    cp -- "$src" "$out" || die 5 "failed to copy ${src@Q}"
    info "page count $pages is even and ends blank; nothing to pad"
    return 0
  fi
  local -- blank="$TMP_DIR"/blank.pdf
  printf '<!doctype html><html lang="en"><head><meta charset="utf-8"><style>@page{size:%smm %smm;margin:0}</style></head><body></body></html>' \
    "$PRINT_TRIM_W_MM" "$PRINT_TRIM_H_MM" >"$TMP_DIR"/blank.html \
    || die 5 'failed to write the blank page source'
  weasyprint "$TMP_DIR"/blank.html "$blank" || die 1 'blank-page render failed'
  local -a parts=("$src")
  local -i j
  for ((j = 0; j < add; j++)); do parts+=("$blank"); done
  pdfunite "${parts[@]}" "$out" || die 1 'pdfunite failed'
  info "padded $pages -> $((pages + add)) pages"
}

main "$@"
#fin
