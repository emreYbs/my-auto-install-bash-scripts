#!/bin/bash
#emreybs
#For some Quick Live VM test cases, Mint is a good combo of Ubuntu and Debian. On purpose, I didn't install much with the automation of the script

# Lets update if needed
sudo apt-get update
sudo apt upgrade -y

# Install firewall and setup very basic rules # Normally LinuxMint has the Ports closed and the firewall is already enabled. But better to automate if it is not installed for a reason
sudo apt install ufw
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw enable

# Add extra Media Codecs
sudo apt-get install mint-meta-codecs


#Optimize Laptop Battery if you'll use on a laptop, comment out otherwise.
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get update
sudo apt-get install tlp tlp-rdw
sudo tlp start
#For Thinkpads, do this as well: sudo apt-get install tp-smapi-dkms acpi-call-dkms

#Install VLC Player
sudo apt install vlc

# Fro screenshots, Flameshot is very handy.
sudo apt install flameshot

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

sudo apt autoremove
echo "Finished."


