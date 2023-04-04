#/**************************************************/
#/* ICC2 Compiler Script for Synopsys              */
#/*                                                */
#/* icc2_shell -f icc.tcl                             */
#/*                                                */
#/* SAED EDK 32nm                                  */
#/**************************************************/

set PDKDIR /home/aedc4/libs/tsmc_32nm/SAED32_EDK
set SAED32_EDK /home/aedc4/libs/tsmc_32nm/SAED32_EDK/lib
set synopsys /home/aedc4/Apps/syn/T-2022.03-SP5-1
#set synopsys /home/aedc4/synopsys/syn/T-2022.03-SP5-1

set search_path [concat $search_path $SAED32_EDK]
set search_path [concat $search_path $SAED32_EDK/stdcell_hvt $SAED32_EDK/stdcell_hvt/db_nldm]
set search_path [concat $search_path ${synopsys}/libraries/syn ${synopsys}/dw/syn_ver ${synopsys}/dw/sim_ver]
#set search_path [concat $search_path $proj/input]
set alib_library_analysis_path $SAED32_EDK

set link_library [set target_library [concat  [list saed32hvt_ss0p7v125c.db] [list dw_foundation.sldb]]]
set synthetic_library [list dw_foundation.sldb]
set target_library "saed32hvt_ss0p7v125c.db"

set std_cell_home /home/aedc4/libs/tsmc_32nm/SAED32_EDK/lib/stdcell_hvt/db_nldm
set lib_home /home/aedc4/libs/tsmc_32nm/SAED32_EDK/lib/stdcell_hvt

set_app_var search_path "* $std_cell_home"
#set_app_var target_library "saed32hvt_ss0p7v125c.db"
set_app_var link_library "* $target_library"

#remove_design -all

#---------------------------------------------
#   Create Milkyway Database
#----------------------------------------------

set mw_logic0_net VSS
set mw_logic1_net VDD

set_tlu_plus_files -max_tluplus ../libs/saed32nm_1p9m_Cmax.tluplus -min_tluplus ../libs/saed32nm_1p9m_Cmin.tluplus -tech2itf_map  ../libs/saed32nm_tf_itf_tluplus.map

create_mw_lib -technology ../libs/saed32nm_1p9m_mw.tf -mw_reference_library {../libs/milkyway/saed32nm_hvt_1p9m} -bus_naming_style {[%d]}  -open  ./full_adder

read_verilog -dirty_netlist {../output/full_adder.out.v}

uniquify_fp_mw_cel
current_design full_adder

link

source ../output/full_adder.sdc

check_timing


#------------------------------------------------
#  Floorplan
#------------------------------------------------

derive_pg_connection -power_net VDD -power_pin VDD -ground_net VSS -ground_pin VSS
derive_pg_connection -power_net VDD -ground_net VSS -tie

derive_pg_connection -create_net

create_floorplan -control_type aspect_ratio -core_aspect_ratio 1 -core_utilization 0.7 \
      -left_io2core 10 -bottom_io2core 10 -right_io2core 10 -top_io2core 10 \
      -start_first_row -flip_first_row

derive_pg_connection -verbose

set_power_plan_strategy s1 -core -nets {VDD VSS} \
   -template ../scripts/power_mesh.tcl:top -extension {{stop: outermost_ring}}
compile_power_plan -strategy s1

preroute_standard_cells -nets {VDD VSS} -connect both -fill_empty_rows

save_mw_cel -as init_design_icc


#------------------------------------------
#      Placement
# -----------------------------------------

set_app_var timing_enable_multiple_clocks_per_reg true
set_fix_multiple_port_nets -all -buffer_constants

set_ignored_layers -max_routing_layer M8 -min_routing_layer M1  
set_app_var enable_recovery_removal_arcs true

set_ideal_network [all_fanout -flat -clock_tree ]
set_app_var compile_instance_name_prefix icc_place

place_opt -continue_on_missing_scandef

save_mw_cel -as place_opt


#-------------------------
#    CTS
#-------------------------

set_clock_tree_references -references INVX4_HVT
define_routing_rule iccrm_clock_double_spacing -default_reference_rule -multiplier_spacing 2

set_clock_tree_options -layer_list "M5 M6"
set_app_var cts_instance_name_prefix CTS
set_delay_calculation_option -arnoldi_effort medium

clock_opt -only_cts -no_clock_route

remove_ideal_network [all_fanout -flat -clock_tree]

set_fix_hold [all_clocks]

clock_opt -no_clock_route -only_psyn -area_recovery
route_zrt_group -all_clock_nets -reuse_existing_global_route true

save_mw_cel -as clock_opt_icc

#----------------------------
#   ROUTE
#----------------------------

set_si_options -delta_delay true  -route_xtalk_prevention true \
               -route_xtalk_prevention_threshold 0.25 -analysis_effort medium

set_route_zrt_common_options -post_detail_route_redundant_via_insertion medium


set_route_zrt_common_options -post_detail_route_redundant_via_insertion medium

route_opt -initial_route_only
route_opt -skip_initial_route -xtalk_reduction

save_mw_cel -as route_opt_icc

exit
