#!/bin/bash
# Vars
USER=$(whoami) # the user runninhg the script
smbdir=/home/share/ # main path to smb shares
TICK=$smbdir/TICK # path to influxdb share
SMBCONF=smb.conf # file name for smb main config file
SMBGRP=sambashare # group for samba users

# Functions
# just makes a banner
function banner () {
echo "----------------------------------------------------------"
}

# System Update
function update () {
sudo apt update || echo "error with update process"
sudo apt upgrade -y || echo "error with upgrade process"
}

# Makes a Backup for the initial config
function smb-backup () {
sudo cp /etc/samba/smb.conf{,.backup}
}

# Blanks any existing files
function smb-blank () {
  #blanks out config files
  sudo echo ' ' > ~/$SMBCONF # blanks out existing custom conf file if it exists change to if statement?
  sudo echo ' ' > ~/$SMBSHARE # blanks out existing custom conf file if it exists change to if statement?
}

# Installs SAMBA
function smb-dl () {
sudo apt update -y
sudo apt -y install samba

}

# Make DIRs for shares
function smb-makeshare (){
sudo mkdir -p  $TICK
}

#-----------------------------------------------#
#						#
#	functions for making config files	#
#						#
#						#
#-----------------------------------------------#

function smbstart (){
sudo systemctl restart smbd nmbd
}


function smb-conf (){

cat << EOF >> ~/$USER/$SMBCONF
# Configure correct UTP
  unix charset = UTF-8
# Change this to the workgroup/NT-domain name your Samba server will be part of
   workgroup = WORKGROUP
   bind interfaces only = yes

# Set share configuration at the end
[noc]
path = $SMBDIR/noc
read only = no
browseable = yes
force create mode = 0777
force directory mode = 0777
valid users = noc


EOF
}


#-----------------------------------------------#
#                                               #
#       	start of script   	        #
#                                               #
#                                               #
#-----------------------------------------------#
# Phase 1 - Install
smb-dl
smb-backup
smb-makeshare
smb-conf
sudo chgrp $SMBGRP $smbdir


#Phase 2 - mkdirs and setup ownership / permissions
sudo mkdir -p $smbdir/noc $smbdir/noc/win $smbdir/noc/linux $smbdir/noc/vcsa
sudo useradd -M -d $smbdir/noc -s /user/sbin/nologin -G $SMBGRP noc
sudo chown -R noc:$SMBGRP $smbdir
sudo chmod 2777 /mnt/samba/noc

#configure user login
sudo smbpasswd -a noc
sudo smbpasswd -e noc


# end of script - restart samba service
smbstart

