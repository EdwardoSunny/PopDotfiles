#!/bin/bash

dotfiles="$HOME/dotfiles"

echo "Updating Packages..."
sudo apt update && sudo apt upgrade -y

echo "Installing Dependencies (Pop_OS/Ubuntu ONLY)"
sudo apt-get install i3 rofi neofetch git fish polybar feh kitty python3 polybar emacs neovim compton compton-conf

ln -s $HOME/PopDotfiles/i3 ~/.config
ln -s $HOME/PopDotfiles/fish ~/.config
ln -s $HOME/PopDotfiles/polybar ~/.config
ln -s $HOME/PopDotfiles/rofi ~/.config
ln -s $HOME/PopDotfiles/kitty ~/.config
ln -s $HOME/PopDotfiles/neofetch ~/.config
