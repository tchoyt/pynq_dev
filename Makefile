# Top Level makefile for pynq_dev

all: fpga bsp pynq
.PHONY : all

# FPGA image
.PHONY : fpga
fpga:
	make all -C ./boards/${BOARD}/${FPGA_PROJ}/

# Linux kernel, device tree, u-boot, bootloader
bsp:
	make all -C ./boards/${BOARD}/bsp/

# Pynq Library - Linux drivers, pynq python modules, etc.
.PHONY : pynq
pynq:
	make all -C ./pynq/

clean:
	make clean -C ./boards/${BOARD}/${FPGA_PROJ}/
	make clean -C ./boards/${BOARD}/bsp/
	make clean -C ./pynq/

# Boot partition, Ubuntu Server root file system partition, Pynq library
install:
	make install -C ./boards/${BOARD}/bsp/
	make install -C ./pynq/
