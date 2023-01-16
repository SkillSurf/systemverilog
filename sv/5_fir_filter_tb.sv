`timescale 1ns/1ps
module fir_filter_tb;
  localparam WIDTH_X = 4,
             WIDTH_B = 4,
             N = 3,
             WIDTH_Y = WIDTH_X + WIDTH_B + N + 1;

  localparam logic [WIDTH_B-1:0] B [N+1] = {1, 2, 3, 4};

  logic clk=0, rstn=0;
  localparam CLK_PERIOD = 10;
  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  logic signed [WIDTH_X-1:0] x=0;
  logic signed [WIDTH_Y-1:0] y;

  fir_filter #(
    .N (N),
    .WIDTH_X (WIDTH_X),
    .WIDTH_B (WIDTH_B),
    .B (B)
  ) dut (.*);


  logic signed [WIDTH_X-1:0] zi [N+1] = '{default:0};
  logic signed [WIDTH_X-1:0] zq [$] = zi;

  int status, y_exp, sum=0;
  int file_x  = $fopen("x.txt", "r");
  int file_y  = $fopen("y.txt", "w");

  // Drive signals
  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);

    #10 rstn <= 1;
    
    while (!$feof(file_x))
      @(posedge clk) #1 status = $fscanf(file_x,"%d\r", x);
    $fclose(file_x);

    repeat (N+1) @(posedge clk);
    $fclose(file_y);
    $finish();
  end

  // Monitor signals
  initial forever begin
      @(posedge clk) #2
      zq = {x,zq}; zq = zq[0:$-1];

      sum = 0;
      foreach (zq[i]) 
        sum += zq[i]*B[i];
      
      assert (y==sum) begin 
        $display("OK: y:%d", y);
        $fdisplay(file_y, "%d", y);
      end else $display("Error: y:%d != y_exp:%d", y, sum);
    end
endmodule