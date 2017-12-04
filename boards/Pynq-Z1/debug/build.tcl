# Build the Vivado project

# Synthesis
launch_runs synth_1 -jobs 8
wait_on_run synth_1
if {[get_property PROGRESS [get_runs synth_1]] != "100%"} {error "ERROR: Synthesis Failed"}

# Implementation + Bitstream Generation
launch_runs impl_1 -to_step write_bitstream -jobs 8
wait_on_run impl_1
if {[get_property PROGRESS [get_runs impl_1]] != "100%"} {error "ERROR: Implementation Failed"}

exit