#/**************************************************/
#/* DC Compile Script for Synopsys Tools           */
#/*                                                */
#/* dc_shell-t -f run_dc.tcl                       */
#/*                                                */
#/* SAED EDK 32nm                                  */
#/**************************************************/

#/* Top-level Module  - MODIFY as required            */
set top_module full_adder  

#/* All verilog .sv files should be placed inside rtl */
set rtlPath "../input/rtl/"

#/* The name of the clock pin. If no clock-pin        */
#/* exists, pick anything                             */
set my_clock_pin clk

#/* Target frequency in MHz for optimization          */
set my_clk_freq_MHz 1000   

#/* Delay of input signals (Clock-to-Q, Package etc.)  */
set my_input_delay_ns 0.2

#/* Reserved time for output signals (Holdtime etc.)   */
set my_output_delay_ns 0.2

# MODIFY as required - aedc4 might need to change
set PDKDIR /home/aedc4/libs/tsmc_32nm/SAED32_EDK
set SAED32_EDK /home/aedc4/libs/tsmc_32nm/SAED32_EDK/lib
set synopsys /home/aedc4/Apps/syn/T-2022.03-SP5-1

#/**************************************************/
#/* No modifications needed below                  */
#/**************************************************/
exec mkdir -p ../log ../output ../report

set search_path [concat $search_path $SAED32_EDK]
set search_path [concat $search_path $SAED32_EDK/stdcell_hvt $SAED32_EDK/stdcell_hvt/db_nldm]
set search_path [concat $search_path ${synopsys}/libraries/syn ${synopsys}/dw/syn_ver ${synopsys}/dw/sim_ver]

set link_library [set target_library [concat  [list saed32hvt_ss0p7v125c.db] [list dw_foundation.sldb]]]
set synthetic_library [list dw_foundation.sldb]
set target_library "saed32hvt_ss0p7v125c.db"

#Compiler directives
set compile_effort "low"
set compile_no_new_cells_at_top_level false
set hdlin_auto_save_templates false
set wire_load_mode enclosed
set timing_use_enhanced_capacitance_modeling true
set verilogout_single_bit false
remove_design -all

define_design_lib WORK -path .template

# read RTL
analyze -format sverilog [glob ${rtlPath}*.sv] > ../log/1.${top_module}_analyse.log
#analyze -format verilog [glob ${rtlPath}*.v] > ../log/1.${top_module}_analyse.log
elaborate $top_module > ../log/2.${top_module}_elaborate.log
current_design $top_module
check_design > ../log/3.${top_module}_check_design.rpt

# Link Design
link
uniquify

# Default SDC Constraints (can be an sdc file)
set my_period 0.7

set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
}

set_input_delay $my_input_delay_ns -clock $clk_name [remove_from_collection [all_inputs] $my_clock_pin]
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

check_design
report_constraint -all_violators

# Write Out Design and Constraints - Hierarchical
current_design $top_module
change_names -rules verilog -hierarchy
write -format verilog -hierarchy -output ../output/${top_module}.out.v
write -format ddc -output ../output/${top_module}.out.ddc
write_sdc ../output/${top_module}.sdc

# Write Reports
report_port > ../report/${top_module}_port.rpt
report_area > ../report/${top_module}_area.rpt
report_cell > ../report/${top_module}_cell.rpt
report_reference > ../report/${top_module}_area_reference.rpt
report_power > ../report/${top_module}_power.rpt
report_timing -path full -max_paths 100 -nets -transition_time -capacitance -significant_digits 3 -nosplit >  ../report/${top_module}_timing.rpt

# start GUI
gui_start

#quit
