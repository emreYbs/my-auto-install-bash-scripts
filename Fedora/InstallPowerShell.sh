#!/bin/bash
#emreybs
# If you don't like Powershell or do not need it on Linux, you can always remove it: sudo dnf remove powershell
# Since I try to switch careers to cybersecurity, I try to practise Powershell and I liked it:).
# If you are also into infoSec, I recommend you should learn Powershell. 
# Otherwise, Bash will be more than enough and no need to install Powershell on Linux:)

# First we need to add Microsoft signature key
sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc

# Now let's add the Microsoft RedHat repository-since it is Fedora:)
curl https://packages.microsoft.com/config/rhel/7/prod.repo | sudo tee /etc/yum.repos.d/microsoft.repo

sudo dnf update

sudo dnf install  powershell -y

echo "Done"

# When needed, Write in the terminal this command to start Powershell: pwsh

