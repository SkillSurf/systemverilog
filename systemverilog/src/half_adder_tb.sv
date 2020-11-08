module half_adder_tb ();

    timeunit 1ns;
    timeprecision 1ps;

    localparam CLK_PERIOD = 10;

    logic clk   = 0;
    logic A     = 0;
    logic B     ; // = 0, intentionl
    logic carry ;
    logic sum   ;

    half_adder ha (.*);

    initial begin
        forever begin
            #(CLK_PERIOD/2);
            clk <= ~clk;
        end

        // Simulation starts

        @(posedge clk);
        #(CLK_PERIOD*3);

        @(posedge clk);
        A = 0;
        B = 0;

        @(posedge clk);
        A = 1;
        B = 0;

        #(CLK_PERIOD*2);

        @(posedge clk);
        A = 0;
        B = 1;
        @(posedge clk);
        A = 1;
        B = 1;

        #(CLK_PERIOD*3);
        A = 0;
        B = 0;
    end
endmodule