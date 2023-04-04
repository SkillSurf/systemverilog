#/**************************************************/
#/* DC Compile Script for Synopsys Tool            */
#/*                                                */
#/* dc_shell-t -f run_dc.tcl                       */
#/*                                                */
#/* OSU FREEPDK 45nm                               */
#/**************************************************/

#/* Top-level Module                                  */
set top_module full_adder

#/* All verilog .sv files should be placed inside rtl */
set rtlPath "../input/rtl/"

#/* The name of the clock pin. If no clock-pin        */
#/* exists, pick anything                             */
set my_clock_pin clk

#/* Target frequency in MHz for optimization          */
set my_clk_freq_MHz 1000   

#/* Delay of input signals (Clock-to-Q, Package etc.)  */
set my_input_delay_ns 0.1

#/* Reserved time for output signals (Holdtime etc.)   */
set my_output_delay_ns 0.1

#/**************************************************/
#/* No modifications needed below                  */
#/**************************************************/
exec mkdir -p ../log ../output ../report

set PDKDIR /home/aedc4/Software/FreePDK45
set OSU_FREEPDK /home/aedc4/Software/FreePDK45/osu_soc/lib/files
set search_path [concat  $search_path $OSU_FREEPDK]
set alib_library_analysis_path $OSU_FREEPDK

set link_library [set target_library [concat  [list gscl45nm.db] [list dw_foundation.sldb]]]
set synthetic_library [list dw_foundation.sldb]
set target_library "gscl45nm.db"
define_design_lib WORK -path ./WORK
set verilogout_show_unconnected_pins "true"

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
#analyze -format verilog [glob ${rtlPath}*.v]
elaborate $top_module > ../log/2.${top_module}_elaborate.log
current_design $top_module
check_design > ../log/3.${top_module}_check_design.rpt

# Link Design
link
uniquify

# Default SDC Constraints (can be an sdc file)
set my_period [expr 1000 / $my_clk_freq_MHz]

set find_clock [ find port [list $my_clock_pin] ]
if {  $find_clock != [list] } {
   set clk_name $my_clock_pin
   create_clock -period $my_period $clk_name
} else {
   set clk_name vclk
   create_clock -period $my_period -name $clk_name
}

set_driving_cell  -lib_cell INVX1  [all_inputs]
set_input_delay $my_input_delay_ns -clock $clk_name [remove_from_collection [all_inputs] $my_clock_pin]
set_output_delay $my_output_delay_ns -clock $clk_name [all_outputs]

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
write_sdc ../output/${top_module}.sdc

# Write Reports
report_port > ../report/${top_module}_port.rpt
report_area > ../report/${top_module}_area.rpt
report_cell > ../report/${top_module}_cell.rpt
report_reference > ../report/${top_module}_area_reference.rpt
report_power > ../report/${top_module}_power.rpt
report_timing -path full -max_paths 100 -nets -transition_time -capacitance -significant_digits 3 -nosplit >  ../report/${top_module}_timing.rpt

set unmapped_designs [get_designs -filter "is_unmapped == true" $top_module]
if {  [sizeof_collection $unmapped_designs] != 0 } {
	echo "****************************************************"
	echo "* ERROR!!!! Compile finished with unmapped logic.  *"
	echo "****************************************************"
}

# start GUI
gui_start

#quit
