`timescale 1ns / 1ps
module n_adder_tb;

  localparam N = 8;

  reg   signed [N-1:0] A, B;
  wire  signed [N-1:0] S;
  reg   ci;
  wire  co;
  
  n_adder #(.N(N)) dut ( .A(A), .B(B), .S(S), .ci(ci), .co(co));

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);
    
    A <= 8'd5; B <= 8'd10; ci <= 0;

    #10 A <= 8'd30;  B <= -8'd10; ci <= 0;
    #10 A <= 8'd5;   B <= 8'd10;  ci <= 1;
    #10 A <= 8'd127; B <= 8'd1;   ci <= 0;

    repeat(10) begin
      #10
      ci <= $urandom%2;
      A  <= $random%128;
      B  <= $random%128;
    end
    $finish();
  end
endmodule
