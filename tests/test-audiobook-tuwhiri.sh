#!/bin/bash
#shellcheck disable=SC2015  # ok()/bad() only printf+append; A&&B||C is safe here
# tests/test-audiobook-tuwhiri.sh - mk-audiobook.sh --edition tuwhiri builds
# the publisher's audiobook: "Tuwhiri presents", the ten narrations, the
# appendix and the final credits, thirteen chapters under Tuwhiri's imprint
# tags, beside the author's own edition and never over it. Also the two
# helpers that feed it: tools/mk-audio-cover.py squares a portrait cover, and
# mk-audio-tuwhiri.sh cuts the appendix where its Sources begin.
#
# Run in a tree of its own, on stand-in tracks (one second of tone each) and a
# stand-in cover, with the web-root pointed at a temporary directory: nothing
# is narrated and nothing published.
set -euo pipefail
shopt -s inherit_errexit
# Fixed PATH: every external tool must resolve from system locations only.
declare -rx PATH=/usr/local/bin:/usr/bin:/bin

#shellcheck disable=SC2155  # exit-on-error catches realpath failure
declare -r TEST_PATH=$(realpath -- "${BASH_SOURCE[0]}")
declare -r TEST_DIR=${TEST_PATH%/*}
declare -r ROOT=${TEST_DIR%/*}
declare -r STEM=In-Search-of-Dharma_Biksu-Okusi_2026
declare -i FAILED=0 N
declare -- TMP='' TRACK='' SQUARE='' SIZE='' EXT='' OUT='' SCRIPT=''
declare -a TITLES=()
trap '[[ -z $TMP ]] || rm -rf -- "$TMP"' EXIT

ok()   { printf '  ✓ %s\n' "$1"; }
bad()  { printf '  ✗ %s\n' "$1"; FAILED+=1; }
die()  { >&2 printf '  ✗ %s\n' "${*:2}"; exit "$1"; }

# One second of tone in the narration format (MP3, 24 kHz mono, 32 kbps).
tone() {
  ffmpeg -hide_banner -loglevel error -y -f lavfi \
    -i 'sine=frequency=330:sample_rate=24000:duration=1' -ac 1 \
    -c:a libmp3lame -b:a 32k "$1" || die 1 "failed to make ${1@Q}"
}

tag() { # tag FILE NAME : a format tag's value, whatever its case
  ffprobe -v error -show_entries format_tags -of default=nw=1 -- "$1" \
    | grep -i -m1 "^TAG:$2=" | cut -d= -f2-
}

chapters() { ffprobe -v error -show_entries chapter_tags=title -of csv=p=0 -- "$1"; }

printf 'test-audiobook-tuwhiri.sh\n'
TMP=$(mktemp -d) || die 1 'mktemp failed'
declare -r WEB=$TMP/web PROJ=$TMP/proj
mkdir -p -- "$WEB" "$PROJ"/audio-tuwhiri/tracks "$PROJ"/images "$PROJ"/print "$PROJ"/tools

# The stand-in tree: the Parts' sources (for chapter titles), the scripts with
# the web-root redirected, stand-in tracks and covers.
ln -s -- "$ROOT"/[0-9]-*.md "$ROOT"/the-better-ones.md "$PROJ"/
sed -- "s#^declare -r AUDIO_SRC_DIR=.*#declare -r AUDIO_SRC_DIR=$WEB#" \
  "$ROOT"/mk-audiobook.sh > "$PROJ"/mk-audiobook.sh
cp -- "$ROOT"/mk-audio-tuwhiri.sh "$PROJ"/
cp -- "$ROOT"/tools/mk-audio-cover.py "$PROJ"/tools/
chmod -- +x "$PROJ"/mk-audiobook.sh "$PROJ"/mk-audio-tuwhiri.sh
tone "$WEB"/In-Search-of-Dharma_cover.mp3
for N in {0..9}; do tone "$WEB/$N"-in-search-of-dharma.mp3; done
for TRACK in 00_Tuwhiri-Presents 11_Appendix 99_Final-Credits; do
  tone "$PROJ"/audio-tuwhiri/tracks/"$TRACK".mp3
done
tone "$TMP"/chime.mp3

# A portrait cover of five blocks on a flat ground, as Tuwhiri's is.
python3 - "$PROJ"/print/front.jpg <<'PY' || die 1 'failed to draw the stand-in cover'
import sys
from PIL import Image, ImageDraw
im = Image.new('RGB', (800, 1240), (221, 217, 218))
d = ImageDraw.Draw(im)
for top, bottom in ((80, 260), (360, 680), (780, 860), (940, 970), (1060, 1160)):
  d.rectangle((250, top, 550, bottom), fill=(30, 30, 30))
im.save(sys.argv[1], quality=95)
PY
SQUARE=$PROJ/print/tuwhiri-cover-audio_2000x2000.jpg
if python3 "$PROJ"/tools/mk-audio-cover.py "$PROJ"/print/front.jpg "$SQUARE" 1000 >/dev/null; then
  SIZE=$(ffprobe -v error -show_entries stream=width,height -of csv=p=0 -- "$SQUARE")
  [[ $SIZE == 1000,1000 ]] && ok 'the portrait cover is recomposed as a square' \
    || bad "square cover is $SIZE, want 1000,1000"
else
  bad 'mk-audio-cover.py failed on a five-block cover'
fi
python3 - "$PROJ"/print/four.jpg <<'PY' || die 1 'failed to draw the four-block cover'
import sys
from PIL import Image, ImageDraw
im = Image.new('RGB', (800, 1240), (221, 217, 218))
d = ImageDraw.Draw(im)
for top, bottom in ((80, 260), (360, 680), (780, 860), (1060, 1160)):
  d.rectangle((250, top, 550, bottom), fill=(30, 30, 30))
im.save(sys.argv[1], quality=95)
PY
python3 "$PROJ"/tools/mk-audio-cover.py "$PROJ"/print/four.jpg "$TMP"/four-out.jpg 1000 \
  &>/dev/null && bad 'a cover without five blocks was squared anyway' \
  || ok 'a cover without five blocks is refused'
ffmpeg -hide_banner -loglevel error -y -f lavfi -i 'color=c=gray:s=64x64:d=1' \
  -frames:v 1 "$PROJ"/images/defining-dharma-cover-title.png \
  || die 1 'failed to make the stand-in own cover'

# Tuwhiri's edition.
if "$PROJ"/mk-audiobook.sh -q -e tuwhiri -g 0 -G "$TMP"/chime.mp3 2>"$TMP"/log; then
  for EXT in mp3 m4b; do
    OUT=$WEB/${STEM}_tuwhiri_audiobook.$EXT
    [[ -s $OUT ]] || { bad "no Tuwhiri $EXT was written"; continue; }
    mapfile -t TITLES < <(chapters "$OUT")
    ((${#TITLES[@]} == 13)) && ok "$EXT: thirteen chapters" \
      || bad "$EXT: ${#TITLES[@]} chapters, want 13"
    [[ ${TITLES[0]} == 'Tuwhiri presents' && ${TITLES[1]} == Preface
      && ${TITLES[11]} == 'Appendix: Dharmas: the better ones'
      && ${TITLES[12]} == 'Final credits' ]] \
      && ok "$EXT: opening, Preface, appendix and credits in their places" \
      || bad "$EXT: chapter order is ${TITLES[*]}"
    [[ $(tag "$OUT" ISBN) == 979-8-9980676-2-4 ]] && ok "$EXT: the audiobook ISBN" \
      || bad "$EXT: ISBN tag is $(tag "$OUT" ISBN)"
    [[ $(tag "$OUT" title) == 'In search of dharma' ]] && ok "$EXT: Tuwhiri's title casing" \
      || bad "$EXT: title tag is $(tag "$OUT" title)"
    [[ $(tag "$OUT" comment) == *'Narrated by an AI voice'* ]] \
      && ok "$EXT: the comment declares the AI narration" \
      || bad "$EXT: comment tag is $(tag "$OUT" comment)"
    [[ $(tag "$OUT" copyright) == *'CC BY 4.0'* ]] && ok "$EXT: the licence" \
      || bad "$EXT: copyright tag is $(tag "$OUT" copyright)"
  done
  python3 - "$WEB/${STEM}"_tuwhiri_audiobook <<'PY' \
    && ok 'publisher and narrator reach both containers' \
    || bad 'publisher or narrator missing from a container'
import sys
from mutagen.id3 import ID3
from mutagen.mp4 import MP4
base = sys.argv[1]
mp4 = MP4(base + '.m4b').tags
id3 = ID3(base + '.mp3')
assert mp4['\xa9pub'] == ['Tuwhiri'] and 'AI voice' in mp4['\xa9nrt'][0]
assert str(id3['TPUB']) == 'Tuwhiri' and id3.getall('COMM') and id3.getall('APIC')
PY
  [[ ! -e $WEB/${STEM}_audiobook.mp3 ]] && ok "the author's edition is not touched" \
    || bad "the Tuwhiri build wrote the author's edition"
else
  bad "mk-audiobook.sh --edition tuwhiri failed: $(<"$TMP"/log)"
fi

# The author's own edition, unchanged by the option.
if "$PROJ"/mk-audiobook.sh -q -g 0 -G "$TMP"/chime.mp3 2>"$TMP"/log; then
  OUT=$WEB/${STEM}_audiobook.mp3
  mapfile -t TITLES < <(chapters "$OUT")
  [[ ${#TITLES[@]} -eq 11 && ${TITLES[0]} == Cover && ${TITLES[10]} == Coda ]] \
    && ok 'own edition: cover and ten narrations, eleven chapters' \
    || bad "own edition chapters are ${TITLES[*]}"
  [[ -z $(tag "$OUT" ISBN) && $(tag "$OUT" title) == 'in search of dharma' ]] \
    && ok "own edition: no publisher's imprint" \
    || bad 'own edition carries Tuwhiri tags'
else
  bad "the default build failed: $(<"$TMP"/log)"
fi

# Refusals.
"$PROJ"/mk-audiobook.sh -q -e nobody &>/dev/null \
  && bad 'an unknown edition was accepted' || ok 'an unknown edition is refused'
rm -- "$PROJ"/audio-tuwhiri/tracks/11_Appendix.mp3
"$PROJ"/mk-audiobook.sh -q -e tuwhiri &>/dev/null \
  && bad 'built without the appendix track' || ok 'a missing appendix track stops the build'

# The appendix as narrated: frontmatter, the text, nothing from Sources on.
# The function is lifted out of mk-audio-tuwhiri.sh so that nothing is narrated.
#shellcheck disable=SC2034  # read by the sourced function
(
  SRC_DIR=$PROJ/audio-tuwhiri
  APPENDIX=$PROJ/the-better-ones.md
  APPENDIX_SCRIPT=$SRC_DIR/11-appendix.md
  SOURCES_HEADING='## Sources & further reading'
  #shellcheck disable=SC1090  # the function is cut from the script at run time
  source <(sed -n -- '/^write_appendix_script() {$/,/^}$/p' "$PROJ"/mk-audio-tuwhiri.sh)
  write_appendix_script
) || die 1 'write_appendix_script failed'
SCRIPT=$PROJ/audio-tuwhiri/11-appendix.md
grep -q -x -- '  output: 11_Appendix.mp3' "$SCRIPT" && ok 'appendix script: audio frontmatter' \
  || bad 'appendix script lacks its output name'
grep -q -F -- 'It is the standard, applied to itself.' "$SCRIPT" \
  && ok 'appendix script: runs to the last sentence' \
  || bad 'appendix script lost its last sentence'
grep -q -F -- 'Sources & further reading' "$SCRIPT" \
  && bad 'appendix script reads into the Sources' || ok 'appendix script: stops before the Sources'
[[ ! $SCRIPT -nt $ROOT/the-better-ones.md && ! $SCRIPT -ot $ROOT/the-better-ones.md ]] \
  && ok "appendix script: stamped with the appendix's time" \
  || bad 'appendix script has a time of its own'

((FAILED == 0)) || { printf '  %d failed\n' "$FAILED"; exit 1; }
#fin
