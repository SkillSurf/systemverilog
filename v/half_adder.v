/*
  This code describes a half_adder circuit
*/

module half_adder 
(
  input  A,
  input  B,
  output carry,
  output sum
);

  assign carry = A & B; // bitwise AND
  assign sum   = A ^ B; // bitwise XOR

endmodule