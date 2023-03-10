#!/bin/bash
#
#
# Script goal: to hung for any files not audio, picture, or video in Unraid Download Folder.
# 

COMPLETE_NZB=/mnt/user/Downloads/NZB-complete    # path to complete NZB files
COMPLETE_TOR=/mnt/user/Downloads/Deluge-Complete # path to complete TOR files
DL_PATH=/mnt/user/Downloads/ # path to downlod folder in general

###########################################################################
#
# folder test: ensures that directorys for complete NZB and TOR files exist.
# 
###########################################################################

[ -d "$COMPLETE_NZB" ] && echo "complete nzb folder exists"  || echo "$COMPLETE_NZB does not exist" && quit
echo " Starting the hunt for bad files in $COMPLETE_NZB"










###########################################################################
#
# folder test: ensures that directorys for complete NZB and TOR files exist.
# 
###########################################################################

[ -d "$COMPLETE_TOR" ] && echo "complete tor folder exists"  || echo "$COMPLETE_TOR does not exist" && quit
echo " Starting the hunt for bad files in $COMPLETE_TOR"