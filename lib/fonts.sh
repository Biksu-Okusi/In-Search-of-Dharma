#!/bin/bash
#shellcheck shell=bash disable=SC2034
# lib/fonts.sh - font sets for the In Search of Dharma book builds.
#
# Sourced (never executed) by mk-book.sh and id/mk-book.sh, which share one book
# design and so must share one set of typefaces. Everything font-related lives
# here: the face inventory, the @font-face CSS both build targets need, the
# preflight file list, and the colophon's prose naming of the typefaces.
#
# Usage:
#   source "$SCRIPT_DIR"/lib/fonts.sh
#   font_set_load "$font_set" "$SCRIPT_DIR"/fonts
#   font_faces_css epub   # or: font_faces_css pdf
#
# font_set_load populates these globals:
#   FONT_SERIF_FAMILY   CSS family for body text
#   FONT_SANS_FAMILY    CSS family for headings and the audio/repo lines
#   FONT_HEADING_WEIGHT font-weight the h1-h6 rule asks for (bold, or 600 for a
#                       SemiBold face -- without this the renderer asks for 700
#                       and synthesises a heavier face than the one embedded)
#   FONT_BODY_SIZE_EPUB / FONT_BODY_SIZE_PDF / FONT_BODY_LEADING
#   FONT_FILES[]        absolute paths, for the preflight check and for pandoc's
#                       --epub-embed-font
#   FONT_COLOPHON_EN / FONT_COLOPHON_ID  typeface names as running prose
#   FONT_SUFFIX         output-filename suffix ('' for the default set)
#
# Adding a set: add a branch to font_set_load and a line to FONT_SETS. A face
# entry is "family|weight|style|path"; a path starting with / is used as-is,
# anything else resolves under the fonts root passed to font_set_load.

# Library only: it defines functions and variables and does nothing on its own,
# so running it is always a mistake worth naming. No `set -euo pipefail` here --
# that belongs to the calling script and must never be forced on its shell.
[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

# Selectable sets, in help-text order. The first is the default.
declare -ar FONT_SETS=(classic worksans bonanova bonanova-worksans bonanova-solo)

# Populated by font_set_load. Declared here so a `set -u` script can reference
# them before the first load without tripping an unbound-variable error.
declare -- FONT_SERIF_FAMILY='' FONT_SANS_FAMILY='' FONT_HEADING_WEIGHT=''
declare -- FONT_BODY_SIZE_EPUB='' FONT_BODY_SIZE_PDF='' FONT_BODY_LEADING=''
declare -- FONT_COLOPHON_EN='' FONT_COLOPHON_ID='' FONT_SUFFIX=''
declare -a FONT_FACES=() FONT_FILES=()

# Body sizes are per-set because apparent size tracks x-height, not point size.
# Measured x-height as a fraction of the em: EB Garamond 0.400, Bona Nova 0.440
# -- Bona Nova sets ~10% larger at the same point size, so its PDF body drops
# from 15pt to 14pt to hold the same colour on the page. The EPUB body stays at
# 1rem for every set: there, 1rem *is* the reader's chosen size, and shrinking
# below it overrides a preference the reader has deliberately set.

# font_set_load <set-name> <fonts-root>
font_set_load() {
  local -- set_name=$1 root=$2
  local -a faces=()
  # Output globals. Named with -g in one place so the plain assignments below
  # read unambiguously as this function's contract rather than as BCS0202
  # namespace leakage: populating these for the caller is the whole job.
  declare -g FONT_SERIF_FAMILY FONT_SANS_FAMILY FONT_HEADING_WEIGHT
  declare -g FONT_BODY_SIZE_EPUB FONT_BODY_SIZE_PDF FONT_BODY_LEADING
  declare -g FONT_COLOPHON_EN FONT_COLOPHON_ID FONT_SUFFIX
  declare -ga FONT_FACES FONT_FILES

  FONT_HEADING_WEIGHT=bold
  FONT_BODY_SIZE_EPUB=1rem
  FONT_BODY_SIZE_PDF=15pt
  FONT_BODY_LEADING=1.5
  FONT_SUFFIX=''

  case $set_name in
    classic)
      # The shipping design. EB Garamond body (vendored: see the note in
      # mk-book.sh on why the Debian package will not do), Lato headings from
      # the system package -- an absolute path, so this set stays byte-identical
      # to the build that produced the tracked EPUB and PDF.
      FONT_SERIF_FAMILY='EB Garamond'
      FONT_SANS_FAMILY='Lato'
      faces=(
        "EB Garamond|normal|normal|ebgaramond/EBGaramond-Regular.otf"
        "EB Garamond|normal|italic|ebgaramond/EBGaramond-Italic.otf"
        "EB Garamond|bold|normal|ebgaramond/EBGaramond-Bold.otf"
        "EB Garamond|bold|italic|ebgaramond/EBGaramond-BoldItalic.otf"
        "Lato|normal|normal|/usr/share/fonts/truetype/lato/Lato-Regular.ttf"
        "Lato|bold|normal|/usr/share/fonts/truetype/lato/Lato-Bold.ttf"
      )
      ;;
    worksans)
      # Ramsey's first request: keep EB Garamond, replace Lato with Work Sans
      # SemiBold. SemiBold is weight 600, so FONT_HEADING_WEIGHT changes too.
      FONT_SERIF_FAMILY='EB Garamond'
      FONT_SANS_FAMILY='Work Sans'
      FONT_HEADING_WEIGHT=600
      FONT_SUFFIX=_worksans
      faces=(
        "EB Garamond|normal|normal|ebgaramond/EBGaramond-Regular.otf"
        "EB Garamond|normal|italic|ebgaramond/EBGaramond-Italic.otf"
        "EB Garamond|bold|normal|ebgaramond/EBGaramond-Bold.otf"
        "EB Garamond|bold|italic|ebgaramond/EBGaramond-BoldItalic.otf"
        "Work Sans|normal|normal|worksans/WorkSans-Regular.ttf"
        "Work Sans|600|normal|worksans/WorkSans-SemiBold.ttf"
      )
      ;;
    bonanova)
      # Ramsey's second request, first option: Bona Nova body with Open Sans
      # headings. Bona Nova ships Regular/Italic/Bold only -- there is no Bold
      # Italic, so bold-italic body text is synthesised by the renderer.
      # Open Sans has no U+1E45/U+1E5B, but every heading in the book is ASCII
      # and the sans face is applied to headings only, so nothing falls back.
      FONT_SERIF_FAMILY='Bona Nova'
      FONT_SANS_FAMILY='Open Sans'
      FONT_HEADING_WEIGHT=600
      FONT_BODY_SIZE_PDF=14pt
      FONT_SUFFIX=_bonanova
      faces=(
        "Bona Nova|normal|normal|bonanova/BonaNova-Regular.ttf"
        "Bona Nova|normal|italic|bonanova/BonaNova-Italic.ttf"
        "Bona Nova|bold|normal|bonanova/BonaNova-Bold.ttf"
        "Open Sans|normal|normal|opensans/OpenSans-Regular.ttf"
        "Open Sans|600|normal|opensans/OpenSans-SemiBold.ttf"
      )
      ;;
    bonanova-worksans)
      # Ramsey's third request: keep the Bona Nova body, swap the sans for Work
      # Sans SemiBold. Reads to him as the bonanova set with Lato in it -- the
      # sans there is Open Sans, but the ask is the same either way, and this is
      # the pairing he wants. Same Bona Nova caveats as the bonanova set: no
      # Bold Italic face, and the 14pt body that its x-height calls for.
      # SemiBold is weight 600, so FONT_HEADING_WEIGHT must say so, or the
      # renderer asks for 700 and synthesises a heavier face than is embedded.
      FONT_SERIF_FAMILY='Bona Nova'
      FONT_SANS_FAMILY='Work Sans'
      FONT_HEADING_WEIGHT=600
      FONT_BODY_SIZE_PDF=14pt
      FONT_SUFFIX=_bonanova-worksans
      faces=(
        "Bona Nova|normal|normal|bonanova/BonaNova-Regular.ttf"
        "Bona Nova|normal|italic|bonanova/BonaNova-Italic.ttf"
        "Bona Nova|bold|normal|bonanova/BonaNova-Bold.ttf"
        "Work Sans|normal|normal|worksans/WorkSans-Regular.ttf"
        "Work Sans|600|normal|worksans/WorkSans-SemiBold.ttf"
      )
      ;;
    bonanova-solo)
      # Ramsey's second request, second option: Bona Nova throughout, headings
      # set in its own Bold. One family serves both roles, so the face list is
      # not duplicated -- FONT_SANS_FAMILY simply names the same family.
      FONT_SERIF_FAMILY='Bona Nova'
      FONT_SANS_FAMILY='Bona Nova'
      FONT_BODY_SIZE_PDF=14pt
      FONT_SUFFIX=_bonanova-solo
      faces=(
        "Bona Nova|normal|normal|bonanova/BonaNova-Regular.ttf"
        "Bona Nova|normal|italic|bonanova/BonaNova-Italic.ttf"
        "Bona Nova|bold|normal|bonanova/BonaNova-Bold.ttf"
      )
      ;;
    *)
      >&2 echo "✗ unknown font set ${set_name@Q} (want: ${FONT_SETS[*]})"
      return 1 ;;
  esac

  # Split each face entry into its four fields, resolving relative paths against
  # the fonts root. FONT_FACES keeps the resolved form for the CSS emitter;
  # FONT_FILES is the flat path list the preflight and pandoc both want.
  FONT_FACES=()
  FONT_FILES=()
  local -- entry family weight style path
  for entry in "${faces[@]}"; do
    IFS='|' read -r family weight style path <<<"$entry"
    [[ $path == /* ]] || path=$root/$path
    FONT_FACES+=("$family|$weight|$style|$path")
    FONT_FILES+=("$path")
  done

  # Colophon prose. One family in both roles reads as a singular typeface.
  if [[ $FONT_SERIF_FAMILY == "$FONT_SANS_FAMILY" ]]; then
    FONT_COLOPHON_EN="the $FONT_SERIF_FAMILY typeface"
    FONT_COLOPHON_ID="huruf $FONT_SERIF_FAMILY"
  else
    FONT_COLOPHON_EN="the $FONT_SERIF_FAMILY and $FONT_SANS_FAMILY typefaces"
    FONT_COLOPHON_ID="huruf $FONT_SERIF_FAMILY dan $FONT_SANS_FAMILY"
  fi
}

# font_faces_css <epub|pdf>
#
# Emit one @font-face rule per embedded face. The two targets resolve the files
# differently: pandoc flattens embedded fonts into EPUB/fonts/ and the
# stylesheet sits in EPUB/styles/, so the EPUB form is a relative ../fonts/ URL;
# weasyprint reads from disk, so the PDF form is an absolute file:// URL.
# Resolving by family name through fontconfig is not an option -- it would find
# the Debian fonts-ebgaramond package (Duffner v0.016), whose italic f-ligatures
# print as ink blots, in preference to the vendored revival.
font_faces_css() {
  local -- target=$1
  local -- entry family weight style path src
  for entry in "${FONT_FACES[@]}"; do
    IFS='|' read -r family weight style path <<<"$entry"
    case $target in
      epub) src="../fonts/${path##*/}" ;;
      pdf)  src="file://$path" ;;
      *) >&2 echo "✗ font_faces_css: unknown target ${target@Q}"; return 1 ;;
    esac
    printf '@font-face{font-family:"%s";font-weight:%s;font-style:%s;src:url("%s")}\n' \
      "$family" "$weight" "$style" "$src"
  done
}

#fin
