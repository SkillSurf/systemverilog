// Code your design here
module example (
    input   clk,a,b,
    output  c,
    output reg   [3-1:0] s1=0, //TODO: also works without reg
    output reg [3-1:0] s2=7
  );
  
  assign c = a & b;

  always @(posedge clk)
    s1 <= s1 + 1;

  always @(posedge clk)
    s2 <= s2 - 1;

endmodule