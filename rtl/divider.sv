module divider #(parameter FREQ = 8)
(
	input  logic board_clk,
	output logic clk
);
    
	localparam COUNT_MAX = 125000000/(FREQ*2) - 1;  //125MHz Board Clock
    
	logic [31:0] count_reg = 32'd0;
    
	always_ff @(posedge board_clk) begin
		if (count_reg == COUNT_MAX) count_reg <= 0;
		else                        count_reg <= count_reg + 1'b1;
	end
    
	always_ff @(posedge board_clk) begin
		if (count_reg == COUNT_MAX) clk <= ~clk;
		else                        clk <= clk;
	end
    
endmodule
