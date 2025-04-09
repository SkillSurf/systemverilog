module matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,
    localparam DEPTH = $clog2(C),
               W_M = W_X + W_K,
               W_Y = W_M + DEPTH
  )(  
    input  wire  clk, cen,
    input  wire  [R*C*W_K-1:0] kf,
    input  wire  [C*W_X  -1:0] xf, 
    output wire  [R*W_Y  -1:0] yf       
  );

  // Padding
  localparam C_PAD = 2**$clog2(C);
  reg [W_Y-1:0] tree [R][DEPTH+1][C_PAD]; // adder tree

  wire signed [W_X-1:0] x_pad        [C_PAD-1:0];
  wire signed [W_K-1:0] k_pad [R-1:0][C_PAD-1:0];

  genvar r, c, d, a;
  generate

    for (c=0; c<C_PAD; c=c+1) begin
      assign x_pad[c] = (c < C) ? xf[(c+1)*W_X-1 : c*W_X] : 0;
      for (r=0; r<R; r=r+1)
        assign k_pad[r][c] = (c < C) ? kf[((r*C + c) + 1)*W_K-1 : (r*C + c)*W_K] : 0;
    end

    for (r=0; r<R; r=r+1) begin
      for (c=0; c<C_PAD; c=c+1)
        always @(posedge clk)  // register after each mul
          if (cen) tree[r][0][c] <= $signed(k_pad[r][c]) * $signed(x_pad[c]);

      for (d=0; d<DEPTH; d=d+1)
        for (a=0; a<C_PAD/2**(d+1); a=a+1)
          always @(posedge clk)  // register after each add
            if (cen) tree [r][d+1][a] <= tree [r][d][2*a] + tree [r][d][2*a+1];

      assign yf[(r+1)*W_Y-1: r*W_Y] = tree [r][DEPTH][0];
    end
  endgenerate
endmodule