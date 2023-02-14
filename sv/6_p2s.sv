module p2s #(N = 8)
(
  input  logic clk, rstn, s_ready, p_valid, 
  input  logic [N-1:0] p_data,
  output logic p_ready, s_data, s_valid
);
  localparam N_BITS = $clog2(N);
  enum logic {RX=0, TX=1} next_state, state; //= RX;
  logic [N_BITS-1:0] count; // = 0; // Initial values when FPGA powers up
  logic [N     -1:0] shift_reg;

  always_comb
    unique case (state)
      RX: next_state = p_valid               ? TX : RX;
      TX: next_state = s_ready && count==N-1 ? RX : TX;
    endcase

  always_ff @(posedge clk or negedge rstn)
    if (!rstn) state <= RX;
    else       state <= next_state;

  assign s_data  = shift_reg[0];
  assign p_ready = (state == RX);
  assign s_valid = (state == TX);

  always_ff @(posedge clk or negedge rstn)
    if (!rstn) count    <= '0;
    else 
      unique case (state)
        RX: begin  
              shift_reg <= p_data;
              count     <= '0;
            end
        TX: if (s_ready) begin
              shift_reg <= shift_reg >> 1;
              count     <= count + 1'd1;
            end 
      endcase
endmodule