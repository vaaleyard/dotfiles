/* UPDATE
* GitHub COPY Custom 16.09.2017
* by https://github.com/appath/
* See LICENSE file for copyright and license details. 
*/

/* include modules */
#include "patch/selfrestart.c"
#include "patch/moveresize.c"
#include "patch/gaplessgrid.c"
#include "patch/zoomswap.c"

/* appearance */
static const char *fonts[] = {
	"siji" ","
    "Monaco:size=12"
};

/* border pixel of windows */
static const unsigned int borderpx 		= 0;
/* snap pixel */
static const unsigned int snap 			= 8;
/* allows you to set the field value */
/* Size of the bar */
static const unsigned int tagpadding 		= 12;
/* the rule checks the spaces inside and around the syntax elements */
static const unsigned int tagspacing 		= 4;
/* gap pixel between windows */
static const unsigned int gappx			= 12;
/* 1: sloppy systray follows selected monitor, >0: pin systray to monitor X */
static const unsigned int systraypinning 	= 0;
/* systray spacing */
static const unsigned int systrayspacing 	= 2;
/* 1: if pinning fails, display systray on the first monitor */
/* 0: display systray on the last monitor */
static const int systraypinningfailfirst 	= 1;
/* 1 means no systray */
static const int showsystray 			= 0;
/* 0 means no bar */
static const int showbar 			= 1;
/* 1 means bottom bar */
static const int topbar 			= 1;

#define NUMCOLORS 9
static const char colors[NUMCOLORS][MAXCOLORS][9] = {
	// border	 foreground	  background 7C817C
	{ "#ffffff",	 "#D8DEE9", 	  "#2D333D" },  // 0 = normal
	{ "#181818", 	 "#D0CBB5", 	  "#81A1C1" },  // 1 = selected
	{ "#b43030", 	 "#f5f5f5", 	  "#b23450" },  // 2 = red / urgent
	{ "#181818", 	 "#dee3e0", 	  "#4C566A" },  // 3 = green / occupied
	{ "#212121", 	 "#ab7438", 	  "#0b0606" },  // 4 = yellow
	{ "#212121", 	 "#475971", 	  "#0b0606" },  // 5 = blue
	{ "#212121", 	 "#694255", 	  "#0b0606" },  // 6 = magenta
	{ "#212121", 	 "#3e6868", 	  "#0b0606" },  // 7 = cyan
	{ "#212121",	 "#cfa696", 	  "#0b0606" },  // 8 = grey
};

/* 2f343f */
/* tagging */
//static const char *tags[] = { "1  ", "2  ", "3  ", "4  ", "5  ", "6  ", "7  ", "8  ", "9  " };
static const char *tags[] = { " ", " ", " ", " ", " ", " ", "\ue241 " };

static const Rule rules[] = {
	/* xprop(1):
	 *	WM_CLASS(STRING) = instance, class
	 *	WM_NAME(STRING) = title
	 */
	/* class             instance    title       tags mask     isfloating   monitor */
	{ "Pale moon"     ,  NULL,       NULL,       1 << 1,       0,           -1 },
	{ "xterm-256color",  NULL,       NULL,       1 << 0,       0,           -1 },
	{ "Telegram"      ,  NULL,       NULL,       1 << 5,       0,           -1 },
	{ "zathura"       ,  NULL,       NULL,       1 << 3,       0,           -1 },
	{ "ranger"        ,  NULL,       NULL,       1 << 3,       0,           -1 },
	{ "neomutt"       ,  NULL,       NULL,       1 << 4,       0,           -1 },
	{ "weechat"       ,  NULL,       NULL,       1 << 6,       0,           -1 },
};
/* layout(s) */
static const float mfact = 0.52;	/* factor of master area size [0.05..0.95] */
static const int nmaster = 1;		/* number of clients in master area */
static const int resizehints = 0;	/* 1 means respect size hints in tiled resizals */

/* tagging */
static const Layout layouts[] = {
	/* symbol     arrange function */
	{ "\ue00a",   gaplessgrid },    /* organizes windows in the grid */
	{ "\ue002",   tile },    	/* first entry is default */
	{ "\ue006",   NULL },   	/* no layout function means floating behavior */
	{ "\ue000",   monocle },        /* monocle is good for maximizing the preservation and focusing of the window */
	{ "\ue003",   htile },          /* first entry is default */
};

/* key definitions
 * Mod4Mask == Super key
 * Mod1Mask == Alt key
 */
#define MODKEY Mod4Mask
#define TAGKEYS(KEY,TAG) \
	{ MODKEY,                       KEY,      view,           {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask,           KEY,      toggleview,     {.ui = 1 << TAG} }, \
	{ MODKEY|ShiftMask,             KEY,      tag,            {.ui = 1 << TAG} }, \
	{ MODKEY|ControlMask|ShiftMask, KEY,      toggletag,      {.ui = 1 << TAG} },

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd) { .v = (const char*[]){ "/bin/sh", "-c", cmd, NULL } }

static char dmenumon[2] = "0"; /* component of dmenucmd, manipulated in spawn() */
static const char *dmenucmd[]   = { "dmenu_run", "-i", "-p", "Search ", "-fn", "iosevka Nerd Font:size=11" , "-nb", "#2D333D", "-nf", "#D8DEE9", "-sb", "#81A1C1", "-sf", "#2D333D", "-w", "360", "-h", "20", "-x", "24", "-y", "42", NULL };
static const char *termcmd[]    = { "st", NULL };
static const char *mail[]       = { "st", "-c", "neomutt", "-e", "neomutt", NULL};
static const char *ranger[]     = { "st", "-c", "ranger", "-e", "ranger", NULL};
static const char *sudoranger[] = { "st", "-c", "ranger", "-e", "sudo", "ranger", NULL};
static const char *dmoji[]      = { "dmoji", NULL};
static const char *cmustatus[]  = { "cmus-status", NULL};
static const char *weechat[]    = { "tmux", "new-window", "-t", "main", "weechat", NULL};
static const char *voldown[]    = { "amixer", "-q", "sset", "Master", "2%-", NULL};
static const char *volup[]      = { "amixer", "-q", "sset", "Master", "2%+", NULL};
static const char *volsupdown[] = { "amixer", "-q", "sset", "Master", "5%-", NULL};
static const char *volsuperup[] = { "amixer", "-q", "sset", "Master", "5%+", NULL};
static const char *muteall[]    = { "amixer", "-q", "sset", "Master", "toggle", NULL};
static const char *cmus[]       = { "tmux", "new-window", "-t", "main", "cmus", NULL};
static const char *cmuspause[]  = { "cmus-remote", "--pause", NULL};
static const char *reboot[]     = { "prompt", "Are you sure you want to reboot?", "sudo reboot", NULL};
static const char *poweroff[]   = { "prompt", "Are you sure you want to shutdown?", "sudo poweroff -h now", NULL};
static const char *lock[]       = { "amixer", "-q", "sset", "Master", "mute", "&&", "locki3.sh", NULL};
static const char *scrotclip[]  = { "scrot", "-e", "xclip", "-selection", "clipboard", "-t;", "image/png", "$f", "&&", "rm", "-f", "$f", NULL};
static const char *scrotsclip[] = { "scrot", "-se", "xclip", "-selection", "clipboard", "-t;", "image/png", "$f", "&&", "rm", "-f", "$f", NULL};
static const char *scrotsave[]  = { "scrot", "-e", "mv", "$f", "~/Pictures/scrot", "&&", "sleep", "1", "&&", "notify-send", "scrot", NULL};

static Key keys[] = {
	/* modifier                     key        function        argument */
    /* Pause music in cmus // Launch dmenu */
	{ MODKEY|ShiftMask,             XK_p,      spawn,          {.v = cmuspause } },
	{ MODKEY,                       XK_p,      spawn,          {.v = dmenucmd } },

    /* Idk // Open terminal */
	{ MODKEY|ShiftMask,             XK_Return, zoom,           {0} },
	{ MODKEY,                       XK_Return, spawn,          {.v = termcmd } },

	{ MODKEY,                       XK_c,      spawn,          {.v = cmustatus } },
	{ MODKEY,                       XK_j,      focusstack,     {.i = +1 } },
	{ MODKEY,                       XK_k,      focusstack,     {.i = -1 } },
	{ MODKEY,                       XK_i,      incnmaster,     {.i = +1 } },
	{ MODKEY,                       XK_d,      incnmaster,     {.i = -1 } },
	{ MODKEY,                       XK_h,      setmfact,       {.f = -0.05} },
	{ MODKEY,                       XK_l,      setmfact,       {.f = +0.05} },
	{ MODKEY,                       XK_Tab,    view,           {0} },

    /* Quit dwm // kill window */
	{ MODKEY|ShiftMask,             XK_q,      quit,           {0} },
	{ MODKEY,                       XK_q,      killclient,     {0} },

    /* Change layouts */
	{ MODKEY,                       XK_F1,     setlayout,      {.v = &layouts[0]} },
	{ MODKEY,                       XK_F2,     setlayout,      {.v = &layouts[1]} },
	{ MODKEY,                       XK_F3,     setlayout,      {.v = &layouts[2]} },
	{ MODKEY,                       XK_F4,     setlayout,      {.v = &layouts[3]} },

    /* Start ranger w/ sudo // start ranger */
	{ MODKEY|ShiftMask,             XK_r,      spawn,          {.v = sudoranger } },
	{ MODKEY,                       XK_r,      spawn,          {.v = ranger } },

    /* Execute dmoji script // open weechat */
	{ MODKEY|ShiftMask,             XK_w,      spawn,          {.v = dmoji } },
	{ MODKEY,                       XK_w,      spawn,          {.v = weechat } },

    /* Mute sound w/ alsa // open cmus */
	{ MODKEY|ShiftMask,             XK_m,      spawn,          {.v = muteall } },
	{ MODKEY,                       XK_m,      spawn,          {.v = cmus } },

    /* Open neomutt */
	{ MODKEY,                       XK_n,      spawn,          {.v = mail } },

    /* Turn off pc // lock pc */
	{ MODKEY|ShiftMask,             XK_x,      spawn,          {.v = poweroff } },
	{ MODKEY,                       XK_x,      spawn,          {.v = lock } },

    /* screenshot */
	{ MODKEY|ShiftMask,             XK_s,      spawn,          {.v = scrotsclip } },
	{ MODKEY,                       XK_s,      spawn,          {.v = scrotclip } },

	{ MODKEY,                       XK_Print,  spawn,          {.v = scrotsave } },

    /* Reboot pc */
	{ MODKEY|ShiftMask,             XK_BackSpace,      spawn,  {.v = reboot } },

	{ MODKEY|ShiftMask,             XK_space,  togglefloating, {0} },
	{ MODKEY,                       XK_space,  setlayout,      {0} },

	{ MODKEY|ShiftMask,             XK_0,      tag,            {.ui = ~0 } },
	{ MODKEY,                       XK_0,      view,           {.ui = ~0 } },

    /* Super increase volume // increase volume */
	{ MODKEY|ShiftMask,             XK_equal,  spawn,          {.v = volsuperup } },
	{ MODKEY,                       XK_equal,  spawn,          {.v = volup } },

    /* Super decrease volume // decrease volume */
	{ MODKEY|ShiftMask,             XK_minus,  spawn,          {.v = volsupdown } },
	{ MODKEY,                       XK_minus,  spawn,          {.v = voldown } },

    /* idk yet */
	{ MODKEY,                       XK_less,  tagmon,         {.i = -1 } },
	{ MODKEY,                       XK_comma,  focusmon,       {.i = -1 } },

	{ MODKEY|ShiftMask,             XK_period, tagmon,         {.i = +1 } },
	{ MODKEY,                       XK_period, focusmon,       {.i = +1 } },

    /* Decrease window size on bottom // move window up */
    { MODKEY|ShiftMask,             XK_u,      moveresize,     {.v = "0x 0y 0w -25h"} },
    { MODKEY,                       XK_u,      moveresize,     {.v = "0x -25y 0w 0h"} },

    /* Increase window on bottom // move window down */
    { MODKEY|ShiftMask,             XK_i,      moveresize,     {.v = "0x 0y 0w 25h"} },
    { MODKEY,                       XK_i,      moveresize,     {.v = "0x 25y 0w 0h"} },

    /* Decrease window on right // move window to the right */
    { MODKEY|ShiftMask,             XK_y,      moveresize,     {.v = "0x 0y -25w 0h"} },
    { MODKEY,                       XK_y,      moveresize,     {.v = "-25x 0y 0w 0h"} },

    /* Decrease window on left // move window to the left */
    { MODKEY|ShiftMask,             XK_o,      moveresize,     {.v = "0x 0y 25w 0h"} },
    { MODKEY,                       XK_o,      moveresize,     {.v = "25x 0y 0w 0h"} },

	{ MODKEY|ShiftMask,             XK_Up,     moveresize,     {.v = "0x 0y 0w -25h"} },
	{ MODKEY|ShiftMask,             XK_Down,   moveresize,     {.v = "0x 0y 0w 25h"} },
	{ MODKEY|ShiftMask,             XK_Left,   moveresize,     {.v = "0x 0y -25w 0h"} },
	{ MODKEY|ShiftMask,             XK_Right,  moveresize,     {.v = "0x 0y 25w 0h"} },

    /* Restart dwm (it does not compile) */
	{ MODKEY,                       XK_F5,     self_restart,   {0} },

    /* Resize window up, also resizing the above window (only on tile mode) // toggle bar */
    { MODKEY|ShiftMask,             XK_b,      setcfact,       {.f = +0.25} },
	{ MODKEY,                       XK_b,      togglebar,      {0} },

    /* Resize window down, also resizing the window below (only on tile mode) */
	{ MODKEY|ShiftMask,             XK_v,      setcfact,       {.f = -0.25} },

    /* Set the default tile size on tile mode */
	{ MODKEY,                       XK_t,      setcfact,       {.f =  0.00} },

	TAGKEYS(                        XK_1,                      0)
	TAGKEYS(                        XK_2,                      1)
	TAGKEYS(                        XK_3,                      2)
	TAGKEYS(                        XK_4,                      3)
	TAGKEYS(                        XK_5,                      4)
	TAGKEYS(                        XK_6,                      5)
	TAGKEYS(                        XK_7,                      6)
	TAGKEYS(                        XK_8,                      7)
	TAGKEYS(                        XK_9,                      8)
};
/* button definitions */
/* click can be ClkLtSymbol, ClkStatusText, ClkWinTitle, ClkClientWin, or ClkRootWin */
static Button buttons[] = {
	/* click		event mask	button		function		argument */
	{ ClkLtSymbol,		0,		Button1,	setlayout,		{0} },
	{ ClkLtSymbol,		0,		Button3,	setlayout,		{.v = &layouts[2]} },
	{ ClkStatusText,	0,		Button2,	spawn,			{.v = termcmd } },
	{ ClkClientWin,		MODKEY,		Button1,	movemouse,		{0} },
	{ ClkClientWin,		MODKEY,		Button2,	togglefloating,		{0} },
	{ ClkClientWin,		MODKEY, 	Button3,	resizemouse,		{0} },
	{ ClkTagBar,		0,		Button1,	view,			{0} },
	{ ClkTagBar,		0,		Button3,	toggleview,		{0} },
	{ ClkTagBar,		MODKEY,		Button1,	tag,			{0} },
	{ ClkTagBar,		MODKEY,		Button3,	toggletag,		{0} },
};
/* the end */
