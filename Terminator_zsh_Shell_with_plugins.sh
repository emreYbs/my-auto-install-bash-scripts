#! /bin/bash

#emreYbs - A simple script for Debian based distros to install Terminator terminal and zsh shell and some plugins for zsh


sudo add-apt-repository ppa:mattrose/terminator
sudo apt-get update
sudo apt install terminator


#Let's add zsh Shell and some extras to make it more useful
touch "$HOME/.cache/zshhistory"
#-- Setup Alias in $HOME/zsh/aliasrc
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/powerlevel10k
echo 'source ~/powerlevel10k/powerlevel10k.zsh-theme' >> ~/.zshrc

sudo apt install zsh zsh-antigen zsh-autosuggestions zsh-syntax-highlighting autokump zsh-theme-powerlevel9k


#Let's install Oh My Zsh for managing your zsh configuration
#You can get it via Github or official website: https://ohmyz.sh/
cd ~
sudo sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Finished.Exitting..."

