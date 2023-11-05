#!/bin/bash
#emreYbs

# WORK in Progress. There are some minor issues with the latest UBUNTU 23.10 in Budgie desktop. So I test regulary and will optimize it very soon.
# Here is the script in progress. NOT COMPLETED, not Refactored yet.
# Beware again, you can encounter some errors and also it's kind of spagetti code which I need to refactor. Some dublicates in the script.
# For now, I love to test new Linux distros with my custom auto scripts.

# Ubuntu23.10_install_tools.sh
# FILEPATH: Ubuntu23.10_install_tools.sh
# DESCRIPTION: This script installs or unsinstalls some tools and modify the new Ubuntu 23.10 installation.


    # Remove preinstalled software if user inputs "yes"
    read -p "Do you want to remove preinstalled software? (yes/no): " remove_software
    if [ "$remove_software" == "yes" ]; then
        if dpkg -s gnome-mines gnome-mahjongg gnome-sudoku libreoffice* thunderbird >/dev/null 2>&1; then
            sudo apt-get remove gnome-mines gnome-mahjongg gnome-sudoku libreoffice* thunderbird -y
        else
            echo "The software is not preinstalled. Skipping removal..."
        fi
    else
        echo "Skipping removal of preinstalled software..."
    fi
    
read -p "Do you want to update the system? (yes/no): " update

# Prompt user to update the system
# Update the system if user inputs "yes"
if [ "$update" == "yes" ]; then
    sudo apt update && sudo apt upgrade -y
    echo "System updated successfully."
else
    echo "Skipping system update."
fi


# Prompt user to enable security settings
read -p "Do you want to enable security settings? (yes/no): " security

# Check if system is up-to-date
if [ "$(sudo apt-get -s dist-upgrade | grep '0 upgraded')" ]; then
    echo "System is already up-to-date."
    read -p "Do you want to skip system update and continue with configuration? (yes/no): " skip_update
    if [ "$skip_update" == "yes" ]; then
        echo "Skipping system update."
    else
        sudo apt update && sudo apt upgrade -y
        echo "System updated successfully."
    fi
else
    sudo apt update && sudo apt upgrade -y
    echo "System has been updated successfully."
fi

    echo  "Installing and configuring the firewall"
    echo "Deny incoming SSH, FTP, and other connections"
    sudo apt-get install ufw -y
    sudo ufw default deny incoming
    sudo ufw allow out 22/tcp #if SSH not needed, then remove this line or 'comment' this line
    sudo ufw allow out 80/tcp
    sudo ufw allow out 443/tcp
    echo "Enabling the firewall"
    sudo ufw enable
    sudo ufw status

    echo "Disabling unnecessary services and removing unnecessary packages."
    sudo systemctl disable bluetooth.service
    sudo systemctl disable cups.service
    sudo apt-get remove gnome-sudoku gnome-mines gnome-mahjongg -y

    # Install and configure fail2ban
    sudo apt-get install fail2ban -y
    sudo cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local
    sudo systemctl enable fail2ban
    sudo systemctl start fail2ban
    
    # Install and configure AppArmor
    sudo apt-get install apparmor apparmor-utils -y
    sudo aa-enforce /etc/apparmor.d/*
    sudo systemctl enable apparmor
    sudo systemctl start apparmor

    # Install and configure auditd
    sudo apt-get install auditd -y
    sudo systemctl enable auditd
    sudo systemctl start auditd

    # Install Firejail and firejail tools
    sudo apt-get install firejail firetools -y

    
read -p "Do you want to update the system? (yes/no): " update

# Prompt user to update the system
# Update the system if user inputs "yes"
if [ "$update" == "yes" ]; then
    sudo apt update && sudo apt upgrade -y
    echo "System updated successfully."
else
    echo "Skipping system update."
fi

# Prompt user to enable security settings
read -p "Do you want to enable security settings? (yes/no): " security

# Check if system is up-to-date
if [ "$(sudo apt-get -s dist-upgrade | grep '0 upgraded')" ]; then
    echo "System is already up-to-date."
    read -p "Do you want to skip system update and continue with configuration? (yes/no): " skip_update
    if [ "$skip_update" == "yes" ]; then
        echo "Skipping system update."
    else
        sudo apt update && sudo apt upgrade -y
        echo "System updated successfully."
    fi
else
    sudo apt update && sudo apt upgrade -y
    echo "System has been updated successfully."
fi

    # Install and configure VPN if user inputs "yes"
    if [ "$security" == "yes" ]; then
        apt-get install openvpn -y
        systemctl enable openvpn
        systemctl start openvpn
    else
        echo "Skipping security settings..."
    fi

    # Install FLATPAK support if user inputs "yes"
    read -p "Do you want to install FLATPAK support? (y/n)" flatpak_answer
    if [ "$flatpak_answer" == "y" ]; then
        apt install flatpak
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        echo "FLATPAK support installed successfully."
        echo "Please reboot your system to apply changes."
        read -p "Do you want to reboot now? (y/n)" reboot_answer
        if [ "$reboot_answer" == "y" ]; then
            reboot
        fi
    fi

    echo "FLATPAK support has been added successfully."

    # Install selected tools
    echo "Which tools would you like to install?"
    echo "1. PyCharm Community IDE"
    echo "2. Sublime Text"
    echo "3. Thonny"
    echo "4. VS Code"
    echo "5. Jupyter Notebook"
    echo "6. None"
    read -p "Enter comma-separated numbers of tools to install (e.g. 1,3,4): " tools
    IFS=',' read -ra tool_array <<< "$tools"
    for tool in "${tool_array[@]}"; do
        case $tool in
            1)
                echo "Do you want to install PyCharm Community IDE via Snap or Flatpak?"
                read -p "Enter 'snap' or 'flatpak': " pycharm_install_method
                if [ "$pycharm_install_method" == "snap" ]; then
                    snap install pycharm-community --classic
                elif [ "$pycharm_install_method" == "flatpak" ]; then
                    flatpak install flathub com.jetbrains.PyCharm-Community
                else
                    echo "Invalid input. Exiting."
                    exit 1
                fi
                ;;
            2)
                echo "Do you want to install Sublime Text via Snap or Flatpak?"
                read -p "Enter 'snap' or 'flatpak': " sublime_install_method
                if [ "$sublime_install_method" == "snap" ]; then
                    snap install sublime-text --classic
                elif [ "$sublime_install_method" == "flatpak" ]; then
                    flatpak install flathub com.sublimetext.three
                else
                    echo "Invalid input. Exiting."
                    exit 1
                fi
                ;;
            3)
                echo "Do you want to install Thonny via Snap or Flatpak?"
                read -p "Enter 'snap' or 'flatpak': " thonny_install_method
                if [ "$thonny_install_method" == "snap" ]; then
                    snap install thonny
                elif [ "$thonny_install_method" == "flatpak" ]; then
                    flatpak install flathub com.thonny.Thonny
                else
                    echo "Invalid input. Exiting."
                    exit 1
                fi
                ;;
            4)
                echo "Do you want to install VS Code via Snap or Flatpak?"
                read -p "Enter 'snap' or 'flatpak': " vscode_install_method
                if [ "$vscode_install_method" == "snap" ]; then
                    snap install code --classic
                elif [ "$vscode_install_method" == "flatpak" ]; then
                    flatpak install flathub com.visualstudio.code
                else
                    echo "Invalid input. Exiting."
                    exit 1
                fi
                ;;
            5)
                echo "Do you want to install Jupyter Notebook via Snap or Flatpak?"
                read -p "Enter 'snap' or 'flatpak': " jupyter_install_method
                if [ "$jupyter_install_method" == "snap" ]; then
                    snap install jupyter
                elif [ "$jupyter_install_method" == "flatpak" ]; then
                    flatpak install flathub org.jupyter.Jupyter
                else
                    echo "Invalid input. Exiting."
                    exit 1
                fi
                ;;
            6)
                echo "No tools selected. Exiting."
                exit 0
                ;;
            *)
                echo "Invalid input. Exiting."
                exit 1
                ;;
        esac
    done

    # Install selected browsers
    echo "Which browsers would you like to install?"
    echo "1. Librewolf"
    echo "2. Vivaldi"
    echo "3. Microsoft Edge"
    echo "4. Google Chrome"
    echo "5. None"
    read -p "Enter comma-separated numbers of browsers to install (e.g. 1,3,4): " browsers
    IFS=',' read -ra browser_array <<< "$browsers"
    for browser in "${browser_array[@]}"; do
        case $browser in
            1)
                flatpak install flathub org.librewolf.LibreWolf -y
                ;;
            2)
                wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | apt-key add -
                add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
                apt-get update
                apt-get install vivaldi-stable -y
                ;;
            3)
                curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
                install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
                sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
                rm microsoft.gpg
                apt update
                apt install microsoft-edge-dev -y
                ;;
            4)
                wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
                dpkg -i google-chrome-stable_current_amd64.deb
                apt-get install -f -y
                rm google-chrome-stable_current_amd64.deb
                ;;
            5)
                echo "No browsers selected. Exiting."
                exit 0
                ;;
            *)
                echo "Invalid input. Exiting."
                exit 1
                ;;
        esac
    done

# Function to handle errors
function handle_error() {
    echo "Error on line $1"
    exit 1
}

# Trap Ctrl+C to stop execution
trap "exit 1" INT

# Set error handling
set -e
trap 'handle_error $LINENO' ERR

# Update and upgrade system
sudo apt update
sudo apt upgrade -y

# Install common tools
sudo apt install -y git curl wget

# Install selected programming languages
# Ask user if they want to install programming languages
read -p "Do you want to install programming languages? (y/n): " install_languages

if [[ $install_languages == "y" ]]; then
    # Install selected programming languages
    echo "Which programming languages would you like to install?"
    echo "1. Python"
    echo "2. Node.js"
    echo "3. Golang"
    echo "4. None"
    read -p "Enter comma-separated numbers of programming languages to install (e.g. 1,2): " languages
    IFS=',' read -ra language_array <<< "$languages"
    for language in "${language_array[@]}"; do
        case $language in
            1)
                sudo apt install -y python3 python3-pip
                ;;
            2)
                curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
                sudo apt-get install -y nodejs
                ;;
            3)
                sudo apt install -y golang-go
                ;;
            4)
                echo "No programming languages selected."
                ;;
            *)
                echo "Invalid input. Exiting."
                exit 1
                ;;
        esac
    done
fi

echo "1. Python"
echo "2. Node.js"
echo "3. Golang"
echo "4. None"
read -p "Enter comma-separated numbers of programming languages to install (e.g. 1,2): " languages
IFS=',' read -ra language_array <<< "$languages"
for language in "${language_array[@]}"; do
    case $language in
        1)
            sudo apt install -y python3 python3-pip
            ;;
        2)
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
            ;;
        3)
            sudo apt install -y golang-go
            ;;
        4)
            echo "No programming languages selected."
            ;;
        *)
            echo "Invalid input. Exiting."
            exit 1
            ;;
    esac
done

# Install selected office suite
echo "Do you want to install LibreOffice or OnlyOffice?"

echo "3. None"
read -p "Enter comma-separated numbers of programming languages to install (e.g. 1,2): " languages
IFS=',' read -ra language_array <<< "$languages"
for language in "${language_array[@]}"; do
    case $language in
        1)
            sudo apt install -y python3 python3-pip
            ;;
        2)
            curl -fsSL https://deb.nodesource.com/setup_lts.x | sudo -E bash -
            sudo apt-get install -y nodejs
            ;;
        3)
            echo "No programming languages selected."
            ;;
        *)
            echo "Invalid input. Exiting."
            exit 1
            ;;
    esac
done

# Install selected office suite
echo "Do you want to install LibreOffice or OnlyOffice?"
read -p "Enter 'libreoffice' or 'onlyoffice': " office_suite
if [ "$office_suite" == "libreoffice" ]; then
    sudo apt install -y libreoffice
elif [ "$office_suite" == "onlyoffice" ]; then
    sudo apt install -y onlyoffice-desktopeditors
else
    echo "Invalid input. Exiting."
    exit 1
fi

# Install selected programming tools
echo "Which programming tools would you like to install?"
echo "1. PyCharm Community Edition"
echo "2. Thonny"
echo "3. VS Code"
echo "4. Jupyter Notebook"
echo "5. None"
read -p "Enter comma-separated numbers of programming tools to install (e.g. 1,3,4): " tools
IFS=',' read -ra tool_array <<< "$tools"
for tool in "${tool_array[@]}"; do
    case $tool in
        1)
            sudo snap install pycharm-community --classic
            ;;
        2)
            echo "Do you want to install Thonny via Snap or Flatpak?"
            read -p "Enter 'snap' or 'flatpak': " thonny_install_method
            if [ "$thonny_install_method" == "snap" ]; then
                sudo snap install thonny
            elif [ "$thonny_install_method" == "flatpak" ]; then
                sudo flatpak install flathub com.thonny.Thonny
            else
                echo "Invalid input. Exiting."
                exit 1
            fi
            ;;
        3)
            echo "Do you want to install VS Code via Snap or Flatpak?"
            read -p "Enter 'snap' or 'flatpak': " vscode_install_method
            if [ "$vscode_install_method" == "snap" ]; then
                sudo snap install code --classic
            elif [ "$vscode_install_method" == "flatpak" ]; then
                sudo flatpak install flathub com.visualstudio.code
            else
                echo "Invalid input. Exiting."
                exit 1
            fi
            ;;
        4)
            echo "Do you want to install Jupyter Notebook via Snap or Flatpak?"
            read -p "Enter 'snap' or 'flatpak': " jupyter_install_method
            if [ "$jupyter_install_method" == "snap" ]; then
                sudo snap install jupyter
            elif [ "$jupyter_install_method" == "flatpak" ]; then
                sudo flatpak install flathub org.jupyter.Jupyter
            else
                echo "Invalid input. Exiting."
                exit 1
            fi
            ;;
        5)
            echo "No tools selected."
            ;;
        *)
            echo "Invalid input. Exiting."
            exit 1
            ;;
    esac
done

# Install selected browsers
echo "Which browsers would you like to install?"
echo "1. Librewolf"
echo "2. Vivaldi"
echo "3. Microsoft Edge"
echo "4. Google Chrome"
echo "5. None"
read -p "Enter comma-separated numbers of browsers to install (e.g. 1,3,4): " browsers
IFS=',' read -ra browser_array <<< "$browsers"
for browser in "${browser_array[@]}"; do
    case $browser in
        1)
            sudo flatpak install flathub org.librewolf.LibreWolf -y
            ;;
        2)
            wget -qO- https://repo.vivaldi.com/archive/linux_signing_key.pub | sudo apt-key add -
            sudo add-apt-repository 'deb https://repo.vivaldi.com/archive/deb/ stable main'
            sudo apt-get update
            sudo apt-get install vivaldi-stable -y
            ;;
        3)
            curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
            sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
            sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/edge stable main" > /etc/apt/sources.list.d/microsoft-edge-dev.list'
            rm microsoft.gpg
            sudo apt update
            sudo apt install microsoft-edge-dev -y
            ;;
        4)
            wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
            sudo dpkg -i google-chrome-stable_current_amd64.deb
            sudo apt-get install -f -y
            rm google-chrome-stable_current_amd64.deb
            ;;
        5)
            echo "No browsers selected."
            ;;
        *)
            echo "Invalid input. Exiting."
            exit 1
            ;;
    esac
done

echo "Unnecessary or no longer needed packages will be autoremoved now..."
sudo apt autoremove

echo "Installation has finally completed."
echo "Please reboot your system to apply changes."
read -p "Do you want to reboot now? (y/n)" reboot_answer
if [ "$reboot_answer" == "y" ]; then
    reboot
fi



