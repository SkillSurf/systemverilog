`timescale 1ns/1ps

module AXIS_Source #(
  parameter  WORD_W=8, BUS_W=8, PROB_VALID=20,
             N_BEATS=10,
  localparam WORDS_PER_BEAT = BUS_W/WORD_W
)(
  input  logic clk, s_ready,
  output logic s_valid=0,
  output logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] s_data = 'x
);
  task automatic axis_push_packet(
    input  logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] packet
  );
    for (int i=0; i<N_BEATS; i++) begin
       // randomize s_valid and wait
      while ($urandom_range(0,99) >= PROB_VALID) @(posedge clk);

      #1ps;
      s_valid = 1;
      s_data  = packet[i];
       // wait for s_data to be accepted
      do @(posedge clk); while (!s_ready);
      #1ps;
      // clear s_valid and s_data
      s_valid = 0;
      s_data  = 'x;
    end
  endtask
endmodule


module AXIS_Sink #(
  parameter  WORD_W=8, BUS_W=8, PROB_READY=20,
             N_BEATS=10,
             WORDS_PER_BEAT = BUS_W/WORD_W
)(
  input  logic clk, m_valid,
  output logic m_ready=0,
  input  logic [WORDS_PER_BEAT-1:0][WORD_W-1:0] m_data
);

  task automatic axis_pull_packet(
    output logic [N_BEATS-1:0][WORDS_PER_BEAT-1:0][WORD_W-1:0] packet
  );
    // loop over beats
    for (int i=0; i<N_BEATS; i++) begin

      do begin 
        #1ps;
        m_ready = 0; // keep m_ready low with probability (1-PROB_READY)
        while ($urandom_range(0,99) >= PROB_READY) @(posedge clk);
        #1ps;
        m_ready = 1;
        @(posedge clk); // keep m_ready high for one cycle
      end while (!m_valid); // if m_valid is high, break out of loop
      
      packet[i] = m_data; //sample m_data
    end
  endtask
endmodule
