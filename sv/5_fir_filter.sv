module fir_filter #(
  parameter  N = 5, W_X = 8, W_K = 3,
  parameter logic signed [W_K-1:0] K [N+1] = {
    8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6},//'{default:0},
  
  localparam W_Y = W_X + W_K + $clog2(N)
)(
  input  clk, rstn,
  input  logic signed [W_X-1:0] x,
  output logic signed [W_Y-1:0] y
);
  genvar n;
  logic signed [N:0][W_X-1:0] z;

  assign z[0] = x;
  always_ff @(posedge clk or negedge rstn)
    z[N:1] <= !rstn ? '0 : z[N-1:0];
  
  always_comb begin
    y = 0;
    for (int n=0; n < N+1; n=n+1)
      y = y + K[n] * z[n];
  end

endmodule

module fir_filter_2 #(
  parameter  N = 5, W_X = 8, W_K = 3,
  parameter logic signed [W_K-1:0] K [N+1] = {
    8'd1, 8'd2, 8'd3, 8'd4, 8'd5, 8'd6},//'{default:0},
  
  localparam W_M = W_X + W_K, W_Y = W_M + $clog2(N)
)(
  input  clk, rstn,
  input  logic signed [W_X-1:0] x,
  output logic signed [W_Y-1:0] y
);
  genvar n;
  logic signed [N  :0][W_M-1:0] m;
  logic signed [N  :0][W_Y-1:0] a;
  logic signed [N-1:0][W_Y-1:0] z;
  
  for (n=0; n<N+1; n=n+1)
    assign m[n] = x * K[N-n];

  assign a[0] = m[0];
  for (n=1; n<N+1; n=n+1)
    assign a[n] = m[n] + z[n-1];

  for (n=0; n<N; n=n+1)
    always_ff @(posedge clk or negedge rstn)
      z[n] <= !rstn ? '0 : a[n];

  assign y = a[N];
endmodule