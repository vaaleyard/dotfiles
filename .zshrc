# Default programs ======================{{{

# DESC: check and choose the first program in the array that is installed as the default

# find alternative apps if it is installed on your system
find_alt() { for i;do which "$i" >/dev/null && { echo "$i"; return 0;};done;return 1; }

# set the default program
# the first program in the array that is detected on your system will be chosen as the default
#export BROWSER=$(find_alt chromium Chromium chromium-browser vivaldi-snapshot firefox qutebrowser google-chrome $OPENER )
#export BROWSERCLI=$(find_alt w3m links2 links lynx elinks $OPENER )
#export EDITOR=$(find_alt vim vi nano emacs leafpad gedit pluma $OPENER )
#export FILEMANAGER=$(find_alt pcmanfm thunar nautilus dolphin spacefm enlightenment_filemanager $OPENER )
#export FILEMANAGERCLI=$(find_alt ranger vifm mc $OPENER )
#export READER=$(find_alt zathura emupdf vince $OPENER )
#export IMAGEVIEWER=$(find_alt feh ristretto display eog $OPENER )
export BROWSER=qutebrowser
export BROWSERCLI=w3m
export EDITOR=vim
export READER=zathura
export IMAGEVIEWER=feh
export VIDEOPLAYER=mpv
export PATH=$HOME/bin/:/usr/local/sbin:/usr/local/bin:/usr/bin:/usr/sbin:/sbin:/bin:/home/valeyard/.fzf/bin

# }}}
# General settings ======================{{{
# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

#export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "

# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion. Case
# sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=13

# DISABLE_LS_COLORS="true"

# DISABLE_AUTO_TITLE="true"

# ENABLE_CORRECTION="true"

# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

plugins=(
git
)

source $ZSH/oh-my-zsh.sh

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# }}}
HISTTIMEFORMAT=" [%Y-%m-%d %H:%M:%S] "
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

SPACESHIP_PROMP_ORDER=(
	time
	user
	dir
	host
	git
	package
	exec_time
	vi_mode
	line_sep
	battery
	jobs
	exit_code
	char
)
SPACESHIP_TIME_SHOW=true
SPACESHIP_VI_MODE_SHOW=true
SPACESHIP_VI_MODE_INSERT='-- INSERT --'
SPACESHIP_VI_MODE_NORMAL='-- NORMAL --'
source ~/shell_aliases
#source "$HOME/.oh-my-zsh/custom/themes/spaceship-prompt/spaceship.zsh-theme"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..//"
