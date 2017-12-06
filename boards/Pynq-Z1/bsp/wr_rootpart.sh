#!/bin/bash

# Copy rootfs
# Wget the rootfs tarball from eewiki if not present
function cp_rootfs()
{
	if [ -e ./*-*-*-armhf-*/armhf-rootfs-*.tar ]
	then
		sudo tar xf ./*-*-*-armhf-*/armhf-rootfs-*.tar -C ${ROOTFS_INSTALL_DIR}/.
	else
		wget -c https://rcn-ee.com/rootfs/eewiki/minfs/${ROOTFS_TARBALL}
		tar xf ${ROOTFS_TARBALL}
		sudo tar xf ./*-*-*-armhf-*/armhf-rootfs-*.tar -C ${ROOTFS_INSTALL_DIR}/.
	fi
}

# Copy Python libraries
# function cp_apps()
# {
# 	sudo cp -v uzed.py fpga_mmap.py ${ROOTFS_INSTALL_DIR}/home/ubuntu/.
# }

# Write /etc/network/interfaces
function wr_ethinterface()
{
	sudo sh -c "echo '# interfaces(5) file used by ifup(8) and ifdown(8)
# Include files from /etc/network/interfaces.d:
source-directory /etc/network/interfaces.d

auto lo
iface lo inet loopback
  
auto eth0
iface eth0 inet dhcp
# iface eth0 inet static
#    address ${BOARD_IP_ADDR}
#    netmask 255.255.0.0
#    gateway 172.20.0.90
#    dns-nameserver 172.20.0.90' > ${ROOTFS_INSTALL_DIR}/etc/network/interfaces"
}

# Write /etc/hosts, /etc/hostname
function wr_hostname()
{
	sudo sh -c "echo '127.0.0.1	localhost
127.0.1.1	${BOARD_HOSTNAME}.localdomain	${BOARD_HOSTNAME}

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters' > ${ROOTFS_INSTALL_DIR}/etc/hosts"

	sudo sh -c "echo '${BOARD_HOSTNAME}' > ${ROOTFS_INSTALL_DIR}/etc/hostname"
}

# Write /etc/fstab
function wr_fstab()
{
	sudo sh -c "echo '/dev/mmcblk0p2  /  auto errors=remount-ro  0  1
/dev/mmcblk0p1  /boot auto defaults  0  2' > ${ROOTFS_INSTALL_DIR}/etc/fstab"
}

# Write pynq dir to home directory
function wr_pynq_dir()
{
	mkdir ${ROOTFS_INSTALL_DIR}/home/ubuntu/pynq
	mkdir ${ROOTFS_INSTALL_DIR}/home/ubuntu/pynq/lib
}

# Define variables
BOARD_HOSTNAME=pynq
BOARD_IP_ADDR=172.20.2.28
ROOTFS_INSTALL_DIR=./rootfs_part
ROOTFS_TARBALL=ubuntu-16.04.3-minimal-armhf-2017-10-10.tar.xz

# Install and configure rootFS
sudo rm -fr ${ROOTFS_INSTALL_DIR}
mkdir ${ROOTFS_INSTALL_DIR}
cp_rootfs
# cp_apps
wr_ethinterface
wr_hostname
wr_fstab
wr_pynq_dir
sync

echo "-----------------------------"
echo "rootFS Script Complete"
echo "-----------------------------"
