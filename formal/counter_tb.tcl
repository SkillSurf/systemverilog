vlog -sv rtl/counter.sv
vlog -sv formal/counter_tb.sv

formal compile -d counter_tb -sva

formal verify  -auto_constraint_off