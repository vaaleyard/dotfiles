#!/usr/bin/env sh

# dependencies: git

# in case you are already using a bare repo
if [ ! -d $HOME/.dotfiles -o ! "sed -n '/Valeyard1/p' $HOME/.dotfiles/config" ]; then
    echo 1
fi

install_zsh() {
    if ! [ -x "$(command -v zsh)" ]; then
        echo -e "\\e[32m[ zsh ]\\e[m not found, installing"
        apt-get install -y zsh >/dev/null 2>&1
    fi

    if [ ! -d "$HOME/.oh-my-zsh" ]; then
        echo -e "\\e[32m[ oh-my-zsh ]\\e[m clonning repository"
        git clone git://github.com/robbyrussell/oh-my-zsh.git "$HOME/.oh-my-zsh" --depth 1 --quiet >/dev/null
    fi

    if [ -f "$HOME/.zshrc" ]; then
        mv $HOME/.zshrc $HOME/.zshrc.bkp
    fi

    if [ -f "$HOME/.aliases" ]; then
        mv $HOME/.aliases $HOME/.aliases.bkp
    fi

    curl -fsSLo "$HOME/.zshrc" https://raw.githubusercontent.com/Valeyard1/dotfiles/trab/.zshrc
    curl -fsSLo "$HOME/.aliases" https://raw.githubusercontent.com/Valeyard1/dotfiles/trab/.aliases

    # install zsh spaceship/dracula theme
    curl -fsLo "$HOME/.oh-my-zsh/themes/dracula.zsh-theme" https://github.com/dracula/zsh/blob/master/dracula.zsh-theme
    curl -fsLo "$HOME/.oh-my-zsh/themes/spaceship-prompt/spaceship.zsh-theme" https://raw.githubusercontent.com/denysdovhan/spaceship-prompt/master/spaceship.zsh
}

install_tmux() {
    if ! [ -x "$(command -v tmux)" ]; then
        echo -e "\\e[32m[ tmux ]\\e[m not found, installing"
        apt-get install tmux -y >/dev/null 2>&1
    fi

    # Install Tmux Plugin Manager (tpm)
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    curl -fsSLo "$HOME/.tmux.conf" https://raw.githubusercontent.com/Valeyard1/dotfiles/trab/.tmux.conf
}

install_requirements() {
    if ! [ -x "$(command -v git)" ]; then
        echo -e "\\e[32m[ git ]\\e[m not found, installing"
        apt-get install git curl -y >/dev/null 2>&1
    fi

    if ! [ -x "$(command -v curl)" ]; then
        echo -e "\\e[32m[ curl ]\\e[m not found, installing"
        apt-get install curl -y >/dev/null 2>&1
    fi

    if ! [ -x "$(command -v pip3)" ]; then
        echo -e "\\e[32m[ pip3 ]\\e[m not found, installing"
        apt-get install python3-pip -y >/dev/null 2>&1
    fi
}

install_neovim() {
    if ! [ -x "$(command -v nvim)" ]; then
        echo -e "\\e[32m[ pip3 ]\\e[m not found, installing"
        pip3 install neovim && pip3 install neovim --upgrade
    fi
}

install_fzf() {
    if [ -x "$(command -v fzf)" ]; then
        echo -e "\\e[32m[ fzf ]\\e[m not found, installing"
        git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
        ~/.fzf/install --all
    fi
}

init() {
    clear
    printf "%s\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    printf "%s\n" ":::::   about:: install autism command line stuff    :::::"
    printf "%s\n" ":::::    code:: https://git.io/fNvUH                 :::::"
    printf "%s\n" ":::::                ¯\_(ツ)_/¯                      :::::"
    printf "%s\n" "::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo
}

help() {
    printf "%s\n\n" "usage: $0 [options]"
    printf "%s\n" "  -f, --fzf     Install fzf"
    printf "%s\n" "  -t, --tmux    Install tmux"
    printf "%s\n" "  -z, --zsh     Install zsh shell"
    printf "%s\n\n" "  -h, --help    Show this message"

}

while [ "$#" -gt 0 ]; do
    case "$1" in
        "-f" | "--fzf")
            fzf=true
            ;;
        "-v" | "--vim")
            vim=true
            ;;
        "-t" | "--tmux")
            tmux=true
            ;;
        "-z" | "--zsh")
            zsh=true
            ;;
        "-h" | "--help")
            help
            ;;
        *)
            printf "%s\n" "$0: invalid option -- '$1'"
            printf "%s\n" "Try '$0 --help' for more information."
            ;;
    esac
    shift
done

programs="fzf vim tmux zsh"
set -- "$programs"

for program in "${programs}"; do
    echo "install_${program}"
done

#init
#install_requirements


