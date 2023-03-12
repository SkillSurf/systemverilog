`timescale 1ns/1ps

module function_lut_tb;

  localparam W_X=4, W_Y=8;
  logic signed [W_X-1:0] xf = 3, xq = 3, xiq;
  logic signed [W_Y-1:0] yiq = 3, yf, yq_lut, yq_fun;
  function_lut #(.W_X(W_X), .W_Y(W_Y)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    #20 $finish;
  end
endmodule