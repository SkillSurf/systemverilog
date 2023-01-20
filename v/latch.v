module latch(
  input  logic a  ,
  input  logic sel,
  output logic b
);
  always_comb
    case (sel)
      1'b1   : b = a;
     // default: b = 0;
    endcase

endmodule