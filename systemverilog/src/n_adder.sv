module n_adder
#(
  parameter N
)(
  input  logic [N-1:0] A    ,
  input  logic [N-1:0] B    ,
  input  logic         c_in ,
  output logic [N-1:0] S    ,
  output logic         c_out
);
  logic [N:0] C;
  assign C[0]  = c_in;
  assign c_out = C[N];

  generate
    for (genvar i=0; i<N; i++) begin:add
      full_adder fa (
        .a      (A[i  ]),
        .b      (B[i  ]),
        .c_in   (C[i  ]), 
        .c_out  (C[i+1]),
        .sum    (S[i  ])
        );
    end
  endgenerate
endmodule