# pynq_dev
Updated Xilinx PYNQ for Zynq + ZynqMP python HW acceleration development

Tools Required:
Xilinx Vivado/SDK 2017.4
Xilinx Petalinx 2017.4

Tested on Ubuntu 16.04.3 64-bit

Boards Supported: Pynq-Z1, Microzed, Ultrazed + I/O Breakout

Install Vivado Board Files:
1. Extract the contents 'vivado_board_files.tar.xz' to VIVADO_INSTALL_DIRECTORY/Vivado/2017.4/data/boards/board_files/.

Help: 
1. ./scripts/env_setup.sh --help

Quick and dirty build instructions:
1. source scripts/env_setup.sh --board <BOARD> --vivado <INSTALL DIRECTORY> --petalinux <INSTALL DIRECTORY>
2. make all && make install

