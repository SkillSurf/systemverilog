#/**************************************************/
#/* DC Compile Script for Synopsys Tools           */
#/*                                                */
#/* dc_shell-t -f run_dc.tcl                       */
#/*                                                */
#/* SAED EDK 32nm                                  */
#/**************************************************/

# set the working directory path
set working_dir /evprj156/projects

# check if the provided working_dir path exists
if {![file exists $working_dir]} {
   puts "Error: $working_dir does not exists"
   exit 1
}

#/* Top-level Module  - MODIFY as required            */
set top_module full_adder; # set the variable top_module to hold the string "full_adder"

#/* All verilog .sv files should be placed inside rtl */
set rtlPath $working_dir/input/rtl/

#/* The name of the clock pin. If no clock-pin        */
#/* exists, pick anything                             */
set my_clock_pin clk

#/* Delay of input signals (Clock-to-Q, Package etc.)  */
# input delay is important to make sure that there won't be any setup time or hold time violation at the inputs to the module
set my_input_delay_ns 0.2; 

#/* Reserved time for output signals (Holdtime etc.)   */
# output delay is important to make sure that there won't be any setup time or hold time violations in the next system that this chip interfaces to
set my_output_delay_ns 0.2; 

# MODIFY as required - aedc4 might need to change
set PDKDIR $working_dir/tsmc_32nm/SAED32_EDK  
set SAED32_EDK $working_dir/tsmc_32nm/SAED32_EDK/lib 
set synopsys /global/etc/modules/files/eda/syn/2024.09-SP2 

#/**************************************************/
#/* No modifications needed below                  */
#/**************************************************/
# exec command in tcl scripting is used to run shell commands
exec mkdir -p $working_dir/log $working_dir/output $working_dir/report; # creates log, output and report directories in the parent directory to the current one

# creates a list of paths as search paths
# $SAED32_EDK/stdcell_hvt -> contain high threshold voltage standard cells of the SAED32_EDK PDK
# $SAED32_EDK/stdcell_hvt/db_nldm -> contain the non-linear delay model database files for characterising cells delays in HVT standard cells.
# ${synopsys}/libraries/syn -> contain generic synthesis libraries for mapping RTL to gates
# ${synopsys}/dw/syn_ver -> contain synthesizable verilog codes of DesignWare IPs (DesignWare is a library of IPs from Synopsys)
# ${synopsys}/dw/sim_ver -> contain simulation-only (non synthesizable) verilog codes of DesignWare IPs
set search_path [concat $search_path $SAED32_EDK]
set search_path [concat $search_path $SAED32_EDK/stdcell_hvt $SAED32_EDK/stdcell_hvt/db_nldm]
set search_path [concat $search_path ${synopsys}/libraries/syn ${synopsys}/dw/syn_ver ${synopsys}/dw/sim_ver]

# saed32hvt_ss0p7v125c.db -> contains the standard cells and their relevant information (eg: cell delays, setup/hold times etc.) of the SAED32_EDK PDK
# dw_foundation.sldb -> contains the DesignWare IPs and their relevant information
set link_library [concat  [list saed32hvt_ss0p7v125c.db] [list dw_foundation.sldb]]
set synthetic_library [list dw_foundation.sldb]
set target_library "saed32hvt_ss0p7v125c.db"

#Compiler directives
set compile_effort "low"
set compile_no_new_cells_at_top_level false
set hdlin_auto_save_templates false
set wire_load_mode enclosed
set timing_use_enhanced_capacitance_modeling true
set verilogout_single_bit false
remove_design -all; # remove all designs that are currently loaded into the tool's memory

# defines a design library named "WORK" and set its directory to be the ".template" folder in the current working directory
# a design library is a container for storing intermediate and final outputs in the synthesis process
# the directory is where those outputs will be saved in the filesystem.
define_design_lib WORK -path .template

# read RTL
# analyze the SystemVerilog files in the rtlPath. This analysis will check for syntax errors and semantic errors in the file.
analyze -format sverilog [glob ${rtlPath}*.sv] > $working_dir/log/1.${top_module}_analyse.log
# analyze the Verilog files in the rtlPath. This analysis will check for syntax errors and semantic errors in the file.
analyze -format verilog [glob ${rtlPath}*.v] > $working_dir/log/1.${top_module}_analyse.log

# converts the rtl into technology independent, generic gate-level netlist using the contents of "${synopsys}/libraries/syn" folder
# the heirarchy will be preserved
elaborate $top_module > $working_dir/log/2.${top_module}_elaborate.log

# set the module that we are working with as the $top_module (= full_adder)
current_design $top_module

# check whether the design is ready to be synthesized
# the logical correctness of the design, whether needed timing constraints are set etc. are checked here
check_design > $working_dir/log/3.${top_module}_check_design.rpt

# Link Design
link; # check whether the interconnections in the heirarchy are proper in the generic gate-level netlist created in the elaborate step
uniquify; # creates separate definitions of the submodules for each of its instantiations (done on the generic gate-level netlist)

# Default SDC Constraints (can be an sdc file)
set my_period 1.4

set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   # if the design have a port named "clk" then set the 0.7ns period to that signal
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   # if the design does not have a port named "clk" then make a virtual clock with period 0.7ns
   # this virtual clock will be the reference for the input and output delay
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
}

# set the input delay to all input ports except the clk port
set_input_delay $my_input_delay_ns -clock $clk_name [remove_from_collection [all_inputs] $my_clock_pin]

# set the output delay to all the output ports
set_output_delay $my_output_delay_ns -clock $clk_name [all_outputs]
#read_sdc ${top_module}.sdc

#More compiler directives
set compile_effort   "high"
set_app_var ungroup_keep_original_design true
set_register_merging [get_designs $top_module] false
set compile_seqmap_propagate_constants false
set compile_seqmap_propagate_high_effort false
# More constraints and setup before compile
foreach_in_collection design [ get_designs "*" ] {
	current_design $design
	#feedthrough / outputs / constants
	set_fix_multiple_port_nets -all
}
current_design $top_module

# Compile
compile -ungroup_all -map_effort medium -incremental_mapping -map_effort medium

check_design; # checks whether the synthesized design is free of errors
report_constraint -all_violators; # reports all timing violations, if any

# Write Out Design and Constraints - Hierarchical
current_design $top_module
change_names -rules verilog -hierarchy; # renames signals and instances in the synthesized design to suit the Verilog naming rules
write -format verilog -hierarchy -output $working_dir/output/${top_module}.out.v; # dump the synthesized design as a verilog file while preserving heirarchy
write -format ddc -output $working_dir/output/${top_module}.out.ddc
write_sdc $working_dir/output/${top_module}.sdc; # dump the design contraints used in this process

# Write Reports
report_port > $working_dir/report/${top_module}_port.rpt
report_area > $working_dir/report/${top_module}_area.rpt
report_cell > $working_dir/report/${top_module}_cell.rpt
report_reference > $working_dir/report/${top_module}_area_reference.rpt
report_power > $working_dir/report/${top_module}_power.rpt
report_timing -path full -max_paths 100 -nets -transition_time -capacitance -significant_digits 3 -nosplit >  $working_dir/report/${top_module}_timing.rpt

# start GUI
gui_start

#quit
