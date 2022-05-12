#!/bin/bash
#emreybs 2022

# My recommendation is nearly always have a fresh install. 
# Yet, if you need to upgrade to Fedora 36 from 35, these will help.

echo "This simple script will upgrade Fedora 35 to Fedora 36 Workstation"
sleep 2
echo "However, I recommend a fresh install,it tends to be more stable that way.."
sleep 3
echo "Anyway, I will install:)"

sudo dnf upgrade --refresh
sudo dnf install dnf-plugin-system-upgrade
sudo dnf --refresh upgrade
sudo dnf system-upgrade download --releasever=36
sudo dnf system-upgrade reboot

echo "Done"

# After Reboot, do these below (to remove cached metadata and transaction)

# dnf system-upgrade clean
# dnf clean packages
