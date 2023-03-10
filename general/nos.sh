#!/bin/bash
# Taylor Goodspeed
# Feb 14, 2022
#
#
#
#
# in class script 3 activity
#
# conditions and loops
# 
# 1. if script dir exists, no not make new dir
# 2. verify the directory is empty before doing anything else
# 3. create multiple files with a loop [for, while, untill]
#
#global vars
DIR=script3
NAME="taylor goodspeed"
x=0
n=1
# script start
echo "-------------------------------------"
echo "-------------------------------------"
echo "Starting script"
#part 1, if the script folder does not exist, make it, otherwise do nothing.
if [ -d ~/"$DIR" ]
then
	echo "that dir exists"
else
	mkdir ~/"$DIR"
fi