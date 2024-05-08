# shell options
setopt EXTENDED_HISTORY   # save command timestamp in HISTFILE
setopt INC_APPEND_HISTORY # commands are added to history immediately
setopt HIST_IGNORE_SPACE
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE
export HISTTIMEFORMAT="[%F %T] "

bindkey -e

# misc variables
SHELL=/bin/zsh
EDITOR=nvim
GOPATH=$HOME/.go
PATH="$PATH:$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.bin:$HOME/.ghcup/bin"
PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/hls/bin/:$(brew --prefix)/bin"

export SHELL EDITOR GOPATH PATH

# yubikey
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

source $HOME/.aliases
