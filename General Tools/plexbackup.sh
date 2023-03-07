#!/bin/bash
# variables
DBPATH='/mnt/user/PlexData/Library/Application Support/Plex Media Server/Plug-in Support/Databases'
BUPATH=/mnt/user/backups/plex/$BU
BU=$DATE
DATE=$(date "+%Y-%m-%d")

echo '$FLDR'
echo 'starting backup'
mkdir -p "$BUPATH" || exit;echo 'error making backup folder'
cp "$DBPATH"/* "$BUPATH"
