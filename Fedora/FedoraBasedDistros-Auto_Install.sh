#!/bin/bash
#emreybs

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
echo -e "\e[1;32mWelcome to the Fedora Based Distros Auto Install Script by emreYbs\e[0m"
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

# Create a standard user for better security
sudo useradd standard-user -s /bin/bash

# Set password for the standard user
sudo passwd standard-user

# Check if LibreOffice Suite is installed. I generally uninstall it and install Only Office instead.
if rpm -q libreoffice-core >/dev/null; then
    read -p "Do you want to uninstall LibreOffice Suite and install Only Office instead? (y/n) " libreoffice_choice
    if [ "$libreoffice_choice" == "y" ]; then
        sudo dnf remove -y libreoffice*
        flatpak install flathub org.onlyoffice.desktopeditors -y
        #If you get this error: ""error: Unable to load summary from remote flathub: "Can't fetch summary from disabled remote 'flathub,"
        # FIX: you can enable flathub with this command: flatpak remote-modify --enable flathub"
    fi
fi

# Update the system before starting
read -p "Do you want to update the system? (y/n) " update_choice
if [ "$update_choice" == "y" ]; then
    sudo dnf update -y
fi

echo "Some packages will be installed to make the system ready for use..."
sudo dnf upgrade --refresh
sudo dnf install -y dnf-plugin-fastestmirror # Install the fastest mirror plugin.
# Script can give error here on some distros.But it is not a problem.
sudo sed -i 's/enabled=0/enabled=1/' /etc/dnf/plugins/fastestmirror.conf
# Modify the DNF configuration file to increase the number of parallel downloads
sudo sed -i 's/^max_parallel_downloads=.*/max_parallel_downloads=6/' /etc/dnf/dnf.conf
sudo dnf install dnf5 dnf5-plugins

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

# Ask the user if they want to enable DVD support
read -p "Do you want to enable DVD support? (y/n) " dvd_choice
if [ "$dvd_choice" == "y" ]; then
    # Enable the RPM Fusion tainted repository and install libdvdcss
    sudo dnf install -y rpmfusion-free-release-tainted
    sudo dnf install -y libdvdcss
fi

sudo dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

# Install the required tools
sudo dnf install -y git curl wget
sudo dnf install firetools -y # Install Firetools for security and privacy reasons for sandboxing.

# Ask the user if they want to install the Flatpak or distro repo version of the web browsers
read -p "Do you want to install the Flatpak or distro repo version of the web browsers? (flatpak/distro) " browser_choice
if [ "$browser_choice" == "flatpak" ]; then
    # Install the Flatpak versions of the web browsers
    flatpak install -y flathub org.librewolf.LibreWolf # LibreWolf is a fork of Firefox and even better, more privacy focused.
    # You can sometimes get an error like this: Nothing matches org.librewolf.LibreWolf in remote flathub
    # If you get this error, you can install LibreWolf from the repository or try this:flatpak install flathub io.gitlab.librewolf-community
    flatpak install -y flathub com.brave.Browser
    flatpak install -y flathub com.vivaldi.Vivaldi #Flatpak version was missing when I wrote this script.
    # So install from here later. https://vivaldi.com/download/?platform=linux
else
    ## Install the distro repo versions of the web browsers
    # Librewolf is not in the official repo. So, I added the repo here.
    sudo rpm --import https://keys.openpgp.org/vks/v1/by-fingerprint/034F7776EF5E0C613D2F7934D29FBD5F93C0CFC3
    sudo dnf config-manager --add-repo https://rpm.librewolf.net/librewolf-repo.repo
    sudo dnf install librewolf                               # Install Librewolf. Script can give error here on some distros.But it is not a problem.
    sudo dnf config-manager --set-disabled rpm.librewolf.net # Disable the repo after installation.For added security and possible repo conflicts.
    #Check here for more info: https://librewolf-community.gitlab.io/
    #https://librewolf.net/installation/fedora/
    sudo dnf install -y brave-browser vivaldi-stable # Install Brave and Vivaldi
    #If you encounter errors in some Fedora based distros, download manually from the Official Websites of Vivaldi and Brave.

    #If you like or need to use Microsoft Edge Browser, then do these:
    # sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    # sudo dnf config-manager --add-repo https://packages.microsoft.com/yumrepos/edge
    #sudo dnf install microsoft-edge-stable

    # If you prefer Flakpak version of Edge, then do these:
    # sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    # flatpak install flathub com.microsoft.Edge -y
fi

# If you need Firefox Flatpak, you can install it from here. I don't need it. So, I commented out. But you can uncomment it if you prefer Flatpat version
# flatpak install flathub org.mozilla.firefox
# flatpak install flathub org.freedesktop.Platform.ffmpeg-full
# Install a firewall for Fedora and harden the system for security and privacy
sudo dnf install -y firewalld
sudo systemctl enable firewalld
sudo systemctl start firewalld
sudo firewall-cmd --permanent --add-service=ssh
sudo firewall-cmd --reload

# install the appstream-data package so that Gnome Software can be used to install GUI programs from RPM Fusion
# Ask the user if they want unrestricted Flathub apps
read -p "Do you want to enable unrestricted Flathub apps? (y/n) " flathub_unrestricted_choice
if [ "$flathub_unrestricted_choice" == "y" ]; then
    # Enable unrestricted Flathub apps
    flatpak remote-modify --enable flathub
fi
sudo dnf groupupdate core

sudo dnf swap ffmpeg-free ffmpeg --allowerasing
#You may get this error in some distros: Error:No match for argument: ffmpeg-free
#If you get this error, you can install ffmpeg from the repository or try this: sudo dnf install ffmpeg
# Also you may get this error: 'No match for group package "core" in any repository' Not important. You can ignore it.
# Install Additional Codec if you need. I sometimes need it for my work.But generally not needed.
# Act according to your own needs and uncomment the line if needed.
# sudo dnf install -y gstreamer1-libav gstreamer1-plugins-ugly gstreamer1-plugins-bad-freeworld
# sudo dnf groupupdate multimedia --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
# sudo dnf groupupdate sound-and-video

# Ask the user if they want to install compression tools
read -p "Do you want to install compression tools? (y/n) " compress_choice
if [ "$compress_choice" == "y" ]; then
    sudo dnf install -y unzip p7zip p7zip-plugins unrar
fi

# Ask the user if they want to install Transmission
read -p "Do you want to install the Torrenting tool Transmission? (y/n) " transmission_choice
if [ "$transmission_choice" == "y" ]; then
    # Give the user two options to choose from
    read -p "Do you want to install Transmission from the repository or Flatpak? (repo/flatpak) " transmission_installation_choice
    if [ "$transmission_installation_choice" == "repo" ]; then
        sudo dnf install -y transmission
    elif [ "$transmission_installation_choice" == "flatpak" ]; then
        flatpak install flathub com.transmissionbt.Transmission
    fi
fi

echo "Some nice looking fonts will be installed..."
sudo dnf install -y 'google-roboto*' 'mozilla-fira*' fira-code-fonts

# Ask the user if they use a laptop
read -p "Do you use a laptop? (y/n) " laptop_choice
if [ "$laptop_choice" == "y" ]; then
    # Ask the user if they want to enable battery optimization tool
    read -p "Do you want to enable battery optimization tool? (y/n) " tlp_choice
    if [ "$tlp_choice" == "y" ]; then
        sudo dnf install -y tlp tlp-rdw
    fi
fi

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
        sudo dnf config-manager --add-repo https://repo.protonvpn.com/fedora/protonvpn-stable.repo
        sudo dnf install -y protonvpn
        ;;
    4)
        # Install NordVPN
        sudo rpm --import https://repo.nordvpn.com/gpg/nordvpn_public.asc
        sudo sh -c "echo 'deb https://repo.nordvpn.com/yum/rpm/stable/main/x86_64/' > /etc/yum.repos.d/nordvpn.repo"
        sudo dnf install -y nordvpn
        ;;
    *)
        echo "Invalid choice. No VPN will be installed."
        ;;
    esac
fi

# Ask the user if they want to install a password manager
read -p "Do you want to install a password manager? (y/n) " password_manager_choice
echo "If you don't need password manager, just press n"
if [ "$password_manager_choice" == "y" ]; then
    # Ask the user if they want to install a password manager
    read -p "Do you want to install a password manager? (y/n) " password_manager_choice
    echo "If you don't need password manager, just press n"
    if [ "$password_manager_choice" == "y" ]; then
        # user has three options to choose from. Why 3, well free and open source, the better. :)
        echo "Choose a password manager to install:"
        echo "1. Keepass"
        echo "2. Keepassxc"
        echo "3. Bitwarden"
        read -p "Enter your choice (1-3): " password_manager_installation_choice
        case $password_manager_installation_choice in
        1)
            # Install Keepass
            sudo dnf install -y keepass
            ;;
        2)
            # Install Keepassxc
            sudo dnf install -y keepassxc
            ;;
        3)
            # Give the user two options to choose from
            read -p "Do you want to install Bitwarden from the repository or Flatpak? (repo/flatpak) " bitwarden_installation_choice
            if [ "$bitwarden_installation_choice" == "repo" ]; then
                sudo dnf install -y bitwarden
            elif [ "$bitwarden_installation_choice" == "flatpak" ]; then
                flatpak install flathub com.bitwarden.desktop
            fi
            ;;
        *)
            echo "Invalid choice. No password manager will be installed."
            ;;
        esac
    fi

    # Ask the user if they want to install Snap support
    read -p "Do you want to install Snap support? (y/n) " snap_choice
    log "User chose to install Snap support: $snap_choice"
    if [ "$snap_choice" == "y" ]; then
        sudo dnf install -y snapd
        sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
        log "Installed Snap support."
    fi

    sudo dnf install gnome-boxes -y # Install Gnome Boxes if you want to use it.Or comment out if you don't want to install it.
    sudo dnf upgrade --refresh
    sudo dnf groupupdate core

    echo "Everything is done! Enjoy your new Fedora Based Distro!"
    echo "Exiting...and the system will reboot in 3 seconds..."
    sleep 3
    sudo reboot now

fi

# Ask the user if they want to install Snap support
read -p "Do you want to install Snap support? (y/n) " snap_choice
if [ "$snap_choice" == "y" ]; then
    sudo dnf install -y snapd
    sudo ln -s /var/lib/snapd/snap /snap # for classic snap support
fi

# Ask the user if they want to install Sublime Text
# Sublime Text is not open source. But is known to be safe and it's handy for developers.
read -p "Do you want to install Sublime Text? (y/n) " sublime_choice
if [ "$sublime_choice" == "y" ]; then
    # Download and install Sublime Text for Fedora
    sudo rpm -v --import https://download.sublimetext.com/sublimehq-rpm-pub.gpg
    sudo dnf config-manager --add-repo https://download.sublimetext.com/rpm/stable/x86_64/sublime-text.repo
    sudo dnf install -y sublime-text
fi

echo "Everything is done! Enjoy your new Fedora Based Distro!"
echo "Exiting...and the system will reboot in 3 seconds..."
sleep 3
log "Installation process completed."
sudo reboot now
