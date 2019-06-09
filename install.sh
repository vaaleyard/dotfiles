#!/bin/sh

# requirements: git, ansible

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

if [ -z $autism ]; then
    autism=master
fi

#
# Checking dependencies
#
if ! [ -x "$(command -v git)" ]; then
    printf "${RED}[ git ] not found, make sure it's installed${CN}\n"
    exit
fi

if ! [ -x "$(command -v ansible)" ]; then
    printf "${RED}[ ansible ] not found, make sure it's installed${CN}\n"
    exit
fi

#
# Set up SSH keys
#
if ! [ -f "$HOME/.ssh/id_rsa" ]; then
    printf "${RED}Place your SSH key in ~/.ssh/id_rsa${NC}\n"
    exit
fi

dotfiles() {
   /usr/bin/git --git-dir=$HOME/.dotfiles.git/ --work-tree=$HOME $@
}

#mkdir -p .dotfiles-backup && dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}

printf "${GREEN}Cloning dotfiles...${NC}\n"
git clone --bare git@github.com:valeyard1/dotfiles.git $HOME/.dotfiles.git >/dev/null 2>&1

echo ".dotfiles.git" >> .gitignore
mkdir -p .dotfiles-backup && dotfiles checkout $autism 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
dotfiles checkout $autism
dotfiles config --local status.showUntrackedFiles no

ansible-playbook --ask-become-pass -i $HOME/src/ansible/hosts $HOME/src/ansible/main.yml --extra-vars "autism=$autism"

# source .aliases after installing everything
if [ "$autism" = "low" ]; then
    . $HOME/.aliases
elif [ "$autism" = "master" ]; then
    . $HOME/usr/.aliases
fi
printf "${YELLOW}Finished!${NC}\n"
