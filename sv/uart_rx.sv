module uart_rx #(
  parameter CLOCKS_PER_PULSE = 4, //200_000_000/9600
            BITS_PER_WORD    = 8,
            W_OUT = 24 //R*C*W_K + C*W_X
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
    m_valid <= 0;

    if (!rstn) begin
      {c_words, c_bits, c_clocks, m_valid, m_data} <= '0;
      state <= IDLE;
    end else
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
                  m_data   <= {!rx, m_data[W_OUT-1:1]};

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
endmodule

module uart_rx_tb;

  timeunit 1ns/1ps;
  localparam  CLOCKS_PER_PULSE = 4, //200_000_000/9600
              W_OUT            = 16,
              BITS_PER_WORD    = 8,
              NUM_WORDS        = W_OUT/BITS_PER_WORD,
              CLK_PERIOD       = 10;

  logic clk=0, baud=0, rstn=0, rx=1, m_valid;
  logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] m_data, data;
  logic [BITS_PER_WORD+2-1:0] packet;

  initial forever #(CLK_PERIOD/2) clk <= !clk;

  uart_rx #(
    .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE), 
    .W_OUT(W_OUT),
    .BITS_PER_WORD(BITS_PER_WORD)) dut (.*);

  initial begin
    $dumpfile("dump.vcd"); $dumpvars;

    repeat(2)  @(posedge clk) #1; 
    rstn = 1;
    repeat(5)  @(posedge clk) #1;

    repeat (10) begin
      data = $urandom();

      for (int iw=0; iw<NUM_WORDS; iw=iw+1) begin
        packet = {1'b1, ~data[iw], 1'b0};

        repeat ($urandom_range(1,20)) @(posedge clk);

        for (int ib=0; ib<BITS_PER_WORD+2; ib=ib+1) begin
          repeat(CLOCKS_PER_PULSE) begin 
            #1 rx <= packet[ib];
            @(posedge clk);
          end
          baud <= !baud;
        end
      end      
      repeat ($urandom_range(1,100)) @(posedge clk);
    end
    $finish();
  end

  initial forever
    @(posedge clk)
    if(m_valid)
      assert (m_data == data) $display("OK, %b", m_data);
      else $error("Sent %b, got %b", data, m_data);

endmodule