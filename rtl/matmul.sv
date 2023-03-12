module matmul #(
    parameter N, WIDTH
  )(  
    input  logic                 clk,
    input  logic [N*N*WIDTH-1:0] A_flat,
    input  logic [N*N*WIDTH-1:0] B_flat,
    output logic [N*N*WIDTH-1:0] C_flat
  );

  logic signed [WIDTH-1:0] A [0:N-1][0:N-1];
  logic signed [WIDTH-1:0] B [N][N];
  logic signed [WIDTH-1:0] C [N][N];

  assign A = {>>{{<<{A_flat}}}}; // A = {<<{A_flat}};
  assign B = {>>{{<<{B_flat}}}};
  assign {<<{C_flat}} = C;

  generate
    for (genvar i=0; i<N; i++) begin:rows
      for (genvar j=0; j<N; j++) begin:cols

        localparam DEPTH = $clog2(N);
        logic signed [WIDTH-1:0] tree [0:DEPTH][0:N-1];

        for (genvar k=0; k<N; k++) begin:mul
          logic [2*WIDTH-1:0] mul_out;
          mult_gen_0 mul (
              .CLK(clk       ),
              .A  (A   [i][k]),
              .B  (B   [k][j]),
              .P  (mul_out   )
          );
          assign tree[0][k] = WIDTH'(signed'(mul_out));
        end

        for (genvar d=0; d<DEPTH; d++) begin: depth
          for (genvar a=0; a<N/(2**(d+1)); a++) begin: add
              c_addsub_1 add (
                .A   (tree[d][2*a  ]),
                .B   (tree[d][2*a+1]),
                .CLK (clk           ),
                .S   (tree[d+1][a]  )
              );
          end
        end

        assign C[i][j] = tree[DEPTH][0];

      end
    end
  endgenerate
endmodule