module counter_tb();
  
  timeunit    1ns;
  timeprecision 1ps;

  logic             clk =  0;
  localparam CLK_PERIOD = 10;
  initial begin
    forever begin
      #(CLK_PERIOD/2);
      clk <= ~clk;
    end
  end

  localparam N = 8;

  logic         rst  ;
  logic         incr ;
  logic [N-1:0] count;

  counter #(.N(N)) dut (.*);

  initial begin
    #(CLK_PERIOD * 2);

    @(posedge clk);
    rst <= 1;

    #(CLK_PERIOD * 2);
    @(posedge clk);
    incr <= 1;

    @(posedge clk);
    rst  <= 0;
    incr <= 1;

    #(CLK_PERIOD * 4);
    @(posedge clk);
    incr <= 0;

    #(CLK_PERIOD * 4);
    @(posedge clk);
    rst  <= 1;
  end
endmodule