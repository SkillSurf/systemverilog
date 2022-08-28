module half_adder_tb ();

    timeunit 1ns;
    timeprecision 1ps;


    logic A     = 0;
    logic B     ; // = 0, intentionl
    logic carry ;
    logic sum   ;

    half_adder ha (.*);

    initial begin

        // Simulation starts

        #30
        A = 0;
        B = 0;

        #10
        A = 1;
        B = 0;

        #20
        A = 0;
        B = 1;

        #10
        A = 1;
        B = 1;

        #30
        A = 0;
        B = 0;
    end
endmodule