`timescale 1ns/1ps

module skid_buffer_tb;
 
  localparam  WORD_W=8, BUS_W=32, 
              N_BEATS=10, WORDS_PER_BEAT=BUS_W/WORD_W,
              PROB_VALID=10, PROB_READY=10,
              CLK_PERIOD=10, NUM_EXP=500;

  logic clk=0, rstn=1, source_reset, sink_reset;
  logic s_ready, s_valid, m_ready, m_valid;
  logic              [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data, m_data, in_beat;
  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] in_data, out_data;

  logic [N_BEATS*WORD_W*WORDS_PER_BEAT-1:0] queue [$];

  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  AXIS_Source #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_VALID(PROB_VALID), .N_BEATS(N_BEATS)) source (.*);
  AXIS_Sink   #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_READY(PROB_READY), .N_BEATS(N_BEATS)) sink   (.*);

  // skid_buffer #(BUS_W) dut (.*);
  assign s_ready = m_ready;
  assign m_data = s_data;
  assign m_valid = s_valid;
  
  initial sink.axis_pull;
  initial source.axis_push;

  initial begin
    $dumpfile ("axis_tb.vcd"); $dumpvars;
    repeat(NUM_EXP) begin
      source_reset = 1; // initalize
      // Randomize in_data
      for (int n=0; n<N_BEATS; n++) begin
        for (int w=0; w<WORDS_PER_BEAT; w++)
          in_beat[w] = $urandom_range(0,2**WORD_W-1);
        in_data[n] = in_beat;
      end
      queue.push_front(in_data); // append to end of queue
      
      @(posedge clk) #1 source_reset = 0; // start
      wait (source.done);
    end
  end

  initial begin
    repeat(NUM_EXP) begin
      sink_reset = 1;
      @(posedge clk) #1 sink_reset = 0; // start
      wait(sink.done);

      assert (queue.pop_back() == out_data) // remove last element
        $display("Outputs match: %p", in_data);
      else $fatal(0, "Input: %p != Output: %p", in_data, out_data);
    end
    $finish();
  end

endmodule