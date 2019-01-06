# Default programs ======================{{{

export SHELL=/bin/zsh
export PAGER=less
export EDITOR=nvim
export BROWSER=chromium-browser
export BROWSERCLI=w3m
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$PATH:$HOME/.bin:$HOME/.bin/ascii

# Avoid duplicates
#export HISTCONTROL=ignoredups:erasedups
# When the shell exits, append to the history file instead of overwriting it
#shopt -s histappend

# After each command, append to the history file and reread it
#export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# }}}
# General settings ======================{{{
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

#export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "

SPACESHIP_TIME_SHOW=true

SPACESHIP_PROMP_ORDER=(
	time
	dir
	git
	line_sep
	battery
	jobs
	char
)

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13
plugins=(
git
docker
)

source $ZSH/oh-my-zsh.sh

# }}}

alias e="$EDITOR"
alias which='command -v'
alias xmo='xmodmap ~/.Xmodmap'
alias kpcli='kpcli --kdb $HOME/syncthing/keepass/keepass.kdbx'
alias dotfiles="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

function osu() {
    cd ~/Downloads/osu!/
    env WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks dotnet40
    WINEPREFIX="$HOME/.wine32" wine 'osu!.exe'
}

HISTTIMEFORMAT=" [%Y-%m-%d %H:%M:%S] "

export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
#export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..// | fzf"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
#export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

source ~/.aliases
source ~/.vim/gruvbox_256palette.sh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
