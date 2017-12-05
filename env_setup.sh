#!/bin/bash

VIVADO_INSTALL_PATH=~/bin/xilinx/Vivado/2017.3
PETALINUX_INSTALL_PATH=~/bin/petalinux_20173

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

# Setup HW environment
source $VIVADO_INSTALL_PATH/settings64.sh
