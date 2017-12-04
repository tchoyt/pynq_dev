# Clean the Vivado project
set VIVADO_PROJ [get_projects ]

# Reset ZynqMP block design
reset_target all [get_files  $VIVADO_PROJ.srcs/sources_1/bd/zynq_top/zynq_top.bd]
delete_ip_run [get_files -of_objects [get_fileset sources_1] $VIVADO_PROJ.srcs/sources_1/bd/zynq_top/zynq_top.bd]

# Reset Implementation results
reset_run impl_1

# Reset Synthesis results
reset_run synth_1

exit