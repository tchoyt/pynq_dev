#!/bin/bash

# Copy FPGA image
function cp_fpga_image()
{
	cp -v fpga_image/*.bit ${BOOT_INSTALL_DIR}/pynq.bit
}

# Copy boot image
function cp_boot_image()
{
	cp -v boot_image/BOOT.bin ${BOOT_INSTALL_DIR}/.
}

# Copy kernel image
function cp_kernel()
{
	cp -v build/images/linux/zImage ${BOOT_INSTALL_DIR}/.
}

# Copy device tree
function cp_dtb()
{
	cp -v build/images/linux/system.dtb ${BOOT_INSTALL_DIR}/.
}

# Define variables
BOOT_INSTALL_DIR=./boot_part

# Install boot partitions
rm -fr ${BOOT_INSTALL_DIR}
mkdir ${BOOT_INSTALL_DIR}
cp_fpga_image
cp_boot_image
cp_kernel
cp_dtb

echo "-----------------------------"
echo "Boot Script Complete"
echo "-----------------------------"
