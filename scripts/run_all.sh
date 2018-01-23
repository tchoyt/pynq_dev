#!/bin/bash

# Print help menu
function print_help()
{
	echo -e "Syntax:   run_all.sh --clean | --build"
	echo -e "--clean   = Clean all the boards"
   	echo -e "--build   = Build all the boards"
}

# Clean all the boards
function clean_all()
{
	# Run fix_petalinux cause it will probably break...
	source scripts/petalinux.sh
	fix_petalinux
	echo "---------------------------"
	echo "Cleaning all the boards... "
	echo "---------------------------"
	for i in "${BOARD_ARRY[@]}"
	do
		echo "---------------------------"
		echo "Cleaning... $i... "
		echo "---------------------------"
		source scripts/env_setup.sh --board $i
		make clean
		git checkout ./boards/$i/$FPGA_PROJ/
	done
	echo "-------------------------------"
	echo "Cleaning all the boards... DONE"
	echo "-------------------------------"
}

# Build all the boards
function build_all()
{
	# Run fix_petalinux cause it will probably break...
	source scripts/petalinux.sh
	fix_petalinux
	echo "---------------------------"
	echo "Building all the boards... "
	echo "---------------------------"
	for i in "${BOARD_ARRY[@]}"
	do
		echo "---------------------------"
		echo "Building... $i... "
		echo "---------------------------"
		source scripts/env_setup.sh --board $i
		make fpga
		make bsp
	done
	echo "-------------------------------"
	echo "Building all the boards... DONE"
	echo "-------------------------------"
}

# Parse command line options
options=()
options+=(--help:HELP)
options+=(--clean:CLEAN)
options+=(--build:BUILD)
source ./scripts/parseopt.sh

# Get all the boards
BOARD_LIST=$(ls ./boards)
BOARD_ARRY=($BOARD_LIST)

# Help
if [ "$HELP" == 1 ] 
then
	print_help
# Clean
elif [ "$CLEAN" == 1 ] 
then
	clean_all
# Build
elif [ "$BUILD" == 1 ]
then
	build_all
else
	print_help
fi
