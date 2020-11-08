module alu #(
  parameter N = 8
)(
  input  logic [ 2 :0] sel,
  input  logic [N-1:0] A  ,
  input  logic [N-1:0] B  ,
  output logic [N-1:0] C  ,
  output logic         Z
);

  always_comb begin
    unique case(sel)
      3'b000 : C = A +  B;
      3'b001 : C = A -  B;
      3'b010 : C = A *  B;
      3'b011 : C = A /  B;
      3'b100 : C = A %  B;
      default: C = A     ;
    endcase
  end
  
  // always_comb begin
  //   if    (sel == 3'b000) C = A +  B;
  //   else if (sel == 3'b001) C = A -  B;
  //   else if (sel == 3'b010) C = A *  B;
  //   else if (sel == 3'b011) C = A /  B;
  //   else if (sel == 3'b100) C = A %  B;
  //   else                    C = A     ;
  // end
  assign Z = (C==0);

endmodule