#!/bin/bash
 
#

#variables

COCKPIT=cockpit.socket

DOCKER=docker.service



#checks if cockpit is running
sudo systemctl is-active $COCKPIT; echo $? > "$STAT"
if [ -z "$STAT" ]
then
    echo "STATUS not set" && quit
else
    if [ "$STAT" != 0 ]
    then
    echo "cockpit is not running or not installed"
    else
    echo "cockpit is running"
    fi
fi


#checks if docker is running
unset "$STAT"
sudo systemctl is-active $DOCKER; echo $? > "$SATUS"
if [ -z "$STAT" ]
then
    echo "STATUS not set" && quit
else
    if [ "$STAT" != 0 ]
    then
    echo "docker is not running or not installed"
    else
    echo "docker is running"
    fi
fi