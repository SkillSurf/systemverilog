module axis_matvec_mul_tb;
  timeunit 1ns/1ps;
  localparam  R=8, C=8, W_X=8, W_K=8,
              W_Y = W_X + W_K + $clog2(C),

              BUS_IN_W = R*C*W_K + C*W_X,
              BUS_OUT_W = R*W_Y,
              PROB_VALID=10, PROB_READY=10,
              CLK_PERIOD=10, NUM_EXP=500;

  logic clk=0, rstn=0;
  initial forever #(CLK_PERIOD/2) clk <= ~clk;

  logic s_ready, s_valid, m_ready, m_valid;

  logic        [C-1:0][W_X-1:0] x_in, x_out;
  logic [R-1:0][C-1:0][W_K-1:0] k_in, k_out;
  logic        [C-1:0][W_K-1:0] k_row_in, k_row_out;
  logic [BUS_IN_W  -1:0] s_axis_kx_tdata, s_data, in_data;
  logic [R-1:0][W_Y-1:0] m_axis_y_tdata, m_data, out_data, exp_data;
  logic [BUS_IN_W  -1:0] queue [$];

  AXIS_Source #(.WORD_W(BUS_IN_W ), .BUS_W(BUS_IN_W ), .PROB_VALID(PROB_VALID), .N_BEATS(1)) source (.*);
  AXIS_Sink   #(.WORD_W(BUS_OUT_W), .BUS_W(BUS_OUT_W), .PROB_READY(PROB_READY), .N_BEATS(1)) sink   (.*);

  logic s_axis_kx_tready, s_axis_kx_tvalid, m_axis_y_tready, m_axis_y_tvalid;
  assign {s_ready, s_axis_kx_tvalid, s_axis_kx_tdata} = {s_axis_kx_tready, s_valid, s_data};
  assign {m_axis_y_tready, m_valid, m_data} = {m_ready, m_axis_y_tvalid, m_axis_y_tdata};
  axis_matvec_mul #(.R(R),.C(C),.W_X(W_X),.W_K(W_K)) dut (.*);

  // AXIS Driver
  initial begin
    $dumpfile ("dump.vcd"); $dumpvars;

    repeat (2) @ (posedge clk);
    rstn = 1;

    repeat(NUM_EXP) begin
      // Randomize in_data
      foreach (x_in[c]) 
        x_in[c] = $urandom_range(0,2**W_X-1);
      foreach (k_in[r]) begin
        foreach (k_row_in[c])
          k_row_in[c] = $urandom_range(0,2**W_K-1);
        k_in[r] = k_row_in;
      end

      in_data = {k_in, x_in};

      queue.push_front(in_data); // append to end of queue
      source.axis_push_packet;
    end
  end

  // AXIS Monitor
  initial begin
    repeat(NUM_EXP) begin

      sink.axis_pull_packet;
      {k_out, x_out} = queue.pop_back();

      exp_data = '0;
      foreach (k_out[r]) begin
        k_row_out = k_out[r];
        foreach (k_row_out[c])
          exp_data[r] = $signed(exp_data[r]) + $signed(k_row_out[c]) * $signed(x_out[c]);
      end

      assert (exp_data == out_data)
        $display("Outputs match: %d", exp_data);
      else $fatal(0, "Expected: %d != Output: %d", exp_data, out_data);
    end
    $finish();
  end

endmodule