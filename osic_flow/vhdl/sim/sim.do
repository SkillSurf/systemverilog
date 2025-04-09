-- For Simulation in ModelSim
vlib work
vmap work work
vcom -work work ../rtl/constants_p.vhd
vcom -work work ../rtl/counter_ea.vhd
vcom -work work ../rtl/counter_board.vhd
vcom -work work counter_tb.vhd

vsim work.counter_tb

do wave.do

when -label end_of_simulation {tb_end == '1'} {echo "End of simulation" ; stop;}
run -a