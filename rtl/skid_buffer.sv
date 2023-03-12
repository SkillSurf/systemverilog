module skid_buffer #(
  parameter WIDTH = 8
)(
  input  logic clk, rstn, s_valid, m_ready,
  input  logic [WIDTH-1:0] s_data,
  output logic [WIDTH-1:0] m_data,
  output logic m_valid, s_ready
);
  // State machine (3 procedure)
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

  // s_ready is registered, breaking the combinational path
  always_ff @(posedge clk)
    s_ready <= !rstn ? 1 : (state_next == EMPTY);

  // Buffer valid & data, when m_ready goes low
  wire buffer_en = (state_next == FULL) && (state==EMPTY);

  logic [WIDTH-1:0] b_data;
  logic b_valid;

  always_ff @(posedge clk)
    if      (!rstn)     b_valid <= 0;
    else if (buffer_en) b_valid <= s_valid;

  always_ff @(posedge clk)
    if (buffer_en && s_valid) b_data <= s_data;
  

  // m_data and m_valid are registered from mux

  wire [WIDTH-1:0] m_data_next  = (state == FULL) ? b_data  : s_data;
  wire             m_valid_next = (state == FULL) ? b_valid : s_valid;
  wire             m_en         = m_valid_next & m_ready;

  always_ff @(posedge clk)
    if      (!rstn)   m_valid <= 0;
    else if (m_ready) m_valid <= m_valid_next;

  always_ff @(posedge clk)
    if (m_en) m_data <= m_data_next;

endmodule