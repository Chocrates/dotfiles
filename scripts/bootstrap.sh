#!/bin/bash
# Configure zsh as default shell
sudo chsh -s $(which zsh) vscode
sudo apt update

# Set timezone
sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

# Install chezmoi and dotfiles from this repository
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Chocrates

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
