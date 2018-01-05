#!/bin/bash

# Copy FPGA image
function cp_fpga_image()
{
	cp -v ../${FPGA_PROJ}/${FPGA_IMG} ${BOOT_INSTALL_DIR}/pynq.bit
	cp -v ../${FPGA_PROJ}/${FPGA_BIN} ${BOOT_INSTALL_DIR}/pynq.bin
}

# Copy boot image
function cp_boot_image()
{
	cp -v ./BOOT.bin ${BOOT_INSTALL_DIR}/.
}

# Copy kernel image
function cp_kernel()
{
	cp -v ${PETA_PROJ}/images/linux/zImage ${BOOT_INSTALL_DIR}/.
}

# Copy device tree
function cp_dtb()
{
	cp -v ${PETA_PROJ}/images/linux/system.dtb ${BOOT_INSTALL_DIR}/.
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
