if status is-interactive
    # Commands to run in interactive sessions can go here
    alias ls 'eza --icons'
    atuin init fish | source

    set EDITOR "nvim"

    # yubikey
    export GPG_TTY="$(tty)"
    export SSH_AUTH_SOCK=$(gpgconf --list-dirs agent-ssh-socket)
    gpgconf --launch gpg-agent
end

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init2.fish 2>/dev/null || :
