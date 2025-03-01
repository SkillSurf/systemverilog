# Icarus Verilog Build

iv_axis: tb/simple_axis_tb.sv
	iverilog -g2012 -o run $^
iv_skid_buffer: rtl/skid_buffer.sv tb/skid_buffer_tb.sv tb/simple_axis_tb.sv
	iverilog -g2012 -o run $^
iv_uart_rx: rtl/uart_rx.sv tb/uart_rx_tb.sv
	iverilog -g2012 -o run $^
iv_uart_tx: rtl/uart_tx.sv tb/uart_tx_tb.sv
	iverilog -g2012 -o run $^
iv_mvm: rtl/matvec_mul.sv tb/matvec_mul_tb.sv
	iverilog -g2012 -o run $^
iv_axis_mvm: rtl/axis_matvec_mul.v rtl/matvec_mul.sv rtl/skid_buffer.sv tb/axis_matvec_mul_tb.sv tb/simple_axis_tb.sv
	iverilog -g2012 -o run $^

# Icarus Verilog Run

run_iv_axis: iv_axis
	vvp run
run_iv_skid_buffer: iv_skid_buffer
	vvp run
run_iv_uart_rx: iv_uart_rx
	vvp run
run_iv_uart_tx: iv_uart_tx
	vvp run
run_iv_mvm: iv_mvm
	vvp run
run_iv_axis_mvm: iv_axis_mvm
	vvp run


# All

all: run_iv_axis run_iv_skid_buffer run_iv_uart_rx run_iv_uart_tx run_iv_mvm run_iv_axis_mvm 
clean:
	rm -f run a.out dump.vcd

