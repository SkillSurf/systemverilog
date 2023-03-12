module p2s_tb;
  timeunit       1ns;
  timeprecision  1ps;

  logic clk = 0, rstn = 0;
  localparam CLK_PERIOD = 10;
  initial forever 
    #(CLK_PERIOD/2) 
    clk <= ~clk;

  parameter N = 8;
  logic [N-1:0] par_data;
  logic par_valid=0, par_ready, 
        ser_data, ser_valid, 
        ser_ready;

  p2s #(.N(N)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    
    @(posedge clk)  #1  rstn <= 1;
    @(posedge clk)  #1  par_data  <= 8'd7 ; par_valid <= 0; ser_ready <= 1;    
    #(CLK_PERIOD*3)
    @(posedge clk)  #1  par_data  <= 8'd62; par_valid <= 1;
    @(posedge clk)  #1  par_valid <= 0;
    #(CLK_PERIOD*10)
    @(posedge clk)  #1  par_data  <= 8'd52; par_valid <= 1;
    @(posedge clk)  #1  par_valid <= 0; 
    @(posedge clk)  #1  ser_ready <= 0;
    #(CLK_PERIOD*3)
    @(posedge clk)  #1  ser_ready <= 1;
    #(CLK_PERIOD*10)
    @(posedge clk)  #1  ser_ready <= 0;
    $finish();
  end
endmodule