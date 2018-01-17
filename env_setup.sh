#!/bin/bash

# Install dependencies for Ubuntu 16.04.3
function install_pkgs() {
	sudo apt-get update
	sudo apt-get install tofrodos iproute2 gawk xvfb gcc git make net-tools libncurses5-dev zlib1g-dev:i386 libssl-dev flex bison libselinux1 \
	gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev screen pax gzip \
	bc device-tree-compiler lzma lzop texinfo
	INSTALL=""
}

# Print help menu
function print_help()
{
	echo -e "Syntax:        env_setup.sh --board <Pynq-Z1|Microzed|Ultrazed>"
	echo -e "--board        = Board Configuration: <Pynq-Z1|Microzed|Ultrazed>"
   	echo -e "--help         = Print this menu"
   	echo -e "--install      = Install dependencies for Ubuntu 16.04.3"
   	echo -e "--vivado       = Specify a Vivado Installation Directory"
   	echo -e "--petalinux    = Specify a Petalinux Installation Directory"
   	HELP=""
}

# Xilinx Tool Setup
function xilinx_tool_setup() {
	# Default vivado path
	if [ "$VIVADO_PATH" == "" ]
	then
		VIVADO_PATH=~/bin/xilinx/Vivado/2017.4
	fi
	# Default petalinux path
	if [ "$PETALINUX_PATH" == "" ]
	then
		PETALINUX_PATH=~/bin/petalinux/2017.4
	fi
	echo -e "Setting up Vivado..."
	source $VIVADO_PATH/settings64.sh
	VIVADO_PATH=""
	echo -e "Setting up Petalinux..."
	source $PETALINUX_PATH/settings.sh
	PETALINUX_PATH=""
}

# Common environment variables
export MB_COMPILE=microblaze-xilinx-elf-
export SWT_GTK3=0
export PETA_PROJ=build
export FPGA_PROJ=debug
export FPGA_IMG=${FPGA_PROJ}.bit
export FPGA_BIN=${FPGA_PROJ}.bin

# Parse command line options
options=()
options+=(--help:HELP)
options+=(--install:INSTALL)
options+=(--board=:TARGET)
options+=(--vivado=:VIVADO_PATH)
options+=(--petalinux=:PETALINUX_PATH)
source parseopt.sh

# Help
if [ "$HELP" == 1 ] 
then
	print_help
# Install packages
elif [ "$INSTALL" == 1 ] 
then
	echo -e "Installing dependencies for Ubuntu 16.04.3..."
   	install_pkgs
# Board specific envrionment variables
elif [ "$TARGET" == "Pynq-Z1" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=arm-linux-gnueabihf-
	export ARCH=arm
	export BOARD=${TARGET}
	TARGET=""
elif [ "$TARGET" == "Microzed" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=arm-linux-gnueabihf-
	export ARCH=arm
	export BOARD=${TARGET}
	TARGET=""
elif [ "$TARGET" == "Ultrazed" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=aarch64-linux-gnu-
	export ARCH=arm64
	export BOARD=${TARGET}
	TARGET=""
else
	echo -e "ERROR: Need to specify a supported board."
	print_help
fi
