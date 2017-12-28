# Build a preconfigured BSP using Petalinux

all:
	petalinux-build --project ./build --component kernel
	petalinux-build --project ./build --component u-boot
	petalinux-build --project ./build --component bootloader

kernel:
	petalinux-build --project ./build --component kernel

uboot:
	petalinux-build --project ./build --component u-boot

bootloader:
	petalinux-build --project ./build --component bootloader

clean:
	petalinux-build --project ./build --execute cleanall
	petalinux-build --project ./build --execute mrproper
	rm -fr ./build/BOOT.BIN ./build/*.elf ./build/components/
