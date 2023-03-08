#!/bin/bash

# variables
D_PATH=/mnt/user/Downloads
N_PATH=NZB-complete
T_PATH=TOR-Complete
UNWANTED_PATH="$D_PATH/unwanted files"
TARGET_FILES=DEATH_STAR.TARGET

# functions

# filter function, checks if file is on allowed list of extenisoins
# if file is not allowed, moves file to the holding directory.
# Perhaps this can be imporved by using the command below, or passing the function to another function.
# find . -type f | xargs file_filter ?
function file_filter () {
    for FILE in *;
    do
    case $FILE in
    *.MP4 | *.mp4 ) 
    echo "MP4 file found" ;;
    *.AVI | *.avi ) 
    echo "AVI file foudn" ;;
    *.MKV | *.mkv ) 
    echo "MKV file found" ;;
    *.??? ) 
    echo "P.U.F. Located." && mv "$FILE" $UNWANTED_PATH  ;;
    esac
    done
}

# script body
cd $D_PATH || exit # sets location to the path where downloads are located 
if [ -d $N_PATH ] || [ -d $T_PATH ] # checks if the NZB and TOR complte folders exist. If not, script exits. 
then 
    echo "Folder location confirmed, starting attack run"
else
    echo "The folders are in another castle!"
    echo "##################################"
    echo " "
    echo "please confirm that all paths are correct, and target folders exist and named correctly" && quit
fi

if [ -d "$UNWANTED_PATH" ] # ensures that the unwanted files folder exists, if not, creates it.
then
    echo "staging location for unwanted files located"
else
    echo "staging location for unwanted files not found"
    echo "creating folder"
    mkdir -p "$UNWANTED_PATH" || echo "cannot create folder, exiting" && quit
fi

# this is where files start to get processed through functions.
echo "eyes are on the thermal exaust port! Fire torpedos!"
cd $N_PATH || exit
file_filter || echo "there was an error, quitting" && quit # runs filter function or exits if error.

cd $T_PATH || exit
file_filter || echo "there was an error, quitting" && quit # runs filter function or exits if error.

# end of file filtering

echo "Torpedos away!"
cd $D_PATH
ls -l $UNWANTED_PATH > $D_PATH/$TARGET_FILES
echo "CONFIRM TARGETS ARE CORRECT"
echo  

more $TARGET_FILES
echo "Can we fire the lazor?" answer
case $anser in 
Y | y ) echo "FIRE MAIN GUN" && rm  $D_PATH/$UNWANTED_PATH/* ;;
N | n ) echo "THE REBELS BLEW UP THE DEATH STAR!!!!" && quit ;;
esac