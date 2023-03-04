module uart_tx #(
  parameter   CLOCKS_PER_PULSE = 4, //200_000_000/9600
              BITS_PER_WORD    = 8,
              PACKET_SIZE      = BITS_PER_WORD+5,
              W_OUT = 24, //R*C*W_K + C*W_X
  
  localparam  NUM_WORDS   = W_OUT/BITS_PER_WORD
)(
  input  logic clk, rstn, s_valid, 
  input  logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data,
  output logic tx, s_ready
);  

  logic [NUM_WORDS-1:0][PACKET_SIZE-1:0] s_packets;
  logic [NUM_WORDS*PACKET_SIZE     -1:0] m_packets;

  always_comb begin

    s_packets = '1;
    for (int i=0; i<NUM_WORDS; i=i+1)
      s_packets[i][BITS_PER_WORD:0] = {s_data[i], 1'b0};
    
    tx = m_packets[0];
  end

  // Counters
  logic [$clog2(NUM_WORDS*PACKET_SIZE)-1:0] c_pulses;
  logic [$clog2(CLOCKS_PER_PULSE)     -1:0] c_clocks;

  // State Machine

  enum {IDLE, SEND} state;

  always_ff @(posedge clk or negedge rstn) begin

    if (!rstn) begin
      state     <= IDLE;
      m_packets <= '1;
      {c_pulses, c_clocks} <= 0;
    end else
      case (state)
        IDLE :  if (s_valid) begin                  
                  state      <= SEND;
                  m_packets  <= s_packets;
                end

        SEND :  if (c_clocks == CLOCKS_PER_PULSE-1) begin
                  c_clocks <= 0;

                  if (c_pulses == NUM_WORDS*PACKET_SIZE-1) begin
                    c_pulses  <= 0;
                    m_packets <= '1;
                    state     <= IDLE;

                  end else begin
                    c_pulses <= c_pulses + 1;
                    m_packets <= (m_packets >> 1);
                  end

                end else c_clocks <= c_clocks + 1;
      endcase
  end

  assign s_ready = (state == IDLE);

endmodule