#!/bin/sh

# requirements: curl, git, ansible, python

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
LEVEL='\033[0;36m'
NC='\033[0m' # No Color

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
        printf "${RED}%s${CN}\\n" "[ git ] not found, make sure it's installed"
        exit
    fi

    if ! [ -x "$(command -v ansible)" ]; then
        printf "${RED}%s${CN}\\n" "[ ansible ] not found, make sure it's installed"
        exit
    fi

    if ! [ -x "$(command -v python)" ]; then
        printf "${RED}%s${CN}\\n" "[ python ] not found, make sure it's installed"
        exit
    fi
}

dotfiles() {
    /usr/bin/git --git-dir="$HOME/.dotfiles.git/" --work-tree="$HOME" "$@"
}
clone_dotfiles() {
    printf "${GREEN}%s${NC}\\n" "Cloning dotfiles..."
    git clone --bare git@github.com:valeyard1/dotfiles.git "$HOME/.dotfiles.git" >/dev/null 2>&1
    if [ "$?" -ne 0 ]; then
        printf "${RED}%s${NC}\\n" "Erro ao clonar o repositório"
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
                printf "${LEVEL}$autism${NC}: ${RED}%s${NC}\\n" "Provide a valid autism level"
                exit
            fi
            if [ "$autism" = "master" ]; then
                printf "${LEVEL}$autism${NC}: ${GREEN}%s${NC}\\n" "Great Level :D"
            fi
            if [ "$autism" = "low" ]; then
                printf "${LEVEL}$autism${NC}: ${YELLOW}%s${NC}\\n" "It's not the ideal level but it happens :("
            fi
            shift
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

if [ -z "$autism" ]; then
    autism=master
fi

#
# Set up SSH keys
#
if ! [ -f "$HOME/.ssh/id_rsa" ]; then
    printf "${RED}%s${NC}\\n" "Place your SSH key in ~/.ssh/id_rsa"
    exit
fi

check_dependences

clone_dotfiles $autism

ansible-playbook --ask-become-pass -i "$HOME/src/ansible/hosts" "$HOME/src/ansible/main.yml" --extra-vars "autism=$autism"

# source .aliases after installing everything
if [ "$autism" = "low" ]; then
    . "$HOME/.aliases"
elif [ "$autism" = "master" ]; then
    . "$HOME/usr/.aliases"
    xdg-dirs-update
    printf "${GREEN}%s${NC}\\n" "Log in again to work everything..."
fi

printf "${YELLOW}%s${NC}\\n" "Finished!"
