#!/bin/bash

#
# pull docker images
#
docker pull weshinetech/uniapps-exam:2020.12.01
docker pull weshinetech/uniapps-exam-couchdb:2020.12.01


#
# start docker compose
#
docker-compose up -d



#
# start netboot
#

PXEDATA=`pwd`/kiosk/
IP=192.168.0.101
PORT=8090


killall dnsmasq 2>/dev/null
dnsmasq --enable-tftp --tftp-root=$PXEDATA/boot --dhcp-boot=pxelinux.0,"$IP",$IP --dhcp-range=$(echo $IP | cut -d. -f1-3).50,$(echo $IP | cut -d. -f1-3).250,infinite --log-dhcp


killall webfsd 2>/dev/null
webfsd -i $IP -p $PORT -r $PXEDATA -u nobody -g nogroup


echo 1 > /proc/sys/net/ipv4/ip_forward
