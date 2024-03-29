#!/bin/bash

#
# init
#
BASEDIR=`pwd`


#
# update
#
sudo apt-get -y update



#
# basic
#
sudo apt-get install -f unzip htop make curl net-tools



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
# disable resolved as we use dnsmasq
#
sudo systemctl stop systemd-resolved
sudo systemctl disable systemd-resolved



#
# update resolv.conf
#
sudo rm /etc/resolv.conf
echo nameserver 8.8.8.8 | sudo tee /etc/resolv.conf



#
# netboot
#
sudo apt-get install -y dnsmasq webfs



#
# copy kiosk image
#
KIOSKDIR=$BASEDIR/kiosk
mkdir -p $KIOSKDIR
cd $KIOSKDIR; curl -O https://download.weshinetech.in/kiosk/var.lib.kiosk.540.zip
unzip var.lib.kiosk.zip
sudo mkdir -p /var/lib/kiosk/
sudo cp -arv var/lib/kiosk/* /var/lib/kiosk/
cd $BASEDIR



#
# get uefi boot file and grub config
#
sudo mkdir -p /var/lib/kiosk/boot/grub
sudo cp $BASEDIR/grub/bootx64.efi /var/lib/kiosk/boot/
sudo cp $BASEDIR/grub/grub.cfg /var/lib/kiosk/boot/grub/
sudo chmod 777 /var/lib/kiosk/boot/grub/grub.cfg



#
# copy system configs
#
sudo cp $BASEDIR/rc.local /etc/rc.local
sudo cp $BASEDIR/configs/limits.conf /etc/security/limits.conf
sudo cp $BASEDIR/configs/sysctl.conf /etc/sysctl.conf
sudo cp $BASEDIR/configs/system.conf /etc/systemd/system.conf
sudo cp $BASEDIR/configs/user.conf /etc/systemd/user.conf
sudo sysctl -p



#
# install anydesk
#
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk-stable.list
sudo apt-get -y update
sudo apt-get install -y anydesk
cd $BASEDIR; wget http://ftp.us.debian.org/debian/pool/main/p/pangox-compat/libpangox-1.0-0_0.0.2-5.1_amd64.deb
sudo dpkg -i $BASEDIR/libpangox-1.0-0_0.0.2-5.1_amd64.deb



#
# disable wayland - required for anydesk to run properly
#
sudo sed -i 's/#WaylandEnable=.*$/WaylandEnable=false/g' /etc/gdm3/custom.conf



#
# save docker images
#
cd $BASEDIR; curl -O https://download.weshinetech.in/docker/uniapps-exam-sl-cbt.tar.gz
cd $BASEDIR; curl -O https://download.weshinetech.in/docker/uniapps-exam-couchdb-2020-12-01.tar.gz
