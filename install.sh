#!/bin/bash


#
# update
#
sudo apt-get -y update



#
# basic
#
sudo apt-get install -f unzip htop make curl



#
# docker
#
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"
sudo apt update
apt-cache policy docker-ce
sudo apt install -y docker-ce
sudo groupadd docker
sudo usermod -aG docker $USER



#
# docker compose
#
sudo curl -L "https://github.com/docker/compose/releases/download/1.26.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose



#
# netboot
#
sudo apt-get install -y dnsmasq webfs



#
# copy kiosk image
#
KIOSKDIR=`pwd`/kiosk
mkdir -p $KIOSKDIR
cd $KIOSKDIR; curl -O https://download.weshinetech.in/kiosk/kiosk.iso
