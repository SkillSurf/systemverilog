`timescale 1ns / 1ps

module n_adder_2 #(
  parameter N=4
)(
  input  logic signed [N-1:0] A, B,
  input  logic ci,
  output logic signed [N-1:0] S,
  output logic co
);
  assign {co,S} = A + B + ci;
endmodule
