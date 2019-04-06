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
ZSH_THEME='dracula'

export PS1="%F{green}${SSH_TTY:+%n@%m}%f%B${SSH_TTY:+:}%b%F{blue}%1~%(?..%F{yellow}%B!%b%f)%F{red}%B%(!.#.$)%b%f "

SPACESHIP_TIME_SHOW=true
SPACESHIP_KUBECONTEXT_SHOW=false

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
#plugins=(
#    git
#)

source $ZSH/oh-my-zsh.sh

# }}}

#alias e="$EDITOR"
alias e="nvim"
alias {vi,vim}='/usr/bin/vi -u NONE'
alias xmo='xmodmap ~/.Xmodmap'
alias g=git
alias t='tmux new -s dot'

#function osu() {
#    cd ~/Downloads/osu!/
#    env WINEARCH=win32 WINEPREFIX=~/.wine32 winetricks dotnet40
#    WINEPREFIX="$HOME/.wine32" wine 'osu!.exe'
#}

HISTTIMEFORMAT=" [%Y-%m-%d %H:%M:%S] "

export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..// | fzf"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# Sysadmin {{{

# Docker
alias dcls='docker container ls'
alias dils='docker image ls'
alias dsprune='docker system prune'

dirm () {
    docker rmi -f "$@"
}

dirmall() {
    docker rmi -f $(docker image ls -aq)
}

dcstop () {
    docker container stop "$@"
}

dcrm () {
    docker container rm -f "$@"
}

dcrmall() {
    docker container rm $(docker container ls -aq) -f
}

# Get the IP address of a docker container
dcip() {
    docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' "$@"
}

dcbash() {
    docker exec -it "$@" bash
    if [ "$?" -ne 0 ]; then
        docker exec -it "$@" sh
    fi
}

dclogs() {
    docker logs -f $(docker ps | grep "$1" | awk '{ print $1 }')
}

dktop() {
  docker stats --format "table {{.Container}}\t{{.Name}}\t{{.CPUPerc}}  {{.MemPerc}}\t{{.NetIO}}\t{{.BlockIO}}"
}

# Redes
digdns() {
    dig +short "$@"
}

alias meuip="ip -f inet -o addr show wlp3s0 | grep -oP '(?<=inet )[0-9.]+'"

# My GCP machines
ssh-gcp() {
    ssh -i $HOME/.ssh/google_compute_engine "$@"
}

gcpstop() {
    gcloud compute instances stop "$@"
}

gcpstart() {
    gcloud compute instances start "$@"
}


# }}}

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
