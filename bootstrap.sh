#!/usr/bin/env bash
# git clone --recurse-submodules git@github.com:fell-lucas/dotfiles.git
# git submodule update --init dotdrop
# git remote set-url origin git@github.com:fell-lucas/dotfiles.git

curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh | bash

touch ~/.z
zsh -c "git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions"
zsh -c "git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting"
zsh -c "git clone https://github.com/denysdovhan/spaceship-prompt.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt --depth=1"
zsh -c "ln -s ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship-prompt/spaceship.zsh-theme ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/themes/spaceship.zsh-theme"

pip3 install -r dotdrop/requirements.txt --user

dotdrop/bootstrap.sh
./dotdrop.sh install -p "$1" -f
