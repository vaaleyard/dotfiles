# Commands to run in interactive sessions can go here
alias ls 'eza --icons'
alias g git

set -gx EDITOR nvim

# yubikey
export GPG_TTY="$(tty)"
export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
gpgconf --launch gpg-agent

set -g fish_greeting
atuin init fish | source

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
