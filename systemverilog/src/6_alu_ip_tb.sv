module alu_ip_tb();
  timeunit      1ns;
  timeprecision 1ps;

  logic clk;
  localparam CLK_PERIOD = 10;
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk <= ~clk;
  end

  logic        [2:0] sel;
  logic signed [7:0] A, B, C;
  logic              Z  ;

  alu_ip    dut (.*);

  int status, file_out, file_in;
  /* paths W.R.T to "project.sim/sim_1/behav/xsim" folder */
  string path_in  ="../../../../../../data/data_input.txt";
  string path_out ="../../../../../../data/data_output.txt";
// string path_in  ="U:/aba/Desktop_Win/missing_semester/systemverilog/data/data_input.txt";
// string path_out ="U:/aba/Desktop_Win/missing_semester/systemverilog/data/data_output.txt";

  initial begin
    file_in  = $fopen(path_in, "r");
    file_out = $fopen(path_out, "w");

    while(!$feof(file_in)) begin
      @(posedge clk); #1;
      status = $fscanf(file_in,"%d\r", A  );
      status = $fscanf(file_in,"%d\r", B  );
      status = $fscanf(file_in,"%d\r", sel);
    end

    #(CLK_PERIOD*3);
    $fclose(file_in);
    $fclose(file_out);
  end

  initial begin
    forever begin
      @(posedge clk); #1;
      $fdisplay(file_out, "%d", C);
    end
  end
endmodule