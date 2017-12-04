#!/bin/bash

# Get Vivado project name - will be the *.xpr file here
function vivado_proj()
{
   if [ -e *.xpr ]
   then
      VIVADO_PROJ="$(echo *.xpr | cut -d'.' -f1)"
   else
      echo "ERROR: No Vivado project file present (*.xpr)"
      exit
   fi
}

# Clean the Vivado project
function clean_fpga() {
	vivado_proj
	vivado -mode tcl -nojournal -nolog -source clean.tcl ${VIVADO_PROJ}.xpr
	rm -fr *.cache/ *.runs/ *.ip_user_files/ *.hw/ *.ioplanning/	
}

# Run full FPGA build - Synthesis -> Implementation/Place & Route -> Bitstream Generation
function build_fpga() {
	vivado_proj
    vivado -mode tcl -nojournal -nolog -source build.tcl ${VIVADO_PROJ}.xpr   
}
