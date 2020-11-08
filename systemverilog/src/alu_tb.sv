module alu_tb ();

  timeunit      1ns;
  timeprecision 1ps;

  logic             clk =  0;
  localparam CLK_PERIOD = 10;
  initial begin
    forever begin
      #(CLK_PERIOD/2);
      clk <= ~clk;
    end
  end

  localparam N = 8 ;

  logic    [  2:0]     sel;
  logic signed [N-1:0] A  ;
  logic signed [N-1:0] B  ;
  logic signed [N-1:0] C  ;
  logic        Z  ;

  alu_ip #(.N(N)) dut (.*);

  initial begin
    A  <= 8'd5    ;
    B  <= 8'd10   ;
    sel  <= 3'b000;

    @(posedge clk);
    A  <=  8'd30  ;
    B  <= -8'd10  ;
    sel  <= 3'b001;

    @(posedge clk);
    A  <= 8'd5    ;
    B  <= 8'd10   ;
    sel  <= 3'b010;

    @(posedge clk);
    A  <= 8'd51   ;
    B  <= 8'd17   ;
    sel  <= 3'b011;
    
    repeat(10) begin
      @(posedge clk);
      randomize(A  );
      randomize(B  );
      randomize(sel);
    end
  end
endmodule