`timescale 1ns/1ps

module n_adder_tb;

localparam N = 4;
logic signed [N-1:0] A, B, S;
logic ci, co;

n_adder #(.N(N)) dut (.A(A), .B(B), .ci(ci), .S(S), .co(co));

// All inputs are free (symbolic)
always_comb
  assert ({co, S} == $signed(A) + $signed(B) + $signed(N'(ci)));


endmodule