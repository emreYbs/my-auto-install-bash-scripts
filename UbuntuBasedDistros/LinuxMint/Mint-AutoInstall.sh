#!/bin/bash
#emreybs

# Lets update if needed
sudo apt-get update
sudo apt upgrade -y

# Install firewall and setup very basic rules
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Add extra MEdia Codecs
sudo apt-get install mint-meta-codecs

#Optimize Laptop Battery
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
sudo tlp start

#For Thinkpads, do this as well: sudo apt-get install tp-smapi-dkms acpi-call-dkms

#Install VLC Player
sudo apt install vlc

# Fro screenshots, Flameshot is very handy.
sudo apt install flameshot

# Installing Bleachbit to destroy unnecessary files 
sudo apt bleachbit


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


#Install some Browsers
wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | apt-key add -
add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
apt-get update
apt-get install vivaldi-stable -y

#Install Google Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
apt-get install -f -y
rm google-chrome-stable_current_amd64.deb

#Install Librewolf Browser
sudo apt update && sudo apt install -y wget gnupg lsb-release apt-transport-https ca-certificates

distro=$(if echo " una bookworm vanessa focal jammy bullseye vera uma " | grep -q " $(lsb_release -sc) "; then lsb_release -sc; else echo focal; fi)

wget -O- https://deb.librewolf.net/keyring.gpg | sudo gpg --dearmor -o /usr/share/keyrings/librewolf.gpg

sudo tee /etc/apt/sources.list.d/librewolf.sources << EOF > /dev/null
Types: deb
URIs: https://deb.librewolf.net
Suites: $distro
Components: main
Architectures: amd64
Signed-By: /usr/share/keyrings/librewolf.gpg
EOF

sudo apt update

sudo apt install librewolf -y

sudo apt autoremove

echo "Finished."
echo "Exitting..."

