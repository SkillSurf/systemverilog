module p2s #(N = 8)
(
  input  logic         clk, 
                       rstn, 
                       s_ready,
                       p_valid, 
  input  logic [N-1:0] p_data,
  output logic         p_ready, 
                       s_data, 
                       s_valid
);
  typedef enum logic {
    RX = 1'b0,
    TX = 1'b1
  } e_states;

  localparam N_BITS = $clog2(N);

  logic [N_BITS-1:0] count; // = 0; // Initial values when FPGA powers up
  e_states state;  //= RX;

  // NEXT STATE DECODER LOGIC

  e_states next_state;
  always_comb begin
    unique case (state)
      RX: begin
        if (p_valid) next_state = TX;
        else         next_state = RX;
      end

      TX: begin
            if (count == N-1 && s_ready)
              next_state = RX;
            else
              next_state = TX;
          end
    endcase
  end

  // STATE SEQUENCER LOGIC

  always_ff @(posedge clk or negedge rstn)
    if (!rstn) state <= RX;
    else       state <= next_state;

  // OUTPUT DECODE LOGIC

  logic [N-1:0] shift_reg;
  assign s_data = shift_reg[0];

  assign p_ready = (state == RX);
  assign s_valid = (state == TX);

  always_ff @(posedge clk or negedge rstn)
  if (!rstn) count     <= '0;
  else 
    unique case (state)
      RX:    shift_reg <= p_data;
      TX: if (s_ready) begin
             shift_reg <= shift_reg >> 1;
             count     <= count + 1'd1;
          end else begin
             shift_reg <= shift_reg;
             count     <= count;
          end
    endcase
endmodule