module n_adder #(
  parameter N=4
)(
  input  logic signed [N-1:0] A, B,
  input  logic ci,
  output logic signed [N-1:0] S,
  output logic co
);
  logic C [N:0];
  assign C[0] = ci;
  assign co = C[N];

  genvar i; 
  for (i=0; i<N; i=i+1) begin:add
    // full_adder fa (A[i],B[i],C[i],C[i+1],S[i]);
    full_adder fa (
      .a    (A[i  ]),
      .b    (B[i  ]),
      .ci   (C[i  ]),
      .co   (C[i+1]),
      .sum  (S[i  ])
    );
  end
endmodule


module n_adder_2 #(
  parameter N=4
)(
  input  logic signed [N-1:0] A, B,
  input  logic ci,
  output logic signed [N-1:0] S,
  output logic co
);
  assign {co,S} = A + B + ci;
endmodule