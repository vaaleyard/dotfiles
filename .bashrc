# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

export SHELL=/bin/zsh
export PAGER=less
export EDITOR=vim
export BROWSER=chromium-browser
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$PATH:$HOME/.bin:$HOME/.bin/ascii
HISTFILE=~/.bash_history

bind "\C-j":previous-history
bind "\C-k":next-history

alias ec="$EDITOR -Nu $HOME/.vimrc"
alias e="$EDITOR -Nu $HOME/.c-vimrc"
alias which='command -v'
alias xmo='xmodmap ~/.Xmodmap'
alias kpcli='kpcli --kdb $HOME/syncthing/keepass/keepass.kdbx'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

#PS1='\w\[\e[1;34m\] \$ \[\e[0m\]'

source ~/.aliases
source ~/.vim/gruvbox_256palette.sh

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
