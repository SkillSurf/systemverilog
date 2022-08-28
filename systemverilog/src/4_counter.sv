module counter #(parameter WIDTH = 8)
(
  input  logic clk, rst, incr,
  output logic [WIDTH-1:0] count_reg
);
  always_ff @(posedge clk) begin
    if      (rst)  count_reg <= 0;
    else if (incr) count_reg <= count_reg + 1'b1;
  end
endmodule