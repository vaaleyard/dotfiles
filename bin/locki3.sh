#!/usr/bin/env bash
# https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/

icon="$XDG_CONFIG_HOME/i3/lock.png"
tmpbg='/tmp/screen.png'

(( $# )) && { icon=$1; }

grim -t png "$tmpbg"
convert "$tmpbg" -scale 10% -scale 1000% "$tmpbg"
convert "$tmpbg" "$icon" -gravity center -composite -matte "$tmpbg"
swaylock -u -i "$tmpbg"
rm "$tmpbg"
