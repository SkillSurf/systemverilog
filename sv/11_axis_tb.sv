`timescale 1ns/1ps

module skid_buffer_tb;
 
  localparam  WORD_W=8, BUS_W=32, 
              N_BEATS=10, WORDS_PER_BEAT=BUS_W/WORD_W,
              PROB_VALID=10, PROB_READY=10,
              CLK_PERIOD=10;

  logic clk=0, rstn;
  logic s_ready, s_valid, m_ready, m_valid;
  logic              [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data, m_data, in_beat;
  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] in_data, out_data;

  initial forever #(CLK_PERIOD/2) clk <= ~clk;
  // skid_buffer #(BUS_W) dut (.*);

  AXIS_Source #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_VALID(PROB_VALID), .N_BEATS(N_BEATS)) source (.*);
  AXIS_Sink   #(.WORD_W(WORD_W), .BUS_W(BUS_W), .PROB_READY(PROB_READY), .N_BEATS(N_BEATS)) sink   (.*);

  assign s_ready = m_ready;
  assign m_data = s_data;
  assign m_valid = s_valid;
  
  initial sink.axis_pull;
  initial source.axis_push;

  initial begin
    $dumpfile ("axis_tb.vcd"); $dumpvars;

    repeat(20) begin
      rstn = 0; // initalize
      // Randomize in_data
      for (int n=0; n<N_BEATS; n++) begin
        for (int w=0; w<WORDS_PER_BEAT; w++)
          in_beat[w] = $urandom_range(0,2**WORD_W-1);
        in_data[n] = in_beat;
      end

      repeat (5) @(posedge clk); 
      rstn = 1; // start

      wait(source.done && sink.done);
      
      assert (in_data == out_data) 
        $display("Outputs match: %d", in_data);
      else $error("Input: %d != Output: %d", in_data, out_data);
    end
    $finish();
  end

endmodule