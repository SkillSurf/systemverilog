`timescale 1ns/1ps

module skid_buffer_tb;
 
  localparam  WORD_W=8, BUS_W=8, 
              N_BEATS=10, WORDS_PER_BEAT=BUS_W/WORD_W,
              PROB_VALID=10, PROB_READY=10,
              CLK_PERIOD=10, NUM_EXP=500;

  logic clk=0, rstn=1;
  logic s_ready, s_valid, m_ready, m_valid;
  logic              [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data, m_data, in_beat;
  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] in_data, out_data, exp_data;

  logic [N_BEATS*WORD_W*WORDS_PER_BEAT-1:0] queue [$];

  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  AXIS_Source #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_VALID(PROB_VALID), .N_BEATS(N_BEATS)) source (.*);
  AXIS_Sink   #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_READY(PROB_READY), .N_BEATS(N_BEATS)) sink   (.*);

  skid_buffer #(BUS_W) dut (.*);
  // assign s_ready = m_ready;
  // assign m_data = s_data;
  // assign m_valid = s_valid;

  initial begin
    $dumpfile ("dump.vcd"); $dumpvars;
    repeat(NUM_EXP) begin
      // Randomize in_data
      foreach (in_data[n]) begin
        foreach (in_beat[w])
          in_beat[w] = $urandom_range(0,2**WORD_W-1);
        in_data[n] = in_beat;
      end
      queue.push_front(in_data); // append to end of queue
      source.axis_push_packet;
    end
  end

  initial begin
    repeat(NUM_EXP) begin

      sink.axis_pull_packet;
      exp_data = queue.pop_back();

      assert (exp_data == out_data) // remove last element
        $display("Outputs match: %d", exp_data);
      else $fatal(0, "Expected: %d != Output: %d", exp_data, out_data);
    end
    $finish();
  end

endmodule