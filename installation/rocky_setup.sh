#!/bin/bash

# variables
CHECKMK='https://download.checkmk.com/checkmk/2.1.0p4/check-mk-raw-2.1.0p4-el8-38.x86_64.rpm'
DIR=checkmk-tmp

# repo installs
dnf install epel-release -y
dnf install elrepo-release -y
dnf install rpmfusion-free-release -y
dnf update -y
dnf makecache
echo 'repo and update process complete'

# install cockpit
dnf install cockpit -y
systemctl enable --now cockpit.socket
echo 'cockpit configured'

# disable firewalld and install ufw
systemctl disable --now firewalld.service
dnf install ufw -y
systemctl enable --now ufw.service
ufw disable
ufw allow http
ufw allow https
ufw allow ssh
ufw allow 9090
ufw enable
echo 'ufw enabbled'

# install checkmk
cd /tmp 
mkdir ./$DIR
cd $DIR
sudo setsebool -P httpd_can_network_connect on
sudo dnf --enablerepo=powertools install graphviz-gd -y
wget $CHECKMK
sudo dnf install ./$CHECKMK 2>/tmp/$DIR/error