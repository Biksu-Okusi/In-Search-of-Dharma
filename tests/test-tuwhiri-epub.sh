#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-tuwhiri-epub.sh - mk-book.sh --edition tuwhiri builds Tuwhiri's
# ePub: the publisher's cover in place of the author's, Tuwhiri's ISBN and name
# in the package, the chapter watercolours kept and still declared, and nothing
# published.
#
# Built over a stand-in cover, so the test needs none of Tuwhiri's artwork, and
# in a tree of its own: links to the book's sources beside a copy of the
# script, with no deploy.conf. Nothing can be published from there whatever
# the script does, so each of the two guards on the publish step can be tried
# alone, and what is asserted is that the guard is what stopped it.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r OWN_NAME=In-Search-of-Dharma_Biksu-Okusi_2026
declare -r ISBN=9798998067617
declare -r OWN_ID='>https://garydean.id/books/in-search-of-dharma</dc:identifier>'
declare -r GUARD_EDITION='publish skipped: the tuwhiri edition is never published from here'
declare -r GUARD_OUTPUT='publish skipped: --output names a file of its own'
declare -r AI_IMAGES='watercolour-style images generated with AI:grok-imagine-image-quality'
declare -i FAILED=0
declare -- TMP='' MKBOOK='' LOG=''
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# refuses DESC WANT_RC PATTERN ARGS... : mk-book.sh stops with WANT_RC, saying
# PATTERN, and writes nothing.
refuses() {
  local -- desc=$1 pattern=$3 out
  local -i want=$2 rc=0
  shift 3
  out=$("$MKBOOK" "$@" 2>&1) || rc=$?
  if ((rc == want)) && [[ $out == *"$pattern"* ]]; then
    ok "$desc"
  else
    bad "$desc: exit $rc, said: ${out%%$'\n'*}"
  fi
}

# holds FILE TEXT : FILE contains TEXT. A file that cannot be read stops the
# test: grep keeps exit 1 for "no such line" and 2 for a failure of its own.
holds() {
  local -i rc=0
  grep -q -F -- "$2" "$1" || rc=$?
  ((rc < 2)) || die 1 "could not read ${1@Q}"
  return "$rc"
}

# first_found DIR NAME : the first file under DIR called NAME, "" if none.
first_found() {
  find -- "$1" -name "$2" -print -quit || die 1 "could not search ${1@Q}"
}

# shown FILE REGEX : what FILE holds that matches REGEX, on one line, for a
# failure's message. Nothing matching is an answer, so grep's exit 1 is let go.
shown() { grep -o -- "$2" "$1" | tr '\n' ' ' ||:; }

# last_said N : the last N lines of the build's log, on one line.
last_said() { tail -n "$1" -- "$LOG" | tr '\n' ' '; }

# plain FILE : an XHTML page as its text, tags gone and white space squeezed.
plain() { sed -e 's/<[^>]*>//g' -- "$1" | tr -s ' \n' ' '; }

main() {
  local -- tool
  for tool in convert identify unzip; do
    command -v "$tool" >/dev/null || die 18 "required: ${tool@Q}"
  done

  echo '== Tuwhiri ePub edition =='
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'
  LOG=$TMP/build.log
  local -- box=$TMP/box src
  mkdir -- "$box" || die 5 "failed to create ${box@Q}"
  # cp -Rs makes real directories holding links to the files: the build finds
  # its images with find, which does not go down into a directory that is
  # itself a link.
  for src in "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$ROOT"/cover.md \
             "$ROOT"/fonts "$ROOT"/images "$ROOT"/lib; do
    [[ -e $src ]] || die 3 "nothing at ${src@Q}"
    cp -Rs -- "$src" "$box"/ || die 5 "failed to link ${src@Q}"
  done
  cp -- "$ROOT"/mk-book.sh "$box"/ || die 5 "failed to copy mk-book.sh into ${box@Q}"
  MKBOOK=$box/mk-book.sh
  local -- epub=$box/${OWN_NAME}_tuwhiri.epub cover=$TMP/cover.jpg left
  # A stand-in cover of a size no image in the book has. ImageMagick has no
  # end-of-options marker, so the file is named by its format first.
  convert -size 613x917 xc:'#d9d7d7' jpg:"$cover" || die 5 "failed to make ${cover@Q}"

  refuses 'an unknown edition is refused' 22 'edition' \
    epub --edition nonesuch
  refuses 'the Tuwhiri edition is an ePub only: a PDF is refused' 22 'ePub' \
    pdf --edition tuwhiri --cover "$cover"
  refuses 'a missing cover stops the build and is named' 3 'nowhere.jpg' \
    epub --edition tuwhiri --cover "$TMP"/nowhere.jpg
  # A cover handed to the default edition would be dropped without a word, and
  # the build would go on to publish the edition nobody asked for.
  refuses '--cover without the Tuwhiri edition is refused' 2 '--cover' \
    epub --cover "$cover"
  # Short options may be run together: -qV is -q and -V, and builds nothing.
  local -- said
  local -i said_rc=0
  said=$("$MKBOOK" -qV 2>&1) || said_rc=$?
  ((said_rc == 0)) && [[ $said == 'mk-book.sh '[0-9]* ]] \
    && ok 'short options run together are taken one by one' \
    || bad "-qV: exit $said_rc, said: ${said%%$'\n'*}"
  left=$(find -- "$box" -maxdepth 1 -name '*.epub' -print -quit) || die 1 "could not search ${box@Q}"
  [[ -z $left ]] && ok 'a refused build writes nothing' || bad "a refused build left ${left@Q}"

  # The edition under its own name, with no --output: only the edition's guard
  # stands between this build and the publish step.
  "$MKBOOK" epub --edition tuwhiri --cover "$cover" &>"$LOG" \
    || die 1 "the build failed: $(last_said 3)"
  [[ -s $epub ]] && ok "the edition is written as ${epub##*/}" || die 1 'the build wrote no file'
  holds "$LOG" "$GUARD_EDITION" \
    && ok 'the Tuwhiri edition stops before the publish step' \
    || bad "the guard on the edition did not stop the publish step: $(last_said 2)"
  holds "$LOG" 'validating with epubcheck' && ok 'epubcheck ran and found no error' \
    || bad 'epubcheck did not run'

  mkdir -- "$TMP"/x || die 5 "failed to create ${TMP@Q}/x"
  ( cd -- "$TMP"/x && unzip -q -- "$epub" ) || die 5 "failed to unpack ${epub@Q}"
  local -- opf
  opf=$(first_found "$TMP"/x '*.opf') || exit 1
  [[ -f $opf ]] || die 3 "no OPF in ${epub@Q}"

  holds "$opf" ">urn:isbn:$ISBN</dc:identifier>" \
    && ok "the package is identified by the ePub ISBN, $ISBN" \
    || bad "the package identifier is not the ePub ISBN: $(shown "$opf" '<dc:identifier[^<]*')"
  holds "$opf" '<dc:publisher>The Tuwhiri Project</dc:publisher>' \
    && ok 'the package names Tuwhiri as the publisher' \
    || bad "the package does not name Tuwhiri as publisher: $(shown "$opf" '<dc:publisher[^<]*')"
  holds "$opf" 'garydean.id/books' \
    && bad 'the package still carries the identifier of the default edition' \
    || ok 'the identifier of the default edition is gone'

  # The cover is the one handed in: the only image of its size in the book.
  local -- item cover_href='' size default_cover
  item=$(shown "$opf" '<item[^>]*properties="cover-image"[^>]*>')
  [[ $item =~ href=\"([^\"]*)\" ]] && cover_href=${BASH_REMATCH[1]} ||:  # none: said below
  # What identify has to say about a file it cannot read is put as one word.
  size=$(identify -format '%wx%h' -- "${opf%/*}/$cover_href" 2>/dev/null) || size=unreadable
  [[ $size == 613x917 ]] && ok 'the cover is the one handed in' \
    || bad "the cover is $size (${cover_href:-no cover-image item}), not the 613x917 handed in"
  default_cover=$(first_found "$TMP"/x 'defining-dharma-cover-title*') || exit 1
  [[ -z $default_cover ]] && ok 'the front cover of the default edition is not in the file' \
    || bad "the front cover of the default edition is still in the file: ${default_cover@Q}"

  # The ten chapter watercolours and the back-cover plate stay.
  local -i art
  art=$(find -- "$TMP"/x -name '*.jpg' ! -path "*/$cover_href" | wc -l) \
    || die 1 "could not count the images under ${TMP@Q}/x"
  ((art == 11)) && ok 'the ten chapter watercolours and the back-cover plate are kept' \
    || bad "the file holds $art images besides the cover, want 11"

  # The colophon, the page that says how the book was typeset, no longer calls
  # the cover an AI image, still declares the watercolours, and credits the
  # cover. grep exits 1 when no page says it, and the next line reports that.
  local -- colophon
  colophon=$(grep -l -r -F --include='*.xhtml' -- 'typeset from Markdown' "$TMP"/x | head -n 1) ||:
  [[ -f $colophon ]] || die 3 "no colophon page in ${epub@Q}"
  colophon=$(plain "$colophon") || die 1 'could not read the colophon'
  [[ $colophon != *'The cover and chapter illustrations'* ]] \
    && ok 'the colophon no longer calls the cover an AI image' \
    || bad 'the colophon still calls the cover an AI image'
  [[ $colophon == *'chapter illustrations'*"$AI_IMAGES"* ]] \
    && ok 'the colophon still declares the watercolours as AI images' \
    || bad "the colophon does not declare the watercolours: ${colophon:0:300}"
  [[ $colophon == *'minimum graphics'* ]] && ok 'the colophon credits the cover to minimum graphics' \
    || bad 'the colophon does not credit the cover'

  # The default edition, written elsewhere: only the --output guard stands
  # between this build and the publish step. It is also the edition the switch
  # must leave alone, read back from the file this time.
  local -- own=$TMP/own.epub
  "$MKBOOK" epub --output "$own" &>"$LOG" \
    || die 1 "the default edition failed to build: $(last_said 3)"
  [[ -s $own ]] && ok 'the default edition is written to the file named' \
    || die 1 'the default edition wrote no file'
  holds "$LOG" "$GUARD_OUTPUT" \
    && ok 'a build written elsewhere stops before the publish step' \
    || bad "the --output guard did not stop the publish step: $(last_said 2)"
  [[ ! -e $box/$OWN_NAME.epub ]] && ok 'nothing is written under the shipping name' \
    || bad 'the build also wrote the shipping file'
  mkdir -- "$TMP"/y || die 5 "failed to create ${TMP@Q}/y"
  ( cd -- "$TMP"/y && unzip -q -- "$own" ) || die 5 "failed to unpack ${own@Q}"
  opf=$(first_found "$TMP"/y '*.opf') || exit 1
  [[ -f $opf ]] || die 3 "no OPF in ${own@Q}"
  holds "$opf" "$OWN_ID" && ! holds "$opf" '<dc:publisher>' \
    && ok 'the default edition keeps its identifier and names no publisher' \
    || bad "the package of the default edition has changed: $(shown "$opf" '<dc:\(identifier\|publisher\)[^<]*')"
  default_cover=$(first_found "$TMP"/y 'defining-dharma-cover-title*') || exit 1
  [[ -n $default_cover ]] && ok 'the default edition keeps its own cover' \
    || bad 'the default edition lost its cover'
  # As above: no page found is reported by the check, not by grep's exit 1.
  colophon=$(grep -l -r -F --include='*.xhtml' -- 'typeset from Markdown' "$TMP"/y | head -n 1) ||:
  [[ -f $colophon ]] || die 3 "no colophon page in ${own@Q}"
  colophon=$(plain "$colophon") || die 1 'could not read the colophon of the default edition'
  [[ $colophon == *'The cover and chapter illustrations are watercolour-style images'* ]] \
    && ok 'the default edition keeps its colophon' || bad 'the colophon of the default edition has changed'

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
