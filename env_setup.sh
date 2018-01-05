#!/bin/bash

VIVADO_INSTALL_PATH=~/bin/xilinx/Vivado/2017.4
PETALINUX_INSTALL_PATH=~/bin/petalinux_20174

# Setup environment variables
# export CROSS_COMPILE=aarch64-linux-gnu-
# export ARCH=arm64
export CROSS_COMPILE=arm-linux-gnueabihf-
export MB_COMPILE=microblaze-xilinx-elf-
export ARCH=arm
export SWT_GTK3=0
export BOARD=Pynq-Z1

# Setup SW environment
source $PETALINUX_INSTALL_PATH/settings.sh
export PETA_PROJ=build

# Setup HW environment
source $VIVADO_INSTALL_PATH/settings64.sh
export FPGA_PROJ=debug
export FPGA_IMG=${FPGA_PROJ}.bit
export FPGA_BIN=${FPGA_PROJ}.bin

# Install dependencies for Ubuntu 16.04.3
function install_pkgs() {
	sudo apt-get update
	sudo apt-get install tofrodos iproute2 gawk xvfb gcc git make net-tools libncurses5-dev tftpd zlib1g-dev:i386 libssl-dev flex bison libselinux1 \
	gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev screen pax gzip \
	bc device-tree-compiler lzma lzop
}
