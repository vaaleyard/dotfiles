#!/bin/bash
#
# Description: Generate hex colors from a picture
# Usage:       sh ./color-gen image.jpg 16
#

N=${2:-8}
COL=$(convert "$1" -define histogram:unique-colors=true -colors $N \
    -format %c histogram:info:- | sed 's/.*#/#/;' | cut -c -7 | sort -nr)

OUT=""
while IFS=" " read -ra ARR; do
    for X in "${ARR[@]}"; do
        OUT="$OUT<span style=\"background: $X;\" onclick=\"setbg(this);\">$X</span>"
    done
done <<< "$COL"

TMP="/tmp/color-generate.html"
echo -e "<!DOCTYPE html>\n" \
        "<html>\n" \
        "<head>\n" \
        "<title>Colors[$N] from \"$1\"</title>\n" \
        "<style type=\"text/css\">\n" \
        "html { height: 100%; }\n" \
        "body {\n" \
        "    margin: 0; padding: 0; min-height: 100%;\n" \
        "    background: #17181A; color: #000;\n" \
        "    transition: background .2s ease;\n" \
        "}\n" \
        "span {\n" \
        "    display: inline-block; width: 128px; height: 64px;\n" \
        "    text-align: center; line-height: 64px;\n" \
        "}\n" \
        "div,img { max-width: calc(128px * 8); }\n" \
        "</style>\n" \
        "<script type=\"text/javascript\">\n" \
        "function setbg(x) { document.body.style.background=x?x.style.background:x; }\n" \
        "</script>\n" \
        "</head>\n" \
        "<body>\n" \
        "<br /><br />\n" \
        "<center>\n" \
        "<div>\n" \
        "$OUT" \
        "</div>\n" \
        "<br /><br />\n" \
        "<img src=\"file://$(pwd)/$1\" onclick=\"setbg('');\" />\n" \
        "</center>\n" \
        "<br /><br />\n" \
        "</body>\n" \
        "</html>\n" > $TMP

$BROWSER "$TMP"

exit 0
