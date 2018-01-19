# pynq_dev
Updated Xilinx PYNQ for Zynq + ZynqMP python HW acceleration development

Tools Required:
Xilinx Vivado/SDK 2017.4
Xilinx Petalinx 2017.4

Tested on Ubuntu 16.04.3 64-bit

Boards Supported: Pynq-Z1, Microzed, Ultrazed + I/O Breakout

Setup environment - Installs Vivado board files and dependencies for Ubuntu 16.04.3:
1. Download and install Vivado Webpack and Petalinux 2017.4
2. source scripts/env_setup.sh --install --vivado VIVADO_INSTALL --petalinux PETALINUX_INSTALL

Quick and dirty build instructions - Configures environment for specified boar and Vivado and Petalinux paths above:
1. source scripts/env_setup.sh --board <BOARD>
2. make all
