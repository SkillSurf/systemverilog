module p2s_tb;
  timeunit       1ns;
  timeprecision  1ps;

  reg clk = 0, rstn = 0;
  localparam CLK_PERIOD = 10;
  initial forever 
    #(CLK_PERIOD/2) 
    clk <= ~clk;

  parameter N = 8;
  reg [N-1:0] p_data;
  reg p_valid, s_ready;
  wire p_ready, s_data, s_valid;

  p2s #(.N(N)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
    @(posedge clk)  #1  rstn <= 1;
    @(posedge clk)  #1  p_data  <= 8'd7 ; p_valid <= 0; s_ready <= 1;    
    #(CLK_PERIOD*3)
    @(posedge clk)  #1  p_data  <= 8'd62; p_valid <= 1;
    @(posedge clk)  #1  p_valid <= 0;
    #(CLK_PERIOD*10)
    @(posedge clk)  #1  p_data  <= 8'd52; p_valid <= 1;
    @(posedge clk)  #1  p_valid <= 0; 
    @(posedge clk)  #1  s_ready <= 0;
    #(CLK_PERIOD*3)
    @(posedge clk)  #1  s_ready <= 1;
    #(CLK_PERIOD*10)
    @(posedge clk)  #1  s_ready <= 0;
    $finish();
  end
endmodule
