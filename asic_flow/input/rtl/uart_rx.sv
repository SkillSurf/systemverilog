module uart_rx #(
  parameter CLOCKS_PER_PULSE = 4, //200_000_000/9600
            BITS_PER_WORD    = 8,
            W_OUT = 24 //R*C*W_K + C*W_X,
)(
  input  logic clk, rstn, rx,
  output logic m_valid,
  output logic [W_OUT-1:0] m_data
);
  localparam  NUM_WORDS = W_OUT/BITS_PER_WORD;

  // Counters

  logic [$clog2(CLOCKS_PER_PULSE) -1:0] c_clocks;
  logic [$clog2(BITS_PER_WORD)    -1:0] c_bits  ;
  logic [$clog2(NUM_WORDS)        -1:0] c_words ;

  // State Machine

  enum {IDLE, START, DATA, END} state;

  always_ff @(posedge clk or negedge rstn) begin
    
    if (!rstn) begin
      {c_words, c_bits, c_clocks, m_valid, m_data} <= '0;
      state <= IDLE;
    end else begin
      m_valid <= 0;
      
      case (state)

        IDLE :  if (rx == 0)                      
                  state <= START;

        START:  if (c_clocks == CLOCKS_PER_PULSE/2-1) begin
                  state <= DATA;
                  c_clocks <= 0;
                end else
                  c_clocks <= c_clocks + 1;

        DATA :  if (c_clocks == CLOCKS_PER_PULSE-1) begin
                  c_clocks <= 0;
                  m_data   <= {rx, m_data[W_OUT-1:1]};

                  if (c_bits == BITS_PER_WORD-1) begin
                    state  <= END;
                    c_bits <= 0;

                    if (c_words == NUM_WORDS-1) begin
                      m_valid <= 1;
                      c_words <= 0;

                    end else c_words <= c_words + 1;
                  end else c_bits <= c_bits + 1;
                end else c_clocks <= c_clocks + 1;

        END  :  if (c_clocks == CLOCKS_PER_PULSE-1) begin
                  state <= IDLE;
                  c_clocks <= 0;
                end else
                  c_clocks <= c_clocks + 1;
      endcase
      end
  end
endmodule