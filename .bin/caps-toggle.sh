#!/bin/bash
if xmodmap -pke | egrep -i "escape" | egrep -i "keycode.*9.*"; then
 echo "Changing from original to mapped"
 xmodmap -e "clear lock"
 xmodmap -e "keycode 66 = Escape"
 xmodmap -e "keycode 9 = Caps_Lock"
 xmodmap -e "add Lock = Caps_Lock"
else
 echo "Changing back from mapped to original"
 xmodmap -e "clear lock"
 xmodmap -e "keycode 9 = Escape"
 xmodmap -e "keycode 66 = Caps_Lock"
 xmodmap -e "add Lock = Caps_Lock"
fi
