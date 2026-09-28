#!/bin/bash
# SC2034: the constants declared here are read by mk-print.sh and the tests,
# which source this file, not by the file itself.
#shellcheck shell=bash disable=SC2034
# lib/print-style.sh - page geometry and stylesheet for the print interior.
#
# Sourced (never executed) by mk-print.sh. Holds the frozen layout constants
# that put every baseline on the grid of Tuwhiri's The secular path to
# well-being, the book Tuwhiri asked this one to follow.
#
# Usage:
#   source "$SCRIPT_DIR"/lib/fonts.sh
#   font_set_load bonanova-worksans "$SCRIPT_DIR"/fonts
#   source "$SCRIPT_DIR"/lib/print-style.sh
#   print_geom_load            # or: print_geom_load 10.5 17  (a proof setting)
#   { font_faces_css pdf && print_title_faces_css "$SCRIPT_DIR"/fonts && print_page_css; } > print.css
#
# The constants below were solved numerically against the model book and are
# frozen, with one deliberate departure: PRINT_H1GAP_MM. The model book drops
# 131mm to the first line of a chapter; Ramsey asked for two line spaces under
# the title instead (2026-09-21), so the opening line sits three linefeeds
# below the title's baseline, at 104.52mm. They are specific to 10pt on 16pt
# leading in Bona Nova. Nothing re-derives them: the design planned a solver
# and it was never built, so any other setting is a proof setting, good for
# judging type size and colour but with its openers, running heads, folios and
# drop caps off the grid. To ship another setting, re-solve the constants by
# hand against `lib/pdfcheck.py baselines` and move the targets in
# tests/test-print-style.sh with them.
#
# Measure the raw WeasyPrint PDF (mk-print.sh --keep-temp leaves it as raw.pdf),
# never the finished interior: the Ghostscript pass rewrites the fonts, and
# pdfcheck then reads baselines 0.3 to 0.7mm low although the ink has not moved
# (checked pixel by pixel, 2026-09-23). And measure in the book's own faces:
# until 2026-09-23 the test loaded the fonts by a relative file:// URL, which
# fails silently, so PRINT_H1GAP_MM was first solved in a fallback font and set
# the opening line 0.25mm too low. It was re-solved in Bona Nova that day.

[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

# Trim and margins, in mm. Measured from the model book and confirmed against
# Ramsey's marked-up recto and verso scans. The gutter is the larger of the two
# because a perfect-bound spine swallows part of it.
declare -r PRINT_TRIM_W_MM=152 PRINT_TRIM_H_MM=229
declare -r PRINT_MEASURE_MM=107 PRINT_INNER_MM=25 PRINT_OUTER_MM=20

# The book's title, on the half-title and the title page, is set in Cascadia
# Code: "in search of" in its Light Italic above "dharma" in its Light, all
# lowercase, as the cover sets it (Tuwhiri's choice, 2026-09-23; Gary's
# lowercase, the same day). Vendored in fonts/cascadia (OFL, fsType 0, so
# embeddable). These faces belong to the print title pages alone, so they stay
# out of lib/fonts.sh, whose sets are embedded whole in the EPUB.
declare -r PRINT_TITLE_FAMILY='Cascadia Code'
# weight|style|file, one per face.
declare -ar PRINT_TITLE_FACES=(
  '300|normal|cascadia/CascadiaCode-Light.ttf'
  '300|italic|cascadia/CascadiaCode-LightItalic.ttf'
)

# print_title_files <fonts-root> : the title faces' paths, one per line.
print_title_files() {
  local -- entry
  for entry in "${PRINT_TITLE_FACES[@]}"; do
    printf '%s/%s\n' "$1" "${entry##*|}"
  done
}

# print_title_faces_css <fonts-root> : one @font-face per title face.
print_title_faces_css() {
  local -- entry weight style path
  for entry in "${PRINT_TITLE_FACES[@]}"; do
    IFS='|' read -r weight style path <<<"$entry"
    printf '@font-face{font-family:"%s";font-weight:%s;font-style:%s;src:url("file://%s/%s")}\n' \
      "$PRINT_TITLE_FAMILY" "$weight" "$style" "$1" "$path"
  done
}

# Populated by print_geom_load. Declared here so a `set -u` script may reference
# them before the call.
declare -- PRINT_SIZE_PT='' PRINT_LEAD_PT='' PRINT_SUB_PT='' PRINT_SRC_PT=''
declare -- PRINT_TOP_MM='' PRINT_BOT_MM='' PRINT_HEADPAD_MM='' PRINT_FOLIOPAD_MM=''
declare -- PRINT_H1PAD_MM='' PRINT_H1GAP_MM='' PRINT_DROP_FS='' PRINT_DROP_LH=''
declare -- PRINT_FOLIORULE_MM='' PRINT_FOLIORISE_MM='' PRINT_FOLIOGAP_MM=''
declare -- PRINT_DROP_DY_MM=''

# The shipping setting, and the constants solved for it.
print_geom_load() {
  PRINT_SIZE_PT=${1:-10} PRINT_LEAD_PT=${2:-16}
  if [[ $PRINT_SIZE_PT != 10 || $PRINT_LEAD_PT != 16 ]]; then
    >&2 printf '▲ %s: %spt on %spt is a proof setting. The layout constants were solved '\
'for 10 on 16 and are not re-derived, so openers, running heads, folios and drop caps '\
'will sit off the grid.\n' \
      "${BASH_SOURCE[0]##*/}" "$PRINT_SIZE_PT" "$PRINT_LEAD_PT"
  fi
  PRINT_SUB_PT=12 PRINT_SRC_PT=9
  PRINT_TOP_MM=24.58 PRINT_BOT_MM=24.5
  PRINT_HEADPAD_MM=13.35 PRINT_FOLIOPAD_MM=6.80
  PRINT_H1PAD_MM=55.34 PRINT_H1GAP_MM=12.60
  PRINT_DROP_FS=3.200 PRINT_DROP_LH=0.688
  # How far the cap is moved down to stand on the second line's baseline
  # (Ramsey, 2026-09-28). PRINT_DROP_LH was solved against pdftotext's boxes,
  # whose feet lie a descent below the baseline: 0.268em, so 2mm further for
  # the 32pt cap than for the 10pt line, and the cap stood that much high.
  PRINT_DROP_DY_MM=2.00
  # The folio's rule (Ramsey, 2026-09-28, after What is this?): 5mm long, rising
  # PRINT_FOLIORISE_MM above the top of the folio's line, which PRINT_FOLIOPAD_MM
  # still places, so the numeral keeps its baseline. The numeral stands
  # PRINT_FOLIOGAP_MM after the rule.
  PRINT_FOLIORULE_MM=5.00 PRINT_FOLIORISE_MM=0.76 PRINT_FOLIOGAP_MM=0.65
}

# The complete print stylesheet. Written after font_faces_css pdf, which binds
# every face by absolute file:// URL.
print_page_css() {
  # The folio, set as Ramsey asked (2026-09-28) after Tuwhiri's What is this?:
  # on the left of every page, recto and verso alike, in regular weight, beside
  # a 5mm hairline standing 10mm in from the text's left edge, the paragraph
  # indent. The margin box begins at that edge; its left border is the rule, and
  # its vertical margins shrink it to the rule's length. vertical-align:top
  # keeps the numeral at the head of the box, PRINT_FOLIORISE_MM below the
  # rule's top.
  #
  # The lengths are worked out by awk, the shell having integers only, and
  # under the C locale: CSS writes its decimals with a point, and an awk that
  # follows the locale would write a comma. It is run and checked before its
  # figures are used, since a stylesheet with a length missing still parses.
  local -- lengths rule_top rule_foot two_lines folio
  lengths=$(LC_ALL=C awk -v pad="$PRINT_FOLIOPAD_MM" -v rise="$PRINT_FOLIORISE_MM" \
    -v len="$PRINT_FOLIORULE_MM" -v bot="$PRINT_BOT_MM" -v lead="$PRINT_LEAD_PT" \
    'BEGIN{printf "%.2f %.2f %g\n", pad - rise, bot - (pad - rise) - len, lead * 2}') \
    || { >&2 printf '✗ %s: could not work out the stylesheet'"'"'s lengths\n' "${BASH_SOURCE[0]##*/}"
         return 1; }
  read -r rule_top rule_foot two_lines <<<"$lengths"
  [[ -n $rule_top && -n $rule_foot && -n $two_lines ]] \
    || { >&2 printf '✗ %s: the stylesheet'"'"'s lengths came back incomplete: %s\n' \
           "${BASH_SOURCE[0]##*/}" "${lengths@Q}"
         return 1; }
  folio="font:400 8pt/1 \"$FONT_SANS_FAMILY\";vertical-align:top;text-align:left;
    margin:${rule_top}mm 0 ${rule_foot}mm 10mm;border-left:0.4pt solid #000;
    padding:${PRINT_FOLIORISE_MM}mm 0 0 ${PRINT_FOLIOGAP_MM}mm"
  cat <<CSS
@page{size:${PRINT_TRIM_W_MM}mm ${PRINT_TRIM_H_MM}mm;
  margin:${PRINT_TOP_MM}mm ${PRINT_OUTER_MM}mm ${PRINT_BOT_MM}mm ${PRINT_INNER_MM}mm;
  @top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page:left{margin-left:${PRINT_OUTER_MM}mm;margin-right:${PRINT_INNER_MM}mm;
  @top-left{content:string(booktitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-left{content:counter(page);$folio}}
@page:right{margin-left:${PRINT_INNER_MM}mm;margin-right:${PRINT_OUTER_MM}mm;
  @top-right{content:string(chaptitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-left{content:counter(page);$folio}}
/* A blank verso keeps its running head (Ramsey, 2026-09-28) and loses only its
   folio: he asked for the head, not the number. :blank outranks :left, so the
   head declared there survives unless it is named again here. */
@page:blank{@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page chapopen{@top-left{content:none}@top-right{content:none}}
@page firstbody{counter-reset:page 1;
  @top-left{content:none}@top-right{content:none}}
@page front:left{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:counter(page,lower-roman);$folio}}
@page front:right{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:counter(page,lower-roman);$folio}}
/* The Preface is a preliminary, numbered on in lower-roman from the front
   matter (Ramsey, 2026-09-28: page 1 is the first page of Part 1). Its pages
   carry running heads like a chapter's; its opener, like a chapter opener,
   does not. mk-print.sh marks it section.chapter.prelim. The opener cannot
   have a page name of its own, as a chapter's does: a change of name between
   the title and the paragraph after it forces a page break there. It shares
   the name, and first-except empties the recto head on the page where the
   title sets it, which is the opener. */
@page prelim{@bottom-left{content:counter(page,lower-roman);$folio}}
@page prelim:right{@top-right{content:string(chaptitle,first-except)}}
/* The Preface's versos name the book outright, not through the booktitle
   string, which stays unset until Part 1 (see section.chapter > h1 below). */
@page prelim:left{@top-left{content:"in search of dharma"}}
/* Which front-matter pages go without a folio. Ramsey will name the pages that
   show a roman numeral; until he does, the half-title, the title page and the
   imprint show none, and the numbering appears from the contents on. They are
   still counted. To change the set, change this page's selector list below
   (section.front ... {page:bare}); nothing else needs touching. */
@page bare{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
/* A blank inside the front matter carries nothing, folio included. It has to
   be said again here, after the rules above: they match a blank front page as
   well as @page:blank does, and the later rule wins. This reaches only a blank
   between two parts of section.front, which takes that section's page name.
   The blank before the Preface and the blank before Part 1 stand between
   sections, and the renderer (WeasyPrint 69) gives such a page no name at all,
   so no named rule can reach them; they are kept empty by leaving the
   booktitle string unset until Part 1. */
@page front:blank{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}

/* Every page runs to its full 31 lines (Ramsey, 2026-09-28), so a paragraph may
   leave one line at the foot of a page or carry one over to the head of the
   next. Widows, orphans and runts are put right by hand at the very end, once
   the pagination has settled; "pdfcheck.py lines" lists the pages to look at.
   A subhead still stays with the text under it, which is his stated exception.
   Both properties are inherited and are set here, at the root, so that they
   reach a list entry as well as a paragraph: the Sources are lists. */
html{font-family:"$FONT_SERIF_FAMILY",serif;font-size:${PRINT_SIZE_PT}pt;
  line-height:${PRINT_LEAD_PT}pt;color:#000;hyphens:auto;widows:1;orphans:1;
  font-variant-numeric:oldstyle-nums;
  font-feature-settings:"onum" 1,"liga" 1,"kern" 1}
body{margin:0}

h1{page:chapopen;break-before:recto;margin:0 0 0 10mm;position:relative;
  font:600 20pt/1 "$FONT_SANS_FAMILY";
  padding-top:${PRINT_H1PAD_MM}mm;padding-bottom:${PRINT_H1GAP_MM}mm;
  string-set:chaptitle content()}
h2{font:600 ${PRINT_SUB_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}
h3{font:600 ${PRINT_SIZE_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}

p{margin:0;text-align:justify;text-indent:10mm}
p.op,h1+p,h2+p,h3+p,blockquote+p{text-indent:0}
blockquote{margin:${PRINT_LEAD_PT}pt 0 ${PRINT_LEAD_PT}pt 8mm;font-style:italic}
blockquote p{text-indent:0}
/* An epigraph directly under a chapter title gives up its top margin: the
   title's own padding already is the two line spaces, and the margin on top of
   it would make three. */
h1 + blockquote{margin-top:0}
p.attrib{text-indent:20mm;font:600 9pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY"}
ul,ol{margin:${PRINT_LEAD_PT}pt 0;padding-left:10mm}
/* The bullet hangs at the left margin and the text stands in by the paragraph
   indent, as in the publisher's sample. A marker left to the renderer sits just
   outside the text instead, a few points in from nowhere in particular. */
ul{list-style:none}
ul > li{position:relative;text-align:left}
ul > li::before{content:"\\2022";position:absolute;left:-10mm}

/* Sources & further reading is reference matter, not narrative, and is set as
   such. The size applies to the whole block: set on p alone it missed the
   lists, which then stood a point larger than the notes around them. Nothing
   takes the narrative first-line indent. A paragraph that is only a bold label
   ("Research notes", "Key works") is a subhead: mk-print.sh marks it p.label,
   since no selector can tell a paragraph that IS a bold run from one that
   merely contains one. */
.sources{font-size:${PRINT_SRC_PT}pt}
.sources p{text-indent:0}
.sources p.label{font:600 ${PRINT_SIZE_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin-top:${PRINT_LEAD_PT}pt;text-align:left;break-after:avoid}
.sources h2 + p.label{margin-top:0}
.sources ul,.sources ol{margin:0}
/* Research notes, as Ramsey set them out (2026-09-28): unhyphenated, the URL
   whole on a line of its own, and the note text 5mm in from its bullet rather
   than the paragraph indent. lib/researchnotes.py wraps the block in div.rn
   and breaks the sentence before the URL. Ragged right, since a justified line
   that may not hyphenate opens rivers. */
.rn{hyphens:none;text-align:left}
.rn p{text-align:left}
.repo-url{white-space:nowrap}
.rn ul{padding-left:5mm}
.rn ul > li::before{left:-5mm}

/* The two-line drop cap. It hangs on p.op, which lib/dropcap.py marks: a
   chapter's opening paragraph is not the element after the h1, because the
   watercolour and the epigraph come between them. The cap is moved down by a
   relative offset, which shifts the letter and leaves the float where it was,
   so the two lines beside it are set exactly as before. */
p.op .dc{float:left;font-size:${PRINT_DROP_FS}em;
  line-height:$PRINT_DROP_LH;padding:0 0.06em 0 0;
  position:relative;top:${PRINT_DROP_DY_MM}mm}
.sc{font-variant-caps:small-caps;letter-spacing:0.02em}

/* Ramsey's point 3: a run of two or more capitals is set in small capitals.
   No selector can reach an element by what it contains, so lib/smallcaps.py
   wraps each run first. "all-small-caps" is smcp+c2sc together: the text is already
   uppercase, so c2sc is the one doing the work. */
.caps{font-variant-caps:all-small-caps;
  font-feature-settings:"c2sc" 1,"smcp" 1,"onum" 1,"liga" 1,"kern" 1;
  letter-spacing:0.02em}

/* Ramsey's point 4: bold in the text is Work Sans SemiBold, not a bold cut of
   the serif. Work Sans carries the larger x-height of the two (0.500 against
   Bona Nova's 0.440) while their cap heights are all but identical (0.660 and
   0.665), so at the same nominal size it reads noticeably bigger than the text
   around it. 0.94em is the geometric mean of those two ratios, which leaves
   neither lowercase nor capitals far out. */
/* The negligible word-spacing is a workaround for WeasyPrint (seen in 69.0),
   not a spacing choice. The renderer applies word spacing as a letter-spacing
   attribute on each space alone, which costs the kerning between a space and
   its neighbours; but it adds those attributes only when word spacing is
   non-zero, and justification spacing only when drawing. A justified line is
   therefore measured with space kerning and drawn without it. Work Sans has
   some 240 kern pairs against the space and Bona Nova none, so a line ending
   in bold ran up to 0.4mm past the measure. Any non-zero value makes layout
   measure what will be drawn. */
strong,b{font-family:"$FONT_SANS_FAMILY";font-weight:600;font-size:0.94em;word-spacing:0.001pt}
/* Bold inside italic -- the Coda's closing statement, the Preface's signature
   -- takes Work Sans SemiBold Italic, which lib/fonts.sh embeds. Without that
   face the renderer fakes a slant; an earlier proof forced such bold upright
   on the mistaken belief that the family had no italic. */
/* A statement set whole in bold is display matter, and is set ragged right
   rather than justified. */
blockquote p:has(> strong:only-child){text-align:left}
/* Italic inside a subhead is meaning, not decoration -- a Javanese term, a
   stressed "The" -- and stays in the subhead's own family, in its true italic. */

/* The book holds exactly two code spans, both of them a domain name in a
   Sources list. Left to the default monospace they pull DejaVu Sans Mono into
   the print file -- a face nothing here binds, that glyphcheck.py therefore
   never inspects, and that reads as a screen artefact on a printed page. They
   take the text face instead. */
code,kbd,samp{font-family:inherit;font-size:inherit}

/* The chapter-opener device, following Ramsey's marked-up recto: a hairline
   vertical rule 32.5mm from the trim edge, running from 15mm below the trim
   top down to just above the title, with the Okusi mark beside it. Tuwhiri's
   own books put their roundel here. The mark is 12mm and its left edge is the
   title's own (left:0), so it stands over the chapter number; its foot stays
   where the 16mm mark's was, 52.4mm down.
   Offsets are relative to the h1's border box, whose top is PRINT_TOP_MM from
   the trim and whose left edge is the 25mm gutter plus the h1's own 10mm
   indent. Openers are always recto, so the geometry never mirrors. */
section.chapter h1::before{content:"";position:absolute;
  left:-2.5mm;top:-9.58mm;width:0.4pt;height:71mm;background:#000}
section.chapter h1::after{content:"";position:absolute;
  left:0;top:40.4mm;width:12mm;height:12mm;
  background:url(images/dharma-eye.svg) no-repeat center/contain}

/* The verso running head: the title in lowercase, as the title pages set it
   (TITLE_TYPESET in mk-print.sh). It is set at each chapter's title from Part
   1 on, rather than once on the body, so that it is still unset through the
   preliminaries. A blank verso keeps its running head, and the two blank
   versos of the preliminaries, before the Preface and before Part 1, are blank
   versos like any other to the renderer; with the string unset they carry
   nothing. Both strings are named in the first rule, since it replaces h1's
   own string-set. The Preface sets its title alone. */
section.chapter > h1{string-set:chaptitle content(),booktitle "in search of dharma"}
section.chapter.prelim > h1{string-set:chaptitle content()}
section.front{page:front}
section.front .endorsements,section.front .halftitle,section.front .titlepage,
section.front .imprint{page:bare}
section.chapter.prelim{page:prelim}
section.chapter.prelim > h1{page:prelim}
section.front h1{break-before:auto;page:front;padding-top:0;
  padding-bottom:${PRINT_LEAD_PT}pt;margin-left:0;font-size:14pt}
/* The arabic sequence restarts at Part 1. ":first-of-type" cannot find it:
   section.front is also a <section>, and the Preface is a chapter too, so
   mk-print.sh tags Part 1 section.chapter.first. */
/* The arabic sequence restarts at the first chapter, via a named page that
   exists only to carry the reset. WeasyPrint ignores counter-reset:page on an
   ELEMENT (verified: it renumbers nothing), and putting the reset on a shared
   named page renumbers every page that uses it. A page name applied to just
   the first chapter's h1 resets once, exactly where it should. */
section.chapter.first > h1{page:firstbody}

/* A printed page has no hyperlinks to follow, so underlines and link colour
   are noise. The href is kept for the PDF's own sake. */
a{text-decoration:none;color:inherit}

/* pandoc's implicit_figures turns an image's alt text into a <figcaption>.
   The alt text is accessibility copy for the EPUB, not a printed caption. */
figcaption{display:none}

/* Chapter watercolours: the source shortcode asks for 40% of the measure and
   preprocess() drops that width, so it is restored here. PLACEMENT ON THE
   OPENER IS STILL RAMSEY'S CALL (see the design spec, section 8): the art
   currently falls where it lands in the flow. */
section.chapter figure{margin:${PRINT_LEAD_PT}pt 0;break-inside:avoid}
section.chapter figure img{max-width:70%}

/* Sources & further reading opens on a page of its own. mk-print.sh wraps it
   in div.sources; the source's own div.pagebreak is the reading PDF's device
   and does nothing here. */
.sources{break-before:page}

/* Each front-matter part takes its own page: half-title, title, imprint,
   contents. Without this they flow together and the whole of the front matter
   lands on page i. */
section.front > div,section.front > nav{break-after:page}
/* The title page is a recto with the imprint on its back, as in the model
   book: half-title i, blank ii, title iii, imprint iv, contents v. Without
   this the title fell on ii, a left-hand page, facing its own imprint. */
section.front .titlepage{break-before:recto}
section.front .halftitle{padding-top:60mm}
/* The endorsements, where the book has any, stand on page i with the
   half-title on the next recto: i endorsements, ii blank, iii half-title, iv
   blank, v title, vi imprint, vii contents. Each is its words and, under them,
   who said them, set ragged and unhyphenated inside the paragraph indent. */
section.front .halftitle{break-before:recto}
section.front .endorsements{padding-top:45mm}
section.front .endorsement{margin:0 0 ${two_lines}pt 10mm;break-inside:avoid}
section.front .endorsement p{text-indent:0;text-align:left;hyphens:none}
section.front .endorsement p + p{margin-top:4pt;font-size:${PRINT_SRC_PT}pt}
/* The title page fills the text area, so the publisher's mark can stand at its
   foot; border-box keeps the 55mm drop inside the 179mm (see the imprint
   below), so the page never spills. WeasyPrint ignores margin-top:auto in a
   flex column here, so the mark is pinned to the bottom edge instead. */
section.front .titlepage{padding-top:55mm;text-align:center;box-sizing:border-box;
  height:179mm;position:relative}
section.front .halftitle p,section.front .titlepage p{text-indent:0;text-align:center}
/* The title stacks: "in search of" in Cascadia Code Light Italic over "dharma"
   in Light, the lead-in about a third the size of the name, as on the cover. */
section.front .ht-title,section.front .tp-title{font-family:"$PRINT_TITLE_FAMILY";font-weight:300;
  line-height:1.1}
section.front .t-lead{display:block;font-style:italic}
section.front .t-name{display:block}
section.front .ht-title .t-lead{font-size:10pt}
section.front .ht-title .t-name{font-size:24pt}
section.front .tp-title{margin-bottom:6mm}
section.front .tp-title .t-lead{font-size:14pt}
section.front .tp-title .t-name{font-size:40pt}
section.front .tp-sub{font-style:italic;margin-bottom:24mm}
section.front .tp-author{font:600 12pt/1.4 "$FONT_SANS_FAMILY";margin-bottom:3mm}
section.front .tp-imprint{font:600 10pt/1.4 "$FONT_SANS_FAMILY"}
/* Tuwhiri's word mark, at the width Tuwhiri's opening pages give it. */
section.front .tp-mark{width:60mm;height:auto}
section.front .tp-imprint{position:absolute;bottom:0;left:0;right:0;margin:0}
/* The imprint stands at the foot of its page, as a copyright page does, so it
   fits however many lines Tuwhiri's copy runs to. 179mm is the text area
   (229 - 24.58 - 24.5 = 179.92mm) less a hair, so the block can never spill
   onto the next page and push the contents back. */
section.front .imprint{height:179mm;display:flex;flex-direction:column;justify-content:flex-end;
  font-size:8.5pt;line-height:12pt}
section.front .imprint p{text-indent:0;text-align:left;margin-bottom:6pt}
section.front .imprint .placeholder{font:600 8.5pt/12pt "$FONT_SANS_FAMILY"}

nav.contents a{text-decoration:none;color:#000}
nav.contents a::after{content:leader('.') target-counter(attr(href), page)}
/* The Preface's entry points into the roman sequence. */
nav.contents p.roman a::after{content:leader('.') target-counter(attr(href), page, lower-roman)}
/* The entries must not inherit the body's 10mm first-line indent: the leader
   computes its fill against the un-indented line width, so an indent pushes
   the page number past the measure and into the trim margin. */
nav.contents p{text-indent:0;text-align:left}

img{max-width:100%;height:auto;display:block;margin:0 auto}
CSS
}
#fin
