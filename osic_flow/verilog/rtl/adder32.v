module adder32 (A, B, Ci, S, Co);

input reg [31:0] A;
input reg [31:0] B;
input reg Ci;
output wire [31:0] S;
output wire Co;

wire[32:0] Sum33;

assign Sum33 = A + B + Ci ;
assign S = Sum33[31:0] ;
assign Co = Sum33[32] ;

endmodule
