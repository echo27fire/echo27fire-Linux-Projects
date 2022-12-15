#!/bin/bash

docker run -d --name mariadb \
 --restart=always \
 -p 3306:3306 \
 -e MARIADB_ROOT_PASSWORD=RtNBq26CnN \
 -e MARIADB_DATABASE=database1 \
 -e MARIADB_USER=tgoodspeed \
 -e MARIADB_PASSWORD=aYBrMB4KT6 \
 -v /appdata/mariadb/data:/var/lib/mysql \
 -v /appdata/mariadb/config:/etc/mysql/conf.d \
 mariadb:latest
