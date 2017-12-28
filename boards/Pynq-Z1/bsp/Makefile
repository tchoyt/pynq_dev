# Build a preconfigured BSP using Petalinux
PROJ_DIR = ./build

all:
	petalinux-build --project ${PROJ_DIR} --component kernel
	petalinux-build --project ${PROJ_DIR} --component u-boot
	petalinux-build --project ${PROJ_DIR} --component bootloader

kernel:
	petalinux-build --project ${PROJ_DIR} --component kernel

uboot:
	petalinux-build --project ${PROJ_DIR} --component u-boot

bootloader:
	petalinux-build --project ${PROJ_DIR} --component bootloader

clean:
	petalinux-build --project ${PROJ_DIR} --execute cleanall
	petalinux-build --project ${PROJ_DIR} --execute mrproper
	rm -fr ${PROJ_DIR}/BOOT.BIN ${PROJ_DIR}/*.elf ${PROJ_DIR}/components/
