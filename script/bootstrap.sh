#!/bin/bash

sudo apt update
sh -c "$(curl -fsLS https://chezmoi.io/get)" -- init --apply Chocrates
