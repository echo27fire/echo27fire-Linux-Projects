#!/bin/bash

$v1 vars
DBDIR=/mnt/user/PlexData/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/
DB=com.plexapp.plugins.library.db
BACKUPDIR=/mnt/user/backups/plex/
DATE=$(date "+%Y-%m-%d")

#v2 vars
DB=/mnt/user/PlexData/Library/Application\ Support/Plex\ Media\ Server/Plug-in\ Support/Databases/com.plexapp.plugins.library.db
BU=/mnt/user/backups/plex/com.plexapp.plugins.library.db-$DATE

cp $DB $BU

'



# v1
#cd "$DBDIR" || exit
#cp $DB $BACKUPDIR
#cd $BACKUPDIR || exit
#mv $DB $DB-"$DATE" 
