#!/bin/bash

# Print help menu
function print_help()
{
   echo -e "Syntax: wr_sdcard.sh --dev <SD Card Device>"
   echo -e "-h --help   = Print this menu"
   echo -e "-p --part 	= Partition SD Card"
   echo -e "--dev 		= SD Card Device"
   exit
}

# Partition the SD card
function partition_sdcard()
{
	echo "-----------------------------"
	echo "Partitioning the SD Card"
	echo "-----------------------------"
	sudo sh -c 'sfdisk '${SD_DEV}' <<-__EOF__
1M,100M,0xE,*
,,,-
__EOF__'
}

# Format the SD card
function format_sdcard()
{
	echo "-----------------------------"
	echo "Formatting the SD Card"
	echo "-----------------------------"	
	sudo mkfs.vfat -F 32 -n BOOT ${SD_DEV}p1
	sudo mkfs.ext4 -L rootfs ${SD_DEV}p2
}

# Copy rootFS
function cp_rootfs()
{
	echo "-----------------------------"
	echo "Copying rootFS Partition"
	echo "-----------------------------"	
	mkdir ${ROOTFS_MOUNT_DIR}
	sudo mount ${SD_DEV}p2 ${ROOTFS_MOUNT_DIR}
	sudo cp -a ${ROOTFS_INSTALL_DIR}/. ${ROOTFS_MOUNT_DIR}/
	sync
	sudo umount ${ROOTFS_MOUNT_DIR}
	rm -fr ${ROOTFS_MOUNT_DIR}
}

# Copy uBoot
function cp_boot()
{
	echo "-----------------------------"
	echo "Copying Boot Partition"
	echo "-----------------------------"	
	mkdir ${BOOT_MOUNT_DIR}
	sudo mount ${SD_DEV}p1 ${BOOT_MOUNT_DIR}
	sudo cp -rv ${BOOT_INSTALL_DIR}/. ${BOOT_MOUNT_DIR}/
	sync
	sudo umount ${BOOT_MOUNT_DIR}
	rm -fr ${BOOT_MOUNT_DIR}
}

# Define variables
BOOT_MOUNT_DIR=./boot_install
BOOT_INSTALL_DIR=./boot_part
ROOTFS_MOUNT_DIR=./rootfs_install
ROOTFS_INSTALL_DIR=./rootfs_part

# Parse command line options
options=()
options+=(-h:HELP)
options+=(--help:HELP)
options+=(-p:SD_PART)
options+=(--part:SD_PART)
options+=(--dev=:SD_DEV)

. parseopt.sh

if [ "$HELP" == 1 ] 
then
	print_help
	exit
fi

if [ "$SD_DEV" == "" ] 
then
	echo -e "ERROR:  Need to specify SD Card device"
	echo -e "Syntax: wr_sdcard.sh --dev <SD Card Device>\n"
   	lsblk
   	exit
fi

# Check to see if SD_DEV is mounted
if mount | grep $SD_DEV > /dev/null
then
	echo -e "ERROR: Need to un-mount $SD_DEV\n"
	lsblk
	exit
fi

# Partition a new SD card
if [ "$SD_PART" == 1 ] 
then
   partition_sdcard
fi

# Write a new SD card
format_sdcard
cp_rootfs
cp_boot

echo "-----------------------------"
echo "SD Card Write Complete"
echo "-----------------------------"
