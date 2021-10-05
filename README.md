# my-auto-install-bash-scripts
*My auto-installs scripts for  osint, bugbounty, pentesting*


**To gain some time and avoid boring installations**, I use these shell scripts for quick installations for VM's for my CyberLabs.

Default path is : home='cd /opt' 
*Or anywhere as you wish. To keep tidy, /opt is better, in my opinion. You can choose /Downloads and mkdir Tools, etc :)*

# Example:

- For example, this shell script will install a couple of tools that I use for some tasks. Take "Photon" and TheHarvester as an example below out of the whole list:

*Photon*<br /> 
git clone https://github.com/s0md3v/Photon.git
cd Photon && python3 -m pip install -r requirements.txt

*TheHarvester<br /> 
git clone https://github.com/laramies/theHarvester.git
cd theHarvester
sudo python3 -m pip install -r requirements.txt --ignore-installed
sudo python3 -m pip install pipenv
sudo python3 -m pip install webscreenshot
sudo add-apt-repository -y ppa:micahflee/ppa
sudo apt -y update



