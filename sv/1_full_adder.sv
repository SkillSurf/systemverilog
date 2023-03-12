/*
  This code describes a full_adder circuit
*/
module full_adder (
  input  logic a, b, ci,
  output logic sum, co
);

  logic wire_1, wire_2;
  assign wire_1 = a ^ b;       // bitwise XOR
  assign wire_2 = wire_1 & ci; // bitwise AND
  
  wire   wire_3 = a & b;       // bitwise AND

  always_comb begin
    co  = wire_2 | wire_3;     // bitwise OR
    sum    = wire_1 ^ ci  ;    // bitwise XOR
  end

endmodule

module full_adder_2 (
  input  logic a, b, ci,
  output logic sum, co
);
  assign {co, sum} = a + b + ci;
endmodule