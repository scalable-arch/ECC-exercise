# ---------------------------------------
# DESIGN PROFILE
# ---------------------------------------
set topmodule_name      rs_ssc_encoder
set clk_port_name       clk
set clk_freq            1000

# ---------------------------------------
# Read Libraries
# ---------------------------------------
#set LIBLIST_PATH        $env(LIBLIST_PATH)
#source $LIBLIST_PATH
set link_library [list /media/0/LogicLibraries/UMC/28nm/35uhd/udl/hvt/latest/liberty/logic_synth/um28nchhlogl35udl140f_tt1p0v85c.db]
set target_library [list /media/0/LogicLibraries/UMC/28nm/35uhd/udl/hvt/latest/liberty/logic_synth/um28nchhlogl35udl140f_tt1p0v85c.db]

# ---------------------------------------
# Read Source Codes
# ---------------------------------------
set RTL_PATH            $env(RTL_PATH)
read_file $RTL_PATH -autoread -recursive -format sverilog -top $topmodule_name

# ---------------------------------------
# 1. Environments Setting
# ---------------------------------------
link
uniquify

# ---------------------------------------
# 2. Constraints Setting
# ---------------------------------------
# Clock
# Reduce clock period to model wire delay (60% of original period)
set delay_percentage 0.6
set clk_period [expr 1000 / double($clk_freq)]
set clk_period [expr $clk_period * $delay_percentage]

if {[sizeof_collection [get_ports $clk_port_name]] > 0} {
  # Create real clock if clock port is found
  set clk_name $clk_port_name
  create_clock -period $clk_period -name $clk_name [get_port {clk}]
  # If real clock, set infinite drive strength
  set_drive 0 $clk_name
} elseif {[sizeof_collection [get_ports $clk_port_name]] == 0} {
  # Create virtual clock if clock port is not found
  set clk_name vclk
  create_clock -period $clk_period -name $clk_name
}

# Apply default timing constraints for modules
set_input_delay  [expr 2/3 * $clk_period] [all_inputs] -clock $clk_name
set_output_delay [expr 2/3 * $clk_period] [all_outputs] -clock $clk_name

# Transition time of a slope that drives the port,
# such that a higher transition value means longer delays
# This prevents the hold time violations that we don't have to care about
set_input_transition 0.1 [all_inputs]

# Area
# If max_area is set 0, DesignCompiler will minimize the design as small as possible
set_max_area 0 

# ---------------------------------------
# 3. Compilation
# ---------------------------------------
compile_ultra

# ---------------------------------------
# 4. Design Reports
# ---------------------------------------
check_design  > $topmodule_name.check_design.rpt

report_constraint -all_violators -verbose -sig 10 > $topmodule_name.all_viol.rpt

report_design > $topmodule_name.design.rpt
report_area -physical -hierarchy > $topmodule_name.area.rpt
report_cell > $topmodule_name.cell.rpt
report_qor > $topmodule_name.qor.rpt
report_reference > $topmodule_name.reference.rpt
report_resources > $topmodule_name.resources.rpt
report_hierarchy -full > $topmodule_name.hierarchy.rpt
report_timing -nworst 10 -max_paths 10 > $topmodule_name.timing.rpt
report_power -analysis_effort high > $topmodule_name.power.rpt
report_threshold_voltage_group > $topmodule_name.vth.rpt

# Dump out the constraints in an SDC file
write_sdc $topmodule_name.constraints.sdc

# Dump out the synthesized database and gate-level-netlist
write -hierarchy -format ddc -output      $topmodule_name.ddc
write -hierarchy -format verilog -output  $topmodule_name.netlist.v

exit
