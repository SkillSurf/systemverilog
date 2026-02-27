`timescale 1ns / 1ps

module counter_tb;

  localparam WIDTH = 8;

  logic clk, rst, incr;
  logic [WIDTH-1:0] count_reg;

  counter #(.WIDTH(WIDTH)) dut (
    .clk(clk), .rst(rst), .incr(incr), .count_reg(count_reg)
  );

 // SBY (open source) cannot handle complex SVAs
`ifdef SBY
  // $past() is not valid at time zero. this blocks that fail.
  logic past_valid = 0;
  always @(posedge clk) past_valid <= 1;

  always @(posedge clk) begin
    if (past_valid) begin
      // rst clears counter in next cycle, so test that
      if ($past(rst))  assert (count_reg == '0);
      else             assert (count_reg == $past(count_reg) + WIDTH'($past(incr)));
    end
  end

 // Questa Formal can
`else

  property p_reset;
    @(posedge clk) rst |=> (count_reg == '0);
  endproperty

  /*
  - disable iff (rst) : we check the property during non reset
  - @(posedge clk) : the event edge
  - Terms:
    - antecedent : "if" part of the implication
    - consequent : "then" part of the implication
  - Implication types:
    - |-> : overlapped implication (if and then are both evaluated in the same clock)
    - |=> : non-overlapped implication (if is evaluated in this clock, then is evaluated in the next clock)
    - |-> ##n : delayed implication (if is evaluated in this clock, then is evaluated after n clocks)
    * |=> is syntactic sugar for |-> ##1
  */

  property p_increment;
    logic [WIDTH-1:0] prev_count_reg;
    logic prev_incr;

    // The implication
    @(posedge clk) // the event edge
      disable iff (rst) // implication valid only when rst is low
      (!rst, prev_count_reg = count_reg, prev_incr = incr) // !rst is the antecedent, rest are variables captured at the same edge as antecedent
        |=> // next clock implication
        (count_reg == prev_count_reg + WIDTH'(prev_incr)); // consequent (then part)
  endproperty

  ap_reset:     assert property (p_reset);
  ap_increment: assert property (p_increment);

`endif
endmodule