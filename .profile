PATH=$PATH:$HOME/.bin:$HOME/.bin/ascii:$GOPATH/bin

export PATH

# misc variables
SHELL=/bin/zsh
PAGER=less
EDITOR=nvim
BROWSER=firefox
BROWSERCLI=w3m
READER=zathura
IMAGEVIEWER=imv
VIDEOPLAYER=mpv
GOPATH=$HOME/.go
GPG_TTY=$(tty)

export SHELL PAGER EDITOR BROWSER BROWSERCLI READER IMAGEVIEWER VIDEOPLAYER GOPATH GPG_TTY


LANG=en_US.UTF-8

export LANG

#
# Set XGD Variables
#
# Needed for wayland
XDG_CURRENT_DESKTOP=Unity
XDG_CONFIG_HOME="$HOME/etc"
# Undocumented but widely used.
# https://github.com/ayekat/dotfiles/issues/30
XDG_BIN_HOME="$HOME/bin"
XDG_LIB_HOME="$HOME/usr/lib"
XDG_DATA_HOME="$HOME/var/share"

export XDG_CONFIG_HOME XDG_BIN_HOME XDG_LIB_HOME XDG_DATA_HOME

test -e "$XDG_CONFIG_HOME"/user-dirs.dirs &&
    . "$XDG_CONFIG_HOME"/user-dirs.dirs


# application variables
WEECHAT_HOME="$XDG_CONFIG_HOME/weechat"

export WEECHAT_HOME

