#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $userresources
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

#xset +fp $HOME/.fonts/
exec redshift &
$HOME/bin/dwmstatus &
#setroot -f $HOME/Pictures/Wallpapers/31.jpg
while true; do
    # Log stderror to a file
    dwm 2> /tmp/dwm.log
    # No error logging
    #dwm >/dev/null 2>&1
done

