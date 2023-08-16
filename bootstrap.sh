#!/bin/bash
# Install curl, tar, git, other dependencies if missing
PACKAGES_NEEDED="\
    curl \
    git \
    kmod \
    gnupg2 \
    jq \
    sudo \
    zsh \
    build-essential \
    openssl \
    libssl-dev \
    fuse \
    dialog \
    apt-utils \
    libfuse2"

if ! dpkg -s ${PACKAGES_NEEDED} > /dev/null 2>&1; then
    if [ ! -d "/var/lib/apt/lists" ] || [ "$(ls /var/lib/apt/lists/ | wc -l)" = "0" ]; then
        sudo apt-get update
    fi
    sudo echo 'debconf debconf/frontend select Noninteractive' | sudo debconf-set-selections
    sudo apt-get -y -q install ${PACKAGES_NEEDED}
fi

# install latest neovim
sudo modprobe fuse
sudo groupadd fuse
sudo usermod -a -G fuse "$(whoami)"

curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
sudo chmod u+x nvim.appimage
sudo mv nvim.appimage /usr/local/bin/nvim

# Configure zsh as default shell
sudo chsh -s $(which zsh) vscode

# Make Pyenv stop complaining
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

## Install rustup and common components
curl https://sh.rustup.rs -sSf | sh -s -- -y 
source "$HOME/.cargo/env"

rustup install nightly
rustup component add rustfmt
rustup component add rustfmt --toolchain nightly
rustup component add clippy 
rustup component add clippy --toolchain nightly

# Set timezone
sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install chezmoi and dotfiles from this repository
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Chocrates
