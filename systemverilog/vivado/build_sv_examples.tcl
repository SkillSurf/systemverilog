set PROJ_NAME sv_examples
set PROJ_FOLDER sv_examples
set SOURCE_FOLDER ../src

# Create project
create_project $PROJ_NAME ./$PROJ_FOLDER -part xc7z020clg484-1
set_property board_part xilinx.com:zc702:part0:1.4 [current_project]

# Add sources
add_files $SOURCE_FOLDER

# add_sub IP
set IP_NAME c_addsub_0
create_ip -name c_addsub -vendor xilinx.com -library ip -version 12.0 -module_name $IP_NAME 
set_property -dict [list CONFIG.A_Width {8} CONFIG.B_Width {8} CONFIG.Add_Mode {Add_Subtract} CONFIG.Latency_Configuration {Manual} CONFIG.CE {false} CONFIG.Out_Width {8} CONFIG.Latency {1} CONFIG.B_Value {00000000}] [get_ips $IP_NAME]

generate_target {instantiation_template} [get_files  $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
set_property generate_synth_checkpoint 0 [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
export_ip_user_files -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -directory $PROJ_FOLDER/$PROJ_NAME.ip_user_files/sim_scripts -ip_user_files_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files -ipstatic_source_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files/ipstatic -lib_map_path [list {modelsim=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/modelsim} {questa=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/questa} {riviera=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/riviera} {activehdl=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet

# add_sub IP
set IP_NAME c_addsub_1
create_ip -name c_addsub -vendor xilinx.com -library ip -version 12.0 -module_name $IP_NAME 
set_property -dict [list CONFIG.A_Width {8} CONFIG.B_Width {8} CONFIG.Add_Mode {Add} CONFIG.Latency_Configuration {Manual} CONFIG.CE {false} CONFIG.Out_Width {8} CONFIG.Latency {1} CONFIG.B_Value {00000000}] [get_ips $IP_NAME]

generate_target {instantiation_template} [get_files  $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
set_property generate_synth_checkpoint 0 [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
export_ip_user_files -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -directory $PROJ_FOLDER/$PROJ_NAME.ip_user_files/sim_scripts -ip_user_files_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files -ipstatic_source_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files/ipstatic -lib_map_path [list {modelsim=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/modelsim} {questa=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/questa} {riviera=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/riviera} {activehdl=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet


# Multiplier
set IP_NAME mult_gen_0
create_ip -name mult_gen -vendor xilinx.com -library ip -version 12.0 -module_name mult_gen_0 -dir u:/aba/Desktop_Win/missing_semester/systemverilog/vivado/sv_examples/sv_examples.srcs/sources_1/ip
set_property -dict [list CONFIG.PortAWidth {8} CONFIG.PortBWidth {8} CONFIG.Multiplier_Construction {Use_Mults} CONFIG.Use_Custom_Output_Width {true} CONFIG.OutputWidthHigh {7}] [get_ips $IP_NAME]

generate_target {instantiation_template} [get_files  $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
set_property generate_synth_checkpoint 0 [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
export_ip_user_files -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -directory $PROJ_FOLDER/$PROJ_NAME.ip_user_files/sim_scripts -ip_user_files_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files -ipstatic_source_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files/ipstatic -lib_map_path [list {modelsim=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/modelsim} {questa=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/questa} {riviera=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/riviera} {activehdl=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet

# Divider
set IP_NAME div_gen_0
create_ip -name div_gen -vendor xilinx.com -library ip -version 5.1 -module_name div_gen_0 -dir u:/aba/Desktop_Win/missing_semester/systemverilog/vivado/sv_examples/sv_examples.srcs/sources_1/ip
set_property -dict [list CONFIG.dividend_and_quotient_width {8} CONFIG.divisor_width {8} CONFIG.latency_configuration {Manual} CONFIG.latency {1} CONFIG.fractional_width {8}] [get_ips $IP_NAME]

generate_target {instantiation_template} [get_files  $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
set_property generate_synth_checkpoint 0 [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci]
export_ip_user_files -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -no_script -sync -force -quiet
export_simulation -of_objects [get_files $PROJ_FOLDER/$PROJ_NAME.srcs/sources_1/ip/$IP_NAME/$IP_NAME.xci] -directory $PROJ_FOLDER/$PROJ_NAME.ip_user_files/sim_scripts -ip_user_files_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files -ipstatic_source_dir $PROJ_FOLDER/$PROJ_NAME.ip_user_files/ipstatic -lib_map_path [list {modelsim=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/modelsim} {questa=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/questa} {riviera=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/riviera} {activehdl=$PROJ_FOLDER/$PROJ_NAME.cache/compile_simlib/activehdl}] -use_ip_compiled_libs -force -quiet
