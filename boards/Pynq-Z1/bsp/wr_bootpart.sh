#!/bin/bash

# Copy FPGA image
function cp_fpga_image()
{
	cp -v ../$FPGA_PROJ/$FPGA_PROJ.runs/impl_1/$FPGA_IMG.bit ${BOOT_INSTALL_DIR}/.
}

# Copy boot image
function cp_boot_image()
{
	cp -v ../software/boot_image/BOOT.bin ${BOOT_INSTALL_DIR}/.
}

# Copy kernel image
function cp_kernel()
{
	cp -v ../software/petalinux_build/images/linux/zImage ${BOOT_INSTALL_DIR}/.
}

# Copy device tree
function cp_dtb()
{
	cp -v ../software/petalinux_build/images/linux/system.dtb ${BOOT_INSTALL_DIR}/.
}

# Define variables
FPGA_PROJ=debug
FPGA_IMG=zynq_top_wrapper
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
