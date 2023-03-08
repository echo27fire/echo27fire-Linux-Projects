#!/bin/bash
#
#
# variables
COCKPIT_STATUS=0


if [ whoami != root ]
    then echo "run this script with elevated privilages"
fi

if ! docker -v docker &>/dev/null
    then echo "docker is not installed"
         echo "now insatalling docker"
         
         sudo dnf update -y
         sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
         sudo dnf install docker-cd docker-ce-cli containerd.io -y
         sudo systemctl enable --now docker
    else echo " docker installed, confirming operation"
        if docker pull hello-world 1>2 
            then 
                echo "docker is working correctly"
            else
                2>./docker-install-err.log
                echo "docker is not working correctly"
        fi
fi

systemctl is-active --quiet cockpit.socket > "$COCKPIT_STATUS"
if [ "$COCKPIT_STATUS" != active ]
    then echo "cockpit is not running"
    sudo systemctl enable --now cockpit.socket &>/dev/null
    systemctl status cockpit.socket
    else echo "cockpit appears to be working"
fi

echo "now installing additional repos "
dnf install epel-release -y
dnf install elrepo-release -y
dnf update -y 
dnf makecache || echo "error with makecache"


