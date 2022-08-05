#!/bin/bash

sudo apt-get install -y curl ncdu htop vim mc ranger zsh git fzf silversearcher-ag tmux w3m
sudo apt-get install -y firmware-realtek firmware-amd-graphics 

sudo apt-get install -y kbdd ufw devmon feh apulse fonts-firacode i3 i3status dmenu polybar rxvt-unicode tldr lxappearance qt5ct xinit firefox-esr xorg alsa-utils deborphan ncal stow vrms pass xclip nethogs micro dunst
sudo apt-get install -y vainfo vulkan-tool libva-glx2

# also install swaykbdd
# sudo apt-get install sway qtwayland5 waybar xwayland

# requred to make icons work
sudo apt-get install -y gnome-icon-theme hicolor-icon-theme

# notebook
# sudo apt-get install -y arandr tlp tlp-rdw wpasupplicant i3lock powertop xserver-xorg-input-synaptics lightdm mate-power-manager network-manager-gnome caffeine xss-lock

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
git clone https://github.com/tau3/dotfiles.git ~/git/dotfiles

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

