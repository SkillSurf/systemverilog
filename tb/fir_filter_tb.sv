module fir_filter_tb;
  timeunit 1ns/1ps;
  localparam W_X = 4,
             W_K = 4,
             N = 3,
             W_Y = W_X + W_K + $clog2(N);

  localparam logic signed [W_K-1:0] K [N+1] = {1, 2, 3, 4};

  logic clk=0, rstn=0;
  localparam CLK_PERIOD = 10;
  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  logic signed [W_X-1:0] x=0;
  logic signed [W_Y-1:0] y;
  fir_filter_2 #(.N(N), .W_X(W_X), .W_K (W_K), .K(K)) dut (.*);

  logic signed [W_X-1:0] zi [N+1] = '{default:0};
  logic signed [W_X-1:0] zq [$] = zi;

  int status, y_exp=0;
  int file_x  = $fopen("D:/x.txt", "r");
  int file_y  = $fopen("D:/y.txt", "w");

  // Drive signals
  initial begin
    $dumpfile("dump.vcd"); $dumpvars(0, dut);

    #10 rstn <= 1;
    
    while (!$feof(file_x))
      @(posedge clk) #1 status = $fscanf(file_x,"%d\r", x);
    $fclose(file_x);
    $fclose(file_y);
    $finish();
  end

  // Monitor signals
  initial forever begin
      @(posedge clk) #2
      zq.push_front(x);
      zq.pop_back();
      
      y_exp = 0;
      foreach (zq[i]) 
        y_exp += zq[i]*K[i];
      
      assert (y==y_exp) begin 
        $display("OK: y:%d", y);
        $fdisplay(file_y, "%d", y);
      end else $display("Error: y:%d != y_exp:%d", y, y_exp);
    end
endmodule