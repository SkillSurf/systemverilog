`timescale 1ns / 1ps

module example_tb;
  reg clk, a,b;
  wire c;
  wire [3-1:0] s1,s2;
  example dut (.clk(clk), .a(a), .b(b), .c(c), .s1(s1), .s2(s2));

  localparam CLK_PERIOD = 10;
  initial begin
    clk = 0;
    forever 
      #(CLK_PERIOD/2) 
      clk <= ~clk;
  end
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
    @(posedge clk);
    #1 a <= 1; b <= 1;
    @(posedge clk);
    #1 a <= 0; b <= 1;
    @(posedge clk);
    #1 a <= 1; b <= 1;
    @(posedge clk);
    $finish();
  end
endmodule