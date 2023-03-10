#!/bin/bash
#
#
# variables

COCKPIT=cockpit.socket
DOCKER=docker.service
LOG=./installer.log

# functions
function COCKPIT_STATUS (){
    systemctl is-active --quiet cockpit.socket > "$STATUS1"
}

function COCKPIT_LISTEN () {
    sudo lsof -i -P -n | grep 9090 | grep LISTEN >"$STATUS2"
}

function DOCKER_STATUS () {
    systemctl is-active --quiet $DOCKER
}

echo ' ' > $LOG

echo "now installing additional repos "
dnf install epel-release -y
dnf install elrepo-release -y
dnf update -y 
dnf makecache || echo "error with makecache" >> $LOG

cat "status of cockpit is $STATUS1" < COCKPIT_STATUS 
cat "status of docker is $STATUS2" < DOCKER_STATUS 

if [ "$STATUS1" == 'active' ]
then
    echo "cockpit appears working, no further action"
else
    echo "cockpit is not working, enableing"
    systemctl enable --now $COCKPIT || echo "error starting cockpit service" >> $LOG
fi

if [ "$STATUS2" == 'active' ]
then
    echo "docker appears to be running"
else
    echo "docker does not appear to be running or installed"
          sudo dnf update -y
          sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
          sudo dnf install docker-cd docker-ce-cli containerd.io -y --allow-erasing
          sudo systemctl enable --now docker || echo "error installing docker" >> $LOG
          echo "docker should be installed"
fi




# if [ whoami != root ]
#     then echo "run this script with elevated privilages"
# fi

# if ! docker -v docker &>/dev/null
#     then echo "docker is not installed"
#          echo "now insatalling docker"
         
#          sudo dnf update -y
#          sudo dnf config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
#          sudo dnf install docker-cd docker-ce-cli containerd.io -y --allow-erasing
#          sudo systemctl enable --now docker
#     else echo " docker installed, confirming operation"
#         if docker pull hello-world 1>2 
#             then 
#                 echo "docker is working correctly"
#             else
#                 2>./docker-install-err.log
#                 echo "docker is not working correctly"
#         fi
# fi

# #COCK_STATUS=(COCKPIT_STATUS)

# #case $COCK_STATUS in 
# #active ) echo "cockpit is active and running" ;;
# #inactive ) systemctl enable --now cockpit.socket ;;
# #*) echo " cockpit status could not be determined" ;;
# #esac

# if ! COCKPIT_LISTEN
# if [ COCKIT_STATUS == active ]
# systemctl is-active cockpit.socket > $COCKPIT_STATUS
# if [ "$COCKPIT_STATUS" != active ]
#     then 
#         echo "cockpit appears to be working"
#         systemctl status cockpit.socket
#     else 
#         echo "cockpit is not running"
#         sudo systemctl enable --now cockpit.socket &>/dev/null
#         systemctl status cockpit.socket
#fi




