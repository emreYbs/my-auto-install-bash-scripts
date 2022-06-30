#!/bin/bash

#First, let's remove libreoffice. Be root or get superuser to do so
dnf remove libreoffice*
dnf clean all

# Install onlyoffice on Fedora
echo [onlyoffice]>/etc/yum.repos.d/onlyoffice.repo
echo name=onlyoffice repo>>/etc/yum.repos.d/onlyoffice.repo
echo baseurl=https://download.onlyoffice.com/repo/centos/main/noarch/>>/etc/yum.repos.d/onlyoffice.repo
echo gpgcheck=0>>/etc/yum.repos.d/onlyoffice.repo
echo enabled=1>>/etc/yum.repos.d/onlyoffice.repo
dnf install onlyoffice-desktopeditors -y
echo 'Finished'
