#/**************************************************/
#/* ICC2 Compiler Script for Synopsys              */
#/*                                                */
#/* icc2_shell -f icc2.tcl                         */
#/*                                                */
#/* SAED EDK 32nm                                  */
#/**************************************************/

#  MODIFY as required

# set the working directory path
set working_dir /evprj156/projects 

#/* Top-level Module                                  */
set top_module full_adder

#/* Library Name                                      */
set library_name saed32_edk 

set PDKDIR /evprj156/projects/tsmc_32nm/SAED32_EDK
set SAED32_EDK /evprj156/projects/tsmc_32nm/SAED32_EDK/lib
set synopsys /global/etc/modules/files/eda/syn/2024.09-SP2

set search_path [concat $search_path $SAED32_EDK/stdcell_hvt $SAED32_EDK/stdcell_hvt/db_nldm]
set link_library {* saed32hvt_ss0p7v125c.db}
set_app_options -list {lib.configuration.default_flow_setup {}};
set_app_options -list {lib.configuration.output_dir {CLIBs}}
set_app_options -list {lib.configuration.lef_site_mapping {}}
set_app_options -list {lib.configuration.process_label_mapping {}}
set_app_options -list {lib.configuration.display_lm_messages {false}}

#----------------------------------------------
#   Create Library
#----------------------------------------------

create_lib -ref_libs {$working_dir/libs/saed32nm_hvt_1p9m.lef} -technology $working_dir/libs/saed32nm_1p9m_mw.tf $library_name

read_parasitic_tech -name {parasitics} -tlup {$working_dir/libs/saed32nm_1p9m_Cmax.tluplus} -layermap {$working_dir/libs/saed32nm_tf_itf_tluplus.map}

#---------------------------------------------
#   Create Block
#----------------------------------------------

read_verilog -library $library_name -top $top_module ../../output/${top_module}.out.v
link_block

save_block $library_name:$top_module
save_lib -all

#------------------------------------------------
#  Floorplan
#------------------------------------------------

initialize_floorplan -core_utilization 0.1 -core_offset {5}

#------------------------------------------
#  Power Rings
# -----------------------------------------

connect_pg_net -automatic -all_blocks

create_pg_ring_pattern ring_pattern -horizontal_layer M1 \
   -horizontal_width {1.5} -horizontal_spacing {0.5} \
   -vertical_layer M2 -vertical_width {1.5} -vertical_spacing {0.5}
set_pg_strategy core_ring \
   -pattern {{name: ring_pattern} \
   {nets: {VDD VSS}} {offset: {0.5 0.5}}} -core
compile_pg -strategies core_ring

# This will need to be done MANUALLY
create_pg_mesh_pattern mesh_pattern -layers { {{horizontal_layer: M1} {width: 0.75} {pitch: 15} {spacing: interleaving}}  {{vertical_layer: M2} {width: 0.84} {pitch: 33.6} {spacing: interleaving}} }
set_pg_strategy mesh_strategy -polygon {{1.000 4.880} {16.144 11.990}} -pattern {{pattern: mesh_pattern}{nets: {VDD VSS}}} -blockage {macros: all}
create_pg_std_cell_conn_pattern std_cell_pattern
set_pg_strategy std_cell_strategy -polygon {{1.000 4.880} {16.144 11.990}} -pattern {{pattern: std_cell_pattern}{nets: {VDD VSS}}}
compile_pg -ignore_via_drc

#------------------------------------------
#  Pin I/O - MODIFY the pins as required
# -----------------------------------------

set_app_options -name plan.pins.incremental -value true -block [current_block]
set_app_options -name plan.pins.layer_range -value 5 -block [current_block]
set_app_options -name plan.pins.pin_range -value 10.00 -block [current_block]
place_pins -self -ports {VDD VSS a b ci co sum}

save_lib -all

#------------------------------------------
#  Placement
# -----------------------------------------

set_app_options -name place.coarse.fix_hard_macros -value false
set_app_options -name plan.place.auto_create_blockages -value auto
create_placement -floorplan -timing_driven
save_lib -all

# -----------------------------------------
#  Route
# -----------------------------------------

#clock_opt
route_auto -max_detail_route_iterations 5
save_block $library_name:$top_module

save_lib -all

write_gds -hier all ${top_module}.gds

start_gui

#exit