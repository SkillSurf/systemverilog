

module AXIS_Sink #(
  parameter  WORD_W=8, BUS_W=8, PROB_READY=20,
             N_BEATS=10,
             WORDS_PER_BEAT = BUS_W/WORD_W
)(
    input  logic clk, m_valid,
    output logic m_ready,
    input  logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] m_data,
    output logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] out_data
);
  timeunit 1ns/1ps;
  int i_beats = 0;
  bit done = 0;
  
  task axis_pull_packet;
    while (!done) begin
      
      @(posedge clk)
      if (m_ready && m_valid) begin  // read at posedge
        out_data[i_beats] = m_data;
        i_beats += 1;
        done = (i_beats == N_BEATS);
      end

      #10ps m_ready = ($urandom_range(0,99) < PROB_READY);
    end
    {m_ready, i_beats, done} ='0;
  endtask
endmodule


module AXIS_Source #(
  parameter  WORD_W=8, BUS_W=8, PROB_VALID=20, 
             N_BEATS=10,
  localparam WORDS_PER_BEAT = BUS_W/WORD_W
)(
    input  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] in_data,
    input  logic clk, s_ready, 
    output logic s_valid,
    output logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data
);
  timeunit 1ns/1ps;
  int i_beats = 0;
  bit prev_handshake = 1; // data is released first
  bit done = 0;
  logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data_val;

  task axis_push_packet;
    // iverilog doesnt support break. so the loop is rolled to have break at top
    while (!done) begin
      if (prev_handshake) begin  // change data
        s_data_val = in_data[i_beats];
        i_beats    += 1;
      end
      s_valid = $urandom_range(0,99) < PROB_VALID;      // randomize s_valid
      // scramble data signals on every cycle if !valid to catch slave reading it at wrong time
      s_data = s_valid ? s_data_val : 'x;

      // -------------- LOOP BEGINS HERE -----------
      @(posedge clk);
      prev_handshake = s_valid && s_ready; // read at posedge
      done           = s_valid && s_ready && (i_beats==N_BEATS);
      
      #10ps; // Delay before writing s_valid, s_data, s_keep
    end
    {s_valid, s_data, i_beats, done} = '0;
    prev_handshake = 1;
  endtask
endmodule