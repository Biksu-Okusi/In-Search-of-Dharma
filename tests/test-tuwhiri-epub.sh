#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-tuwhiri-epub.sh - mk-book.sh --edition tuwhiri builds Tuwhiri's
# ePub: the publisher's cover in place of the author's, Tuwhiri's ISBN and name
# in the package, the chapter watercolours kept and still declared, and nothing
# published.
#
# Built into a temporary file over a stand-in cover, so the test neither needs
# Tuwhiri's artwork nor leaves anything behind that could pass for the edition.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r MKBOOK=$ROOT/mk-book.sh
declare -r ISBN=9798998067617
declare -i FAILED=0
declare -- TMP=''
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
  local -- epub=$TMP/tuwhiri.epub cover=$TMP/cover.jpg log=$TMP/build.log
  # A stand-in cover of a size no image in the book has.
  convert -size 613x917 xc:'#d9d7d7' "$cover" || die 5 'failed to make the stand-in cover'

  refuses 'an unknown edition is refused' 22 'edition' \
    epub --edition nonesuch --output "$epub"
  refuses 'the Tuwhiri edition is an ePub only: a PDF is refused' 22 'ePub' \
    pdf --edition tuwhiri --cover "$cover" --output "$epub"
  refuses 'a missing cover stops the build and is named' 3 'nowhere.jpg' \
    epub --edition tuwhiri --cover "$TMP"/nowhere.jpg --output "$epub"
  [[ ! -e $epub ]] && ok 'a refused build writes nothing' || bad 'a refused build left a file'

  "$MKBOOK" epub --edition tuwhiri --cover "$cover" --output "$epub" >"$log" 2>&1 \
    || die 1 "the build failed: $(tail -n 3 "$log" | tr '\n' ' ')"
  [[ -s $epub ]] && ok 'the edition is written to the file named' || die 1 'the build wrote no file'
  grep -q -F 'publish skipped' "$log" && ok 'nothing is published' \
    || bad "the build did not say the publish step was skipped: $(tail -n 2 "$log" | tr '\n' ' ')"
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

  # The author's own edition is untouched by the switch: same identifier, same
  # colophon sentence. Read from the script, since building it would publish it.
  grep -q -F "IDENTIFIER='https://garydean.id/books/in-search-of-dharma'" "$MKBOOK" \
    && grep -q -F 'The cover and chapter illustrations are watercolour-style images' "$MKBOOK" \
    && ok 'the default edition keeps its identifier and its colophon' \
    || bad 'the default edition'"'"'s identifier or colophon has changed'

  ((FAILED == 0)) || exit 1
}

main "$@"
#fin
