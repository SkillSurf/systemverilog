`timescale 1ns/1ps

module alu_tb;

  localparam WIDTH = 8;
  reg        [2:0]        alu_sel;
  reg signed [WIDTH-1:0]  bus_a,bus_b;
  wire       [WIDTH-1:0]  alu_out;
  wire                    zero, negative;

  alu #(.WIDTH(WIDTH)) dut ( .alu_sel(alu_sel), 
                            .bus_a(bus_a), 
                            .bus_b(bus_b), 
                            .alu_out(alu_out), 
                            .zero(zero), .negative(negative));


  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);

    repeat(10) begin
      #10
      bus_a   <= $urandom;
      bus_b   <= $urandom;
      alu_sel <= $urandom%5;
      
    end

    #30 bus_a <= 8'd5;  bus_b <=  8'd10; alu_sel <= 3'b000;
    #10 bus_a <= 8'd30; bus_b <= -8'd10; alu_sel <= 3'b001;
    #10 bus_a <= 8'd5;  bus_b <=  8'd10; alu_sel <= 3'b010;
    #10 bus_a <= 8'd51; bus_b <=  8'd17; alu_sel <= 3'b011;

    #10 $finish();
  end
endmodule