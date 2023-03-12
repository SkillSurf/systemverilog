`timescale 1ns / 1ps

module full_adder_tb;


  reg a=0, ci=0, b=0;
  wire sum, co ;

  full_adder dut (.a(a), .ci(ci), .b(b), .sum(sum), .co(co));

  initial begin // simulation starts
    $dumpfile("dump.vcd"); $dumpvars;

    #10 a <= 0; b <= 0; ci <= 0;    
    #10 a <= 0; b <= 0; ci <= 1;
    
    #10 a <= 1; b <= 1; ci <= 0;
    
    #10 a <= 1; b <= 1; ci <= 1;
    #10
    
    $finish(); // simulation ends
    
  end
endmodule