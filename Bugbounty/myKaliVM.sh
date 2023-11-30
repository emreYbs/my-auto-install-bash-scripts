#!/bin/bash
#emreYbs
#Work in Progress with little issues, not fully ready, still testing and adding more features.So be warned, use at your own risk or wait for the final version.

echo "This script will install and configure Kali Linux for you."
echo "Please run this script as root."

echo "Press Ctrl+C to cancel or Enter to continue."
read -r input
input=$(echo "$input" | tr -d '\r') I wrote this script on a Windows VM, so I had to remove the carriage return character for Linux to work properly.
echo "Starting..."


# Change the password
sudo passwd

sudo apt install unattended-upgrades -y
sudo dpkg-reconfigure -plow unattended-upgrades

# Check if ufw is installed
if ! command -v ufw &> /dev/null
then
    # Install ufw
    sudo apt install ufw -y
fi

# Enable the firewall
sudo ufw enable

# Disallow SSH connections
sudo ufw deny ssh

# Disallow incoming traffic
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow necessary services
sudo ufw allow http
sudo ufw allow https

# Disable unnecessary services
sudo systemctl disable apache2
sudo systemctl disable mysql
sudo systemctl disable postgresql
sudo systemctl disable vsftpd

# Stop unnecessary services
sudo systemctl stop apache2
sudo systemctl stop mysql
sudo systemctl stop postgresql
sudo systemctl stop vsftpd

# Remove unnecessary packages if you don't need them
# sudo apt-get purge -y apache2 mysql-server postgresql vsftpd

# Install necessary packages
# Kali-Whoami – (Stay anonymous on Kali Linux), well sort of privacy if ever occurs in this age of surveillance:)
sudo apt update && sudo apt install tar tor curl python3 python3-scapy network-manager

# Check if user wants to install Kali-Whoami tool
read -p "Do you want to install Kali-Whoami tool? (y/n): " install_kaliwhoami

if [[ $install_kaliwhoami == "y" ]]; then
    # Create a folder in Downloads called "myAddedTools" and navigate to it and then Clone the repository
    mkdir ~/Downloads/myAddedTools
    cd ~/Downloads/myAddedTools
    git clone https://github.com/omer-dogan/kali-whoami
    sudo make install
    # Later you can start this tool by typing kali-whoami in terminal or sudo kali-whoami --start
    # To stop the tool type sudo kali-whoami --stop
    # To uninstall the tool type sudo make uninstall
    # To update the tool type sudo make update
    # To see all the options type kali-whoami --help
    # To see the logs type sudo kali-whoami --logs
    # To see the status type sudo kali-whoami --status
    # To see the version type sudo kali-whoami --version
fi

# Install necessary packages
sudo apt-get install -y git curl wget zip unzip

# Check if user wants to install Librewolf browser
read -p "Do you want to install Librewolf browser? (y/n): " install_librewolf

if [[ $install_librewolf == "y" ]]; then
    # Install Librewolf browser
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
fi


# Update and upgrade the system
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get dist-upgrade -y
sudo apt autoremove -y

echo "Done!"
echo "Please reboot the system to apply changes."
echo "Exiting..."
exit

