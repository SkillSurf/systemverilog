module uart_rx #(
  parameter CLOCKS_PER_PULSE = 4, //200_000_000/9600
            BITS_PER_WORD    = 8,
            W_OUT = 24 //R*C*W_K + C*W_X,
)(
  input  wire clk, rstn, rx,
  output reg  m_valid,
  output reg  [W_OUT-1:0] m_data
);
  localparam  NUM_WORDS = W_OUT/BITS_PER_WORD;

  // Counters

  localparam W_CCLOCKS = $clog2(CLOCKS_PER_PULSE),
             W_CBITS   = $clog2(BITS_PER_WORD),
             W_CWORDS  = $clog2(NUM_WORDS);

  reg [W_CCLOCKS-1:0] c_clocks;
  reg [W_CBITS  -1:0] c_bits  ;
  reg [W_CWORDS -1:0] c_words ;

  // State Machine


  localparam IDLE=0, START=1, DATA=2, END=3;
  reg [1:0] state;

  always @(posedge clk or negedge rstn) begin
    
    if (!rstn) begin
      {c_words, c_bits, c_clocks, m_valid, m_data} <= '0;
      state <= IDLE;
    end else begin
      m_valid <= 0;
      
      case (state)

        IDLE :  if (rx == 0)                      
                  state <= START;

        START:  if (c_clocks == W_CCLOCKS'(CLOCKS_PER_PULSE/2-1)) begin
                  state <= DATA;
                  c_clocks <= 0;
                end else
                  c_clocks <= c_clocks + 1;

        DATA :  if (c_clocks == W_CCLOCKS'(CLOCKS_PER_PULSE-1)) begin
                  c_clocks <= 0;
                  m_data   <= {rx, m_data[W_OUT-1:1]};

                  if (c_bits == W_CBITS'(BITS_PER_WORD-1)) begin
                    state  <= END;
                    c_bits <= 0;

                    if (c_words == W_CWORDS'(NUM_WORDS-1)) begin
                      m_valid <= 1;
                      c_words <= 0;

                    end else c_words <= c_words + 1;
                  end else c_bits <= c_bits + 1;
                end else c_clocks <= c_clocks + 1;

        END  :  if (c_clocks == W_CCLOCKS'(CLOCKS_PER_PULSE-1)) begin
                  state <= IDLE;
                  c_clocks <= 0;
                end else
                  c_clocks <= c_clocks + 1;
      endcase
      end
  end
endmodule