`timescale 1ns / 1ps

module alu_tb;

  localparam WIDTH = 8, W_ALU_SEL = 3;

  logic signed [WIDTH-1:0] bus_a, bus_b, alu_out;
  logic [W_ALU_SEL-1:0] alu_sel;
  logic zero, negative;

  alu #(.WIDTH(WIDTH)) dut (
    .bus_a(bus_a), .bus_b(bus_b), .alu_out(alu_out),
    .alu_sel(alu_sel), .zero(zero), .negative(negative)
  );

  // All inputs are free (symbolic)
  always_comb begin
    case (alu_sel)
      'b001: assert (alu_out == bus_a + bus_b);
      'b010: assert (alu_out == bus_a - bus_b);
      'b011: assert (alu_out == bus_a * bus_b);
      'b100: assert (alu_out == bus_a / 2);
      default: assert (alu_out == bus_a);
    endcase
    assert (zero == (alu_out == 0));
    assert (negative == (alu_out < 0));
  end
endmodule