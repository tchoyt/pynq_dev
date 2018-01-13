# Build a preconfigured BSP using Petalinux

all: kernel uboot bootloader bootimage
.PHONY : all

kernel:
	petalinux-build --project ${PETA_PROJ} --component kernel

uboot:
	petalinux-build --project ${PETA_PROJ} --component u-boot

bootloader:
	petalinux-build --project ${PETA_PROJ} --component bootloader
	petalinux-build --project ${PETA_PROJ} --component arm-trusted-firmware
	petalinux-build --project ${PETA_PROJ} --component pmufw

clean:
	petalinux-build --project ${PETA_PROJ} --execute cleanall
	petalinux-build --project ${PETA_PROJ} --execute mrproper
	rm -fr ${PETA_PROJ}/*.elf ${PETA_PROJ}/components/
	rm -fr BOOT.bin *.bif

bootimage:
	echo "sdimage : { [destination_cpu=a53-0, bootloader] ${PETA_PROJ}/images/linux/zynqmp_fsbl.elf [destination_cpu=pmu, pmufw_image] ${PETA_PROJ}/images/linux/pmufw.elf [destination_cpu=a53-0, exception_level=el-3, trustzone] ${PETA_PROJ}/images/linux/bl31.elf [destination_cpu=a53-0, exception_level=el-2] ${PETA_PROJ}/images/linux/u-boot.elf }" > boot.bif
	bootgen -image boot.bif -arch zynqmp -o BOOT.bin -w on 

install:
	./wr_bootpart.sh
	./wr_rootpart.sh
