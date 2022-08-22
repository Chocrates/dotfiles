#!/bin/bash

sudo apt update
sudo ln -fs /usr/share/zoneinfo/America/Chicago /etc/localtime
sudo dpkg-reconfigure --frontend noninteractive tzdata

sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Chocrates
