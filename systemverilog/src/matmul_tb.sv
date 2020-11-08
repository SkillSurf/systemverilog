module matmul_tb();
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

  localparam N     = 4;
  localparam WIDTH = 8;

  logic [N*N*WIDTH-1:0] A_flat;
  logic [N*N*WIDTH-1:0] B_flat;
  logic [N*N*WIDTH-1:0] C_flat;
  matmul_top #(.N(N), .WIDTH(WIDTH)) dut (.*);

  logic [WIDTH-1:0] A [0:N-1][0:N-1];
  logic [WIDTH-1:0] B [0:N-1][0:N-1];
  logic [WIDTH-1:0] C [0:N-1][0:N-1];
  logic [WIDTH-1:0] C_sim [0:N-1][0:N-1];

  assign {<<{A_flat}} = A;
  assign {<<{B_flat}} = B;
  assign C = {<<{C_flat}};

  initial begin
    @(posedge clk);
    for (int i=0; i<N; i++) begin:rows
      for (int j=0; j<N; j++) begin:cols
        A[i][j] <= i*N + j;
        B[i][j] <= 1;
      end
    end

    @(posedge clk);
    for (int i=0; i<N; i++) begin:rows
      for (int j=0; j<N; j++) begin:cols
        std::randomize(A[i][j]) with {A[i][j] inside{[0:10]};};
        std::randomize(B[i][j]) with {B[i][j] inside{[0:10]};};
      end
    end

    repeat(20) begin
      @(posedge clk);
      #(CLK_PERIOD*$clog2(N)+2);
      for (int i=0; i<N; i++) begin:rows
        for (int j=0; j<N; j++) begin:cols

          C_sim[i][j] = 0;
          for (int k=0; k<N; k++) begin:mul
            C_sim[i][j] = C_sim[i][j] + A[i][k] * B[k][j];
          end

        end
      end
    end
  end
endmodule