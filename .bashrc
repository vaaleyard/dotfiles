HISTSIZE=256
HISTFILE=~/.bash_history

export SHELL=/bin/bash
export PAGER=less
export EDITOR=vim
export BROWSER=chromium
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$PATH:$HOME/.bin:$HOME/.bin/ascii
export NNN_USE_EDITOR=1

set -o emacs
bind "\C-l":clear-screen
bind "\C-j":previous-history
bind "\C-k":next-history

alias c=clear
alias e="$EDITOR -Nu $HOME/.vimrc"
alias ec="$EDITOR -Nu $HOME/.c-vimrc"
alias ..="cd .."
alias which='command -v'
alias xmo='xmodmap ~/.Xmodmap'
alias kpcli='kpcli --kdb $HOME/syncthing/keepass/keepass.kdbx'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

PS1='\w\[\e[1;34m\]\$ \[\e[0m\]'

source ~/.aliases
source ~/.vim/gruvbox_256palette.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
