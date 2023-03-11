module matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,
    localparam DEPTH = $clog2(C),
               W_M = W_X + W_K,
               W_Y = W_M + DEPTH
  )(  
    input  logic clk, cen,
    input  logic signed [R-1:0][C-1:0][W_K-1:0] k,
    input  logic signed        [C-1:0][W_X-1:0] x, 
    output logic signed        [R-1:0][W_Y-1:0] y
  );

  logic signed [W_Y-1:0] tree [R][DEPTH+1][C]; // adder tree

  genvar r, c, d, a;
  for (r=0; r<R; r=r+1) begin
    for (c=0; c<C; c=c+1)
      always_ff @(posedge clk)  // register after each mul
        if (cen) tree[r][0][c] <= k[r][c] * x[c];

    for (d=0; d<DEPTH; d=d+1)
      for (a=0; a<C/2**(d+1); a=a+1)
        always_ff @(posedge clk)  // register after each add
          if (cen) tree [r][d+1][a] <= tree [r][d][2*a] + tree [r][d][2*a+1];

    assign y[r] = tree [r][DEPTH][0];
  end
endmodule