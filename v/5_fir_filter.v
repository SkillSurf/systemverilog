`timescale 1ns/1ps

module fir_filter #(
  parameter  N = 5,
             WIDTH_X = 8,
             WIDTH_B = 3,
  parameter logic [WIDTH_B-1:0] B [N+1] = '{default:0},
  
  localparam WIDTH_M = WIDTH_X + WIDTH_B,
             WIDTH_Y = WIDTH_M + N + 1
)(
  input  clk, rstn,
  input  logic signed [WIDTH_X-1:0] x,
  output logic signed [WIDTH_Y-1:0] y
);

  logic [WIDTH_X-1:0] z [N+1];
  logic [WIDTH_M-1:0] m [N+1];
  logic [WIDTH_Y-1:0] a [N+1];
  
  assign z[0] = x;

  always_ff @(posedge clk or negedge rstn)
    for (int n=1; n <= N; n=n+1)
      if (~rstn) z[n] <= 0;
      else       z[n] <= z[n-1];

  always_comb
    for (int n=0; n <= N; n=n+1)
      m[n] = B[n] * z[n];

  assign a[0] = m[0];
  
  always_comb
    for (int n=1; n <= N; n=n+1)
      a[n] = a[n-1] + m[n];

  assign y = a[N];

endmodule