
# shell options
setopt EXTENDED_HISTORY
setopt appendhistory
setopt inc_append_history
export HISTSIZE=1000000000
export SAVEHIST=$HISTSIZE

bindkey -e

# misc variables
SHELL=/bin/zsh
EDITOR=lvim
GOPATH=$HOME/.go
GPG_TTY=$(tty)
PATH="$PATH:$HOME/bin:$GOPATH/bin:$HOME/.cargo/bin:$HOME/.local/bin:$HOME/.bin:$HOME/.ghcup/bin"
PATH="$PATH:$HOME/.local/share/nvim/lsp_servers/hls/bin/:$(brew --prefix)/bin"

export SHELL EDITOR GOPATH GPG_TTY PATH

# yubikey
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

source $HOME/.aliases

