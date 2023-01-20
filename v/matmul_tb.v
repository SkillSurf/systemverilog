class Matrix #(parameter WIDTH, N);
  typedef logic signed [WIDTH-1:0] m_t [N][N];
  rand m_t data;

  constraint c {
    foreach (data[i,j]) 
      {data[i][j] inside 
        {[-2**(WIDTH-1):2**(WIDTH-1)-1]}; 
      }
  }
  function new();
    this.randomize();
  endfunction;

  static function m_t matmul (m_t m_1, 
                              m_t m_2);
    m_t out;
    foreach (out[i,j]) begin
      integer signed sum = 0;
      foreach(m_1[,k])
        sum += m_1[i][k] * m_2[k][j];
      out[i][j] = sum;
      end
    return out;
  endfunction
endclass

module matmul_tb();
  timeunit      1ns;
  timeprecision 1ps;
  logic clk;
  localparam CLK_PERIOD = 10;
  initial begin
    clk = 0;
    forever #(CLK_PERIOD/2) clk <= ~clk;
  end

  localparam N       = 2;
  localparam WIDTH   = 8;
  localparam LATENCY = $clog2(N) + 1;

  logic [N*N*WIDTH-1:0] A_flat, B_flat, C_flat;
  matmul_top #(.N(N), .WIDTH(WIDTH)) dut (.*);

  logic signed [WIDTH-1:0] A [N][N];
  logic signed [WIDTH-1:0] B [N][N];
  logic signed [WIDTH-1:0] C [N][N];

  assign {<<{A_flat}} = A;
  assign {<<{B_flat}} = B;
  assign C = {>>{{<<{C_flat}}}};;

  typedef Matrix #(.WIDTH(WIDTH),.N(N)) Mat_N_t; 
  Mat_N_t matrix_a, matrix_b;

  initial begin
    @(posedge clk);
    A = '{default:1};
    B = '{default:1};

    @(posedge clk);
    for (int i=0; i<N; i++) begin:rows
      for (int j=0; j<N; j++) begin:cols
        A[i][j] <= 10*i + j;
        B[i][j] <= 1;
      end
    end

    @(posedge clk);
    foreach(A[i,j]) begin
      A[i][j] <= 10*i + j;
      B[i][j] <= 1;
    end

    repeat(20) begin
      @(posedge clk);
      matrix_a = new();
      matrix_b = new();

      A <= matrix_a.data;
      B <= matrix_b.data;

      #(LATENCY * CLK_PERIOD + 1);

      $display("%p", Mat_N_t::matmul(A,B));
      assert (Mat_N_t::matmul(A,B) == C);
    end
  end
endmodule