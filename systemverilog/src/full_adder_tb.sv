module full_adder_tb ();

  timeunit 1ns;
  timeprecision 1ps;

  localparam CLK_PERIOD = 10;
  logic clk;
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk <= ~clk;
  end

  logic a     = 0;
  logic b     ; // = 0, intentional
  logic c_in  = 0;
  logic sum   ;
  logic c_out ;

  full_adder fa (.*);


  initial begin
    // Simulation starts

    @(posedge clk);
    #(CLK_PERIOD*3);

    @(posedge clk);
    a  <= 0;
    b  <= 0;
    c_in <= 0;

    @(posedge clk);
    a  <= 0;
    b  <= 0;
    c_in <= 1;

    #(CLK_PERIOD*2);
    @(posedge clk);
    a  <= 1;
    b  <= 1;
    c_in <= 0;
    @(posedge clk);
    a  <= 1;
    b  <= 1;
    c_in <= 1;

  end
endmodule