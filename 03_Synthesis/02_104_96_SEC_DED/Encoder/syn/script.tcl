# ---------------------------------------
# Step 1: Specify libraries
# ---------------------------------------
set link_library \
[list /media/0/LogicLibraries/UMC/28nm/35uhd/udl/hvt/latest/liberty/logic_synth/um28nchslogl35udl140f_tt1p0v85c.db ]
set target_library \
[list /media/0/LogicLibraries/UMC/28nm/35uhd/udl/hvt/latest/liberty/logic_synth/um28nchslogl35udl140f_tt1p0v85c.db ]

 

# ---------------------------------------
# Step 2: Read designs
# ---------------------------------------

 

set design_name         rs_ssc_encoder
elaborate $design_name

 

# connect all the library components and designs
link

 

# renames multiply references designs so that each
# instance references a unique design
uniquify

 

# ---------------------------------------
# Step 3: Define design environments
# ---------------------------------------
#
# ---------------------------------------
# Step 4: Set design constraints
# ---------------------------------------
# ---------------------------------------
# Clock
# ---------------------------------------
set clk_name clk
set clk_freq            200

 

# Reduce clock period to model wire delay (65% of original period)
set clk_period [expr 1000 / double($clk_freq)]
create_clock -period $clk_period $clk_name
set clk_uncertainty [expr $clk_period * 0.35]
set_clock_uncertainty -setup $clk_uncertainty $clk_name

 

# Set infinite drive strength
set_drive 0 $clk_name
set_ideal_network rst_n

 

# ---------------------------------------
# Input/Output
# ---------------------------------------
# Apply default timing constraints for modules
set_input_delay  1.3 [all_inputs]  -clock $clk_name
set_output_delay 1.3 [all_outputs] -clock $clk_name

 

# ---------------------------------------
# Area
# ---------------------------------------
# If max_area is set 0, DesignCompiler will minimize the design as small as possible
set_max_area 0

 

# ---------------------------------------
# Step 5: Synthesize and optimzie the design
# ---------------------------------------
compile_ultra
#compile

 

# ---------------------------------------
# Step 6: Analyze and resolve design problems
# ---------------------------------------
check_design  > $design_name.check_design.rpt

 

report_constraint -all_violators -verbose -sig 10 > $design_name.all_viol.rpt

 

report_design                             > $design_name.design.rpt
report_area -physical -hierarchy          > $design_name.area.rpt
report_timing -nworst 10 -max_paths 10    > $design_name.timing.rpt
report_power -analysis_effort high        > $design_name.power.rpt
report_cell                               > $design_name.cell.rpt
report_qor                                > $design_name.qor.rpt
report_reference                          > $design_name.reference.rpt
report_resources                          > $design_name.resources.rpt
report_hierarchy -full                    > $design_name.hierarchy.rpt
report_threshold_voltage_group            > $design_name.vth.rpt

 

# ---------------------------------------
# Step 7: Save the design database
# ---------------------------------------
write -hierarchy -format verilog -output  $design_name.netlist.v
write -hierarchy -format ddc     -output  $design_name.ddc
write_sdf -version 1.0                    $design_name.sdf
write_sdc                                 $design_name.sdc

 

exit
