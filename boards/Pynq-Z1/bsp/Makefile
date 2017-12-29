# Build a preconfigured BSP using Petalinux
PROJ_DIR = ./build

all: kernel uboot bootloader bootimage
.PHONY : all

kernel:
	petalinux-build --project ${PROJ_DIR} --component kernel

uboot:
	petalinux-build --project ${PROJ_DIR} --component u-boot

bootloader:
	petalinux-build --project ${PROJ_DIR} --component bootloader

clean:
	petalinux-build --project ${PROJ_DIR} --execute cleanall
	petalinux-build --project ${PROJ_DIR} --execute mrproper
	rm -fr ${PROJ_DIR}/*.elf ${PROJ_DIR}/components/
	rm -fr BOOT.bin *.bif

bootimage:
	echo "sdimage : { [bootloader] ${PROJ_DIR}/images/linux/zynq_fsbl.elf ${PROJ_DIR}/images/linux/u-boot.elf }" > boot.bif
	bootgen -image boot.bif -arch zynq -o BOOT.bin -w on 

install:
	./wr_bootpart.sh
	./wr_rootpart.sh
