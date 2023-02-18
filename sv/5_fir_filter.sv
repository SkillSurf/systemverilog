`timescale 1ns/1ps

module fir_filter #(
  parameter  N = 5, W_X = 8, W_K = 3,
  parameter logic signed [W_K-1:0] K [N+1] = {
    8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6},//'{default:0},
  
  localparam W_M = W_X + W_K,
             W_Y = W_M + N + 1
)(
  input  clk, rstn,
  input  logic signed [W_X-1:0] x,
  output logic signed [W_Y-1:0] y
);
  genvar n;
  logic signed [N:0][W_X-1:0] z;

  assign z[0] = x;
  always_ff @(posedge clk or negedge rstn)
    z[N:1] <= ~rstn ? '0 : z[N-1:0];
  
  always_comb begin
    y = 0;
    for (int n=0; n < N+1; n=n+1)
      y = y + K[n] * $signed(z[n]);
  end

endmodule