// module a_tb();
//   timeunit 10ns;
//   timeprecision 1ns;

//   localparam N     = 4;
//   localparam WIDTH = 8;

//   logic [N*N*WIDTH-1:0] A_flat_1;
//   logic [WIDTH-1:0] A_1 [N][N];

//   logic [N*N*WIDTH-1:0] A_flat_2;
//   logic [WIDTH-1:0] A_2 [N][N];

//   assign {<<{A_flat_1}} = A_1;
//   assign A_flat_2 = A_flat_1;
//   assign A_2 = {<<{A_flat_2}};

//   initial begin
//     foreach (A_1[i,j]) begin
//       A_1[i][j] = 10*i+j;
//     end

//     #10;
//     $display("%p", A_1);
//     $display("%p", A_2);
//     assert(A_1==A_2);
//   end
// endmodule

module a_tb();
  timeunit 10ns;
  timeprecision 1ns;
  
  localparam N     = 4;
  localparam WIDTH = 8;

  logic [N*N*WIDTH-1:0] A_flat_1;
  logic [WIDTH-1:0] A_1 [N][N];

  logic [N*N*WIDTH-1:0] A_flat_2;
  logic [WIDTH-1:0] A_2 [N][N];

  assign {<<{A_flat_1}} = A_1;
  assign A_flat_2 = A_flat_1;
  assign A_2 = {>>{{<<{A_flat_2}}}};

  initial begin
    foreach (A_1[i,j]) begin
      A_1[i][j] = 10*i+j;
    end

    #10;
    $display("%p", A_1);
    $display("%p", A_2);
    assert(A_1==A_2);
  end
endmodule