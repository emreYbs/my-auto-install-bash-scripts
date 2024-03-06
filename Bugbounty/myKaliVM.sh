#!/bin/bash
#emreYbs
#Work in Progress with little issues, not fully ready, still testing and adding more features.So be warned, use at your own risk or wait for the final version.
# https://www.kali.org/docs/general-use/xfce-faq/ If you have issues with XFCE Desktop, you can switch to GNOME.

echo "This script will install and configure Kali Linux for you."
echo "Please run this script as root."

echo "Press Ctrl+C to cancel or Enter to continue."
read -r input
input=$(echo "$input" | tr -d '\r') I wrote this script on a Windows VM, so I had to remove the carriage return character for Linux to work properly.
echo "Starting..."


# Change the password
sudo passwd

sudo apt update
sudo apt upgrade

# Check if ufw is installed
if ! command -v ufw &> /dev/null
then
    # Install ufw
    sudo apt install ufw -y
    sudo apt install rsyslog  # Suggested packages for ufw Firewall
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
# sudo systemctl disable vsftpd #Disable if already installed. Otherwise, you'll get an error:"Unit file vsftpd.service does not exist."

# Stop unnecessary services
sudo systemctl stop apache2
sudo systemctl stop mysql
sudo systemctl stop postgresql
sudo systemctl stop vsftpd #If not already installed, you'll get an error.

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

#Some useful OSINT tools. Uncomment if you don't need them.
sudo apt install pipx
pipx ensurepath
pipx install search-that-hash
pipx install name-that-hash
pipx install h8mail
pipx install toutatis
pipx install holehe
pipx install shodan
pipx ınstall ghunt
pipx install socialscan
pipx install waybackpy
pipx install instalooter
pipx install instaloader
pipx ensurepath

#Install Docker and so Go-lang based tools
#Installing Golang can cause some issues depending on the version. So I prefered to use Docker here. If you want, you can use this instead: https://go.dev/doc/install
sudo apt install docker.io
#Fast golang web crawler for gathering URLs and JavaScript file locations
echo https://www.google.com | sudo docker run --rm -i hakluke/hakrawler:v2 -subs
sudo docker pull projectdiscovery/nuclei:latest #To test, run:  docker run --rm projectdiscovery/nuclei
#To Update Nuclei on Docker version: sudo docker run --rm projectdiscovery/nuclei --update
#For Further info about Nuclei, check here: https://docs.projectdiscovery.io/tools/nuclei/running#running-with-docker

sudo docker pull ghcr.io/oj/gobuster:latest #Directory/File, DNS and VHost busting tool written in Go

#Install AutoRecon and ensure you have some useful related tools that AutoRecon will need.
sudo apt install seclists curl dnsrecon enum4linux feroxbuster gobuster impacket-scripts nbtscan nikto nmap onesixtyone oscanner redis-tools smbclient smbmap snmp sslscan sipvicious tnscmd10g whatweb wkhtmltopdf
sudo apt install python3-venv
python3 -m pip install --user pipx
python3 -m pipx ensurepath
pipx install git+https://github.com/Tib3rius/AutoRecon.git  #Check here for further info:https://github.com/Tib3rius/AutoRecon

#Wordlists
sudo apt -y install seclists #Already installed above but in case you may need.
# install some penetration testing tools
sudo apt install arjun burpsuite gospider

sudo mkdir myAddedTools
cd MyAddedTools
git clone https://github.com/maurosoria/dirsearch.git --depth 1 #Use the dirsearch.py to use the tool
cd ..
                                                                                                                                                               
#Install naabu Tool: https://github.com/projectdiscovery/naabu
sudo apt install -y libpcap-dev --fix-missing
sudo apt install naabu

#Install Subfinder, theHarvester, Bleachbit, OWASP Zaproxy, Owasp-mantra, Feroxbuster(faster than others, written in Rust)
sudo apt install subfinder
sudo subfinder --update 
sudo apt install theharvester
sudo apt install bleachbit
sudo apt install zaproxy owasp-mantra-ff
sudo apt install -y feroxbuster 
#If not you use a Kali, then check its Github repo to see other options to install

#Python Virtual Environment
python3 -m pip install pipenv

#Update the VM, but better to shut down your Antivirus Software on Host to be able to update properly
sudo apt -y update

echo "Done!"
echo "Please reboot the system to apply changes."
echo "Exiting..."
exit


