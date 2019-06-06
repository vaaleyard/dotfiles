#!/usr/bin/env sh

filename="$HOME/Pictures/Scrot/$(date +%d-%m-%Y-%T).png"

if [ "$1" = "-s" ]
then
	maim -us "$filename"
else

	maim -u "$filename"
fi

[ "$?" = "1" ] && exit 0

notify-send "Take!" "Saved screenshot as \n$(basename ${filename})"

xclip -selection clipboard -t "image/png" "$filename"
