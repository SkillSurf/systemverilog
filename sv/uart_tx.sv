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
      s_packets[i][BITS_PER_WORD:0] = {~s_data[i], 1'b0};
    
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
                    c_pulses = c_pulses + 1;
                    m_packets <= (m_packets >> 1);
                  end

                end else c_clocks <= c_clocks + 1;
      endcase
  end

  assign s_ready = (state == IDLE);

endmodule


module uart_tx_tb;

  timeunit 1ns/1ps;
  localparam  CLOCKS_PER_PULSE = 4, //200_000_000/9600
              W_OUT            = 16,
              BITS_PER_WORD    = 8,
              PACKET_SIZE      = BITS_PER_WORD+5,
              NUM_WORDS        = W_OUT/BITS_PER_WORD,
              CLK_PERIOD       = 10;

  logic clk=0, baud=0, rstn=0, tx, s_valid=0, s_ready;
  logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data, rx_data;

  initial forever #(CLK_PERIOD/2) clk <= !clk;

  uart_tx #(
    .CLOCKS_PER_PULSE(CLOCKS_PER_PULSE), 
    .BITS_PER_WORD(BITS_PER_WORD),
    .PACKET_SIZE(PACKET_SIZE),
    .W_OUT(W_OUT)) dut (.*);


  // Driver
  initial begin
    $dumpfile("dump.vcd"); $dumpvars;
    repeat(2)  @(posedge clk) #1; 
    rstn = 1;
    repeat(5)  @(posedge clk) #1;

    repeat (10) begin
      repeat ($urandom_range(1,20)) @(posedge clk);
      wait (s_ready);

      @(posedge clk) #1;
      s_data = $urandom();
      s_valid = 1;
      
      @(posedge clk) #1;
      s_valid = 0;
      wait (s_ready);
    end
    $finish();
  end

  logic sample=1;

  // Monitor
  initial forever begin
    rx_data <= 'x;
    for (int iw=0; iw<NUM_WORDS; iw=iw+1) begin

      wait(!tx);
      
      sample = 0;
      // go to middle of start bit
      repeat (CLOCKS_PER_PULSE/2) @(posedge clk);
      sample = !sample;

      for (int ib=0; ib<BITS_PER_WORD; ib=ib+1) begin
        // go to middle of data bit
        repeat (CLOCKS_PER_PULSE) @(posedge clk);
        rx_data[iw][ib] = !tx;
        sample = !sample;
      end

      for (int ib=0; ib<PACKET_SIZE-BITS_PER_WORD-1; ib=ib+1) begin
        repeat (CLOCKS_PER_PULSE) @(posedge clk);
        assert (tx == 1) else $error("Incorrect end bits/padding");
        sample = !sample;
      end
    end

    assert (rx_data == s_data) $display("OK, %b", rx_data);
    else $error("Sent %b, got %b", s_data, rx_data);
  end

endmodule