module counter_wrapper(
	input  logic board_clk, rst, incr,
	output logic [3:0] count_reg
);
    
	wire clk;
	
	counter #(.WIDTH(4)) Counter_1 (.*);
	divider #(.FREQ(1)) Divider_1 (.*); // FREQ set to 1 Hz
    
endmodule
