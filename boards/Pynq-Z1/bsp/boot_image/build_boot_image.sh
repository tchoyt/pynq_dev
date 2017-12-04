#!/bin/bash

FPGA_PROJ=uzed_base
FPGA_IMG=uzed_top

function cp_bootimg() {
	cp -v ../build/images/linux/zynq_fsbl.elf .
	cp -v ../build/images/linux/u-boot.elf .
}

function clean_bootimg() {
	rm -fr *.elf *.bin
}

function build_bootimg() {
	clean_bootimg
	cp_bootimg
	bootgen -image boot.bif -arch zynq -o BOOT.bin -w on 
}
