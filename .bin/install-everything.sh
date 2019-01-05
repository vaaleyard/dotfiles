#!/usr/bin/env sh

if [ "$(id -u)" -ne 0 ]; then
    echo "$0 must be run as root."
    exit
fi

echo "Upgrading system..."
apt update -y &>/dev/null && apt upgrade &>/dev/null


echo "Installing personal autistic stuff..."
apt install neomutt mpv pandoc tmux python-pip3 cargo exiv2 zsh &>/dev/null
pip3 install neovim && pip3 install neovim --upgrade &>/dev/null
# zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &>/dev/null
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" &>/dev/null
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme" &>/dev/null


echo "Installing work stuff..."
apt install git python3 traceroute htop &>/dev/null
apt-add-repository ppa:ansible/ansible &>/dev/null


# docker and docker-compose
curl -fsSL https://get.docker.com | sh &>/dev/null
groupadd docker && usermod -aG docker ubuntu &>/dev/null
DOCKER_COMPOSE_LATEST_VERSION=$(curl --silent "https://api.github.com/repos/docker/compose/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/' )
sudo curl -L https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_LATEST_VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose &>/dev/null


# dbeaver
curl -o /tmp/dbeaver-ce_latest_amd64.deb -sSL https://dbeaver.io/files/dbeaver-ce_latest_amd64.deb &>/dev/null
dpkg -i /tmp/dbeaver-ce_latest_amd64.dev &>/dev/null


# slack
curl -o /tmp/slack-desktop-3.3.3-amd64.deb -sSL https://downloads.slack-edge.com/linux_releases/slack-desktop-3.3.3-amd64.deb &>/dev/null
dpkg -i /tmp/slack-desktop-3.3.3-amd64.deb &>/dev/null


# keybase
curl -O https://prerelease.keybase.io/keybase_amd64.deb &>/dev/null
sudo dpkg -i keybase_amd64.deb &>/dev/null
sudo apt-get install -f &>/dev/null


apt update -y &>/dev/null && apt upgrade &>/dev/null

