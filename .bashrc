# Avoid duplicates
export HISTCONTROL=ignoredups:erasedups  
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

HISTSIZE=10000
HISTFILESIZE=10000

#PS1='\w \[\e[1;34m\]\$ \[\e[0m\]'
PS1='\[\e[1;36m\]\w\[\e[0m\] $(__git_ps1 "\[\e[01;37m\]on\[\e[0m\] \[\e[1;35m\]\\ue0a0 %s\[\e[0m\]")\n\[\e[1;32m\]➜\[\e[0m\] '

# After each command, append to the history file and reread it
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

export SHELL=/bin/zsh
export PAGER=less
export EDITOR=nvim
export BROWSER=brave
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$PATH:$HOME/.bin:$HOME/.bin/ascii
HISTFILE=~/.shell_history

source ~/.aliases
source ~/.git-prompt.sh
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
