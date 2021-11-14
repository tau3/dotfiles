#!/bin/bash

sudo apt-get install -y curl ncdu htop vim mc ranger zsh git fzf silversearcher-ag tmux
sudo apt-get install -y firmware-realtek firmware-amd-graphics

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tau3/dotfiles.git ~/git/dotfiles

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
