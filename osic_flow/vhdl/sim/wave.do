onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider CONSTANTs
add wave -noupdate /counter_tb/dut_counter/counter_0/COUNTER_BITWIDTH
add wave -noupdate /counter_tb/dut_counter/counter_0/COUNTER_MAX
add wave -noupdate -divider INPUTs
add wave -noupdate /counter_tb/dut_counter/clock_i
add wave -noupdate /counter_tb/dut_counter/reset_n_i
add wave -noupdate /counter_tb/dut_counter/enable_i
add wave -noupdate -divider OUTPUTs
add wave -noupdate -radix unsigned /counter_tb/dut_counter/counter_value_o
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {0 ps} 0}
quietly wave cursor active 0
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits us
update
WaveRestoreZoom {0 ps} {4200 ns}
