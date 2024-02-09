#!/bin/bash
#emreybs(e3re)
# This Bash script is the shorter version of my other script: https://github.com/emreYbs/my-auto-install-bash-scripts/blob/main/Fedora/FedoraBasedDistros-Auto_Install.sh

# This bash script will install the required tools and make your system ready for use after a fresh install of Fedora Based Distros.
# Check if the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root!"
    echo "It needs root privileges to install the required tools properly."
    exit
fi


hostnamectl set-hostname myTestVM  # I like to change the hostname and for testing VM's, I changed the default hostname as a name like "myTestVM". Change according to your wish
sudo dnf update
sudo dnf --security update #At first, I only install security related updates since I generally work on a live VM and disk size can cause an issue on the Live CD
sudo dnf install firewalld
sudo systemctl start firewalld
sudo systemctl enable firewalld

#If you need to add some extra Desktop Environments, you can uncomment the one that you prefer
sudo dnf groupinstall "Xfce"

# For VM's, KDE and Gnome is a bit heavier in terms of resource usage. So this Bash script will only install Xfce since it is low on system.
# sudo dnf groupinstall "KDE Plasma Workspaces"  
# For Mac Os or Elemantary Linux like Desktop environment: sudo dnf groupinstall "Pantheon Desktop"

# Install Brave Browser
sudo dnf install dnf-plugins-core
sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo
sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
sudo dnf install brave-browser

# Install Librewolf Browser
sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
sudo dnf install librewolf

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


# If you prefer Flatpak version of Brave and flatpak is already installed, then use the command:
# flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
# flatpak install flathub com.brave.Browser

# Install Visual Studio Code if you want, then uncomment below:
#sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
#sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/vscode
#sudo dnf install -y code


# Install SublimeText
sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg #Install the GPG key
sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64
sudo dnf install sublime-text


# Create a standard user for better security
sudo useradd standard-user -s /bin/bash

# Set password for the standard user
sudo passwd standard-user

# Update the system, say no if you only work on a live CD, at least it is what I do:)
read -p "Do you want to update the system? (y/n) " update_choice
if [ "$update_choice" == "y" ]; then
    sudo dnf update -y
fi

echo "Some nice looking fonts will be installed..."
sudo dnf install -y 'google-roboto*' 'mozilla-fira*' fira-code-fonts

# If you need to back up, uncomment the line below. Since it will not fully work and back up on a VM use case, I just wrote thelines for others and commented the lines for my use case.
#sudo dnf install timeshift

echo "Everything is done! Enjoy your new Fedora Based Distro!"
echo "Exiting...and the system will reboot in 3 seconds..."
sleep 3
log "Installation process completed."
sudo reboot now
