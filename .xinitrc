#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap

if [ -f $sysresources ]; then
    xrdb -merge $userresources
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

xset +fp $HOME/.fonts/
exec redshift &
exec dunst &
exec dwmstatus &
exec dwm
