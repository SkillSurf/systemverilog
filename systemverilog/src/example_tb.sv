module example_tb();
  timeunit      1ns;
  timeprecision 1ps;

  logic clk = 0;
  localparam CLK_PERIOD = 10;

  logic a,b,c;
  logic [7:0] s1,s2;
  example ex(.*);

  initial begin
    forever begin
      #(CLK_PERIOD/2);
      clk <= ~clk;
    end
  end

  initial begin
    @(posedge clk);
    a <= 1;
    b <= 1;
    @(posedge clk);
    a <= 0;
    b <= 1;
    @(posedge clk);
    a <= 1;
    b <= 1;
  end
endmodule