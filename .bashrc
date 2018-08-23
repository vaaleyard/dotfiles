HISTSIZE=3000
HISTFILESIZE=200

export SHELL=/bin/bash
export PAGER=less
export EDITOR=vim
export BROWSER=chromium
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$PATH:$HOME/bin:$HOME/bin/ascii
export NNN_USE_EDITOR=1

set -o emacs
#bind 'set show-mode-in-prompt on'
#bind 'set vi-ins-mode-string \e[1;31m INSERT \e[0m'
#bind 'set vi-cmd-mode-string \e[1;32m NORMAL \e[0m'
bind "\C-l":clear-screen
bind "\C-j":previous-history
bind "\C-k":next-history

alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

PS1='\w \[\e[1;34m\]\$ \[\e[0m\]'

source ~/.aliases
# git prompt(requirement to get __git_ps1). Ref: https://stackoverflow.com/a/12871094/9159065
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh ] && source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"

