`timescale 1ns/1ps

module counter #(parameter WIDTH = 8)
(
  input  clk, rst, incr,
  output reg [WIDTH-1:0] count_reg
);

  always @(posedge clk) begin
    if      (rst)  count_reg <= 0;
    else if (incr) count_reg <= count_reg + 1'b1;
  end
  
endmodule
