module skid_buffer #( parameter WIDTH = 8)(
  input  logic clk, rstn, s_valid, m_ready,
  input  logic [WIDTH-1:0] s_data,
  output logic [WIDTH-1:0] m_data,
  output logic m_valid, s_ready
);
  enum {FULL, EMPTY} state, state_next;
  always_comb begin
    state_next = state;
    case (state)
      EMPTY : if(!m_ready && s_ready && s_valid) state_next = FULL;
      FULL  : if(m_ready)                        state_next = EMPTY;
    endcase
  end
  always_ff @(posedge clk)
    if      (!rstn)              state <= EMPTY;
    else if (m_ready || s_ready) state <= state_next;

  logic b_valid;
  logic [WIDTH-1:0] b_data;
  wire  [WIDTH-1:0] m_data_next  = (state      == FULL) ? b_data  : s_data;
  wire              m_valid_next = (state      == FULL) ? b_valid : s_valid;
  wire              buffer_en    = (state_next == FULL) && (state==EMPTY);
  wire              m_en         = m_valid_next & m_ready;

  always_ff @(posedge clk)
    if (!rstn) begin
      s_ready <= 1;
      {m_valid, b_valid} <= '0;
    end else begin
      s_ready <= state_next == EMPTY;
      if (buffer_en) b_valid <= s_valid;      
      if (m_ready  ) m_valid <= m_valid_next;
    end
    
  always_ff @(posedge clk) begin
    if (m_en)                 m_data <= m_data_next;
    if (buffer_en && s_valid) b_data <= s_data;
  end
endmodule