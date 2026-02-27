`timescale 1ns / 1ps

module full_adder_2 (
  input  logic a, b, ci,
  output logic sum, co
);
  assign {co, sum} = a + b + ci;
endmodule
