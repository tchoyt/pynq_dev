#!/bin/bash

FPGA_PROJ=debug

# Increase the 'max_user_watches' setting to fix the petalinux build error
function fix_petalinux() {
	sudo sysctl -n -w fs.inotify.max_user_watches=65536 > /dev/null
}

# Create the petalinux project
function create_petalinux() {
	rm -fr build
	petalinux-create --type project --template zynq --name build
}

# Import project from Vivado
function import_petalinux() {
	petalinux-config --get-hw-description=../../$FPGA_PROJ/$FPGA_PROJ.sdk/
}

# Configure the Kernel build
function config_petalinux_kernel() {
	petalinux-config --project ./build --component kernel
}

# Configure the u-Boot build
function config_petalinux_uboot() {
	petalinux-config --project ./build --component u-boot
}

# Clean the petalinux workspace
function clean_petalinux() {
	petalinux-build --project ./build --execute cleanall
	petalinux-build --project ./build --execute mrproper
	rm -fr BOOT.BIN *.elf components/
}

# Build kernel, uBoot, Device Tree, FSBL with petalinux
function build_petalinux() {
	petalinux-build --project ./build --component kernel
	petalinux-build --project ./build --component u-boot
	petalinux-build --project ./build --component bootloader
}
