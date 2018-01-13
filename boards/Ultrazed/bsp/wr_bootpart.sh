#!/bin/bash

# Copy boot image
function cp_boot_image()
{
	cp -v ./BOOT.bin ${BOOT_INSTALL_DIR}/.
}

# Copy kernel image
function cp_kernel()
{
	cp -v ${PETA_PROJ}/images/linux/Image ${BOOT_INSTALL_DIR}/.
}

# Copy device tree binaries
function cp_dtb()
{
	cp -v ${PETA_PROJ}/images/linux/system.dtb ${BOOT_INSTALL_DIR}/.
}

# Copy FPGA image
function cp_fpgaimg()
{
	cp -v ../fpga/${FPGA_PROJ}/*.bit ${BOOT_INSTALL_DIR}/${FPGA_BIT}
}

# Define variables
BOOT_INSTALL_DIR=./boot_part

# Install boot partitions
rm -fr ${BOOT_INSTALL_DIR}
mkdir ${BOOT_INSTALL_DIR}
cp_boot_image
cp_kernel
cp_dtb
cp_fpgaimg

echo "-----------------------------"
echo "Boot Script Complete"
echo "-----------------------------"
