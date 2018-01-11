# Build a preconfigured BSP using Petalinux

all: kernel uboot bootloader bootimage
.PHONY : all

kernel:
	petalinux-build --project ${PETA_PROJ} --component kernel

uboot:
	petalinux-build --project ${PETA_PROJ} --component u-boot

bootloader:
	petalinux-build --project ${PETA_PROJ} --component bootloader

clean:
	petalinux-build --project ${PETA_PROJ} --execute cleanall
	petalinux-build --project ${PETA_PROJ} --execute mrproper
	rm -fr ${PETA_PROJ}/*.elf ${PETA_PROJ}/components/
	rm -fr BOOT.bin *.bif

bootimage:
	echo "sdimage : { [bootloader] ${PETA_PROJ}/images/linux/zynq_fsbl.elf ${PETA_PROJ}/images/linux/u-boot.elf }" > boot.bif
	bootgen -image boot.bif -arch zynq -o BOOT.bin -w on 

install:
	./wr_bootpart.sh
	./wr_rootpart.sh
