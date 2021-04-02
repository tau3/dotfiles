#!/bin/bash

sudo apt-get install -y curl ncdu htop vim mc ranger zsh git fzf silversearcher-ag nodejs tmux
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tau3/dotfiles.git ~/git/dotfiles
ln -s ~/git/dotfiles/.zshrc ~/.zshrc
ln -s ~/git/dotfiles/.zshenv ~/.zshenv
ln -s ~/git/dotfiles/.vimrc ~/.vimrc
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
