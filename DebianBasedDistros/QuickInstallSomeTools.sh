#!/bin/bash
#emreybs

# Lets update if needed
sudo apt update 


# It is not needed but first, I love changing the keyboard layout.
# Changing keyboard layout to American English. You can change as fr,tr, etc according o your keyboard layout

setxkbmap us

# Installing OnlyOffice(Free for personal use, open source and similiar to Microsoft Word, and I prefer this to Libra Office
# If you don't like, just:   sudo apt-get purge onlyoffice-desktopeditors

mkdir -p ~/.gnupg
chmod 700 ~/.gnupg
gpg --no-default-keyring --keyring gnupg-ring:/tmp/onlyoffice.gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys CB2DE8E5
chmod 644 /tmp/onlyoffice.gpg
sudo chown root:root /tmp/onlyoffice.gpg
sudo mv /tmp/onlyoffice.gpg /etc/apt/trusted.gpg.d/

echo 'deb https://download.onlyoffice.com/repo/debian squeeze main' | sudo tee -a /etc/apt/sources.list.d/onlyoffice.list
sudo apt install onlyoffice-desktopeditors



# Installing Joplin MarkDown Editor(with icon)

wget -O - https://raw.githubusercontent.com/laurent22/joplin/dev/Joplin_install_and_update.sh | bash


# Installing Sublime Text Editor
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list

sudo apt-get install apt-transport-https
sudo apt-get install sublime-text

# Installing Project Jupyter. To run when needed: jupyter-lab
pip install jupyterlab

# Installing VSCodium
# Add the GPG key of the repo

wget -qO - https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo dd of=/usr/share/keyrings/vscodium-archive-keyring.gpg

# Add repo
echo 'deb [ signed-by=/usr/share/keyrings/vscodium-archive-keyring.gpg ] https://download.vscodium.com/debs vscodium main' \
    | sudo tee /etc/apt/sources.list.d/vscodium.list
    
sudo apt install codium

# Fro screenshots, Flameshot is very handy.
sudo apt install flameshot

# Installing Bleachbit to destroy unnecessary files 
sudo apt bleachbit

# Install firewall and setup very basic rules
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

echo "Finished"

exit


