#!/bin/bash

FPGA_PROJ=base

# Increase the 'max_user_watches' setting to fix the petalinux build error
function fix_petalinux() {
	sudo sysctl -n -w fs.inotify.max_user_watches=65536 > /dev/null
}

# Create the petalinux project
function create_petalinux() {
	rm -fr petalinux_build
	petalinux-create --type project --template zynq --name petalinux_build
}

# Import project from Vivado
function import_petalinux() {
	petalinux-config --get-hw-description=../$FPGA_PROJ/$FPGA_PROJ.sdk/
}

# Configure the Kernel build
function config_petalinux_kernel() {
	petalinux-config --component kernel
}

# Configure the u-Boot build
function config_petalinux_uboot() {
	petalinux-config --component u-boot
}

# Clean the petalinux workspace
function clean_petalinux() {
	petalinux-build --execute cleanall
	petalinux-build --execute mrproper
	rm -fr BOOT.BIN *.elf components/
}

# Build kernel, uBoot, Device Tree, FSBL with petalinux
function build_petalinux() {
	petalinux-build --component kernel
	petalinux-build --component u-boot
	petalinux-build --component bootloader
}
