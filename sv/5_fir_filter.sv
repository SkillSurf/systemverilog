`timescale 1ns/1ps

module fir_filter #(
  parameter  N = 5, W_X = 8, W_B = 3,
  parameter logic signed [W_B-1:0] B [N+1] = {
    8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6},//'{default:0},
  
  localparam W_M = W_X + W_B,
             W_Y = W_M + N + 1
)(
  input  clk, rstn,
  input  logic signed [W_X-1:0] x,
  output logic signed [W_Y-1:0] y
);

  genvar n;
  logic signed [W_X-1:0] z [N+1];
  logic signed [W_M-1:0] m [N+1];
  logic signed [W_Y-1:0] a [N+1];
  
  assign z[0] = x;
  
  for (n=1; n<= N; n=n+1)
    always_ff @(posedge clk or negedge rstn)
      if (~rstn) z[n] <= '0;
      else       z[n] <= z[n-1];

  for (n=0; n <= N; n=n+1) begin
    assign m[n] = B[n] * z[n];
    assign a[n] = n==0 ? m[0] : a[n-1] + m[n];
  end

  assign y = a[N];

endmodule