#!/bin/bash
# mk-book.sh - Build "In Search of Dharma" (EPUB and/or PDF) from cover.md + 0..9.
#
#   ./mk-book.sh [epub|pdf|all] [--audio none|link|embed]   (defaults: all, link)
#
# Audio narration (one MP3 per chapter, 0..9) is referenced at the top of each
# chapter. Modes (--audio):
#   link   (default) per-chapter hyperlink to https://garydean.id/audio/N-...mp3.
#          The EPUB shows a "Listen to this chapter" link; the PDF shows the bare
#          URL instead (invisible hyperlinks are useless on paper, so a print
#          reader gets a typable address). Tiny output; needs a network
#          connection at read-time.
#   embed  the MP3s are bundled inside the EPUB (~61 MB; EPUB target only,
#          distribute via GitHub Releases). Output gets a _with-audio suffix.
#   none   no narration reference at all.
# The canonical MP3s are read straight from the web-root; they are never copied
# into the repository.
#
# Preprocesses each source Markdown file (strips YAML frontmatter, converts the
# custom `<image r 40 "src" "alt" "cap">` shortcode into a standard Markdown
# image, rewrites web-root image paths to on-disk paths and images to JPEG), then
# stitches them into an EPUB3 with pandoc and/or a PDF via the weasyprint engine.
#
# The EPUB follows Standard Ebooks conventions as far as a pandoc pipeline
# practicably can (https://standardebooks.org/manual): a stable URL identifier,
# CC BY licence as dc:rights, EPUB Accessibility 1.1 (schema:*) metadata,
# semantic epub:type inflection (titlepage / bodymatter chapter / colophon), a
# generated colophon, and a hard epubcheck validation gate. Reading fonts remain
# embedded (a deliberate divergence from Standard Ebooks, which defers to the
# reader's device) so the book renders identically everywhere.
set -euo pipefail
shopt -s inherit_errexit

# Fixed PATH: every external tool (pandoc, convert, weasyprint, zip, epubcheck)
# must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

# correct — handles every install pattern, including symlinked wrappers
declare -r VERSION=1.1.0
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

declare -r TITLE='In Search of Dharma'
declare -r SUBTITLE='What holds a life, a people, a world together'
declare -r TAGLINE='A natural history of ethics'
declare -r AUTHOR='Biksu Okusi'
declare -r LANGUAGE=en

# Bibliographic identity, following Standard Ebooks conventions as far as a
# pandoc pipeline practicably can (https://standardebooks.org/manual). A stable
# URL identifier makes releases reproducible (pandoc otherwise mints a fresh
# random UUID on every build). The licence is machine-declared in the OPF via
# dc:rights and echoed on the title/colophon pages; see LICENSE.
declare -r IDENTIFIER='https://garydean.id/books/in-search-of-dharma'
declare -r PUB_DATE=2026-08
declare -r LICENSE_NAME='Creative Commons Attribution 4.0 International (CC BY 4.0)'
declare -r LICENSE_URL='https://creativecommons.org/licenses/by/4.0/'
declare -r -a SUBJECTS=(Anthropology Philosophy)
# The lettered cover: the watercolour with title, subtitle and author laid over
# it by images/defining-dharma-gentitle.sh, which takes the strings below as its
# source of truth. Re-run that script after changing TITLE, SUBTITLE, TAGLINE or
# AUTHOR.
declare -r COVER_IMAGE="$SCRIPT_DIR"/images/defining-dharma-cover-title.png
# The lettered back cover: the blurb from BACKCOVER_In-Search-of-Dharma.md laid
# over the back art by images/defining-dharma-genback.sh. Re-run that script
# after editing the blurb. It closes the book as its final page.
declare -r BACK_IMAGE="$SCRIPT_DIR"/images/defining-dharma-back-text.png
declare -r OUTPUT="$SCRIPT_DIR"/In-Search-of-Dharma_Biksu-Okusi_2026.epub
declare -r OUTPUT_PDF="${OUTPUT%.epub}".pdf
declare -r OUTPUT_AUDIO="${OUTPUT%.epub}"_with-audio.epub

# Chapter narration. One MP3 per chapter, named N-<stem>.mp3 (N = 0..9), living
# canonically under the garydean.id web-root and served from AUDIO_BASE_URL. The
# embed build reads them via --resource-path=AUDIO_WEBROOT (so "audio/N-...mp3"
# resolves); nothing is copied into the repo.
declare -r AUDIO_SRC_DIR=/var/www/vhosts/garydean.id/html/audio
declare -r AUDIO_WEBROOT=${AUDIO_SRC_DIR%/audio}
declare -r AUDIO_BASE_URL=https://garydean.id/audio
declare -r AUDIO_STEM=in-search-of-dharma

# Research-note links. Each essay's "Sources & further reading" section links the
# notes it draws on by repo-relative path (../ prefixed in the Indonesian
# edition), which resolves only for someone browsing the repository. Those paths
# are rewritten to absolute GitHub URLs at build time so they resolve from an
# EPUB or PDF too; the notes are all tracked, so every generated URL is live.
# main (not a tag) is deliberate: note IDs and filenames are stable, so later
# corrections reach readers holding an older build.
declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r REPO_BLOB="$REPO_URL"/blob/main

# Publication targets for the finished artefacts. Read from an untracked
# deploy.conf (copy deploy.conf.example) so no machine name or server path is
# published with the source. Building never needs them: without the file the
# build completes normally and only the publish step is skipped.
if [[ -r $SCRIPT_DIR/deploy.conf ]]; then
  #shellcheck source=/dev/null
  source "$SCRIPT_DIR"/deploy.conf
fi
declare -r PUBLISH_DIR=${PUBLISH_DIR:-}
declare -r PUBLISH_OWNER=${PUBLISH_OWNER:-}
declare -r DEPLOY_HOST=${DEPLOY_HOST:-}
declare -r DEPLOY_DIR=${DEPLOY_DIR:-$PUBLISH_DIR}

# Speaker glyph for the audio link, as inline SVG. Inline SVG renders identically
# in EPUB3 and weasyprint and scales with the font (width/height 1em), whereas an
# emoji would fall back to a missing-glyph box -- the embedded EB Garamond / Lato
# faces carry no emoji. fill/stroke use currentColor so it inherits the link hue.
declare -r AUDIO_ICON='<svg class="audio-icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="1em" height="1em" aria-hidden="true" focusable="false"><path d="M3 9v6h4l5 4V5L7 9H3z" fill="currentColor"/><path d="M15.5 8.5a4 4 0 0 1 0 7" fill="none" stroke="currentColor" stroke-width="1.8" stroke-linecap="round"/></svg>'

# Images are recompressed to JPEG at build time (source PNGs stay untouched). The
# watercolours are painterly, so lossy JPEG is far smaller than lossless PNG at the
# same visible quality, taking the finished EPUB from ~20 MB to ~4 MB.
declare -ir JPEG_QUALITY=80

# Fonts, embedded into the EPUB so it renders identically everywhere rather than
# falling back to the reader's defaults:
#   - body: EB Garamond, serif, vendored under fonts/ebgaramond (OFL; see
#     OFL.txt there). This is Octavio Pardo's revival (the version Google Fonts
#     distributes), NOT the Debian fonts-ebgaramond package: that package ships
#     Georg Duffner's unfinished v0.016, whose italic f-ligature glyphs (ff,
#     ffi, ffl) are drawn far too heavy and print as ink blots. The vendored
#     copy also supplies a true Bold Italic and covers U+221A (the root sign in
#     "√dhṛ"), which previously fell back to Georgia.
#   - headings: Lato (pkg fonts-lato), humanist sans-serif. Stands in for Prima
#     Sans (commercial, not installed); swap LATO_DIR/faces below to switch.
declare -r FONT_DIR="$SCRIPT_DIR"/fonts/ebgaramond
declare -r LATO_DIR=/usr/share/fonts/truetype/lato
declare -ar FONT_FILES=(
  "$FONT_DIR"/EBGaramond-Regular.otf
  "$FONT_DIR"/EBGaramond-Italic.otf
  "$FONT_DIR"/EBGaramond-Bold.otf
  "$FONT_DIR"/EBGaramond-BoldItalic.otf
  "$LATO_DIR"/Lato-Regular.ttf
  "$LATO_DIR"/Lato-Bold.ttf
)

die() { >&2 echo "✗ $*"; exit 1; }
info() { >&2 echo "◉ $*"; }

# Help text (to stdout: it is requested output, not a diagnostic).
show_help() {
  cat <<HELP
$SCRIPT_NAME $VERSION - build "$TITLE" as an EPUB3 and/or PDF.

Usage:
  $SCRIPT_NAME [epub|pdf|all] [--audio none|link|embed]
  $SCRIPT_NAME -h|--help
  $SCRIPT_NAME -V|--version

Targets (default: all):
  epub   Build the EPUB3 only.
  pdf    Build the PDF only.
  all    Build both.

Options:
  --audio MODE   Per-chapter audio narration reference (default: link):
                   link   hyperlink to the web-hosted MP3s. The EPUB shows a
                          "Listen" link; the PDF shows the URL. Default.
                   embed  bundle the MP3s in the EPUB (EPUB target only;
                          output gets a _with-audio suffix)
                   none   no narration reference
  -h, --help     Show this help and exit.
  -V, --version  Show version and exit.
HELP
}

# Build workspace, created in main(). Declared at script scope so the EXIT trap
# (installed before mktemp) can clean it: an EXIT trap fires after main returns,
# by which point a function-local would be out of scope under `set -u`.
tmp=''

# Mirror pandoc's auto-identifier algorithm for a heading: downcase, drop
# punctuation (keeping underscore, hyphen, period), spaces to hyphens, strip
# everything up to the first letter. Used to link the hand-built contents page
# to each chapter H1.
slugify() {
  local -- s=${1,,}
  s=${s//[^a-z0-9 ._-]/}
  s=${s// /-}
  while [[ -n $s && ! $s =~ ^[a-z] ]]; do s=${s:1}; done
  printf '%s' "$s"
}

# Convert one source file into pandoc-ready Markdown on stdout.
#   - drop a leading YAML frontmatter block (--- ... ---)
#   - <image ALIGN WIDTH "SRC" "ALT" "CAP"> -> ![ALT](SRC)
#   - "/images/..." web-root path -> "images/..." on-disk path
#   - image .webp/.png refs -> .jpg (build stages JPEG copies; see main)
#   - self-close bare <br> (raw <br> is invalid XHTML -> fatal EPUB parse error)
#   - drop obsolete <center> tags (not valid in EPUB3 XHTML; centring is done in
#     CSS via <div align="center"> -> [data-align="center"])
#   - a line containing only \newpage -> a hard page break (styled by .pagebreak)
#   - a lone <!--\newpage--> marker -> the same page break, blank-line-surrounded
#     so it forms its own raw-HTML block. (A raw <div>/<!-- --> directly abutting a
#     preceding `---` becomes an HTML block that runs to the next blank line, which
#     can swallow whole following chapters -> dropped headings, dangling TOC links.)
#   - strip any other stray HTML comments (e.g. <!--audio start/stop--> narration
#     markers); they render nothing and risk the same block-swallowing.
#   - research-note links -> absolute REPO_BLOB URLs. The optional "../" prefix
#     (Indonesian edition) is captured and dropped, so both editions produce the
#     same valid URL. Anchoring on the leading digit scopes the rule to the eight
#     category directories, and excluding ":" from the path means an
#     already-absolute link can never be prefixed twice. External https targets
#     do not trip epubcheck RSC-007, which governs dangling *internal* refs.
#   - the repo-URL link in the "published on GitHub" line gains a trailing span
#     carrying the bare URL, hidden in the EPUB and shown in the PDF (a hyperlink
#     is useless on paper). Keyed on the URL, not the prose, so it works in both
#     languages. Safe after the rule above, whose output ends in ".md)" and so
#     cannot match a pattern requiring ")" straight after the repo name.
#   - de-link /works/ prev-next nav, keeping the link text; those live outside the
#     book and would otherwise be dangling references (epubcheck RSC-007).
#   - spaced em dash " — " -> spaced en dash " – " (the typesetter's house style
#     for the book; British/NZ practice). Sources keep their em dashes -- this is
#     a book-build concern, not a change to the canonical essays. All source em
#     dashes are the spaced form, so this one rule covers every occurrence.
#   - "fj"/"ffj" -> wrapped in <span class="dlig"> so the stylesheets can switch
#     on the OpenType dlig feature for just that sequence. EB Garamond keeps its
#     f_j/f_f_j ligatures in dlig (off by default), unlike ff/fi/ffl which sit in
#     liga, so "Klingefjord" otherwise prints with the f hook colliding with the
#     j dot. Enabling dlig globally is not an option: it would also ligate Th,
#     ct, st, ch, ck throughout. Caveat: the rule is textual, so an fj inside a
#     Markdown link *target* would break that link -- no current source has one.
preprocess() {
  local -- src=$1
  awk 'NR==1 && $0=="---"{fm=1; next} fm && $0=="---"{fm=0; next} !fm{print}' "$src" \
    | sed -E \
        -e 's#<image[[:space:]]+[a-z]+[[:space:]]+[0-9]+[[:space:]]+"([^"]*)"[[:space:]]+"([^"]*)"[[:space:]]+"[^"]*"[[:space:]]*>#![\2](\1)#' \
        -e 's#\]\(/images/#](images/#g' \
        -e 's#\.(webp|png)\)#.jpg)#g' \
        -e 's#<br[[:space:]]*/?>#<br/>#g' \
        -e 's#</?center>##g' \
        -e 's#^[[:space:]]*\\newpage[[:space:]]*$#<div class="pagebreak"></div>#' \
        -e 's#^[[:space:]]*<!--[[:space:]]*\\?newpage[[:space:]]*-->[[:space:]]*$#\n<div class="pagebreak"></div>\n#' \
        -e 's#<!--.*-->##g' \
        -e "s#\]\((\.\./)?([0-9]-[^):]*\.md)\)#]($REPO_BLOB/\2)#g" \
        -e "s#(\[[^]]+\]\($REPO_URL\))#\1<span class=\"repo-url\"> — $REPO_URL</span>#g" \
        -e 's#\[([^]]+)\]\(/works/[^)]*\)#\1#g' \
        -e 's# — # – #g' \
        -e 's#f?fj#<span class="dlig">&</span>#g'
}

# Emit the audio player/link for chapter n (0..9) in the requested mode, to be
# spliced in just below the chapter's H1. Nothing is emitted for mode=none.
#   embed -> raw XHTML <audio> whose <source src> pandoc bundles into the EPUB
#   link  -> a raw <p> carrying two anchors to the same MP3: a friendly "Listen"
#            label and the bare URL. book.css/pdf.css each hide the one they don't
#            want (EPUB shows the label, PDF shows the URL a print reader can type),
#            so the shared chapter file feeds both formats without duplication.
audio_block() {
  local -i n=$1
  local -- mode=$2
  local -- url shown
  case $mode in
    embed)
      printf '<audio controls="controls" preload="none">\n'
      printf '<source src="audio/%d-%s.mp3" type="audio/mpeg"/>\n' "$n" "$AUDIO_STEM"
      printf '</audio>\n'
      ;;
    link)
      url="$AUDIO_BASE_URL/$n-$AUDIO_STEM.mp3"
      #shown=${url#https://}
      shown="Part $n: $TITLE"
      printf '<p class="audio">'
      printf '%s' "$AUDIO_ICON"
      printf '<a class="audio-listen" href="%s">Listen to this chapter (audio narration)</a>' "$url"
      printf '<a class="audio-url" href="%s">Audio: %s</a>' "$url" "$shown"
      printf '</p>\n'
      ;;
    *) die "internal: audio_block called with bad mode ${mode@Q}" ;;
  esac
}

# Splice $block into $file immediately after its first level-1 heading (^# ),
# surrounded by blank lines so pandoc parses a raw-HTML block cleanly. Section
# headings (## and deeper) are not matched, and only the first H1 is touched.
splice_after_h1() {
  local -- file=$1 block=$2
  local -- t
  t=$(mktemp -p "${file%/*}") || die "failed to create temp file beside ${file@Q}"
  awk -v blk="$block" '
    !done && /^# / { print; print ""; print blk; print ""; done=1; next }
    { print }
  ' "$file" >"$t" || die "failed to rewrite ${file@Q}"
  mv -- "$t" "$file" || die "failed to update ${file@Q}"
}

# Standard Ebooks-style semantic inflection: set an epub:type on a section by
# attaching it to that section's H1 heading. pandoc carries the attribute
# verbatim onto the generated <section> in EPUB3 output (verified against
# epubcheck); raw <section> wrappers, by contrast, break --split-level splitting.
# The value is merged into an existing attribute block ({.unlisted} ->
# {.unlisted epub:type="..."}) so classes and identifiers are preserved. Only the
# first H1 is touched. See https://standardebooks.org/manual (semantic inflection).
inflect_h1() {
  local -- file=$1 etype=$2
  local -- t
  t=$(mktemp -p "${file%/*}") || die "failed to create temp file beside ${file@Q}"
  awk -v et="$etype" '
    !done && /^# / {
      if ($0 ~ /\{[^}]*\}[[:space:]]*$/) {
        sub(/\}[[:space:]]*$/, " epub:type=\"" et "\"}")
      } else {
        $0 = $0 " {epub:type=\"" et "\"}"
      }
      done=1
    }
    { print }
  ' "$file" >"$t" || die "failed to rewrite ${file@Q}"
  mv -- "$t" "$file" || die "failed to update ${file@Q}"
}

# Inject EPUB Accessibility 1.1 / schema.org metadata into a finished EPUB's OPF.
# pandoc's --epub-metadata silently discards <meta property="schema:*"> elements,
# so we splice them in after the fact and repackage. The claims are truthful for
# this book: a linear text reading order, a table of contents, and text
# alternatives on every illustrative image (the <image> shortcode's ALT field).
# Repackaging keeps mimetype as the first, stored (uncompressed) entry, as the
# EPUB OCF spec requires. See https://standardebooks.org/manual (accessibility).
inject_accessibility_metadata() {
  local -- epub=$1 tmpdir=$2
  # Work under the caller's already-trapped temp dir, so it is cleaned on any
  # exit/signal without this function owning a second trap.
  local -- work
  work=$(mktemp -d -p "$tmpdir") || die 'failed to create EPUB work dir'
  ( cd -- "$work" && unzip -q "$epub" ) || die "failed to unpack EPUB: $epub"
  local -- opf
  opf=$(find "$work" -name '*.opf' -print -quit)
  [[ -f $opf ]] || die "OPF not found inside ${epub@Q}"

  local -- meta
  meta=$(cat <<'META'
    <meta property="schema:accessMode">textual</meta>
    <meta property="schema:accessMode">visual</meta>
    <meta property="schema:accessModeSufficient">textual</meta>
    <meta property="schema:accessibilityFeature">tableOfContents</meta>
    <meta property="schema:accessibilityFeature">readingOrder</meta>
    <meta property="schema:accessibilityFeature">alternativeText</meta>
    <meta property="schema:accessibilityHazard">none</meta>
    <meta property="schema:accessibilitySummary">This publication conforms to a linear text reading order with a navigable table of contents. Illustrations are decorative watercolour-style images carrying text alternatives, and the book contains no flashing, motion, or sound hazards.</meta>
META
)
  # Splice the block in just before </metadata>.
  local -- t
  t=$(mktemp -p "${opf%/*}") || die "failed to create temp file beside ${opf@Q}"
  awk -v ins="$meta" '/<\/metadata>/ && !done { print ins; done=1 } { print }' \
    "$opf" >"$t" || die "failed to rewrite ${opf@Q}"
  mv -- "$t" "$opf" || die "failed to update ${opf@Q}"

  # Repackage: mimetype first and stored, everything else deflated.
  rm -f -- "$epub" || die "failed to remove ${epub@Q} before repackaging"
  ( cd -- "$work" \
    && zip -X -0 -q "$epub" mimetype \
    && zip -X -9 -rq "$epub" . -x mimetype ) \
    || die "failed to repackage EPUB ${epub@Q}"
  rm -rf -- "$work" || die 'failed to clean EPUB work dir'
}

main() {
  # Output format(s) to build and audio mode.
  local -- target=all
  local -- audio_mode=link
  while (($#)); do
    case $1 in
      -h|--help)
        show_help; exit 0 ;;
      -V|--version)
        printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; exit 0 ;;
      epub|pdf|all)
        target=$1 ;;
      --audio)
        [[ -n ${2:-} ]] || die "--audio requires a value (none|link|embed)"
        shift
        audio_mode=$1 ;;
      --audio=*)
        audio_mode=${1#*=} ;;
      *)
        die "usage: $SCRIPT_NAME [epub|pdf|all] [--audio none|link|embed]" ;;
    esac
    shift
  done
  case $audio_mode in
    none|link|embed) ;;
    *) die "invalid --audio ${audio_mode@Q} (want: none|link|embed)" ;;
  esac
  # Embedded audio is an EPUB-only, Releases-only artefact; a PDF cannot play it.
  if [[ $audio_mode == embed && $target != epub ]]; then
    die "audio embed only applies to the EPUB; use: $SCRIPT_NAME epub --audio embed"
  fi

  command -v pandoc >/dev/null 2>&1 || die 'pandoc not found (apt install pandoc)'
  command -v convert >/dev/null 2>&1 || die "ImageMagick 'convert' not found (apt install imagemagick)"
  [[ $target == epub ]] || command -v weasyprint >/dev/null 2>&1 \
    || die 'weasyprint not found, needed for PDF (apt install weasyprint)'
  # zip/unzip repackage the EPUB after injecting accessibility metadata (EPUB only).
  if [[ $target != pdf ]]; then
    command -v zip >/dev/null 2>&1 || die 'zip not found (apt install zip)'
    command -v unzip >/dev/null 2>&1 || die 'unzip not found (apt install unzip)'
  fi
  [[ -f $COVER_IMAGE ]] || die "cover image missing ${COVER_IMAGE@Q}"
  [[ -f $BACK_IMAGE ]] || die "back cover image missing ${BACK_IMAGE@Q} (run images/defining-dharma-genback.sh)"
  local -- font
  for font in "${FONT_FILES[@]}"; do
    [[ -f $font ]] \
      || die "font missing ${font@Q} (EB Garamond: vendored in fonts/ebgaramond; Lato: sudo apt install fonts-lato)"
  done
  # Sanity-check the canonical MP3s before building. embed must have them locally
  # (they get bundled) -> hard fail. link only points at the web URL, so a missing
  # local copy is a warning, not a failure (the URL is the source of truth).
  if [[ $audio_mode != none ]]; then
    local -i an
    local -- missing=''
    for an in {0..9}; do
      [[ -f "$AUDIO_SRC_DIR/$an-$AUDIO_STEM.mp3" ]] && continue
      [[ $audio_mode == embed ]] \
        && die "audio missing '$AUDIO_SRC_DIR/$an-$AUDIO_STEM.mp3'"
      missing+=" $an"
    done
    [[ -z $missing ]] \
      || info "local MP3s absent (${missing# }); links still resolve via ${AUDIO_BASE_URL@Q}"
  fi

  # Assemble the source list: cover first, then essays 0..9 by numeric prefix.
  local -a sources=("$SCRIPT_DIR"/cover.md)
  local -i n
  local -a match
  for n in {0..9}; do
    match=("$SCRIPT_DIR/$n"-*.md)
    (( ${#match[@]} == 1 )) || die "expected exactly one file for essay $n, found ${#match[@]}"
    [[ -f ${match[0]} ]] || die "essay $n source not found: ${match[0]}"
    sources+=("${match[0]}")
  done

  # Install the cleanup trap before creating the temp dir, so a signal landing
  # between the two cannot leak it. Single quotes defer expansion to exit time;
  # the script-scope `tmp` (still '' here) makes the pre-mktemp window a harmless
  # empty rm, and keeps it in scope when the EXIT trap fires after main returns.
  trap 'rm -rf -- "$tmp"' EXIT
  # Convert fatal signals into exits so the EXIT trap performs the cleanup
  # exactly once (a bare cleanup command in a signal trap would let the
  # script continue past the interrupt).
  trap 'exit 130' SIGINT
  trap 'exit 143' SIGTERM
  tmp=$(mktemp -d) || die 'failed to create temp dir'

  # Stage JPEG copies of every source PNG under $tmp/img, mirroring the on-disk
  # layout (images/ and images/png/) so the .png->.jpg link rewrites resolve
  # against --resource-path. Source PNGs are never modified.
  local -- img_stage="$tmp"/img
  mkdir -p "$img_stage"/images/png || die "failed to create image staging dir ${img_stage@Q}"
  local -- png rel
  while IFS= read -r -d '' png; do
    rel=${png#"$SCRIPT_DIR"/}
    convert "$png" -quality "$JPEG_QUALITY" "$img_stage/${rel%.png}.jpg" \
      || die "image conversion failed ${png@Q}"
  done < <(find "$SCRIPT_DIR"/images -maxdepth 2 -name '*.png' -print0)
  # The staged cover, named relative to $img_stage so both the EPUB (which needs
  # the path) and the PDF cover plate (which needs the markdown link) derive from
  # COVER_IMAGE rather than repeating its name.
  local -- cover_rel=${COVER_IMAGE#"$SCRIPT_DIR"/}
  cover_rel=${cover_rel%.png}.jpg
  local -- cover_jpg="$img_stage"/"$cover_rel"
  [[ -f $cover_jpg ]] || die "staged cover JPEG not produced ${cover_jpg@Q}"
  # The staged back cover, likewise named relative to $img_stage.
  local -- back_rel=${BACK_IMAGE#"$SCRIPT_DIR"/}
  back_rel=${back_rel%.png}.jpg
  [[ -f "$img_stage"/$back_rel ]] || die "staged back-cover JPEG not produced ${back_rel@Q}"
  # SVGs (the title-page ornament) are copied verbatim; EPUB3 and weasyprint
  # both render them natively, and they are tiny.
  cp -- "$SCRIPT_DIR"/images/*.svg "$img_stage"/images/ \
    || die 'failed to stage SVG images'

  # Preprocess into ordered temp files (00-, 01-, ...) to preserve chapter order.
  # Chapters are cover(=0), then essays 0..9 at indices 1..10, so essay index i
  # carries audio number i-1. The cover (i=0) never gets an audio player.
  local -a inputs=()
  local -i i=0
  local -- src dst block
  for src in "${sources[@]}"; do
    printf -v dst '%s/%02d-%s' "$tmp" "$i" "${src##*/}"
    preprocess "$src" >"$dst" || die "preprocessing failed for ${src@Q}"
    if [[ $audio_mode != none ]] && ((i >= 1)); then
      block=$(audio_block "$((i - 1))" "$audio_mode")
      splice_after_h1 "$dst" "$block"
    fi
    inputs+=("$dst")
    i+=1
  done

  # Hand-built contents page, inserted after the title page so the book reads
  # cover -> title -> contents -> chapters. pandoc's --toc cannot do this: it
  # always places the TOC at the very front of the flow. Entries link to each
  # chapter's H1 via its pandoc auto-identifier (see slugify). The Preface
  # entry is italic, the rest render in small caps (see .contents CSS).
  local -- contents="$tmp"/contents.md
  {
    printf '<div align="center">\n\n# Contents {.unlisted .contents}\n\n'
    local -- h1 label
    local -i k=0
    for dst in "${inputs[@]:1}"; do
      h1=$(grep -m1 '^# ' "$dst") || die "no H1 found in $dst"
      label=${h1#\# }
      if (( k == 0 )); then
        printf '*[%s](#%s)*\n\n' "$label" "$(slugify "$label")"
      else
        printf '[%s](#%s)\n\n' "$label" "$(slugify "$label")"
      fi
      k+=1
    done
    printf '</div>\n'
  } >"$contents" || die "failed to write ${contents@Q}"
  inputs=("${inputs[0]}" "$contents" "${inputs[@]:1}")

  # Standard Ebooks-style semantic inflection. inputs is now
  # [cover(title page), contents, essays 0..9]; tag each so readers and the
  # landmarks navigation know the cover is the title page, the essays are the
  # body, and reading begins at essay 0 rather than the cover.
  inflect_h1 "${inputs[0]}" 'frontmatter titlepage'
  inflect_h1 "${inputs[1]}" 'frontmatter'
  local -- ch
  for ch in "${inputs[@]:2}"; do
    inflect_h1 "$ch" 'bodymatter chapter'
  done

  # A colophon, closing the book (backmatter), in the same centred house style as
  # the title page: production credits and the licence, per Standard Ebooks.
  local -- colophon="$tmp"/colophon.md
  {
    printf '<div align="center">\n\n'
    printf '# Colophon {.unlisted}\n\n'
    printf '*%s*\n\n' "$TITLE"
    printf '%s\n\n' "$SUBTITLE"
    printf '*%s*\n\n' "$TAGLINE"
    printf 'by **%s**\n\n' "$AUTHOR"
    printf '<br/>\n\n'
    printf 'This ebook was typeset from Markdown with pandoc, in the EB Garamond and Lato typefaces. The cover and chapter illustrations are watercolour-style images generated with AI image models, from prompts written, iterated, and selected by the author.\n\n'
    printf '<br/>\n\n'
    printf 'This work is licensed under the %s.\n\n' "$LICENSE_NAME"
    printf '<%s>\n\n' "$LICENSE_URL"
    printf '</div>\n'
  } >"$colophon" || die "failed to write ${colophon@Q}"
  inflect_h1 "$colophon" "backmatter colophon"
  inputs+=("$colophon")

  # The lettered back cover closes the book, mirroring the front. The heading
  # exists only to give pandoc a split point (its own XHTML page in the EPUB)
  # and is hidden by both stylesheets; the .pagebreak div starts the page in
  # the PDF, where a display:none heading cannot carry the break.
  local -- backcover="$tmp"/backcover.md
  {
    printf '# Back Cover {.unlisted .backcover}\n\n'
    printf '<div class="pagebreak"></div>\n\n'
    # Trailing backslash (hard line break) stops pandoc's implicit_figures from
    # dressing the lone image as a <figure> with a visible "Back cover" caption.
    printf '![Back cover](%s)\\\n' "$back_rel"
  } >"$backcover" || die "failed to write ${backcover@Q}"
  inflect_h1 "$backcover" 'backmatter'
  inputs+=("$backcover")

  # EPUB package metadata pandoc will merge in (dc:* elements). A stable
  # identifier, the licence as dc:rights, and the subjects. Accessibility
  # metadata is injected separately after the build (pandoc drops schema:* here).
  local -- meta_xml="$tmp"/epub-meta.xml
  {
    printf '<dc:identifier id="uid">%s</dc:identifier>\n' "$IDENTIFIER"
    printf '<dc:rights>Licensed under the %s. %s</dc:rights>\n' \
      "$LICENSE_NAME" "$LICENSE_URL"
    local -- subj
    for subj in "${SUBJECTS[@]}"; do
      printf '<dc:subject>%s</dc:subject>\n' "$subj"
    done
  } >"$meta_xml" || die "failed to write ${meta_xml@Q}"

  # Stylesheet: bind the embedded faces (EB Garamond body, Lato headings) to
  # their families and apply them. Fonts are embedded under EPUB/fonts/; this
  # CSS lives under EPUB/styles/, so the src url() is one directory up.
  local -- css="$tmp"/book.css
  cat >"$css" <<'CSS' || die "failed to write ${css@Q}"
@font-face{font-family:"EB Garamond";font-weight:normal;font-style:normal;src:url("../fonts/EBGaramond-Regular.otf")}
@font-face{font-family:"EB Garamond";font-weight:normal;font-style:italic;src:url("../fonts/EBGaramond-Italic.otf")}
@font-face{font-family:"EB Garamond";font-weight:bold;font-style:normal;src:url("../fonts/EBGaramond-Bold.otf")}
@font-face{font-family:"EB Garamond";font-weight:bold;font-style:italic;src:url("../fonts/EBGaramond-BoldItalic.otf")}
@font-face{font-family:"Lato";font-weight:normal;font-style:normal;src:url("../fonts/Lato-Regular.ttf")}
@font-face{font-family:"Lato";font-weight:bold;font-style:normal;src:url("../fonts/Lato-Bold.ttf")}
body{font-family:"EB Garamond",Georgia,serif;font-size:1rem;line-height:1.5;text-align:justify;-webkit-hyphens:auto;-epub-hyphens:auto;hyphens:auto;orphans:2;widows:2}
a{color:#0b295a}
h1,h2,h3,h4,h5,h6{font-family:"Lato","DejaVu Sans",sans-serif;line-height:1.2;text-align:left;-webkit-hyphens:none;-epub-hyphens:none;hyphens:none}
h1{font-size:2em;margin:1em 0 0.6em}
h2{font-size:1.133em;margin:1.2em 0 0.4em}
h3{font-size:1.2em;margin:1em 0 0.3em}
[data-align="center"]{text-align:center}
[data-align="center"] h1,[data-align="center"] h2,[data-align="center"] h3,[data-align="center"] h4,[data-align="center"] h5,[data-align="center"] h6{text-align:center}
.pagebreak{break-before:page;page-break-before:always}
.dlig{font-variant-ligatures:discretionary-ligatures;font-feature-settings:"dlig" 1}
.copyright{font-size:0.8em}
p.audio{font-family:"Lato","DejaVu Sans",sans-serif;font-size:0.9em;margin:0.2em 0 1.2em}
p.audio a{text-decoration:none}
p.audio .audio-url{display:none}
.audio-icon{vertical-align:-0.12em;margin-right:0.4em}
.repo-url{display:none}
h1.backcover{display:none}
img.ornament{width:25px;height:auto;margin:0 auto;opacity:0.6}
section.contents h1{font-variant:small-caps;letter-spacing:0.08em}
section.contents p{margin:0.9em 0}
section.contents a{text-decoration:none;font-variant:small-caps;font-size:1.15em}
section.contents em a{font-variant:normal}
nav#toc h1{text-align:center;font-variant:small-caps;letter-spacing:0.08em}
nav#toc ol{list-style:none;padding:0;margin:2.5em 0;text-align:center}
nav#toc li{margin:0.9em 0}
nav#toc a{text-decoration:none;font-variant:small-caps;font-size:1.15em}
nav#toc li:first-child a{font-variant:normal;font-style:italic}
CSS

  local -a font_args=()
  for font in "${FONT_FILES[@]}"; do
    font_args+=(--epub-embed-font="$font")
  done

  if [[ $target != pdf ]]; then
    # For embedded audio, write the _with-audio output and add the web-root to the
    # resource path so pandoc resolves (and bundles) each "audio/N-...mp3".
    local -- epub_out=$OUTPUT
    local -- resource_path=$img_stage
    if [[ $audio_mode == embed ]]; then
      epub_out=$OUTPUT_AUDIO
      resource_path="$img_stage:$AUDIO_WEBROOT"
    fi
    info "building EPUB from ${#inputs[@]} files -> $epub_out"
    # markdown-yaml_metadata_block: metadata comes from --metadata/--epub-metadata,
    # and preprocess already strips frontmatter, so pandoc's YAML parsing is pure
    # liability -- with it on, the chapters' `---` thematic breaks get paired as
    # YAML delimiters and the build dies with a YAML parse error.
    ( cd -- "$SCRIPT_DIR" && pandoc \
        --from=markdown-yaml_metadata_block \
        --to=epub3 \
        --split-level=1 \
        --epub-title-page=false \
        --epub-metadata="$meta_xml" \
        --metadata title="$TITLE" \
        --metadata author="$AUTHOR" \
        --metadata lang="$LANGUAGE" \
        --metadata date="$PUB_DATE" \
        --metadata toc-title="Contents" \
        --epub-cover-image="$cover_jpg" \
        --css="$css" \
        "${font_args[@]}" \
        --resource-path="$resource_path" \
        -o "$epub_out" \
        "${inputs[@]}" ) || die "pandoc EPUB build failed"
    inject_accessibility_metadata "$epub_out" "$tmp"
    info "done: $epub_out ($(du -h --apparent-size "$epub_out" | cut -f1))"
    # Validate: epubcheck is the arbiter of EPUB conformance. Fail the build on
    # any error so a broken artefact is never shipped. ace (DAISY accessibility
    # checker) is run only if installed, as an informational pass.
    if command -v epubcheck >/dev/null 2>&1; then
      info 'validating with epubcheck'
      epubcheck "$epub_out" || die "epubcheck reported errors in ${epub_out@Q}"
    else
      info 'epubcheck not found; skipping validation (apt install epubcheck)'
    fi
    if command -v ace >/dev/null 2>&1; then
      info 'running DAISY ace accessibility check'
      ace -o "$tmp"/ace "$epub_out" || info 'ace reported issues (informational)'
    fi
  fi

  if [[ $target != epub ]]; then
    # PDF via weasyprint: it renders HTML/CSS, so it reuses the centred cover,
    # the .pagebreak breaks and the images. EB Garamond is bound to the vendored
    # faces via @font-face (unquoted heredoc: $FONT_DIR expands) -- resolving it
    # by family name through fontconfig would pick up the broken Debian-packaged
    # Duffner v0.016 instead. Lato still resolves by family name. weasyprint
    # resolves image URLs relative to the CWD, so this pandoc runs from the
    # staged image dir.
    local -- pdf_css="$tmp"/pdf.css
    cat >"$pdf_css" <<CSS || die "failed to write ${pdf_css@Q}"
@font-face{font-family:"EB Garamond";font-weight:normal;font-style:normal;src:url("file://$FONT_DIR/EBGaramond-Regular.otf")}
@font-face{font-family:"EB Garamond";font-weight:normal;font-style:italic;src:url("file://$FONT_DIR/EBGaramond-Italic.otf")}
@font-face{font-family:"EB Garamond";font-weight:bold;font-style:normal;src:url("file://$FONT_DIR/EBGaramond-Bold.otf")}
@font-face{font-family:"EB Garamond";font-weight:bold;font-style:italic;src:url("file://$FONT_DIR/EBGaramond-BoldItalic.otf")}
body{font-family:"EB Garamond",Georgia,serif;font-size:15pt;line-height:1.5}
a{color:#0b295a}
h1,h2,h3,h4,h5,h6{font-family:"Lato","DejaVu Sans",sans-serif;line-height:1.2}
h1{font-size:2em;margin:1em 0 0.6em;break-before:page}
h2{font-size:1.133em;margin:1.2em 0 0.4em}
h3{font-size:1.2em;margin:1em 0 0.3em}
[data-align="center"]{text-align:center}
.pagebreak{break-before:page}
.dlig{font-variant-ligatures:discretionary-ligatures;font-feature-settings:"dlig" 1}
.copyright{font-size:0.8em}
p.audio{font-family:"Lato","DejaVu Sans",sans-serif;font-size:0.9em;margin:0.2em 0 1.2em}
p.audio a{text-decoration:none;color:inherit}
p.audio .audio-listen{display:none}
.audio-icon{vertical-align:-0.12em;margin-right:0.4em}
.repo-url{font-family:"Lato","DejaVu Sans",sans-serif;font-size:0.85em;overflow-wrap:break-word}
h1.backcover{display:none}
img{max-width:100%}
img.ornament{width:25px;height:auto;margin:0 auto;opacity:0.6}
header#title-block-header{display:none}
section.contents h1{font-variant:small-caps;letter-spacing:0.08em}
section.contents p{margin:0.9em 0}
section.contents a{text-decoration:none;color:inherit;font-variant:small-caps;font-size:1.15em}
section.contents em a{font-variant:normal}
@page{size:A4;margin:2.2cm}
CSS
    # The EPUB gets the watercolour via --epub-cover-image; the PDF has no such
    # option, so a dedicated cover-plate page is prepended ahead of the title page.
    local -- plate="$tmp"/00-cover-plate.md
    # No explicit pagebreak needed: the title page's own h1 carries break-before:page.
    printf '![](%s)\n' "$cover_rel" >"$plate" || die "failed to write ${plate@Q}"
    info "building PDF from $(( ${#inputs[@]} + 1 )) files -> $OUTPUT_PDF"
    ( cd -- "$img_stage" && pandoc \
        --from=markdown-yaml_metadata_block \
        --to=pdf \
        --pdf-engine=weasyprint \
        --metadata title="$TITLE" \
        --metadata author="$AUTHOR" \
        --metadata lang="$LANGUAGE" \
        --css="$pdf_css" \
        -o "$OUTPUT_PDF" \
        "$plate" "${inputs[@]}" ) || die 'pandoc PDF build failed'
    info "done: $OUTPUT_PDF ($(du -h --apparent-size "$OUTPUT_PDF" | cut -f1))"
  fi

  # Publish to the local web-root, then mirror to the remote host. Both targets
  # come from deploy.conf; unset, the artefacts simply stay in the build dir.
  # The glob is derived from OUTPUT so it stays anchored to the build directory
  # (main never cd's, so a bare pattern would resolve against the caller's cwd)
  # and a filename change happens in exactly one place.
  if [[ -z $PUBLISH_DIR ]]; then
    info 'publish skipped: PUBLISH_DIR unset (see deploy.conf.example)'
    return 0
  fi
  local -a artefacts=("${OUTPUT%.epub}"*)
  cp -- "${artefacts[@]}" "$PUBLISH_DIR"/ || die "publish failed: cp to ${PUBLISH_DIR@Q}"
  if [[ -n $PUBLISH_OWNER ]]; then
    chown -R -- "$PUBLISH_OWNER" "$PUBLISH_DIR" || die 'publish failed: chown'
  fi
  chmod -- 664 "$PUBLISH_DIR"/* || die 'publish failed: chmod'
  if [[ -n $DEPLOY_HOST ]]; then
    rsync -av --timeout=300 -- "${artefacts[@]}" "$DEPLOY_HOST":"$DEPLOY_DIR"/ \
      || die 'publish failed: rsync to remote host'
  else
    info 'remote mirror skipped: DEPLOY_HOST unset'
  fi
}

main "$@"
#fin
