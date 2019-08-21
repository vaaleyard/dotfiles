# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME='robbyrussell'

HISTTIMEFORMAT=" [%Y-%m-%d %H:%M:%S] "
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

export UPDATE_ZSH_DAYS=13
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
export FZF_CTRL_T_OPTS="--preview '(highlight -O ansi -l {} 2> /dev/null || cat {} || tree -C {}) 2> /dev/null | head -200'"
export FZF_DEFAULT_COMMAND="find . -path '*/\.*' -type d -prune -o -type f -print -o -type l -print 2> /dev/null | sed s/^..// | fzf"
export FZF_CTRL_R_OPTS="--preview 'echo {}' --preview-window down:3:hidden:wrap --bind '?:toggle-preview'"
export FZF_DEFAULT_COMMAND='ag --hidden --ignore .git -g ""'

source $ZSH/oh-my-zsh.sh
source $HOME/usr/.aliases


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
