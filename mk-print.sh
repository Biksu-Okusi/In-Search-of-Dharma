#!/bin/bash
# mk-print.sh - Build the print-ready interior PDF of "In Search of Dharma"
# for Tuwhiri's printer.
#
#   ./mk-print.sh [--size PT] [--lead PT] [--fonts SET] [--output FILE]
#                 [--quiet] [--keep-temp]
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
# One rule is the book's own rather than the printer's: no word may lie outside
# the measure, which a renderer fault once allowed (see the strong,b rule in
# lib/print-style.sh). lib/pdfcheck.py asserts all of that against the finished
# file, and the build refuses to write a non-conforming PDF.
#
# Sources, preprocessing and typefaces are shared with mk-book.sh through
# lib/preprocess.sh and lib/fonts.sh: one set of sources, one reading of them.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (pandoc, weasyprint, gs, convert, pdfunite,
# pdfinfo, jq) must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

declare -r VERSION=1.0.0
#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='In search of dharma'
# The half-title and title page set the title all in lowercase, as the cover
# does (the author's decision, 2026-09-23), stacked in two parts: the lead-in
# over the name. TITLE keeps its capital as the bibliographic form, used for
# the HTML document's own <title>.
declare -r TITLE_LEAD='in search of' TITLE_NAME='dharma'
declare -r TITLE_TYPESET="$TITLE_LEAD $TITLE_NAME"
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

# Where the interior is written, unless --output names another file: a test or
# a proof setting is built beside the interior, never over it.
declare -r DEFAULT_OUTPUT_PDF="$SCRIPT_DIR"/In-Search-of-Dharma_interior_152x229.pdf
# Optional imprint copy from Tuwhiri. Absent, a deliberately visible placeholder
# is set instead, so a proof cannot be sent without the omission being obvious.
declare -r IMPRINT_SRC="$SCRIPT_DIR"/print-imprint.md
# Optional endorsements, set on page i ahead of the half-title. Absent, the
# interior opens on the half-title.
declare -r ENDORSE_SRC="$SCRIPT_DIR"/print-endorsements.md
# The Okusi mark, set on the rule above each chapter title in place of the
# roundel Tuwhiri uses in its own books.
declare -r LOGO_SRC="$SCRIPT_DIR"/images/dharma-eye.svg
# Tuwhiri's word mark, black only, set on the title page in place of the
# publisher's name (Ramsey Margolis, 2026-09-23). It is Tuwhiri's trademark, not
# this repository's to license, so it lives in the untracked print/ folder with
# the publisher's other material. Absent, the name is set instead, with a warning.
declare -r WORDMARK_SRC="$SCRIPT_DIR"/print/tuwhiri-wordmark-black.jpg
# Part watercolours in the printed interior. Off: in greyscale on a 107mm
# measure they take a large part of an opener and earn little, and they
# compete with the rule and the mark that open each chapter. The reading PDF
# and the EPUB keep them, in colour. Set to 1 to put them back in print;
# this flag is the only thing that needs changing.
declare -ir PRINT_CHAPTER_ART=0

declare -r FONT_LIB="$SCRIPT_DIR"/lib/fonts.sh
declare -r PREPROCESS_LIB="$SCRIPT_DIR"/lib/preprocess.sh
declare -r STYLE_LIB="$SCRIPT_DIR"/lib/print-style.sh
declare -r PDFCHECK="$SCRIPT_DIR"/lib/pdfcheck.py

# Script-scope state, declared before any function (BCS0105).
declare -i VERBOSE=1 KEEP_TEMP=0
declare -- TMP_DIR='' OUTPUT_PDF=$DEFAULT_OUTPUT_PDF LIB=''

# Messaging (BCS0703). error() is unconditional; die() takes the exit code
# first, then an optional message.
_msg()  { >&2 printf '%s: %s %s\n' "$SCRIPT_NAME" "$1" "${*:2}"; }
info()  { ((VERBOSE)) || return 0; _msg '◉' "$@"; }
warn()  { _msg '▲' "$@"; }
error() { _msg '✗' "$@"; }
die()   { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }

# Sourced at file scope, not from a function: the libraries declare their
# globals with plain `declare`, which inside a function would make them local.
for LIB in "$FONT_LIB" "$PREPROCESS_LIB" "$STYLE_LIB"; do
  [[ -f $LIB ]] || die 3 "missing library ${LIB@Q}"
done
unset LIB
#shellcheck source=lib/fonts.sh
source -- "$FONT_LIB"       || die 1 "failed to source ${FONT_LIB@Q}"
#shellcheck source=lib/preprocess.sh
source -- "$PREPROCESS_LIB" || die 1 "failed to source ${PREPROCESS_LIB@Q}"
#shellcheck source=lib/print-style.sh
source -- "$STYLE_LIB"      || die 1 "failed to source ${STYLE_LIB@Q}"

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
  --output FILE    write the interior to FILE (default ${DEFAULT_OUTPUT_PDF##*/})
  --preflight FILE check an existing PDF against the printer's rules and stop
  -q, --quiet      suppress progress messages
  --keep-temp      leave the build directory in place for inspection
  -h, --help       this message
  -V, --version    print the version

The interior only: IngramSpark requires the cover uploaded as a separate file.
Output: ${DEFAULT_OUTPUT_PDF##*/}
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

# Escape the five XML metacharacters, for text interpolated into raw HTML. Each
# replacement is quoted: Bash 5.2 reads a bare & in a replacement as the text
# that matched, which turned < into <lt; and " into "quot;.
xml_escape() {
  local -- s=$1
  s=${s//&/'&amp;'}; s=${s//</'&lt;'}; s=${s//>/'&gt;'}
  s=${s//\"/'&quot;'}; s=${s//\'/'&#39;'}
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
  mkdir -p -- "$stage"/images || die 5 "failed to create image staging dir ${stage@Q}"
  if ((PRINT_CHAPTER_ART)); then
    while IFS= read -r -d '' src; do
      rel=${src#"$SCRIPT_DIR"/}
      mkdir -p -- "$stage/${rel%/*}" || die 5 "failed to create a directory for ${rel@Q} under ${stage@Q}"
      convert "$src" -colorspace Gray -level 5%,95% -sigmoidal-contrast 3,50% \
        -strip -quality "$JPEG_QUALITY" "$stage/${rel%.*}.jpg" \
        || die 5 "greyscale conversion failed ${src@Q}"
    done < <(find -- "$SCRIPT_DIR"/images -maxdepth 2 \
               \( -name '*.webp' -o -name '*.png' \) -print0)
  fi
  # The Okusi mark for chapter openers, whose source is the house navy. Left
  # to the greyscale pass a navy lands wherever its luminance happens to fall,
  # so the tint is chosen instead: 75% black, at the publisher's request, which
  # sits the mark back from the 100% K of the title beside it. #404040 is that
  # tint (0.251 grey), and DeviceGray carries it through unchanged. The source
  # SVG is untouched.
  # Tuwhiri's word mark arrives as an sRGB-tagged JPEG of grey pixels: made
  # single-channel grey and stripped of its profile, like every other image.
  if [[ -f $WORDMARK_SRC ]]; then
    convert "$WORDMARK_SRC" -colorspace Gray -strip -quality "$JPEG_QUALITY" \
      "$stage"/images/"${WORDMARK_SRC##*/}" || die 5 "failed to stage the word mark ${WORDMARK_SRC@Q}"
  fi
  [[ -f $LOGO_SRC ]] || die 3 "logo missing ${LOGO_SRC@Q}"
  sed -- 's/#0b295a/#404040/g' "$LOGO_SRC" >"$stage"/images/"${LOGO_SRC##*/}" \
    || die 5 "logo tinting failed ${LOGO_SRC@Q}"
}

# The front matter: the endorsements where there are any, then half-title,
# title, imprint and contents. No
# running heads; roman folios, shown from the contents on (see the bare page in
# lib/print-style.sh). The Preface follows in the same roman sequence, and the
# arabic sequence starts at Part 1, as Tuwhiri asked (2026-09-28). The
# contents entries carry no page numbers here -- target-counter in
# lib/print-style.sh resolves them at render time, so they cannot drift from
# the pages they point at. The first entry, the Preface's, is marked to read
# its number in roman.
front_matter() {
  local -n _titles=$1
  local -- t id
  local -i k=0
  printf '<section class="front">\n'
  # The endorsements run through smallcaps.py like the text: a name the cover
  # sets in capitals is set here in small capitals, as the house style has it.
  if [[ -f $ENDORSE_SRC ]]; then
    printf '<div class="endorsements">\n'
    pandoc --from=markdown --to=html5 -- "$ENDORSE_SRC" | "$SCRIPT_DIR"/lib/smallcaps.py \
      || die 1 "endorsements conversion failed ${ENDORSE_SRC@Q}"
    printf '</div>\n'
  fi
  local -- stack
  printf -v stack '<span class="t-lead">%s</span><span class="t-name">%s</span>' \
    "$(xml_escape "$TITLE_LEAD")" "$(xml_escape "$TITLE_NAME")"
  printf '<div class="halftitle"><p class="ht-title">%s</p></div>\n' "$stack"
  printf '<div class="titlepage">\n'
  printf '<p class="tp-title">%s</p>\n' "$stack"
  printf '<p class="tp-sub">%s</p>\n' "$(xml_escape "$SUBTITLE")"
  printf '<p class="tp-author">%s</p>\n' "$(xml_escape "$AUTHOR")"
  if [[ -f $WORDMARK_SRC ]]; then
    printf '<p class="tp-imprint"><img class="tp-mark" src="images/%s" alt="%s"></p>\n' \
      "${WORDMARK_SRC##*/}" "$(xml_escape "$PUBLISHER")"
  else
    warn "no word mark at ${WORDMARK_SRC@Q}: the title page carries the publisher's name instead"
    printf '<p class="tp-imprint">%s</p>\n' "$(xml_escape "$PUBLISHER")"
  fi
  printf '</div>\n'
  printf '<div class="imprint">\n'
  if [[ -f $IMPRINT_SRC ]]; then
    pandoc --from=markdown --to=html5 -- "$IMPRINT_SRC" \
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
    printf '<p%s><a href="#%s">%s</a></p>\n' \
      "$( ((k)) || printf ' class="roman"' )" "$id" "$(xml_escape "$t")"
    k+=1
  done
  printf '</div>\n</nav>\n</section>\n'
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
  pages=$(pdfinfo -- "$src" | awk '/^Pages:/{print $2}') \
    || die 1 "pdfinfo failed for ${src@Q}"
  ((pages > 0)) || die 1 "no page count read from ${src@Q}"
  # blank_pages is a pretty-printed JSON array, so it spans lines; grep with .*
  # cannot match across them. Ask jq whether the last page is in the list. jq -e
  # exits 1 for "not in the list" and higher for a real failure, and the two
  # must not be confused: a failure read as "last page inked" pads wrongly.
  local -- measured
  local -i rc=0
  measured=$("$PDFCHECK" measure -- "$src") || die 1 "pdfcheck measure failed for ${src@Q}"
  jq --argjson p "$pages" -e '.blank_pages | index($p)' <<<"$measured" >/dev/null || rc=$?
  case $rc in
    0) last_blank=1 ;;
    1) ;;
    *) die 1 "could not read blank_pages for ${src@Q} (jq exit $rc)" ;;
  esac
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
  {
    printf '<!doctype html><html lang="en"><head><meta charset="utf-8">' \
      && printf '<style>@page{size:%smm %smm;margin:0}</style></head><body></body></html>' \
           "$PRINT_TRIM_W_MM" "$PRINT_TRIM_H_MM"
  } >"$TMP_DIR"/blank.html || die 5 'failed to write the blank page source'
  weasyprint -- "$TMP_DIR"/blank.html "$blank" || die 1 'blank-page render failed'
  local -a parts=("$src")
  local -i j
  for ((j = 0; j < add; j+=1)); do parts+=("$blank"); done
  pdfunite -- "${parts[@]}" "$out" || die 1 'pdfunite failed'
  info "padded $pages -> $((pages + add)) pages"
}

main() {
  local -- font_set=${FONT_SETS[0]} size='' lead='' preflight=''
  while (($#)); do
    case $1 in
      --size)      [[ -n ${2:-} ]] || die 2 '--size needs a value';  size=$2;      shift 2 ;;
      --lead)      [[ -n ${2:-} ]] || die 2 '--lead needs a value';  lead=$2;      shift 2 ;;
      --fonts)     [[ -n ${2:-} ]] || die 2 '--fonts needs a value'; font_set=$2;  shift 2 ;;
      --preflight) [[ -n ${2:-} ]] || die 2 '--preflight needs a file'; preflight=$2; shift 2 ;;
      --output)    [[ -n ${2:-} ]] || die 2 '--output needs a file';    OUTPUT_PDF=$2; shift 2 ;;
      -q|--quiet)  VERBOSE=0;   shift ;;
      --keep-temp) KEEP_TEMP=1; shift ;;
      -h|--help)   show_help; return 0 ;;
      -V|--version) printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; return 0 ;;
      # Short options run together (-qV) are taken apart and read one by one.
      -[qhV]?*)    set -- "${1:0:2}" "-${1:2}" "${@:2}" ;;
      *) die 2 "unknown option ${1@Q} (try --help)" ;;
    esac
  done
  readonly VERBOSE KEEP_TEMP
  # Absolute: Ghostscript is handed the name inside -sOutputFile=, where a
  # relative name beginning with a dash or a percent sign would be misread.
  OUTPUT_PDF=$(realpath -m -- "$OUTPUT_PDF") || die 22 "invalid --output value ${OUTPUT_PDF@Q}"
  # A name of any other kind is most likely a slip, and could be a source.
  local -r out_name=${OUTPUT_PDF##*/} out_dir=${OUTPUT_PDF%/*}
  [[ $out_name == *.pdf ]] || die 22 "--output wants a name ending .pdf, not ${out_name@Q}"
  [[ -d $out_dir ]] || die 3 "no such directory for --output ${out_dir@Q}"
  readonly OUTPUT_PDF
  # Both reach the stylesheet as "${size}pt", so they are held to a number.
  [[ -z $size || $size =~ ^[0-9]+(\.[0-9]+)?$ ]] || die 22 "invalid --size value ${size@Q}"
  [[ -z $lead || $lead =~ ^[0-9]+(\.[0-9]+)?$ ]] || die 22 "invalid --lead value ${lead@Q}"

  if [[ -n $preflight ]]; then
    [[ -f $preflight ]] || die 3 "no such file ${preflight@Q}"
    # Options first, then --: the name is the user's, and one beginning with a
    # dash must reach the checker as a file.
    "$PDFCHECK" check \
      --trim "${PRINT_TRIM_W_MM}x${PRINT_TRIM_H_MM}" \
      --measure "$PRINT_MEASURE_MM" --inner "$PRINT_INNER_MM" \
      --require-even --require-blank-last -- "$preflight"
    return $?
  fi

  local -- tool
  for tool in pandoc weasyprint gs convert pdfunite pdfinfo jq; do
    command -v "$tool" &>/dev/null || die 18 "$tool not found"
  done
  [[ -x $PDFCHECK ]] || die 3 "missing or non-executable ${PDFCHECK@Q}"

  font_set_load "$font_set" "$SCRIPT_DIR"/fonts || die 22 "invalid --fonts value ${font_set@Q}"
  # Both arguments always, empty for "default": with an unset size dropped from
  # the list, --lead given alone would land in the size's position.
  print_geom_load "$size" "$lead"
  local -- font
  local -a title_fonts=()
  readarray -t title_fonts < <(print_title_files "$SCRIPT_DIR"/fonts)
  ((${#title_fonts[@]})) || die 3 'no title faces listed by lib/print-style.sh'
  for font in "${FONT_FILES[@]}" "${title_fonts[@]}"; do
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
    [[ -f ${match[0]} ]] || die 3 "essay $n source not found: ${match[0]@Q}"
    sources+=("${match[0]}")
  done
  local -r appendix="$SCRIPT_DIR"/the-better-ones.md
  [[ -f $appendix ]] || die 3 "appendix source not found: ${appendix@Q}"
  sources+=("$appendix")

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
    # The title faces set one string, so that string is all they are held to:
    # asking Cascadia for every character in the book would fail the build over
    # glyphs it is never asked to draw.
    printf '%s\n' "$TITLE_TYPESET" >"$TMP_DIR"/title.txt || die 5 'failed to stage the title text'
    "$SCRIPT_DIR"/lib/glyphcheck.py "${title_fonts[@]}" -- "$TMP_DIR"/title.txt \
      || die 1 'a title character is missing from the title faces'
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
    if [[ $src == "$appendix" ]]; then
      # Same appendix treatment as mk-book.sh: label it, strip the repo-surface
      # headnote. Exact-match rewrite plus check, so a future title change
      # fails the build loudly instead of shipping unlabelled.
      sed -i -- 's/^# Dharmas: the better ones$/# Appendix: Dharmas, the better ones/' "$dst" \
        || die 1 "appendix H1 rewrite failed for ${dst@Q}"
      grep -q -- '^# Appendix: ' "$dst" \
        || die 1 "appendix H1 not rewritten in ${dst@Q} (title changed in ${appendix@Q}?)"
      sed -i -e '/^\*A discussion piece /d' -e '0,/^---$/{/^---$/d}' -- "$dst" \
        || die 1 "appendix headnote strip failed for ${dst@Q}"
    fi
    # The print interior carries no audio links: a hyperlink is useless on
    # paper, and the bare URL belongs to the reading PDF, not a printed book.
    sed -i -- '/^<p class="audio">/d' "$dst" || die 1 "audio strip failed for ${dst@Q}"
    # Nor the end-of-chapter furniture: the "« previous | next »" line is web
    # navigation, and the rule under it divides the essay from its Sources,
    # which in print begin on a page of their own. Every staged source holds
    # exactly one such rule; the appendix headnote rule is already gone.
    sed -i -E -e '/^(« .*|.* »)$/d' -e '/^---$/d' -- "$dst" \
      || die 1 "chapter-end marker strip failed for ${dst@Q}"
    # Drop the Part watercolour unless PRINT_CHAPTER_ART is set. preprocess()
    # has already turned the <image ...> shortcode into a standalone Markdown
    # image on its own line, which is the only image any source carries.
    ((PRINT_CHAPTER_ART)) \
      || sed -i -E -- '/^!\[[^]]*\]\(images\/[^)]*\)$/d' "$dst" \
      || die 1 "chapter-art strip failed for ${dst@Q}"
    title=$(sed -n -- '/^# /{s///p;q}' "$dst") || die 1 "cannot read the H1 of ${dst@Q}"
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
  local -- frag cls
  local -i chapter_n=0
  local -r body_html="$TMP_DIR"/body.html
  : >"$body_html" || die 5 "failed to create ${body_html@Q}"
  for dst in "${inputs[@]}"; do
    # A paragraph that is nothing but a bold run is a label, and is marked as
    # one here for the stylesheet (see .sources p.label in lib/print-style.sh).
    # dropcap.py runs before smallcaps.py: it scans for a line that begins
    # "<p>" and takes the first two words, which a <span> inserted ahead of it
    # would hide. researchnotes.py sets the Research notes block for paper
    # (Ramsey, 2026-09-28) and finds it by that label, so it runs after the sed.
    frag=$(pandoc --from=markdown-yaml_metadata_block --to=html5 -- "$dst" \
             | sed -E 's|^<p><strong>([^<]*)</strong></p>$|<p class="label">\1</p>|' \
             | "$SCRIPT_DIR"/lib/dropcap.py \
             | "$SCRIPT_DIR"/lib/smallcaps.py \
             | "$SCRIPT_DIR"/lib/researchnotes.py) \
      || die 1 "pandoc failed for ${dst@Q}"
    # The Preface (chapter 0) is a preliminary, numbered in roman with the
    # front matter; Part 1 (chapter 1) is where the arabic sequence starts.
    # Each carries a class for the stylesheet, since no CSS selector can count
    # sections: section.front is also a <section>.
    case $chapter_n in
      0) cls=' prelim' ;;
      1) cls=' first' ;;
      *) cls='' ;;
    esac
    printf '<section class="chapter%s">\n%s\n</section>\n' "$cls" "$frag" >>"$body_html" \
      || die 5 "failed to append to ${body_html@Q}"
    chapter_n+=1
  done

  # Sources & further reading sets smaller. Wrap from that h2 to the end of its
  # own section: open a div at the heading, and close it only in sections that
  # opened one (awk, because the close must be conditional -- a blanket sed
  # would close a div in every chapter whether or not one was opened). The
  # section test takes the class PREFIX: the first chapter is "chapter first",
  # and an exact match once left the Preface's sources unwrapped -- full size,
  # and running on from the text instead of opening a page of their own.
  awk -- '
    /^<section class="chapter[ "]/ { insec = 1; opened = 0 }
    /<h2 id="sources/            { if (insec && !opened) { print "<div class=\"sources\">"; opened = 1 } }
    /^<\/section>/               { if (opened) { print "</div>"; opened = 0 }; insec = 0 }
    { print }
  ' "$body_html" >"$body_html".wrapped || die 1 'sources wrap failed'
  mv -- "$body_html".wrapped "$body_html" || die 5 'sources wrap move failed'

  local -- css="$TMP_DIR"/print.css
  # Chained with &&: a group tested by || runs with errexit off, so with plain
  # semicolons only the last command's status would be seen, and a failed
  # font_faces_css would leave a stylesheet with no faces in it.
  { font_faces_css pdf \
      && print_title_faces_css "$SCRIPT_DIR"/fonts \
      && print_page_css; } >"$css" \
    || die 5 "failed to write ${css@Q}"
  cp -- "$css" "$img_stage"/print.css || die 5 'failed to stage the stylesheet'

  local -- front="$TMP_DIR"/front.html
  front_matter titles >"$front" || die 5 "failed to write ${front@Q}"

  local -- doc="$img_stage"/book.html
  {
    printf '<!doctype html><html lang="en"><head><meta charset="utf-8">\n' \
      && printf '<title>%s</title><link rel="stylesheet" href="print.css"></head><body>\n' \
           "$(xml_escape "$TITLE")" \
      && cat -- "$front" \
      && cat -- "$body_html" \
      && printf '</body></html>\n'
  } >"$doc" || die 5 "failed to write ${doc@Q}"

  local -r raw_pdf="$TMP_DIR"/raw.pdf
  info "typesetting at ${PRINT_SIZE_PT}pt on ${PRINT_LEAD_PT}pt"
  weasyprint --base-url "$img_stage"/ -- "$doc" "$raw_pdf" \
    || die 1 'weasyprint failed'

  local -r padded="$TMP_DIR"/padded.pdf
  pad_to_even "$raw_pdf" "$padded"

  # WeasyPrint writes black as DeviceRGB 0 0 0. The model book sets its text in
  # 100% K, and IngramSpark's B&W interior rules forbid ICC profiles.
  # Ghostscript converts the whole file to DeviceGray while keeping every font
  # embedded and subset, and preserves the trim to two decimals.
  # Written and checked in the build directory, and put in place only once it
  # conforms. Ghostscript reads a percent sign in its output name as a page
  # number pattern, which a name of the build's own choosing cannot contain.
  local -r finished="$TMP_DIR"/interior.pdf
  info 'converting to DeviceGray'
  gs -q -dBATCH -dNOPAUSE -dSAFER -sDEVICE=pdfwrite \
     -dProcessColorModel=/DeviceGray -sColorConversionStrategy=Gray \
     -dCompatibilityLevel=1.6 -dPDFSETTINGS=/prepress \
     -dSubsetFonts=true -dEmbedAllFonts=true -dAutoRotatePages=/None \
     -dDetectDuplicateImages=true \
     -sOutputFile="$finished" "$padded" \
    || die 1 'greyscale conversion failed'

  info 'running preflight'
  if ! "$PDFCHECK" check \
         --trim "${PRINT_TRIM_W_MM}x${PRINT_TRIM_H_MM}" \
         --measure "$PRINT_MEASURE_MM" --inner "$PRINT_INNER_MM" \
         --require-even --require-blank-last -- "$finished"; then
    # The interior under its own name is this script's work and nobody else's:
    # an earlier one is removed, so that what lies there can never be mistaken
    # for the build that has just failed. A file named with --output is the
    # caller's, and is left as it was found.
    [[ $OUTPUT_PDF != "$DEFAULT_OUTPUT_PDF" ]] || rm -f -- "$OUTPUT_PDF"
    die 1 'preflight failed; no file was written for upload'
  fi
  # Copied beside its destination and renamed into place, so the destination
  # holds either the file that was there or the whole of the new one.
  local -r staged="$OUTPUT_PDF".part
  if ! cp -- "$finished" "$staged" || ! mv -f -- "$staged" "$OUTPUT_PDF"; then
    rm -f -- "$staged"
    die 5 "failed to write ${OUTPUT_PDF@Q}"
  fi

  info "done: $OUTPUT_PDF ($(du -h --apparent-size -- "$OUTPUT_PDF" | cut -f1))"
  ((KEEP_TEMP == 0)) || info "build directory kept: $TMP_DIR"
}

main "$@"
#fin
