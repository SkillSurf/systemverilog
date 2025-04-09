module skid_buffer #(parameter WIDTH = 8)(
  input  wire clk, rstn, s_valid, m_ready,
  input  wire [WIDTH-1:0] s_data,
  output reg  [WIDTH-1:0] m_data,
  output reg  m_valid, s_ready
);
  localparam EMPTY=0, PARTIAL=1, FULL=2;
  reg [1:0] state, state_next;

  always @* begin
    state_next = state;
    unique case (state)
      EMPTY  : if      ( s_valid)             state_next = PARTIAL;
      PARTIAL: if      (!m_ready &&  s_valid) state_next = FULL;
               else if ( m_ready && !s_valid) state_next = EMPTY;
      FULL   : if      ( m_ready)             state_next = PARTIAL;
    endcase
  end
  always @(posedge clk or negedge rstn)
    if (!rstn) state <= EMPTY;
    else       state <= state_next;

  reg [WIDTH-1:0] buffer;
  always @(posedge clk or negedge rstn)
    if (!rstn) {m_valid, s_ready, buffer, m_data} <= 0;
    else begin
      
      m_valid <= state_next != EMPTY;
      s_ready <= state_next != FULL;

      if (state == PARTIAL && state_next == FULL)
        buffer <= s_data;

      unique case (state)
        EMPTY  : if (state_next == PARTIAL) m_data <= s_data;
        PARTIAL: if (m_ready && s_valid)    m_data <= s_data;
        FULL   : if (m_ready)               m_data <= buffer;
      endcase
    end
endmodule