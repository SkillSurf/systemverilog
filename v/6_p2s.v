module p2s #(N = 8)
(
  input  clk, rstn, s_ready, p_valid, 
  input  [N-1:0] p_data,
  output p_ready, s_data, s_valid
);
  localparam N_BITS = $clog2(N);
  localparam RX = 0;
  localparam TX = 1;
  reg next_state, state;
  reg [N_BITS-1:0] count; // = 0; // Initial values when FPGA powers up
  reg [N     -1:0] shift_reg;

  always @(*) begin
    case (state)
      RX: next_state = p_valid               ? TX : RX;
      TX: next_state = s_ready && count==N-1 ? RX : TX;
    endcase
  end
  
  always @(posedge clk or negedge rstn) begin
    if (!rstn) state <= RX;
    else       state <= next_state;
  end
  
  assign s_data  = shift_reg[0];
  assign p_ready = (state == RX);
  assign s_valid = (state == TX);

  always @(posedge clk or negedge rstn) begin
    if (!rstn) count    <= 0;
    else 
      case (state)
        RX:   shift_reg <= p_data;
        TX: if (s_ready) begin
              shift_reg <= shift_reg >> 1;
              count     <= count + 1'd1;
            end 
      endcase
  end

endmodule
