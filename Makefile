# Top Level makefile for pynq_dev

all: fpga bsp
.PHONY : all

# FPGA image
.PHONY : fpga
fpga:
	make -C ./boards/${BOARD}/${FPGA_PROJ}/

# Linux kernel, device tree, u-boot, bootloader
bsp:
	make -C ./boards/${BOARD}/bsp/

# Boot partition, Ubuntu Server root file system partition
install:
	make install -C ./boards/${BOARD}/bsp/

clean:
	make clean -C ./boards/${BOARD}/${FPGA_PROJ}/
	make clean -C ./boards/${BOARD}/bsp/
