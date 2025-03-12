module alu #(
  parameter  WIDTH     = 8,
  localparam W_ALU_SEL = 3
)(
  input  logic signed [WIDTH-1:0] bus_a,
  input  logic signed [WIDTH-1:0] bus_b,
  output logic signed [WIDTH-1:0] alu_out,
  input  logic [W_ALU_SEL   -1:0] alu_sel,
  output logic zero, negative
);

//   always_comb
//     unique case (alu_sel)
//       'b001  : alu_out = bus_a + bus_b;
//       'b010  : alu_out = bus_a - bus_b;
//       'b011  : alu_out = bus_a * bus_b;
//       'b100  : alu_out = bus_a/2;
//       default: alu_out = bus_a; // pass a if 0
//     endcase

  always_comb
    if      (alu_sel == 'b001) alu_out = bus_a +  bus_b;
    else if (alu_sel == 'b010) alu_out = bus_a -  bus_b;
    else if (alu_sel == 'b011) alu_out = bus_a *  bus_b;
    else if (alu_sel == 'b100) alu_out = bus_a / 2;
    else                       alu_out = bus_a;  // pass a if 0

  assign zero      = (alu_out == 0);
  assign negative  = (alu_out <  0);

endmodule