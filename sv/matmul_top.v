// matmul_top.v

module matmul_top #(
  parameter N     = 4,
  parameter WIDTH = 4
)(
  input  wire clk,
  input  wire [N*N*WIDTH-1:0] A_flat,
  input  wire [N*N*WIDTH-1:0] B_flat,
  output wire [N*N*WIDTH-1:0] C_flat
);
  matmul #(
    .N      (N    ), 
    .WIDTH  (WIDTH)
  ) matmul_0 (
    .clk    (clk   ),
    .A_flat (A_flat),
    .B_flat (B_flat),
    .C_flat (C_flat)
  );
endmodule