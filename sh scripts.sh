
# My auto-install scripts for Osint, Bugbounty, Pentesting


# **To gain some time and avoid boring installations, I use these shell scripts for quick installations for VM's for my CyberLabs.**

# Default path is : home='cd /opt' 
# *Or anywhere as you wish. To keep tidy, /opt is better, in my opinion. You can choose /Downloads and mkdir Tools, etc :)*

#!/bin/bash

cd /opt

# dirsearch
git clone https://github.com/maurosoria/dirsearch
# WPScan
git clone https://github.com/wpscanteam/wpscan
# DNSRecon
git clone https://github.com/darkoperator/dnsrecon
# Gobuster
git clone https://github.com/OJ/gobuster
cd gobuster
apt install golang
make
export PATH=$PATH:/opt/gobuster
`echo $home`
cd /opt
# Powersploit
https://github.com/PowerShellMafia/PowerSploit/tree/master/Recon
# LinEnum
mkdir -p priv_esc/linux; cd priv_esc/linux
git clone https://github.com/rebootuser/LinEnum
# linux-exploit-suggest.sh
git clone https://github.com/mzet-/linux-exploit-suggester
# Windows Exploit Suggester
git clone https://github.com/AonCyberLabs/Windows-Exploit-Suggester

# Autorecon
git clone https://github.com/Tib3rius/AutoRecon
# Evil-winrm
git clone https://github.com/Hackplayers/evil-winrm
# Juicy Potato
git clone https://github.com/ohpe/juicy-potato 
# Unicorn
git clone https://github.com/trustedsec/unicorn
# PrintSpoofer
git clone https://github.com/itm4n/PrintSpoofer
# Reverse Shell Generator - rsg
git clone https://github.com/mthbernardes/rsg
# Peas
git clone https://github.com/carlospolop/privilege-escalation-awesome-scripts-suite
# sshng2john
wget https://raw.githubusercontent.com/stricture/hashstack-server-plugin-jtr/master/scrapers/sshng2john.py
# Impacket
git clone https://github.com/SecureAuthCorp/impacket
# Joomscan
git clone https://github.com/rezasp/joomscan.git
# SMTP User Enum
git clone https://github.com/pentestmonkey/smtp-user-enum
# Sherlock
git clone https://github.com/sherlock-project/sherlock.git
cd /opt/sherlock
sudo python3 -m pip install -r requirements.txt
sudo python3 -m pip install socialscan
sudo python3 -m pip install holehe
# Sublist3r
git clone https://github.com/aboul3la/Sublist3r.git
sudo python3 -m pip install -r requirements.txt
#theHarvester
git clone https://github.com/laramies/theHarvester.git
# Photon
git clone https://github.com/s0md3v/Photon.git
cd Photon && python3 -m pip install -r requirements.txt

# privilege escalation  Empire
mkdir priv_esc/windows; cd priv_esc/windows
git clone https://github.com/EmpireProject/Empire
`echo $home`

# theHarvester
git clone https://github.com/laramies/theHarvester.git
cd theHarvester
sudo python3 -m pip install -r requirements.txt --ignore-installed
sudo python3 -m pip install pipenv
sudo python3 -m pip install webscreenshot
sudo add-apt-repository -y ppa:micahflee/ppa
sudo apt -y update


