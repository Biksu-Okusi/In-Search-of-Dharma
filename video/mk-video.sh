#!/usr/bin/bash
# Build the YouTube video-audiobook of In Search of Dharma, one MOV per Part:
# a still title frame (Part image + title), the published narration underneath,
# forced-aligned WebVTT captions, and a paste-ready description file.
set -euo pipefail
shopt -s inherit_errexit extglob nullglob

# --- Script Metadata ---
declare -r VERSION='1.0.0'
#shellcheck disable=SC2155
declare -r SCRIPT_PATH=$(realpath -- "$0")
declare -r SCRIPT_DIR=${SCRIPT_PATH%/*} SCRIPT_NAME=${SCRIPT_PATH##*/}

# --- Configuration ---
declare -r BOOK_DIR=${SCRIPT_DIR%/*}
declare -r IMAGES_DIR=$BOOK_DIR/images
declare -r OUT_DIR=$SCRIPT_DIR/out
declare -r PYTHON=$SCRIPT_DIR/.venv/bin/python
declare -r ALIGNER=$SCRIPT_DIR/align-vtt.py
# Same conventions as mk-book.sh: narration lives in the site's audio directory
declare -r AUDIO_SRC_DIR=/var/www/vhosts/garydean.id/html/audio
declare -r AUDIO_STEM=in-search-of-dharma
declare -r BOOK_URL=https://garydean.id/books/in-search-of-dharma
declare -r AUDIO_BASE_URL=https://garydean.id/audio
declare -r REPO_URL=https://github.com/Biksu-Okusi/In-Search-of-Dharma
declare -r DOI_URL=https://doi.org/10.5281/zenodo.21348716
declare -r AUTHOR='Biksu Okusi'
declare -r CHANNEL='www.youtube.com/@aseculardharma'
# Intro sting played before each Part, then INTRO_GAP seconds of silence
declare -r INTRO=$BOOK_DIR/audio-assets/dharmic-ai.mp3
declare -r INTRO_GAP=2
declare -r SERIES_BLURB='In Search of Dharma asks what a dharma is, how dharmas arise, how they get under the skin, '\
'how they go wrong, and what survives in a secular age. Preface, eight Parts and a Coda, read in full.'

# Frame design: 1920x1080, image 900x900 at (90,90), text column at x=1080
declare -r BG='#141414' FG='#e8e2d6' ACCENT='#c9b98a' MUTED='#7d786f'
declare -r FONT_REG='EB-Garamond-12-Regular' FONT_ITAL='EB-Garamond-08-Italic'

declare -i FORCE=0 SPOT_CHECK=5
declare -- STEPS='frame,vtt,video,desc'
declare -- WHISPER_MODEL='large-v3'

# --- Messaging Functions ---
declare -i VERBOSE=1
_msg() { >&2 printf "$SCRIPT_NAME: $1 %s\n" "${@:2}"; }
info()    { ((VERBOSE)) || return 0; _msg '◉' "$@"; }
success() { ((VERBOSE)) || return 0; _msg '✓' "$@"; }
warn()    { _msg '▲' "$@"; }
error()   { _msg '✗' "$@"; }
die()     { (($# < 2)) || error "${@:2}"; exit "${1:-0}"; }
noarg()   { (($# > 1)) || die 22 "Option ${1@Q} requires an argument"; }

usage() {
  cat <<EOT
Usage: $SCRIPT_NAME [OPTIONS] [PART...]

Build YouTube videos for the given Parts (default 0..9) into $OUT_DIR/:
  N-$AUDIO_STEM.png       1920x1080 title frame (also the thumbnail)
  N-$AUDIO_STEM.vtt       forced-aligned captions
  N-$AUDIO_STEM.chapters  chapter timestamps
  N-$AUDIO_STEM.mov       the video (MOV container: some players glitch the sting in MP4)
  N-$AUDIO_STEM.txt       title + description, paste-ready

Each video opens with the intro sting ($INTRO_GAP s gap), then the narration;
captions and chapters are offset to match. Outputs are rebuilt only when the
MP3, sting, image or Part markdown is newer.

Options:
  -s, --steps LIST     comma list of frame,vtt,video,desc (default: all)
  -m, --model NAME     whisper model for alignment (default: $WHISPER_MODEL)
  -c, --spot-check N   ASR spot-check N random cues per Part (default: $SPOT_CHECK; 0 = off)
  -f, --force          rebuild even when outputs are current
  -q, --quiet          suppress progress output
  -V, --version        print version
  -h, --help           this help
EOT
}

# --- Helpers ---

# frontmatter_value KEY FILE -> the quoted value of KEY inside the audio: block
frontmatter_value() {
  local -- key=$1 file=$2
  awk -v key="$key" '
    NR==1 && $0=="---" {fm=1; next}
    fm && $0=="---" {exit}
    fm && /^audio:/ {inaudio=1; next}
    inaudio && /^[^ \t#]/ {exit}
    inaudio && $1==key":" {sub(/^[^:]*:[ \t]*/, ""); gsub(/^"|"$/, ""); print; exit}
  ' "$file"
}

# part_file N -> path of the Part markdown
part_file() {
  local -- n=$1
  local -a matches=("$BOOK_DIR"/"$n"-*.md)
  ((${#matches[@]} == 1)) || die 2 "expected one Part file for $n, found ${#matches[@]}"
  printf '%s\n' "${matches[0]}"
}

# part_image FILE -> path of the PNG master behind the Part's <image> tag
part_image() {
  local -- md=$1 rel
  rel=$(sed -nE 's#^<image[[:space:]]+[a-z]+[[:space:]]+[0-9]+[[:space:]]+"/images/([^"]*)".*#\1#p' "$md" | head -1)
  [[ -n $rel ]] || die 2 "no <image> tag in $md"
  local -- png=$IMAGES_DIR/${rel%.*}.png
  [[ -f $png ]] && { printf '%s\n' "$png"; return 0; }
  [[ -f $IMAGES_DIR/$rel ]] || die 2 "image not found: $IMAGES_DIR/$rel"
  printf '%s\n' "$IMAGES_DIR/$rel"
}

# standfirst FILE -> the italic blockquote under the image, markup stripped
standfirst() {
  awk '
    NR==1 && $0=="---" {fm=1; next}
    fm && $0=="---" {fm=0; next}
    !fm && /^> \*/ {sub(/^> \*/, ""); sub(/\*[ \t]*$/, ""); print; exit}
  ' "$1"
}

# stale TARGET SRC... -> 0 when TARGET is missing or older than any SRC
stale() {
  local -- target=$1 src
  ((FORCE)) && return 0
  [[ -f $target ]] || return 0
  for src in "${@:2}"; do
    [[ $src -nt $target ]] && return 0
  done
  return 1
}

has_step() { [[ ,$STEPS, == *,"$1",* ]]; }

# --- Build steps ---

build_frame() {
  local -- png=$1 image=$2 title=$3 subtitle=$4
  convert -size 1920x1080 xc:"$BG" \
    \( "$image" -resize 900x900 \) -gravity northwest -geometry +90+90 -composite \
    \( -background none -gravity northwest \
       \( -size 750x -fill "$FG" -font "$FONT_REG" -pointsize 84 caption:"$title" \) \
       \( -size 750x36 xc:none \) \
       \( -size 750x -fill "$ACCENT" -font "$FONT_REG" -pointsize 58 -interline-spacing 4 caption:"$subtitle" \) \
       \( -size 750x70 xc:none \) \
       \( -size 750x -fill "$FG" -font "$FONT_ITAL" -pointsize 46 caption:"$AUTHOR" \) \
       -append \) -gravity west -geometry +1080+0 -composite \
    \( +size -background none -fill "$MUTED" -font "$FONT_REG" -pointsize 32 label:"$CHANNEL" \) \
       -gravity southeast -geometry +90+70 -composite \
    -depth 8 "$png"
}

# intro_offset -> seconds before the narration starts (intro sting + gap)
intro_offset() {
  local -- d
  d=$(ffprobe -v error -show_entries format=duration -of csv=p=0 "$INTRO") \
    || die 1 "ffprobe failed on $INTRO"
  printf '%s\n' "$(bc -l <<< "$d + $INTRO_GAP")"
}

build_vtt() {
  local -- stem=$1 md=$2 mp3=$3 language=$4 offset=$5
  local -- spoken=$stem.spoken.txt
  gentts --dump-text "$spoken" -q "$md"
  [[ -s $spoken ]] || die 1 "gentts produced no spoken text for $md"
  "$PYTHON" "$ALIGNER" --audio "$mp3" --text "$spoken" --md "$md" --out "$stem" \
    --language "$language" --model "$WHISPER_MODEL" --spot-check "$SPOT_CHECK" \
    --offset "$offset"
}

# Audio = intro sting, INTRO_GAP seconds of silence, then the narration.
# MOV rather than MP4: bit-identical MP4s glitch the sting in some desktop
# players (verified by A/B, 2026-08-21); MOV plays clean and YouTube accepts it.
build_video() {
  local -- mov=$1 png=$2 mp3=$3
  local -i gap_ms=$((INTRO_GAP * 1000))
  ffmpeg -v error -y -loop 1 -framerate 24 -i "$png" -i "$INTRO" -i "$mp3" \
    -filter_complex "[1:a]aformat=sample_rates=48000:channel_layouts=stereo[intro];\
[2:a]aformat=sample_rates=48000:channel_layouts=stereo,adelay=${gap_ms}|${gap_ms}[part];\
[intro][part]concat=n=2:v=0:a=1[a]" \
    -map 0:v -map '[a]' \
    -c:v libx264 -tune stillimage -preset slow -crf 28 -pix_fmt yuv420p \
    -c:a aac -b:a 256k -shortest -movflags +faststart "$mov"
}

build_desc() {
  local -- txt=$1 n=$2 md=$3 title=$4 subtitle=$5 chapters=$6
  local -- blurb
  blurb=$(standfirst "$md")
  {
    printf '%s — %s\n\n' "$title" "$subtitle"
    printf '%s\n\n' "$blurb"
    printf '%s\n\n' "$SERIES_BLURB"
    printf 'Book, audio and text: %s\n' "$BOOK_URL"
    printf 'This Part as MP3: %s/%s-%s.mp3\n' "$AUDIO_BASE_URL" "$n" "$AUDIO_STEM"
    printf 'Source, PDF and EPUB: %s\n' "$REPO_URL"
    printf 'Archived edition (DOI): %s\n\n' "$DOI_URL"
    printf 'Chapters\n'
    cat "$chapters"
    printf '\nNarration: Google Chirp3-HD (en-AU) · Text and image © %s · Licence: CC BY 4.0\n' "$AUTHOR"
  } > "$txt"
}

build_part() {
  local -- n=$1 md mp3 image title subtitle language stem offset
  md=$(part_file "$n")
  mp3=$AUDIO_SRC_DIR/$n-$AUDIO_STEM.mp3
  [[ -f $mp3 ]] || die 2 "narration not found: $mp3"
  image=$(part_image "$md")
  title=$(frontmatter_value title "$md")
  subtitle=$(frontmatter_value subtitle "$md")
  language=$(frontmatter_value lang_code "$md"); language=${language%%-*}; language=${language:-en}
  [[ -n $title && -n $subtitle ]] || die 2 "audio.title/subtitle missing in $md"
  stem=$OUT_DIR/$n-$AUDIO_STEM
  offset=$(intro_offset)
  info "Part $n: $subtitle"

  if has_step frame; then
    if stale "$stem.png" "$image" "$md"; then
      build_frame "$stem.png" "$image" "$title" "$subtitle"
      success "  frame  $stem.png"
    else
      info "  frame  current"
    fi
  fi
  if has_step vtt; then
    if stale "$stem.vtt" "$mp3" "$md" "$ALIGNER" "$INTRO"; then
      build_vtt "$stem" "$md" "$mp3" "$language" "$offset"
      success "  vtt    $stem.vtt"
    else
      info "  vtt    current"
    fi
  fi
  if has_step video; then
    if stale "$stem.mov" "$mp3" "$stem.png" "$INTRO"; then
      build_video "$stem.mov" "$stem.png" "$mp3"
      success "  video  $stem.mov ($(du -h "$stem.mov" | cut -f1))"
    else
      info "  video  current"
    fi
  fi
  if has_step desc; then
    [[ -f $stem.chapters ]] || die 2 "no chapters file for Part $n (run the vtt step first)"
    if stale "$stem.txt" "$md" "$stem.chapters" "$SCRIPT_PATH"; then
      build_desc "$stem.txt" "$n" "$md" "$title" "$subtitle" "$stem.chapters"
      success "  desc   $stem.txt"
    else
      info "  desc   current"
    fi
  fi
}

check_dependencies() {
  local -- dep
  for dep in convert ffmpeg ffprobe gentts bc; do
    command -v "$dep" >/dev/null || die 1 "missing dependency: $dep"
  done
  [[ -f $INTRO ]] || die 2 "intro sting not found: $INTRO"
  if has_step vtt; then
    [[ -x $PYTHON ]] || die 1 "no venv at $PYTHON" \
      '(uv venv .venv && uv pip install -p .venv/bin/python stable-ts faster-whisper)'
  fi
}

# --- Main ---
main() {
  local -a parts=()
  while (($#)); do case $1 in
    -s|--steps)      noarg "$@"; shift; STEPS=$1 ;;
    -m|--model)      noarg "$@"; shift; WHISPER_MODEL=$1 ;;
    -c|--spot-check) noarg "$@"; shift; SPOT_CHECK=$1 ;;
    -f|-F|--force)   FORCE=1 ;;
    -V|--version)    printf '%s %s\n' "$SCRIPT_NAME" "$VERSION"; exit 0 ;;
    -h|--help)       usage; exit 0 ;;
    -v|--verbose)    VERBOSE=1 ;;
    -q|--quiet)      VERBOSE=0 ;;
    --)              shift; break ;;
    -[smcfFVhvq]?*)  set -- "${1:0:2}" "-${1:2}" "${@:2}"; continue ;;
    -*)              die 22 "Invalid option ${1@Q}" ;;
    [0-9])           parts+=("$1") ;;
    *)               die 2 "Unexpected argument ${1@Q} (Parts are 0..9)" ;;
  esac; shift; done
  ((${#parts[@]})) || parts=(0 1 2 3 4 5 6 7 8 9)

  check_dependencies
  mkdir -p "$OUT_DIR"
  local -- n
  for n in "${parts[@]}"; do
    build_part "$n"
  done
  success "done: ${parts[*]}"
}

main "$@"
#fin
