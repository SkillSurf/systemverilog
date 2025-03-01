`timescale 1ns/1ps

module axis_skid_buffer_tb;

  localparam  WORD_W=8, BUS_W=8,
              N_BEATS=10, WORDS_PER_BEAT=BUS_W/WORD_W,
              PROB_VALID=1, PROB_READY=10,
              CLK_PERIOD=10, NUM_EXP=100;

  logic clk=0, rstn;
  logic s_valid, s_ready, m_valid, m_ready;
  logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data, m_data;
  logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] in_beat;

  initial forever #(CLK_PERIOD/2) clk = ~clk;

  AXIS_Source #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_VALID(PROB_VALID), .N_BEATS(N_BEATS)) source (.*);
  AXIS_Sink   #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_READY(PROB_READY), .N_BEATS(N_BEATS)) sink   (.*);

  // assign s_ready = m_ready;
  // assign m_valid = s_valid;
  // assign m_data = s_data;
  skid_buffer #(.WIDTH(BUS_W)) dut (.*);

  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] tx_packet, rx_packet;

  initial begin
    $dumpfile ("dump.vcd"); $dumpvars;
    rstn = 0;
    repeat(5) @(posedge clk);
    rstn <= 1;
    repeat(5) @(posedge clk);

    // initialize reference data beat
    foreach (tx_packet[n]) begin
      foreach (in_beat[w])
        in_beat[w] = $urandom_range(0,2**WORD_W-1);
      tx_packet[n] = in_beat;
    end
    
    for (int i=0; i<NUM_EXP; i++)
      source.axis_push_packet(tx_packet);
  end

  initial begin
    for (int i=0; i<NUM_EXP; i++) begin
      rx_packet = 'x;
      sink.axis_pull_packet(rx_packet);
      assert (rx_packet == tx_packet)
        $display("Packet[%0d]: Outputs match: %h", i, rx_packet);
      else 
        $fatal(1, "Packet[%0d]: Expected: %h != Received: %h", i, tx_packet, rx_packet);
    end
    $finish();
  end
endmodule