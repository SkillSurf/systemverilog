`timescale 1ns/1ps

module fir_filter #(
  parameter  N = 5,
             WIDTH_X = 8,
             WIDTH_B = 3,
  parameter logic [WIDTH_B*(N+1)-1:0] B = 0,
  
  localparam WIDTH_M = WIDTH_X + WIDTH_B,
             WIDTH_Y = WIDTH_M + N + 1
)(
  input  clk, rstn,
  input  signed [WIDTH_X-1:0] x,
  output signed [WIDTH_Y-1:0] y
);

  reg [WIDTH_X-1:0] z [N+1];
  wire [WIDTH_M-1:0] m [N+1];
  wire [WIDTH_Y-1:0] a [N+1];
  
  assign z[0] = x;

  always @(posedge clk or negedge rstn) begin
    for (int n=1; n <= N; n=n+1)
      if (~rstn) z[n] <= 0;
      else       z[n] <= z[n-1];
  end
  
  always @(*) begin
    for (int n=0; n <= N; n=n+1)
      m[n] = B[WIDTH_B*n +: WIDTH_B] * z[n];

  assign a[0] = m[0];
  end
  
  always @(*) begin
    for (int n=1; n <= N; n=n+1)
      a[n] = a[n-1] + m[n];
  end

  assign y = a[N];

endmodule