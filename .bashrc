HISTSIZE=3000
HISTFILESIZE=200

if [ "x" != "x$DISPLAY" ]; then
    xmodmap -e "clear lock"
    xmodmap -e "keycode 66 = Escape"
    xmodmap -e "keycode 9 = Caps_Lock"
    xmodmap -e "add Lock = Caps_Lock"
fi

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

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
#alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

#PS1='\[\e[1;36m\]\w\[\e[0m\] $(__git_ps1 "\[\e[01;37m\]on\[\e[0m\] \[\e[1;35m\]\\ue0a0 %s\[\e[0m\]")\n\[\e[1;32m\]➜\[\e[0m\] '

PS1='\w \[\e[1;34m\]\$ \[\e[0m\]'

source ~/shell_aliases
# git prompt(requirement to get __git_ps1). Ref: https://stackoverflow.com/a/12871094/9159065
[ -f ~/.git-prompt.sh ] && source ~/.git-prompt.sh
[ -f $HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh ] && source "$HOME/.vim/plugged/gruvbox/gruvbox_256palette.sh"
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
