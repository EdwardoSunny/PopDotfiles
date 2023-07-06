#!/bin/bash
declare -a fonts=(
    # BitstreamVeraSansMono
    # CodeNewRoman
    # DroidSansMono
    FiraCode
    FiraMono
    # Go-Mono
    # Hack
    # Hermit
    JetBrainsMono
    # Meslo
    # Noto
    # Overpass
    # ProggyClean
    # RobotoMono
    # SourceCodePro
    # SpaceMono
    # Ubuntu
    # UbuntuMono
)

dotfiles="$HOME/dotfiles"
fonts_dir="${HOME}/.local/share/fonts"

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

echo "Installing Dependencies for DOOM Emacs"
sudo apt-get install python3 fish python3-pylsp cmake python3-pip

echo "Setting Fish as Default Shell"
echo /usr/local/bin/fish | sudo tee -a /etc/shells
chsh -s /usr/local/bin/fish

echo "Installing LSP's"
pip3 install pyright
pip3 install 'python-lsp-server[all]'
pip3 install black
pip3 install pyflakes

if [[ ! -d "$fonts_dir" ]]; then
    mkdir -p "$fonts_dir"
fi

echo -e "\e[0;32mScript:\e[0m \e[0;34mClonning\e[0m \e[0;31mNerdFonts\e[0m \e[0;34mrepo (sparse)\e[0m"
git clone --filter=blob:none --sparse git@github.com:ryanoasis/nerd-fonts
cd nerd-fonts

for font in "${fonts[@]}"; do
    echo -e "\e[0;32mScript:\e[0m \e[0;34mClonning font:\e[0m \e[0;31m${font}\e[0m"
    git sparse-checkout add "patched-fonts/${font}"
    echo -e "\e[0;32mScript:\e[0m \e[0;34mInstalling font:\e[0m \e[0;31m${font}\e[0m"
    ./install.sh "${font}"
done

echo -e "\e[0;32mScript:\e[0m \e[0;34mCleaning the mess...\e[0m"
sudo rm -rf nerd-fonts

ln -s $HOME/PopDotfiles/doom/config.el ~/.doom.d/config.el
ln -s $HOME/PopDotfiles/doom/packages.el ~/.doom.d/packages.el
ln -s $HOME/PopDotfiles/doom/init.el ~/.doom.d/init.el
