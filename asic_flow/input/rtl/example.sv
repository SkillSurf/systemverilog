module example (
    input  logic clk,a,b,
    output logic c,
    output logic [3-1:0] s1=0, 
    output logic [3-1:0] s2=7
  );
  
  assign c = a & b;

  always_ff @(posedge clk)
    s1 <= s1 + 1;

  always_ff @(posedge clk)
    s2 <= s2 - 1;

endmodule