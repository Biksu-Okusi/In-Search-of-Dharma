#!/bin/bash
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
#   { font_faces_css pdf; print_page_css; } > print.css
#
# The constants below were solved numerically against the model book and are
# frozen. They are specific to 10pt on 16pt leading in Bona Nova; any other
# setting needs them re-solved, which is what mk-print.sh --solve does.

[[ ${BASH_SOURCE[0]} != "$0" ]] \
  || { >&2 echo "✗ ${BASH_SOURCE[0]##*/} is a library: source it, do not run it"; exit 2; }

# Trim and margins, in mm. Measured from the model book and confirmed against
# Ramsey's marked-up recto and verso scans. The gutter is the larger of the two
# because a perfect-bound spine swallows part of it.
declare -r PRINT_TRIM_W_MM=152 PRINT_TRIM_H_MM=229
declare -r PRINT_MEASURE_MM=107 PRINT_INNER_MM=25 PRINT_OUTER_MM=20

# Populated by print_geom_load. Declared here so a `set -u` script may reference
# them before the call.
declare -- PRINT_SIZE_PT='' PRINT_LEAD_PT='' PRINT_SUB_PT='' PRINT_SRC_PT=''
declare -- PRINT_TOP_MM='' PRINT_BOT_MM='' PRINT_HEADPAD_MM='' PRINT_FOLIOPAD_MM=''
declare -- PRINT_H1PAD_MM='' PRINT_H1GAP_MM='' PRINT_DROP_FS='' PRINT_DROP_LH=''

# The shipping setting, and the constants solved for it.
print_geom_load() {
  PRINT_SIZE_PT=${1:-10} PRINT_LEAD_PT=${2:-16}
  if [[ $PRINT_SIZE_PT != 10 || $PRINT_LEAD_PT != 16 ]]; then
    >&2 printf '▲ %s: %spt on %spt is a proof setting; the frozen constants were solved '\
'for 10 on 16. Run mk-print.sh --solve.\n' \
      "${BASH_SOURCE[0]##*/}" "$PRINT_SIZE_PT" "$PRINT_LEAD_PT"
  fi
  PRINT_SUB_PT=12 PRINT_SRC_PT=9
  PRINT_TOP_MM=24.58 PRINT_BOT_MM=24.5
  PRINT_HEADPAD_MM=13.35 PRINT_FOLIOPAD_MM=6.80
  PRINT_H1PAD_MM=55.34 PRINT_H1GAP_MM=39.21
  PRINT_DROP_FS=3.200 PRINT_DROP_LH=0.688
}

# The complete print stylesheet. Written after font_faces_css pdf, which binds
# every face by absolute file:// URL.
print_page_css() {
  cat <<CSS
@page{size:${PRINT_TRIM_W_MM}mm ${PRINT_TRIM_H_MM}mm;
  margin:${PRINT_TOP_MM}mm ${PRINT_OUTER_MM}mm ${PRINT_BOT_MM}mm ${PRINT_INNER_MM}mm;
  @top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page:left{margin-left:${PRINT_OUTER_MM}mm;margin-right:${PRINT_INNER_MM}mm;
  @top-left{content:string(booktitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-left{content:counter(page);font:600 8pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_FOLIOPAD_MM}mm}}
@page:right{margin-left:${PRINT_INNER_MM}mm;margin-right:${PRINT_OUTER_MM}mm;
  @top-right{content:string(chaptitle);font:600 9pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_HEADPAD_MM}mm}
  @bottom-right{content:counter(page);font:600 8pt/1 "$FONT_SANS_FAMILY";
    vertical-align:top;padding-top:${PRINT_FOLIOPAD_MM}mm}}
@page:blank{@top-left{content:none}@top-right{content:none}
  @bottom-left{content:none}@bottom-right{content:none}}
@page chapopen{@top-left{content:none}@top-right{content:none}}
@page front{
  @bottom-left{content:counter(page,lower-roman)}
  @bottom-right{content:counter(page,lower-roman)}
  @top-left{content:none}@top-right{content:none}}

html{font-family:"$FONT_SERIF_FAMILY",serif;font-size:${PRINT_SIZE_PT}pt;
  line-height:${PRINT_LEAD_PT}pt;color:#000;hyphens:auto;
  font-variant-numeric:lining-nums;
  font-feature-settings:"lnum" 1,"liga" 1,"kern" 1}
body{margin:0;string-set:booktitle "In search of dharma"}

h1{page:chapopen;break-before:recto;margin:0 0 0 10mm;
  font:600 20pt/1 "$FONT_SANS_FAMILY";
  padding-top:${PRINT_H1PAD_MM}mm;padding-bottom:${PRINT_H1GAP_MM}mm;
  string-set:chaptitle content()}
h2{font:600 ${PRINT_SUB_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}
h3{font:600 ${PRINT_SIZE_PT}pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY";
  margin:${PRINT_LEAD_PT}pt 0 0 0;break-after:avoid}

p{margin:0;text-align:justify;text-indent:10mm;widows:2;orphans:2}
p.op,h1+p,h2+p,h3+p,blockquote+p{text-indent:0}
blockquote{margin:${PRINT_LEAD_PT}pt 0 ${PRINT_LEAD_PT}pt 8mm;font-style:italic}
blockquote p{text-indent:0}
p.attrib{text-indent:20mm;font:600 9pt/${PRINT_LEAD_PT}pt "$FONT_SANS_FAMILY"}
.sources p{font-size:${PRINT_SRC_PT}pt}
ul,ol{margin:${PRINT_LEAD_PT}pt 0;padding-left:8mm}

h1+p::first-letter{float:left;font-size:${PRINT_DROP_FS}em;
  line-height:${PRINT_DROP_LH};padding:0 0.06em 0 0}
.sc{font-variant-caps:small-caps;letter-spacing:0.02em}

section.front{page:front}
section.front h1{break-before:auto;page:front;padding-top:0;padding-bottom:${PRINT_LEAD_PT}pt}
section.chapter:first-of-type{counter-reset:page 1}

nav.contents a{text-decoration:none;color:#000}
nav.contents a::after{content:leader('.') target-counter(attr(href), page)}

img{max-width:100%;height:auto;display:block;margin:0 auto}
CSS
}
#fin
