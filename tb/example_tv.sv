module example_tb;
  timeunit      1ns;
  timeprecision 1ps;

  logic clk, a,b,c;
  logic [3-1:0] s1,s2;
  example dut (.*);

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