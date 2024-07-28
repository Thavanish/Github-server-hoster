#!/bin/bash
clear
pwd
var=$(pwd)
basename $(pwd)
mydir="$(basename $PWD)"
echo "starting install...."
sudo su 
apt update && apt upgrade -y
apt install git curl nano sudo wget sudo -y
echo "installing docker..."

# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
echo "testing docker.."
echo "check if any output is shown as expected if not stop the script and check it out .."
echo "sleep +10"
sleep 10
clear
echo "installing pufferpanel..."
sleep 2
mkdir -p /var/lib/pufferpanel
docker volume create pufferpanel-config
docker create --name pufferpanel -p 8080:8080 -p 5657:5657 -v pufferpanel-config:/etc/pufferpanel -v /var/lib/pufferpanel:/var/lib/pufferpanel -v /var/run/docker.sock:/var/run/docker.sock --restart=on-failure pufferpanel/pufferpanel:latest
docker start pufferpanel
docker exec -it pufferpanel /pufferpanel/pufferpanel user add
echo "to start type gserver in the cli."
cd
echo "alias gserver='bash ${mydir}/start.sh'" > .bashrc
echo "complete!"










sleep 1
