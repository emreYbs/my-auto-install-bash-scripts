# my-auto-install-bash-scripts

*My **auto-installation scripts** for osint, bugbounty, pentesting*


**To gain some time and avoid boring installations**, I use these shell scripts for quick installations for VM's for my CyberLabs. Having and maintaining cyberLabs are required to learn better for an infoSec student, hobbyist, or an professional and setting new VM's from scratch becomes boring and I generally use different sets of auto shells for different tasks. So I can gain some time and get rid of the burden. As they say, automation is the future:)

Default path is : home='cd /opt' 
*Or anywhere as you wish. To keep it tidy, /opt is better, in my opinion. You can choose /Downloads and mkdir Tools, etc, if you prefer. That is why, I tried to only add auto git clone and install requirements and avoid setting paths, you can arrange as you are used to.*

# Example:

- For example, this shell script will install a couple of tools that I use for some tasks. Take "Photon" and TheHarvester as an example below out of the whole list:

*Photon*<br /> 
git clone https://github.com/s0md3v/Photon.git<br />
cd Photon && python3 -m pip install -r requirements.txt

*TheHarvester<br /> 
git clone https://github.com/laramies/theHarvester.git<br />
cd theHarvester<br />
sudo python3 -m pip install -r requirements.txt --ignore-installed<br />
sudo python3 -m pip install pipenv<br />
sudo python3 -m pip install webscreenshot<br />
sudo add-apt-repository -y ppa:micahflee/ppa<br />
sudo apt -y update



