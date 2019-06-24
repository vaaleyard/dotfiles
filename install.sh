#!/bin/sh

# requirements: curl, git, ansible, python

info() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[00;34m..\033[0m ] $1\n"
}

user() {
    # shellcheck disable=SC2059
    printf "\r  [ \033[0;33m??\033[0m ] $1\n"
}

success() {
    # shellcheck disable=SC2059
    printf "\r\033[2K  [ \033[00;32mOK\033[0m ] $1\n"
}

fail() {
    # shellcheck disable=SC2059
    printf "\r\033[2K  [\033[0;31mFAIL\033[0m] $1\n"
    exit
}

init() {
    printf "%s\\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    printf "%s\\n" ":::::   about:: install autism command line stuff    :::::"
    printf "%s\\n" ":::::    code:: https://bit.do/autism-sh             :::::"
    printf "%s\\n" ":::::                ¯\_(ツ)_/¯                      :::::"
    printf "%s\\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}

help() {
    printf "%s\\n\\n" "usage: $0 [options]"
    printf "%s\\n" "  -a, --autism                 Which branch to clone"
    printf "%s\\n\\n" "  -h, --help, help             Show this message"
}

check_dependences() {
    if ! [ -x "$(command -v git)" ]; then
        fail "[ git ] not found, make sure it's installed"
    fi

    if ! [ -x "$(command -v ansible)" ]; then
        fail "[ ansible ] not found, make sure it's installed"
    fi

    if ! [ -x "$(command -v python)" ]; then
        fail "[ python ] not found, make sure it's installed"
    fi
}

dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME" "$@"
}
clone_dotfiles() {
    if [ -d "$HOME/.dotfiles.git" ]; then
        fail "There is already a dotfiles installed! Backup it first."
    fi
    info "Cloning dotfiles..."
    git clone --bare git@github.com:valeyard1/dotfiles.git "$HOME/.dotfiles.git" >/dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        fail "Erro ao clonar o repositório"
    fi

    echo ".dotfiles.git" >> .gitignore
    mkdir -p .dotfiles-backup && dotfiles checkout "$1" 2>&1 | grep -E "\\s+\\." | awk '{print $1}' | xargs -I{} mv {} .dotfiles-backup/{};
    dotfiles checkout "$1"
    dotfiles config --local status.showUntrackedFiles no
}

init
while [ $# -gt 0 ]; do
    case $1 in
        -a | --autism)
            autism=$2
            if [ "$autism" != "master" ] && [ "$autism" != "low" ]; then
                fail "Provide a valid autism level"
            fi
            if [ "$autism" = "master" ]; then
                success "Great Level :D"
            fi
            if [ "$autism" = "low" ]; then
                success "It's not the ideal level but it happens :("
            fi
            shift
            ;;
        -d | --dbeaver)
            dbeaver=true
            ;;
        -z | --zsh)
            zsh=true
            ;;
        -h | --help | help)
            help
            exit
            ;;
        *)
            printf "%s\\n" "$0: invalid option -- '$1'"
            printf "%s\\n" "Try '$0 --help' for more information."
            ;;
    esac
    shift
done

# Set defaults if not set
if [ -z "$autism" ]; then
    autism=master
elif [ -z "$dbeaver" ]; then
    dbeaver=false
elif [ -z "$zsh" ]; then
    zsh=false
fi

#
# Set up SSH keys
#
if ! [ -f "$HOME/.ssh/id_rsa" ]; then
    fail "Place your SSH key in ~/.ssh/id_rsa"
fi

check_dependences

clone_dotfiles $autism

ansible-playbook --ask-become-pass -i "$HOME/src/ansible/hosts" "$HOME/src/ansible/main.yml" --extra-vars "autism=$autism,dbeaver=$dbeaver,zsh=$zsh"

# source .aliases after installing everything
if [ "$autism" = "low" ]; then
    . "$HOME/.aliases"
elif [ "$autism" = "master" ]; then
    . "$HOME/usr/.aliases"
    xdg-dirs-update
fi

success "Finished! Log in again to make sure everything is working..."
