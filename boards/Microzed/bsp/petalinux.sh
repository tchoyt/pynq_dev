#!/bin/bash

# Increase the 'max_user_watches' setting to fix the petalinux build error
function fix_petalinux() {
	sudo sysctl -n -w fs.inotify.max_user_watches=65536 > /dev/null
}

# Create the petalinux project
function create_petalinux() {
	rm -fr ${PETA_PROJ}
	petalinux-create --type project --template zynq --name ${PETA_PROJ}
}

# Import project from Vivado
function import_petalinux() {
	petalinux-config --project ${PETA_PROJ} --get-hw-description=../$FPGA_PROJ/$FPGA_PROJ.sdk/
}

# Configure the Kernel build
function config_petalinux_kernel() {
	petalinux-config --project ${PETA_PROJ} --component kernel
}

# Configure the u-Boot build
function config_petalinux_uboot() {
	petalinux-config --project ${PETA_PROJ} --component u-boot
}

# Clean the petalinux workspace
function clean_petalinux() {
	petalinux-build --project ${PETA_PROJ} --execute cleanall
	petalinux-build --project ${PETA_PROJ} --execute mrproper
	rm -fr BOOT.BIN *.elf components/
}

# Build kernel, uBoot, Device Tree, FSBL with petalinux
function build_petalinux() {
	petalinux-build --project ${PETA_PROJ} --component kernel
	petalinux-build --project ${PETA_PROJ} --component u-boot
	petalinux-build --project ${PETA_PROJ} --component bootloader
}
