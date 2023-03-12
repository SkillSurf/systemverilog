module n_adder_tb;
  timeunit 1ns;
  timeprecision 1ps;
  
  localparam N = 8;

  logic signed [N-1:0] A, B, S;
  logic ci, co;
  
  bit [N-1:0] m;
  int status;

  n_adder #(.N(N)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);
    
    A <= 8'd5; B <= 8'd10; ci <= 0;
    #1 assert (S == 8'd15) else $error("Fail");

    #10 A <= 8'd30;  B <= -8'd10; ci <= 0;
    #10 A <= 8'd5;   B <= 8'd10;  ci <= 1;
    #10 A <= 8'd127; B <= 8'd1;   ci <= 0;

    repeat(10) begin
      #9
      status = std::randomize(ci);
      status = std::randomize(A) with { A inside {[-128:127]}; };
      status = std::randomize(B) with { B inside {[-128:127]}; };
      #1
      assert ({co,S} == A+B+ci)
        else $error("%d+%d+%d != {%d,%d}", A,B,ci,co,S);
    end
  end
endmodule