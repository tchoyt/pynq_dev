# pynq_dev
Updated Xilinx PYNQ for Zynq + ZynqMP python HW acceleration development

Tools Required:
Xilinx Vivado/SDK 2017.4
Xilinx Petalinx 2017.4

Tested on Ubuntu 16.04.3 64-bit

Boards Supported: Pynq-Z1, Microzed, Ultrazed + I/O Breakout

Help: 
1. ./env_setup.sh --help

Quick and dirty build instructions:
1. source env_setup.sh --board <BOARD> --vivado <INSTALL DIRECTORY> --petalinux <INSTALL DIRECTORY>
2. make all && make install
