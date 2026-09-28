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
declare -i FAILED=0
declare -- TMP='' MKBOOK=''
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

main() {
  echo '== Tuwhiri ePub edition =='
  TMP=$(mktemp -d) || die 5 'failed to create temp dir'
  local -- box=$TMP/box src
  mkdir -- "$box" || die 5 'failed to create the build tree'
  # cp -rs makes real directories holding links to the files: the build finds
  # its images with find, which does not go down into a directory that is
  # itself a link.
  for src in "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$ROOT"/cover.md \
             "$ROOT"/fonts "$ROOT"/images "$ROOT"/lib; do
    cp -Rs -- "$src" "$box"/ || die 5 "failed to link ${src@Q}"
  done
  cp -- "$ROOT"/mk-book.sh "$box"/ || die 5 'failed to copy mk-book.sh'
  MKBOOK=$box/mk-book.sh
  local -- epub=$box/${OWN_NAME}_tuwhiri.epub cover=$TMP/cover.jpg log=$TMP/build.log
  # A stand-in cover of a size no image in the book has.
  convert -size 613x917 xc:'#d9d7d7' "$cover" || die 5 'failed to make the stand-in cover'

  refuses 'an unknown edition is refused' 22 'edition' \
    epub --edition nonesuch
  refuses 'the Tuwhiri edition is an ePub only: a PDF is refused' 22 'ePub' \
    pdf --edition tuwhiri --cover "$cover"
  refuses 'a missing cover stops the build and is named' 3 'nowhere.jpg' \
    epub --edition tuwhiri --cover "$TMP"/nowhere.jpg
  # A cover handed to the author's edition would be dropped without a word,
  # and the build would go on to publish the edition nobody asked for.
  refuses '--cover without the Tuwhiri edition is refused' 2 '--cover' \
    epub --cover "$cover"
  [[ -z $(find "$box" -maxdepth 1 -name '*.epub' -print -quit) ]] \
    && ok 'a refused build writes nothing' || bad 'a refused build left a file'

  # The edition under its own name, with no --output: only the edition's guard
  # stands between this build and the publish step.
  "$MKBOOK" epub --edition tuwhiri --cover "$cover" >"$log" 2>&1 \
    || die 1 "the build failed: $(tail -n 3 "$log" | tr '\n' ' ')"
  [[ -s $epub ]] && ok "the edition is written as ${epub##*/}" || die 1 'the build wrote no file'
  grep -q -F 'publish skipped: the tuwhiri edition is never published from here' "$log" \
    && ok 'the Tuwhiri edition stops before the publish step' \
    || bad "the edition's guard did not stop the publish step: $(tail -n 2 "$log" | tr '\n' ' ')"
  grep -q -F 'validating with epubcheck' "$log" && ok 'epubcheck ran and found no error' \
    || bad 'epubcheck did not run'

  mkdir -- "$TMP"/x && ( cd -- "$TMP"/x && unzip -q "$epub" ) || die 5 'failed to unpack the ePub'
  local -- opf
  opf=$(find "$TMP"/x -name '*.opf' -print -quit)
  [[ -f $opf ]] || die 3 'no OPF in the ePub'

  grep -q -F ">urn:isbn:$ISBN</dc:identifier>" "$opf" \
    && ok "the package is identified by the ePub ISBN, $ISBN" \
    || bad "the package identifier is not the ePub ISBN: $(grep -o '<dc:identifier[^<]*' "$opf" | tr '\n' ' ')"
  grep -q -F '<dc:publisher>The Tuwhiri Project</dc:publisher>' "$opf" \
    && ok 'the package names Tuwhiri as the publisher' \
    || bad "the package does not name Tuwhiri as publisher: $(grep -o '<dc:publisher[^<]*' "$opf" | tr '\n' ' ')"
  grep -q -F 'garydean.id/books' "$opf" \
    && bad 'the package still carries the author'"'"'s own edition identifier' \
    || ok 'the author'"'"'s own edition identifier is gone'

  # The cover is the one handed in: the only image of its size in the book.
  local -- cover_href size
  cover_href=$(grep -o '<item[^>]*properties="cover-image"[^>]*>' "$opf" | grep -o 'href="[^"]*"' | cut -d'"' -f2)
  size=$(identify -format '%wx%h' -- "${opf%/*}/$cover_href" 2>/dev/null) || size=unreadable
  [[ $size == 613x917 ]] && ok 'the cover is the one handed in' \
    || bad "the cover is $size (${cover_href:-no cover-image item}), not the 613x917 handed in"
  [[ -z $(find "$TMP"/x -name 'defining-dharma-cover-title*' -print -quit) ]] \
    && ok 'the author'"'"'s own front cover is not in the file' \
    || bad 'the author'"'"'s own front cover is still in the file'

  # The ten chapter watercolours and the back-cover plate stay.
  local -i art
  art=$(find "$TMP"/x -name '*.jpg' ! -path "*/$cover_href" | wc -l)
  ((art == 11)) && ok 'the ten chapter watercolours and the back-cover plate are kept' \
    || bad "the file holds $art images besides the cover, want 11"

  # The colophon no longer calls the cover an AI image, still declares the
  # watercolours, and credits the cover.
  local -- colophon
  colophon=$(grep -l -r -F 'Colophon' "$TMP"/x --include='*.xhtml' | xargs grep -l -F 'typeset from Markdown' | head -n 1)
  [[ -f $colophon ]] || die 3 'no colophon page in the ePub'
  colophon=$(sed -e 's/<[^>]*>//g' "$colophon" | tr -s ' \n' ' ')
  [[ $colophon != *'The cover and chapter illustrations'* ]] \
    && ok 'the colophon no longer calls the cover an AI image' \
    || bad 'the colophon still calls the cover an AI image'
  [[ $colophon == *'chapter illustrations'*'watercolour-style images generated with AI:grok-imagine-image-quality'* ]] \
    && ok 'the colophon still declares the watercolours as AI images' \
    || bad "the colophon does not declare the watercolours: ${colophon:0:300}"
  [[ $colophon == *'minimum graphics'* ]] && ok 'the colophon credits the cover to minimum graphics' \
    || bad 'the colophon does not credit the cover'

  # The author's own edition, written elsewhere: only the --output guard stands
  # between this build and the publish step. It is also the edition the switch
  # must leave alone, read back from the file this time.
  local -- own=$TMP/own.epub
  "$MKBOOK" epub --output "$own" >"$log" 2>&1 \
    || die 1 "the author's edition failed to build: $(tail -n 3 "$log" | tr '\n' ' ')"
  [[ -s $own ]] && ok "the author's edition is written to the file named" \
    || die 1 "the author's edition wrote no file"
  grep -q -F 'publish skipped: --output names a file of its own' "$log" \
    && ok 'a build written elsewhere stops before the publish step' \
    || bad "the --output guard did not stop the publish step: $(tail -n 2 "$log" | tr '\n' ' ')"
  [[ ! -e $box/$OWN_NAME.epub ]] && ok 'nothing is written under the shipping name' \
    || bad 'the build also wrote the shipping file'
  mkdir -- "$TMP"/y && ( cd -- "$TMP"/y && unzip -q "$own" ) || die 5 "failed to unpack the author's ePub"
  opf=$(find "$TMP"/y -name '*.opf' -print -quit)
  grep -q -F '>https://garydean.id/books/in-search-of-dharma</dc:identifier>' "$opf" \
    && ! grep -q -F '<dc:publisher>' "$opf" \
    && ok "the author's edition keeps its identifier and names no publisher" \
    || bad "the author's edition's package has changed: $(grep -o '<dc:\(identifier\|publisher\)[^<]*' "$opf" | tr '\n' ' ')"
  [[ -n $(find "$TMP"/y -name 'defining-dharma-cover-title*' -print -quit) ]] \
    && ok "the author's edition keeps its own cover" || bad "the author's edition lost its cover"
  colophon=$(grep -l -r -F 'typeset from Markdown' "$TMP"/y --include='*.xhtml' | head -n 1)
  [[ -f $colophon && $(sed -e 's/<[^>]*>//g' "$colophon" | tr -s ' \n' ' ') == *'The cover and chapter illustrations are watercolour-style images'* ]] \
    && ok "the author's edition keeps its colophon" || bad "the author's edition's colophon has changed"

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
