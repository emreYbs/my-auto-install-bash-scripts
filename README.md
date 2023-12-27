# my-auto-install-bash-scripts

*My **auto-installation scripts** for osint 🧐, bugbounty 🐛, pentesting 🔨*

[![Bash Shell](https://badges.frapsoft.com/bash/v1/bash-200x34.png?v=103)](https://github.com/ellerbrock/open-source-badges/)



**To gain some time 🚘 and avoid boring 🥱 installations**, I use these shell scripts for quick ⏩ installations for VM's for my CyberLabs.
*Having and maintaining cyberLabs are required to learn better for an infoSec student, hobbyist, or an professional and setting new VM's from scratch becomes boring and I generally use different sets of auto shells for different tasks.*

So I can gain some time and get rid of the burden. As they say, **automation is the future:)**

**Default path** is : ````home='cd /opt' ````
*Or anywhere as you wish. To keep it tidy, **/opt** is better, in my opinion. You can choose /Downloads and mkdir Tools, etc, if you prefer. That is why, I tried to only add auto git clone and install requirements and avoid setting paths, you can arrange as you are used to.*

# Example:

- For example, this shell script will install a couple of tools that I use for some tasks. Take "Photon" and TheHarvester as an example below out of the whole list:

*Photon* <br /> 
- Although **Photon** is not regulary updated, it is still very handy and for Recon/Osint, a great and fast crawler for an OSINTer, pentester, bugbounty hunter, etc.
git clone https://github.com/s0md3v/Photon.git<br />
cd Photon && python3 -m pip install -r requirements.txt

- If you want, you can also use **Photon** in a Docker:

````
$ git clone https://github.com/s0md3v/Photon.git
$ cd Photon
$ docker build -t photon .
$ docker run -it --name photon photon:latest -u google.com
````
- Tip: Add ````--wayback```` to your Photon command, so it can fetch URL's from archived by archive.org. Handy for some Recon process. 
*TheHarvester*<br /> 
git clone https://github.com/laramies/theHarvester.git<br />
cd theHarvester<br />
sudo python3 -m pip install -r requirements.txt --ignore-installed<br />
sudo python3 -m pip install pipenv<br />
sudo python3 -m pip install webscreenshot<br />
sudo add-apt-repository -y ppa:micahflee/ppa<br />
sudo apt -y update


### Extra Information:
- _Although this repo is intended for Linux users, for the Windows users, "winget" tool can update the apps easily._ 
- **Tip for Windows Users:**
 ````winget upgrade --all --accept-package-agreements```` this command will update all the installed packages in a Windows PC. Since I generally use MacOs and Linux, I don't need to use this command much, but it is very handy. If you need, start a Powershell terminal and run this command. OR google it for extra uses. Some good info can be found here:
- https://learn.microsoft.com/en-us/windows/package-manager/winget/
- https://www.howtogeek.com/674470/how-to-use-windows-10s-package-manager-winget/
- https://github.com/microsoft/winget-cli
  


