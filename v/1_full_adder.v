`timescale 1ns/1ps

/*
  This code describes a full_adder circuit
*/
module full_adder 
(
  input  a, b, ci,
  output reg sum, co
);

  wire wire_1, wire_2;

  assign wire_1 = a ^ b;       // bitwise XOR
  assign wire_2 = wire_1 & ci; // bitwise AND
  
  wire   wire_3 = a & b;       // bitwise AND

  always @(*)  begin
    co  = wire_2 | wire_3;     // bitwise OR
    sum    = wire_1 ^ ci  ;    // bitwise XOR
  end

endmodule