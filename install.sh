#!/bin/sh

GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
LEVEL='\033[0;36m'
NC='\033[0m' # No Color

init() {
    printf "%s\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    printf "%s\n" ":::::   about:: install autism command line stuff    :::::"
    printf "%s\n" ":::::    code:: https://git.io/autism.sh             :::::"
    printf "%s\n" ":::::                ¯\_(ツ)_/¯                      :::::"
    printf "%s\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
}

help() {
    printf "%s\n\n" "usage: $0 [options]"
    printf "%s\n" "  --autism                     Which branch to clone"
    printf "%s\n\n" "  -h, --help, help             Show this message"
}

init
while [ $# -gt 0 ]; do
    case $1 in
        -x | --create-xdg-dirs)
            xdg_dir=true
            ;;
        --autism)
            autism=$2
            if [ "$autism" != "master" -a "$autism" != "low" ]; then
                printf "${LEVEL}$autism${NC}: ${RED}Provide a valid autism level${NC}\n"
                exit
            fi
            if [ "$autism" = "master" ]; then
                printf "${LEVEL}$autism${NC}: ${GREEN}Great Level :D${NC}\n"
            fi
            if [ "$autism" = "low" ]; then
                printf "${LEVEL}$autism${NC}: ${YELLOW}It's not the ideal level but it happens :(${NC}\n"
            fi
            shift
            ;;
        -h | --help | help)
            help
            exit
            ;;
        *)
            printf "%s\n" "$0: invalid option -- '$1'"
            printf "%s\n" "Try '$0 --help' for more information."
            ;;
    esac
    shift
done

#
# Set up SSH keys
#
if ! [ -f "$HOME/.ssh/id_rsa" ]; then
    printf "${RED}Place your SSH key in ~/.ssh/id_rsa${NC}\n"
    return
fi
#pkill ssh-agent && eval "$(ssh-agent -s)" >/dev/null 2>&1
ssh-add -q $HOME/.ssh/id_rsa

dotfiles() {
   /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $@
}

git clone --bare git@github.com:valeyard1/dotfiles.git $HOME/.dotfiles.git
echo ".dotfiles.git" >> .gitignore
mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
dotfiles checkout
dotfiles config --local status.showUntrackedFiles no

ansible-playbook --ask-become-pass -i usr/ansible/hosts usr/ansible/main.yml --extra-vars "branch=$autism"

