module example(input  logic clk,a,b,
         output logic c, 
         output logic s1=0,
         output logic s2=0);

  assign c = a + b;

  always_ff@(posedge clk)
    s1  <=  s1 + 1;

  always_ff@(posedge clk)
    s2 <= s2 + 1;

endmodule