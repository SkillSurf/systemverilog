module axis_matvec_mul #(
    parameter R=8, C=8, W_X=8, W_K=8,
    localparam LATENCY = $clog2(C)+1,
               W_Y = W_X + W_K + $clog2(C)
  )(
    input  clk, rstn,
    input  s_valid, m_ready,
    output s_ready, m_valid,
    input  [R*C*W_K + C*W_X -1:0] s_data,
    output [R*W_Y           -1:0] m_data
  );
    wire [R*C*W_K-1:0] k;
    wire [C*W_X  -1:0] x;
    assign {k, x} = s_data;

    wire [R*W_Y-1:0] i_data;
    wire i_ready;

    matvec_mul #(
      .R(R), .C(C), .W_X(W_X), .W_K(W_K)
    ) MATVEC (  
      .clk(clk    ),
      .cen(i_ready),
      .k  (k      ),
      .x  (x      ), 
      .y  (i_data )
    );

    reg [LATENCY-2:0] shift;
    reg  i_valid;

    always @(posedge clk or negedge rstn)
      if     (!rstn)   {i_valid, shift} <= 0;
      else if(i_ready) {i_valid, shift} <= {shift, s_valid};

    skid_buffer #(.WIDTH(R*W_Y)) SKID (
      .clk     (clk    ), 
      .rstn    (rstn   ), 
      .s_ready (i_ready),
      .s_valid (i_valid), 
      .s_data  (i_data ),
      .m_ready (m_ready),
      .m_valid (m_valid), 
      .m_data  (m_data )
    );

    assign s_ready = i_ready;

endmodule