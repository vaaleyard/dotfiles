dwm - dynamic window manager
============================
dwm is an extremely fast, small, and dynamic window manager for X.


Requirements
------------
In order to build dwm you need the Xlib header files.


Installation
------------
Edit config.mk to match your local setup (dwm is installed into
the /usr/local namespace by default).

Afterwards enter the following command to build and install dwm (if
necessary as root):

    make clean install

If you are going to use the default bluegray color scheme it is highly
recommended to also install the bluegray files shipped in the dextra package.


Running dwm
-----------
Add the following line to your .xinitrc to start dwm using startx:

    exec dwm

In order to connect dwm to a specific display, make sure that
the DISPLAY environment variable is set correctly, e.g.:

    DISPLAY=foo.bar:1 exec dwm

(This will start dwm on display :1 of the host foo.bar.)

In order to display status info in the bar, you can do something
like this in your .xinitrc:

    while xsetroot -name "`date` `uptime | sed 's/.*,//'`"
    do
    	sleep 1
    done &
    exec dwm


Configuration
-------------
The configuration of dwm is done by creating a custom config.h
and (re)compiling the source code.

PATCHES:
 - [uselessgaps](https://dwm.suckless.org/patches/uselessgap/)
 - [moveresize](https://dwm.suckless.org/patches/moveresize/)
 - [statuscolors](https://dwm.suckless.org/patches/statuscolors/)

CHANGES:
 - I've created the `barsize` variable, which represent the size of the dwm statusbar
 - Set gaps if only one window is open, you can do this through the [uselessgaps](https://dwm.suckless.org/patches/uselessgap/) patch, and do this:

    Change this line of the patch:
```
if (selmon->lt[selmon->sellt]->arrange == monocle || n == 1) {
```

to this:

```
if (selmon->lt[selmon->sellt]->arrange == monocle) {
```
 - In the original patch of the [uselessgaps](https://dwm.suckless.org/patches/uselessgap/) the gaps between windows is bigger than the gaps between the borders, which is weird:
![image](https://i.imgur.com/t58XDCx.png)
    The modified version, fix this, and make all gaps be equal, you can patch the original, and change the resizeclient function to [this](https://github.com/Valeyard1/dotfiles/blob/master/suckless/dwm-6.1/dwm.c#L1293-L1327) function
