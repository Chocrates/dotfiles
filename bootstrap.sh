#!/bin/bash
sudo apt-get install -y \
  curl \
  git \
  gnupg2 \
  jq \
  sudo \
  zsh \
  build-essential \
  openssl \
  libfuse2

mkdir -p $HOME/bin

# Configure zsh as default shell
sudo chsh -s $(which zsh) vscode

# Install neovim
curl -L -o $HOME/bin/nvim https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
chmod a+x $HOME/bin/nvim

# Make Pyenv stop complaining
curl -L https://raw.githubusercontent.com/yyuu/pyenv-installer/master/bin/pyenv-installer | bash

## Install rustup and common components
curl https://sh.rustup.rs -sSf | sh -s -- -y 
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
