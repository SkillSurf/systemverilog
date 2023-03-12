class Random_Num #(WIDTH=8);
  rand bit signed [WIDTH-1:0] num;
endclass

class Random_Sel;
  rand bit [2:0] num;
  constraint c {num inside {[0:4]};}

  function new();
    this.num = 3'd4;
  endfunction
endclass

module alu_tb;
  timeunit 1ns/1ps;

  localparam WIDTH = 8;
  logic        [2:0]       alu_sel;
  logic signed [WIDTH-1:0] bus_a,bus_b,alu_out;
  logic                    zero, negative;

  alu #(.WIDTH(WIDTH)) dut (.*);

  Random_Num #(.WIDTH(WIDTH)) A_r = new(), B_r = new();
  Random_Sel sel_r = new();

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);

    repeat(5) begin
      #10
      bus_a <= A_r.num; bus_b <= B_r.num; alu_sel <= sel_r.num;
      
      A_r.randomize();
      B_r.randomize();
      sel_r.randomize();
    end

    #30 bus_a <= 8'd5;  bus_b <=  8'd10; alu_sel <= 3'b000;
    #10 bus_a <= 8'd30; bus_b <= -8'd10; alu_sel <= 3'b001;
    #10 bus_a <= 8'd5;  bus_b <=  8'd10; alu_sel <= 3'b010;
    #10 bus_a <= 8'd51; bus_b <=  8'd17; alu_sel <= 3'b011;
  end
endmodule