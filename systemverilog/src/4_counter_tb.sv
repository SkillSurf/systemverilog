module counter_tb;
  
  timeunit 1ns/1ps;
  localparam WIDTH = 8;

  logic clk=0, rst, incr;
  logic [WIDTH-1:0] count_reg;

  counter #(.WIDTH(WIDTH)) dut (.*);
  
  localparam CLK_PERIOD = 10;
  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);
    
    #(CLK_PERIOD * 2)
    @(posedge clk);
    #1 rst  <= 1;

    repeat(2) @(posedge clk);
    #1 incr <= 1;

    @(posedge clk);
    #1 rst  <= 0; incr <= 1;

    repeat(4) @(posedge clk);
    #1 incr <= 0;

    repeat(4) @(posedge clk);
    #1 rst  <= 1;
    
    $finish();
  end
endmodule