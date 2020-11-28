class Random_Num #(WIDTH);
  rand bit signed [WIDTH-1:0] num;
endclass

class Random_Sel;
  rand bit [2:0] num;
  constraint c {num inside {[0:4]};}

  function new();
    this.randomize();    
  endfunction
  
endclass

module alu_tb ();
  timeunit 1ns; timeprecision 1ps;
  logic clk = 0;
  localparam CLK_PERIOD = 10;
  initial begin
    forever #(CLK_PERIOD/2) clk <= ~clk;
  end

  localparam WIDTH = 8;
  logic        [2:0] sel;
  logic signed [WIDTH-1:0] A,B,C;
  logic Z;

  alu #(.WIDTH(WIDTH)) dut (.*);

  Random_Num #(.WIDTH(WIDTH)) A_r, B_r;
  Random_Sel sel_r;

  initial begin
    A   <= 8'd5;
    B   <= 8'd10;
    sel <= 3'b000;
    @(posedge clk);
    A   <= 8'd30;
    B   <= -8'd10;
    sel <= 3'b001;
    @(posedge clk);
    A   <= 8'd5;
    B   <= 8'd10;
    sel <= 3'b010;
    @(posedge clk);
    A   <= 8'd51;
    B   <= 8'd17;
    sel <= 3'b011;

    repeat(10) begin
      @(posedge clk);
      A_r = new();
      A_r.randomize();
      B_r = new();
      B_r.randomize();
      sel_r = new();

      A   <= A_r.num;
      B   <= B_r.num;
      sel <= sel_r.num;
    end
  end

endmodule