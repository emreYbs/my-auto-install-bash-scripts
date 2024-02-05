#!/bin/bash
# This is a good Firefox fork and for web application security testing, it is better to try various browsers.

# Check if user wants to install Firefox fork called Floorp Browser
read -p "Do you want to install Floorp Browser, a fork of Firefox? (y/n): " install_floorpbrowser

if [[ $install_floorpbrowser == "y" ]]; then

curl -fsSL https://ppa.ablaze.one/KEY.gpg | sudo gpg --dearmor -o /usr/share/keyrings/Floorp.gpg
sudo curl -sS --compressed -o /etc/apt/sources.list.d/Floorp.list 'https://ppa.ablaze.one/Floorp.list'
sudo apt update
sudo apt install floorp
echo "You can check the official site for Floorp Browser here:https://floorp.app/en/"
echo "Finished.Exitting..."
exit
