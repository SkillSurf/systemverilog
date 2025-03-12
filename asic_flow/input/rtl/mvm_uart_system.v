
module mvm_uart_system #(
  parameter CLOCKS_PER_PULSE = 200_000_000/9600, //200_000_000/9600
            BITS_PER_WORD    = 8,
            PACKET_SIZE_TX   = BITS_PER_WORD + 5,
            W_Y_OUT          = 32,
            R=8, C=8, W_X=8, W_K=8
)(
  input  clk, rstn, rx,
  output tx
);

  localparam  W_BUS_KX = R*C*W_K + C*W_X,
              W_BUS_Y  = R*W_Y_OUT,
              W_Y      = W_X + W_K + $clog2(C);

  wire s_valid, m_valid, s_ready, m_ready;
  wire [W_BUS_KX-1:0] s_data_kx;

  uart_rx #(
    .CLOCKS_PER_PULSE (CLOCKS_PER_PULSE),
    .BITS_PER_WORD (BITS_PER_WORD), 
    .W_OUT (W_BUS_KX)
  ) UART_RX (
    .clk    (clk), 
    .rstn   (rstn), 
    .rx     (rx),
    .m_valid(s_valid),
    .m_data (s_data_kx)
  );

  wire [R*W_Y  -1:0] m_data_y;
  axis_matvec_mul #(
    .R(R), .C(C), .W_X(W_X), .W_K(W_K)
  ) AXIS_MVM (
    .clk    (clk      ), 
    .rstn   (rstn     ),
    .s_axis_kx_tready(s_ready  ), // assume always valid
    .s_axis_kx_tvalid(s_valid  ), 
    .s_axis_kx_tdata (s_data_kx),
    .m_axis_y_tready (m_ready  ),
    .m_axis_y_tvalid (m_valid  ),
    .m_axis_y_tdata  (m_data_y )
  );

  // Padding to 32 bits to be read in computer
  wire [W_Y      -1:0] y_up     [R-1:0];
  wire [W_Y_OUT  -1:0] o_up   [R-1:0];
  wire [R*W_Y_OUT-1:0] o_flat;

  genvar r;
  for (r=0; r<R; r=r+1) begin
    assign y_up  [r] = m_data_y[W_Y*(r+1)-1 : W_Y*r];
    assign o_up  [r] = $signed(y_up[r]); // sign extend to 32b
    assign o_flat[W_Y_OUT*(r+1)-1 : W_Y_OUT*r] = o_up[r];
    // assign o_flat[W_Y_OUT*(r+1)-1 : W_Y_OUT*r] = $signed(m_data_y[W_Y*(r+1)-1 : W_Y*r]);
  end

  uart_tx #(
   .CLOCKS_PER_PULSE (CLOCKS_PER_PULSE),
   .BITS_PER_WORD    (BITS_PER_WORD),
   .PACKET_SIZE      (PACKET_SIZE_TX),
   .W_OUT            (W_BUS_Y)
  ) UART_TX (
   .clk     (clk      ), 
   .rstn    (rstn     ), 
   .s_ready (m_ready  ),
   .s_valid (m_valid  ), 
   .s_data  (o_flat   ),
   .tx      (tx       )
  );  

endmodule