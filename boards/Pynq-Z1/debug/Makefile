VIVADO_PROJFILE = $(wildcard *.xpr)
VIVADO_PROJ = $(basename ${VIVADO_PROJFILE})

all: ${VIVADO_PROJ}.bit
.PHONY: all

${VIVADO_PROJ}.bit:
	vivado -mode tcl -nojournal -nolog -source build.tcl ${VIVADO_PROJFILE}
	cp -avf ${VIVADO_PROJ}.runs/impl_1/*.bit ${VIVADO_PROJ}.bit

clean:
	vivado -mode tcl -nojournal -nolog -source clean.tcl ${VIVADO_PROJFILE}
	rm -fr *.cache/ *.runs/ *.ip_user_files/ *.hw/ *.ioplanning/ *.bit
