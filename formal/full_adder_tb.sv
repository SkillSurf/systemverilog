`timescale 1ns / 1ps
module full_adder_tb;
  logic a, b, ci;
  logic sum, co;

  full_adder dut (.a(a), .b(b), .ci(ci), .sum(sum), .co(co));

  // All inputs are free (symbolic)
  always_comb
    assert ({co, sum} == (2'(a) + 2'(b) + 2'(ci)));
endmodule