#!/bin/bash

sudo apt-get install -y curl ncdu htop mc zsh zsh-autosuggestions git fzf tmux w3m
sudo apt-get install -y firmware-realtek firmware-amd-graphics 

sudo apt-get install -y kbdd ufw feh apulse i3 i3status dmenu polybar rxvt-unicode tldr lxappearance qt6ct xinit firefox-esr xorg alsa-utils deborphan ncal stow vrms pass xclip at kmon nvtop pulsemixer dmz-cursor-theme atop prettyping
sudo apt-get install -y vainfo vulkan-tool libva-glx2

# monitor plugged devices
sudo apt-get install -y devmon

# for notify-send 
sudo apt-get install -y libnotify-bin dunst 

# requred to make icons work
sudo apt-get install -y gnome-icon-theme hicolor-icon-theme

sudo apt-get install lnav bandwhich

# notebook
# sudo apt-get install -y autorandr arandr tlp tlp-rdw wpasupplicant i3lock powertop xserver-xorg-input-synaptics lightdm mate-power-manager network-manager-gnome caffeine xss-lock lightdm-settings slick-greeter xdotool

git clone https://github.com/tau3/dotfiles.git ~/git/dotfiles

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/rupa/z.git ~/git/z
