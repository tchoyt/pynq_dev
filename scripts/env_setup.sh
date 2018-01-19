#!/bin/bash

# Print help menu
function print_help()
{
	echo -e "Syntax:        env_setup.sh --board <Pynq-Z1|Microzed|Ultrazed>"
	echo -e "--board        = Board Configuration: <Pynq-Z1|Microzed|Ultrazed>"
   	echo -e "--help         = Print this menu"
   	echo -e "--install      = Install Vivado board files & build dependencies for Ubuntu 16.04.3"
   	echo -e "--vivado       = Specify a Vivado Installation Directory"
   	echo -e "--petalinux    = Specify a Petalinux Installation Directory"
   	HELP=""
}

# Install build dependencies for Ubuntu 16.04.3
function install_pkgs() 
{
	echo -e "Installing build dependencies for Ubuntu 16.04.3..."
	sudo apt-get update
	sudo apt-get install tofrodos iproute2 gawk xvfb gcc git make net-tools libncurses5-dev zlib1g-dev:i386 libssl-dev flex bison libselinux1 \
	gnupg wget diffstat chrpath socat xterm autoconf libtool tar unzip zlib1g-dev gcc-multilib build-essential libsdl1.2-dev libglib2.0-dev screen pax gzip \
	bc device-tree-compiler lzma lzop texinfo
}

# Install Vivado board files
function install_board_files() 
{
	# Default vivado path
	if [ "${VIVADO_PATH}" == "" ]
	then
		VIVADO_PATH=~/bin/xilinx/Vivado/2017.4
	fi
	# Check for valid vivado board file path
	if [ -d ${VIVADO_PATH}/data/boards/board_files ]
	then
		echo -e "Installing Vivado board files: '${VIVADO_PATH}/data/boards/board_files/'"
		tar xf vivado_board_files.tar.xz -C ${VIVADO_PATH}/data/boards/board_files/.
	else
		echo -e "ERROR: Specify a valid Vivado install path"
		print_help
	fi
}

# Xilinx Tool Setup
function xilinx_tool_setup() 
{
	# Default vivado path
	if [ "${VIVADO_PATH}" == "" ]
	then
		VIVADO_PATH=~/bin/xilinx/Vivado/2017.4
	fi
	# Default petalinux path
	if [ "${PETALINUX_PATH}" == "" ]
	then
		PETALINUX_PATH=~/bin/petalinux/2017.4
	fi
	echo -e "Setting up Vivado..."
	echo -e "Vivado environment set to '${VIVADO_PATH}'"
	source ${VIVADO_PATH}/settings64.sh
	echo -e "Setting up Petalinux..."
	source ${PETALINUX_PATH}/settings.sh
}

# Common environment variables
export MB_COMPILE=microblaze-xilinx-elf-
export SWT_GTK3=0
export PETA_PROJ=build
export FPGA_PROJ=debug
export FPGA_IMG=${FPGA_PROJ}.bit
export FPGA_BIN=${FPGA_PROJ}.bin
export PYNQ_PATH=pynq
export PYNQ_LIB_PATH=${PYNQ_PATH}/lib

# Parse command line options
options=()
options+=(--help:HELP)
options+=(--install:INSTALL)
options+=(--board=:TARGET)
options+=(--vivado=:VIVADO_PATH)
options+=(--petalinux=:PETALINUX_PATH)
source ./scripts/parseopt.sh

# Help
if [ "$HELP" == 1 ] 
then
	print_help
# Install packages
elif [ "$INSTALL" == 1 ] 
then
	install_pkgs
   	install_board_files
   	INSTALL=""
# Board specific envrionment variables
elif [ "$TARGET" == "Pynq-Z1" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=arm-linux-gnueabihf-
	export ARCH=arm
	export ZYNQ=zynq
	export BOARD=${TARGET}
	TARGET=""
elif [ "$TARGET" == "Microzed" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=arm-linux-gnueabihf-
	export ARCH=arm
	export ZYNQ=zynq
	export BOARD=${TARGET}
	TARGET=""
elif [ "$TARGET" == "Ultrazed" ]
then
	echo -e "Configuring envrionment for ${TARGET}..."
	xilinx_tool_setup
	export CROSS_COMPILE=aarch64-linux-gnu-
	export ARCH=arm64
	export ZYNQ=zynqmp
	export BOARD=${TARGET}
	TARGET=""
else
	echo -e "ERROR: Need to specify a supported board."
	print_help
fi
