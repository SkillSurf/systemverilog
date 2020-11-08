module counter #(parameter N = 8)
(
  input  logic         clk  ,
  input  logic         rst  ,
  input  logic         incr ,
  output logic [N-1:0] count
);
  always_ff @(posedge clk) begin

    if      (rst ) count <= 0           ;
    else if (incr) count <= count + 1'b1;
    else           count <= count       ;

  end
endmodule