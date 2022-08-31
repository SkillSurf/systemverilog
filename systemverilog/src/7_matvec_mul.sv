`timescale 1ns/1ps

module matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,
    localparam DEPTH = $clog2(C),
               W_M = W_X + W_K,
               W_Y = W_M + DEPTH
  )(  
    input  logic clk,
    input  logic signed [R-1:0][C-1:0][W_K -1:0] k,
    input  logic signed        [C-1:0][W_X -1:0] x, 
    output logic signed        [R-1:0][W_Y -1:0] y
  );

  logic signed [W_Y-1:0] tree [DEPTH+1][R][C]; // adder tree

  genvar r, c, d, a;
  for (r=0; r<R; r=r+1) begin
    for (c=0; c<C; c=c+1)
      always_ff @(posedge clk)  // register after each mul
        tree[0][r][c] <= k[r][c] * x[c];

    for (d=0; d<DEPTH; d=d+1)
      for (a=0; a<C/2**(d+1); a=a+1)
        always_ff @(posedge clk)  // register after each add
          tree [d+1][r][a] <= tree [d][r][2*a] + tree[d][r][2*a+1]; 

    assign y[r] = tree[DEPTH][r][0];
  end
endmodule