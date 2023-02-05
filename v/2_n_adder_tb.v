module n_adder_tb;
  timeunit 1ns;
  timeprecision 1ps;
  
  localparam N = 8;

  reg   signed [N-1:0] A, B;
  wire  signed [N-1:0] S;
  reg   ci;
  wire  co;
  
  bit [N-1:0] m;

  n_adder #(.N(N)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);
    
    A <= 8'd5; B <= 8'd10; ci <= 0;
    assert (co == 8'd20) else $error("Fail");

    #10 A <= 8'd30;  B <= -8'd10; ci <= 0;
    #10 A <= 8'd5;   B <= 8'd10;  ci <= 1;
    #10 A <= 8'd127; B <= 8'd1;   ci <= 0;

    repeat(10) begin
      #9
      ci = $urandom%2
      A  = $random%128
      B  = $random%128
      #1
      assert ({co,S} == A+B+ci)
        else $error("%d+%d+%d != {%d,%d}", A,B,ci,co,S);
    end
  end
endmodule
