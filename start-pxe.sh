#!/bin/bash

# Run services necessary for booting Porteus Kiosk over the network.


# Path to folder where Kiosk ISO is unpacked/mounted:
PXEDATA=/var/lib/kiosk/


# Server IP address:
IP=`hostname -I | awk '{print $1}'`


#disable firewall
ufw disable 2>/dev/null



#add entry of dhcp-range in dnsmasq.conf
sed -i '/^dhcp-range=192.168.0.0,proxy/d' /etc/dnsmasq.conf
a=`echo $IP|cut -d. -f1-2`;b=`echo ".0.0"`;echo "dhcp-range=$a$b,proxy" >> /etc/dnsmasq.conf



# Port on which the HTTP daemon is listening:
PORT=8090



# Start the DHCP server and the TFTP server:
systemctl stop systemd-resolved
killall dnsmasq 2>/dev/null
dnsmasq --enable-tftp --tftp-root=$PXEDATA/boot --dhcp-boot=pxelinux.0,"$IP",$IP --dhcp-range=$(echo $IP | cut -d. -f1-3).50,$(echo $IP | cut -d. -f1-3).250,infinite --log-dhcp


# Start the HTTP server:
killall webfsd 2>/dev/null
webfsd -i 0.0.0.0 -p $PORT -r $PXEDATA -u nobody -g nogroup


# Enable packet forwarding so pxe clients can connect to internet:
echo 1 > /proc/sys/net/ipv4/ip_forward


#add entry in /var/lib/kiosk/boot/pxelinux.cfg/default
sed -i '/^append/d' /var/lib/kiosk/boot/pxelinux.cfg/default
echo "append initrd=initrd.xz,pxelinux.cfg/initrdpxe.xz quiet http_server=$IP:8090" >> /var/lib/kiosk/boot/pxelinux.cfg/default


echo "PXE services for Porteus Kiosk should be started now."

