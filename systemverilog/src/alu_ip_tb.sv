module alu_ip_tb ();

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

    logic        [  2:0] sel;
    logic signed [N-1:0] A  ;
    logic signed [N-1:0] B  ;
    logic signed [N-1:0] C  ;
    logic                Z  ;

    alu_ip dut (.*);

    int status = 0;
    int file_out, file_in;

    // paths W.R.T to "project.sim/sim_1/behav/xsim" folder
    string path_in  ="../../../../../../data/data_input.txt";
    string path_out ="../../../../../../data/data_output.txt";
    initial begin
        file_in  = $fopen(path_in, "r");
        file_out = $fopen(path_out, "w");
    end

    always @ (posedge clk) begin
        #(CLK_PERIOD/2);
        $fdisplay(file_out, "%d", C);
    end

    initial begin
        while(!$feof(file_in)) begin
            @(posedge clk);
            #1;
            status = $fscanf(file_in,"%d\r", A  );
            status = $fscanf(file_in,"%d\r", B  );
            status = $fscanf(file_in,"%d\r", sel);
        end

        #(CLK_PERIOD*3);
        $fclose(file_in);
        $fclose(file_out);
    end
endmodule