#!/bin/bash
# @emreYbs https://github.com/emreYbs # I combined this new script with some of my previous scripts.
# This new script is intended to be run on Fedora 38-39 and for InfoSec purposes and will install the following tools:
# BurpSuite, Sublime Text, Visual Studio Code, Librewolf, Chromium, Vivaldi, Golang, Nuclei, OWASP ZAP, Nmap, Wireshark, Metasploit, Sublist3r, Metagoofil, Spiderpig, WebHTTrack Website Copier, Youtube-DL, HTTProbe, FFUF, Dirsearch, Subfinder, Assetfinder, Amass, Firefox, Shodan, SpiderFoot, Tor Browser, recon-ng, Little Brother, FinalRecon, OSINT-Search, PhoneInfoga, Twint, Instaloader, Sherlock, WhatsMyName, exiftool, AWS Inventory Tool, EyeWitness, Loki, Social Analyzer, theHarvester, subfinder, hakrawler, httpx, naabu, interactsh-client, sqlmap

### I will update this Bash script and customise better in the future and fix some minor issues ###

echo "Bug Bounty Tools Installer for Fedora 38-39"
echo "Application security testing tools for bug bounty hunting and security testing"
echo "Also there are some OSINT related tools"
echo "This script will install the following tools:"
echo "BurpSuite, Sublime Text, Visual Studio Code, Librewolf, Chromium, Vivaldi, Golang, Nuclei, OWASP ZAP, Nmap, Wireshark, Metasploit, Sublist3r, Metagoofil, Spiderpig, WebHTTrack Website Copier, Youtube-DL, HTTProbe, FFUF, Dirsearch, Subfinder, Assetfinder, Amass, Firefox, Shodan, SpiderFoot, Tor Browser, recon-ng, Little Brother, FinalRecon, OSINT-Search, PhoneInfoga, Twint, Instaloader, Sherlock, WhatsMyName, exiftool, AWS Inventory Tool, EyeWitness, Loki, Social Analyzer, theHarvester, subfinder, hakrawler, httpx, naabu, interactsh-client, sqlmap"

# echo "Before installing, make sure you have the latest version of Fedora 38 or 39 and then update the system"
# echo "If you are using Fedora 38, you can upgrade to Fedora 39 with the following command:"
# echo "sudo dnf upgrade --refresh"
# echo "sudo dnf install dnf-plugin-system-upgrade"
# echo "sudo dnf system-upgrade download --releasever=39"
# echo "sudo dnf system-upgrade reboot"

# This bash script will install the required tools and make your system ready for use after a fresh install of Fedora Based Distros.
# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root!"
    echo "It needs root privileges to install the required tools properly."
    exit
fi

# Get the directory of the script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"

# Add the script directory to the PATH variable
export PATH="$SCRIPT_DIR:$PATH"

# Check if Bash is installed, if not, install it
if ! command -v bash &>/dev/null; then
    sudo dnf install -y bash
fi

# Define log file path
LOG_FILE="/var/log/fedora_install.log"

# Function to log messages to file
# I only wanted to log Snap and Flatpak installations, but you can log whatever you want.
# For privacy, better not to log anything. Snap and Flatpak installations are not a problem for me.
log() {
    echo "$(date): $*" >>"$LOG_FILE"
}

log "Starting installation process."
echo -e "\e[1;32mWelcome to the Fedora Based Distros Auto Install (for Bugbounty-OSINT) Script by emreYbs\e[0m"
echo "This script will install the required tools and make your system ready for use after a fresh install of Fedora Based Distros."
echo "Please run this script as root!"
echo "Please enter your password below when prompted!"
echo "This script will start in 3 seconds..."
sleep 3

# # Check if the system is Fedora Based Distro.
# # Uncomment if you want to check. No need for my case.

# if ! grep -qi "fedora" /etc/os-release; then
#     echo "This script is only for Fedora Based Distros!"
#     exit
# fi

# Update the system
sudo dnf update -y
# Create a standard user for better security
sudo useradd standard-user -s /bin/bash

# Set password for the standard user
sudo passwd standard-user

# Add the standard user to the sudo group
#sudo usermod -aG wheel standard-user

echo "Some packages will be installed to make the system ready for use..."
sudo dnf upgrade --refresh
sudo dnf install -y dnf-plugin-fastestmirror # Install the fastest mirror plugin.
# Script can give error here on some distros.But it is not a problem.
sudo dnf install dnf5 -y # Install DNF5 for faster package management.
sudo dnf5 upgrade -y
sudo sed -i 's/enabled=0/enabled=1/' /etc/dnf/plugins/fastestmirror.conf
# Modify the DNF configuration file to increase the number of parallel downloads
sudo sed -i 's/^max_parallel_downloads=.*/max_parallel_downloads=6/' /etc/dnf/dnf.conf
sudo dnf install dnf5 dnf5-plugins
sudo dnf groupupdate core

# Ask the user if they want to update firmware
# Not so important but I like to update firmware.
# UEFI firmware can not be updated in legacy BIOS mode. So,script can notify you about it depending on your system.
read -p "Do you want to update firmware? (y/n) " firmware_choice
if [ "$firmware_choice" == "y" ]; then
    sudo fwupdmgr refresh --force
    sudo fwupdmgr get-updates
    sudo fwupdmgr update
fi

# Ask the user if they want to change the hostname
read -p "Do you want to change the hostname? (y/n) " hostname_choice
if [ "$hostname_choice" == "y" ]; then
    read -p "Enter the new hostname: " new_hostname
    sudo hostnamectl set-hostname "$new_hostname"
fi

# Ask the user if they want to enable the RPM Fusion repositories
read -p "Do you want to enable the RPM Fusion repositories? (y/n) " rpmfusion_choice
if [ "$rpmfusion_choice" == "y" ]; then
    # Enable the RPM Fusion repositories
    sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
fi

# Ask the user if they want to enable Flathub
read -p "Do you want to enable Flathub? (y/n) " flathub_choice
if [ "$flathub_choice" == "y" ]; then
    # Enable Flathub
    flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
fi

# Install the required tools
sudo dnf install -y git curl wget
sudo dnf install firejails # Install Firetools for security and privacy reasons for sandboxing.

echo "Installing tools..."
# Install iptables
sudo dnf install iptables -y
dnf install iptables-services -y
sudo dnf install iptables-services-1.8.9-5.fc39

# Enable and configure iptables
sudo systemctl enable iptables
sudo systemctl start iptables

# Configure iptables rules for best security settings
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP
sudo iptables -P OUTPUT ACCEPT
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A INPUT -p icmp --icmp-type echo-request -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Enable and start the firewall
sudo systemctl enable firewalld
sudo systemctl start firewalld

# Allow necessary ports through the firewall
sudo firewall-cmd --permanent --add-port=22/tcp
sudo firewall-cmd --reload

# Install BurpSuite
# sudo dnf install -y burpsuite  #May not work unless you use Fedora Security spin. Repos don't have it.
# Download BurpSuite from the official site
wget -O burpsuite.sh "https://portswigger-cdn.net/burp/releases/download?product=community&version=2023.10.3.6&type=Linux"
sudo chmod +x burpsuite.sh
# # Check if the download was successful
# if [ $? -eq 0 ]; then
#     echo "BurpSuite downloaded successfully."
# else
#     echo "Failed to download BurpSuite. Please check the URL and try again."
# fi

# Install Sublime Text
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
sudo dnf install sublime-text

# Install Visual Studio Code
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/vscode
sudo dnf install -y code

# Install Librewolf Web Browser
# Librewolf is not in the official repo. So, I added the repo here.
sudo rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
sudo dnf install librewolf                               # Install Librewolf. Script can give error here on some distros.But it is not a problem.
sudo dnf config-manager --set-disabled rpm.librewolf.net # Disable the repo after installation.For added security and possible repo conflicts.
#Check here for more info: https://librewolf-community.gitlab.io/
#https://librewolf.net/installation/fedora/
echo "Now the script will try to install Brave and Vivaldi Browsers, but it can give error."
#echo "Better to check the Official Websites to download them. Repos tend to lack them."
#sudo dnf install -y brave-browser vivaldi-stable # Install Brave and Vivaldi
#If you encounter errors in some Fedora based distros, download manually from the Official Websites of Vivaldi and Brave.
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser
# Install Chromium
sudo dnf install -y chromium

# Install Vivaldi
sudo dnf config-manager --add-repo https://repo.vivaldi.com/stable/vivaldi-fedora.repo
sudo dnf install vivaldi-stable
# Install Microsoft Edge (uncomment if needed)
# sudo dnf install -y microsoft-edge-beta

# Install 7zip, unzip, unrar
sudo dnf install -y unzip p7zip p7zip-plugins unrar

echo "Some nice looking fonts will be installed..."
sudo dnf install -y 'google-roboto*' 'mozilla-fira*' fira-code-fonts

# Install Golang (For Nuclei, we need to install Golang)
#sudo dnf install -y golang # Install Golang. Repo has the older versions. So better download from the Official Website.
#https://go.dev/doc/install
sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go1.21.4.linux-amd64.tar.gz
#Remove any previous Go installation by deleting the /usr/local/go folder (if it exists), then extract the archive you just downloaded into /usr/local, creating a fresh Go tree in /usr/local/go:
#Do not untar the archive into an existing /usr/local/go tree. This is known to produce broken Go installations.
# Add /usr/local/go/bin to the PATH environment variable
export PATH=$PATH:/usr/local/go/bin

# Install Nuclei
#https://github.com/projectdiscovery/nuclei/releases  You can also download the latest version for different OS from here.
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest

sudo dnf install proxychains-ng.x86_64 -y # Install Proxychains for security and privacy reasons.

# Install OWASP ZAP if you need, uncomment some lines below:
#sudo dnf install -y zaproxy  #Repos don't have it. So, download from the Official Website.
#https://www.zaproxy.org/download/
#Also you will need Java. So, install it.
# sudo dnf install java-11-openjdk-devel
#Download the latest version of OWASP ZAP from the Official Website.

# Install Nmap
sudo dnf install -y nmap

# Install Wireshark
sudo dnf install -y wireshark

# Install Metasploit (uncomment if needed)
# sudo dnf install -y metasploit

# Install Sublist3r
sudo pip install sublist3r

# Install Metagoofil
git clone https://github.com/opsdisk/metagoofil
cd metagoofil
virtualenv -p python3 .venv # If using a virtual environment.
source .venv/bin/activate   # If using a virtual environment.
pip install -r requirements.txt

#yersinia is in the official Repo
sudo dnf install yersinia
sudo dnf install sqlninja
sudo dnf install medusa
sudo dnf install etherape
sudo dnf install ettercap
sudo dnf install hashid
sudo dnf install tree
sudo dnf install timeshift

# Install WebHTTrack Website Copier
yum install httrack

# Install FFUF
#sudo dnf install -y ffuf
git clone https://github.com/ffuf/ffuf
cd ffuf
go get
go build

# Install Dirsearch
sudo dnf install -y dirsearch

# Install Subfinder
sudo dnf install -y subfinder

# Install Assetfinder
sudo dnf install -y assetfinder

# Install Amass
sudo dnf install -y amass

# Install Firefox
sudo dnf install -y firefox

# Configure Firefox settings
firefox_prefs_path="$HOME/.mozilla/firefox/*.default-release"
firefox_prefs_file="$firefox_prefs_path/prefs.js"

# Delete cookies/history on shutdown
echo 'user_pref("privacy.clearOnShutdown.cookies", true);' >>$firefox_prefs_file
echo 'user_pref("privacy.clearOnShutdown.history", true);' >>$firefox_prefs_file

# Privacy protection (block mic/camera/geo)
echo 'user_pref("media.navigator.permission.disabled", true);' >>$firefox_prefs_file
echo 'user_pref("media.navigator.enabled", false);' >>$firefox_prefs_file
echo 'user_pref("geo.enabled", false);' >>$firefox_prefs_file

# Install OSINT Bookmarks
osint_bookmarks_url="https://github.com/Dimaslg/osintBOX/blob/main/bookmarks.html"
osint_bookmarks_file="$firefox_prefs_path/osint_bookmarks.html"
wget "$osint_bookmarks_url" -O "$osint_bookmarks_file"

# Install Shodan
sudo dnf install -y python3-shodan

# Install SpiderFoot
echo "You may encounter some error codes here. But it is not a problem. Check the Github Repo or Official Websites"
wget https://github.com/smicallef/spiderfoot/archive/v4.0.tar.gz
tar zxvf v4.0.tar.gz
cd spiderfoot-4.0
pip3 install -r requirements.txt
python3 ./sf.py -l 127.0.0.1:5001

# Install Tor Browser
wget https://www.torproject.org/dist/torbrowser/10.5.6/tor-browser-linux64-10.5.6_en-US.tar.xz

# Most of the tools below are not in the official repo at least except from Fedora Security spin.
# So you can check the repos and download from Github or the Official Websites if you want.
# Install recon-ng
sudo dnf install -y recon-ng

# Install Little Brother
sudo dnf install -y littlebrother

# Install FinalRecon
sudo dnf install -y finalrecon

# Install OSINT-Search
sudo dnf install -y osint-search

# Install PhoneInfoga
sudo dnf install -y phoneinfoga

# Install Twint
sudo dnf install -y twint

# Install Instaloader
sudo dnf install -y instaloader

# Install Sherlock
$ git clone https://github.com/sherlock-project/sherlock.git
# change the working directory to sherlock
$ cd sherlock
# install the requirements
$ python3 -m pip install -r requirements.txt

# Install WhatsMyName
#sudo dnf install -y whatsmyname
# Use its Website to use the tool online:whatsmyname.app/

# Install exiftool
sudo dnf install -y perl-Image-ExifTool

# Install AWS Inventory Tool
sudo dnf install -y awscli

# Install EyeWitness if Repo has it. Normally it is not in the Repo. So, check Github
#sudo dnf install -y eyewitness

# Install Loki
git clone https://github.com/malwaredojo/loki.git
cd loki/
pip3 install -r requirements.txt
cd loki
sudo python3 loki.py

# Install Social Analyzer
git clone https://github.com/qeeqbox/social-analyzer
cd social-analyzer
pip3 install -r requirements.txt

# Install theHarvester
sudo dnf install python3-virtualenv
virtualenv -p /usr/bin/python3 Downloads/theHarvester-venv
source Downloads/theHarvester-venv/bin/activate

# Install subfinder
go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest

# Install Oneliner-Bugbounty
git clone https://github.com/daffainfo/Oneliner-Bugbounty.git

# Install hakrawler
go install github.com/hakluke/hakrawler@latest

# Install httpx
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest

# Install naabu
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest

# Install interactsh-client
go install -v github.com/projectdiscovery/interactsh/cmd/interactsh-client@latest

# Install sqlmap
git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git sqlmap-dev

echo "About to finish the installation..."
echo "Last question: Do you want to install the following programs?"

# Ask the user if they want to install a VPN
read -p "Do you want to install a VPN? (y/n) " vpn_choice
echo "If you don't need VPN, just press n"
if [ "$vpn_choice" == "y" ]; then
    # Give the user four options to choose from
    echo "Choose a VPN to install:"
    echo "1. OpenVPN"
    echo "2. Mullvad"
    echo "3. ProtonVPN"
    echo "4. NordVPN"
    read -p "Enter your choice (1-4): " vpn_installation_choice
    case $vpn_installation_choice in
    1)
        # Install OpenVPN
        sudo dnf install -y openvpn
        ;;
    2)
        # Install Mullvad
        sudo dnf config-manager --add-repo https://mullvad.net/media/app/latest/rpm/mullvad-vpn.repo
        sudo dnf install -y mullvad-vpn
        ;;
    3)
        # Install ProtonVPN
        wget https://repo.protonvpn.com/fedora-39-stable/protonvpn-stable-release/protonvpn-stable-release-1.0.1-2.noarch.rpm
        sudo dnf install ./protonvpn-stable-release-1.0.1-2.noarch.rpm
        sudo dnf install --refresh proton-vpn-gnome-desktop
        sudo dnf install libappindicator-gtk3 gnome-shell-extension-appindicator gnome-extensions-app
        #If you want to uninstall later: sudo dnf remove “protonvpn*” proton-vpn-gnome-desktop
        # or check here: https://protonvpn.com/support/official-linux-vpn-fedora/
        ;;
    4)
        # Install NordVPN
        sudo rpm --import https://repo.nordvpn.com/gpg/nordvpn_public.asc
        sudo sh -c "echo 'deb https://repo.nordvpn.com/yum/rpm/stable/main/x86_64/' > /etc/yum.repos.d/nordvpn.repo"
        sudo dnf install -y nordvpn
        # or check here: https://nordvpn.com/download/linux/
        # if it doesn't work, try this:
        sh <(wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh) # Install NordVPN
        ;;
    *)
        echo "Invalid choice. No VPN will be installed."
        ;;
    esac
fi

# # Ask the user if they want to install Snap support
# read -p "Do you want to install Snap support? (y/n) " snap_choice
# log "User chose to install Snap support: $snap_choice"
# if [ "$snap_choice" == "y" ]; then
#     sudo dnf install -y snapd
#     sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
#     log "Installed Snap support."
# fi

sudo dnf install gnome-boxes -y # Install Gnome Boxes if you want to use it.Or comment out if you don't want to install it.
sudo dnf upgrade --refresh
sudo dnf groupupdate core

echo "Tools installation has finished. Reboot recommended for some tools to work properly."
echo "Exiting...and the system will reboot in 3 seconds..."
sleep 3
log "Installation process completed."
sudo reboot now

# Added some usage examples from Net to give a very basic idea for new users

# Usage example:
# To use BurpSuite, open a terminal and run 'burpsuite'
# To use Sublime Text, open a terminal and run 'subl'
# To use Visual Studio Code, open a terminal and run 'code'
# To use Librewolf, open a terminal and run 'librewolf'
# To use Chromium, open a terminal and run 'chromium'
# To use Vivaldi, open a terminal and run 'vivaldi'
# To use Golang, open a terminal and run 'go'
# To use Nuclei, open a terminal and run 'nuclei'
# To use OWASP ZAP, open a terminal and run 'zaproxy'
# To use Nmap, open a terminal and run 'nmap'
# To use Wireshark, open a terminal and run 'wireshark'
# To use Firefox, open a terminal and run 'firefox'
# To use Shodan, open a terminal and run 'shodan'
# To use SpiderFoot, open a terminal and run 'python3 ./sf.py -l 127.0.0.1:5001'
# To use Tor Browser, extract the downloaded tar.xz file and run 'start-tor-browser.desktop'
# To use recon-ng, open a terminal and run 'recon-ng'
# To use Little Brother, open a terminal and run 'littlebrother'
# To use FinalRecon, open a terminal and run 'finalrecon'
# To use OSINT-Search, open a terminal and run 'osint-search'
# To use PhoneInfoga, open a terminal and run 'phoneinfoga'
# To use Twint, open a terminal and run 'twint'
# To use Instaloader, open a terminal and run 'instaloader'
# To use Sherlock, open a terminal and run 'sherlock'
# To use WhatsMyName, open a terminal and run 'whatsmyname'
# To use exiftool, open a terminal and run 'exiftool'
# To use AWS Inventory Tool, open a terminal and run 'aws'
# To use EyeWitness, open a terminal and run 'eyewitness'
# To use Loki, open a terminal and run 'sudo python3 loki.py'
# To use Social Analyzer, open a terminal and run 'python3 social_analyzer.py'
# To use theHarvester, open a terminal and run 'theharvester'
# To use subfinder, open a terminal and run 'subfinder'
# To use hakrawler, open a terminal and run 'hakrawler'
# To use httpx, open a terminal and run 'httpx'
# To use naabu, open a terminal and run 'naabu'
# To use interactsh-client, open a terminal and run 'interactsh-client'
# To use sqlmap, open a terminal and run 'sqlmap'
