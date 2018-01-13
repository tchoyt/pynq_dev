# Build an FPGA desgn with Vivado
VIVADO_PROJFILE = $(wildcard *.xpr)
VIVADO_PROJ = $(basename ${VIVADO_PROJFILE})

all: bit bin
.PHONY : all

bit: ${VIVADO_PROJ}.bit

bin: ${VIVADO_PROJ}.bin

${VIVADO_PROJ}.bit:
	vivado -mode tcl -nojournal -nolog -source build.tcl ${VIVADO_PROJFILE}
	cp -avf ${VIVADO_PROJ}.runs/impl_1/*.bit ${FPGA_IMG}

${VIVADO_PROJ}.bin: ${VIVADO_PROJ}.bit
	echo "fpgaimage : { ${VIVADO_PROJ}.bit }" > ./fpga.bif
	bootgen -image fpga.bif -arch zynqmp -process_bitstream bin -w on
	mv ${VIVADO_PROJ}.bit.bin ${FPGA_BIN}

.PHONY: clean
clean:
	vivado -mode tcl -nojournal -nolog -source clean.tcl ${VIVADO_PROJFILE}
	rm -fr *.cache/ *.runs/ *.ip_user_files/ *.hw/ *.ioplanning/ *.bit *.bin *.bif
