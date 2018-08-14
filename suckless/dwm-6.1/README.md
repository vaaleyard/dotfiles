# MY SETUP

PATCHES:
 - [tilegap](https://dwm.suckless.org/patches/tilegap/) to set gaps between windows
 - [moveresize](https://dwm.suckless.org/patches/moveresize/) to resize/move windows
 - [statuscolors](https://dwm.suckless.org/patches/statuscolors/) to set different colors for each action (i.e. normal, selected, urgent, occupied)
- CHANGES:
    - I've created the `barsize` variable, which represents the size of the dwm statusbar
    - There's a `tagspacing` variable which represents the size of the tag label
    - To remove the windows indicator in the statusbar, change this _for loop_ in the **dwm.c** file:
    ```
    for (i = 0; i < LENGTH(tags); i++) {
        w = TEXTW(tags[i]);
        drw_setscheme(drw, &scheme[(m->tagset[m->seltags] & 1 << i) ? 1 : (urg & 1 << i ? 2 : 0)]);
        drw_text(drw, x, 0, w, bh, tags[i], 0);
        drw_rect(drw, x + 1, 1, dx, dx, m == selmon && selmon->sel && selmon->sel->tags & 1 << i,
                occ & 1 << i, 0);
        x += w;
    }
    ```
    to this:  
    ```
    for (i = 0; i < LENGTH(tags); i++) {
        w = TEXTW(tags[i]) + tagspacing;
        drw_setscheme(drw, &scheme[(m->tagset[m->seltags] & 1 << i) ? 1 : (urg & 1 << i ? 2 : (occ & 1 << i ? 3:0))]);
        drw_text(drw, x, 0, w, bh, tags[i], 0);
        x += w;
    }
    ```
    **Obs.:** You will need the [statuscolors](https://dwm.suckless.org/patches/statuscolors/) patch to set the colors to each situation (selected, normal, occupied, etc).
    
    



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
