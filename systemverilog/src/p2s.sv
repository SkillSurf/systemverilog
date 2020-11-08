module p2s #(parameter N = 8)
(
  input  logic         clk    ,
  input  logic [N-1:0] p_data ,
  input  logic         p_valid,
  output logic         p_ready,
  output logic         s_data ,
  output logic         s_valid,
  input  logic         s_ready
);
  typedef enum logic [0:0] { 
    RX = 1'b0,
    TX = 1'b1
  } states_t;

  // Inital values 
  // when FPGA power ups

  localparam N_BITS             = $clog2(N);
  logic      [N_BITS-1:0] count = 0        ;
  states_t                state = RX       ;

  // NEXT STATE DECODER LOGIC
  states_t next_state;
  always_comb begin
    unique case(state) 
      RX: begin 
            if (p_valid) next_state = TX;
            else         next_state = RX;
          end

      TX: begin
            if (count == N-1 && s_ready)
                next_state = RX;
            else         
                next_state = TX;
          end
    endcase
  end

  // STATE SEQUENCER LOGIC

  always_ff @(posedge clk) begin
    state <= next_state;
  end

  // OUTPUT DECODE LOGIC

  logic  [N-1:0]   shift_reg;
  assign s_data  = shift_reg[0];

  assign p_ready = (state == RX);
  assign s_valid = (state == TX);

  always_ff @(posedge clk) begin
    unique case(state)
      RX: shift_reg    <= p_data;
      TX: begin
            if (s_ready) begin
              shift_reg <= {1'd0, shift_reg[N-1:1]};
              count     <= count + 1'd1;
            end
            else begin
              shift_reg <= shift_reg;
              count     <= count;
            end
          end
    endcase
  end
endmodule

module p2s_tb();
  timeunit      1ns;
  timeprecision 1ps;

  logic             clk =  0;
  localparam CLK_PERIOD = 10;
  initial begin
    forever begin
      #(CLK_PERIOD/2);
      clk <= ~clk;
    end
  end

  parameter     N   = 8;
  logic [N-1:0] p_data    ;
  logic         p_valid;
  logic         p_ready;
  logic         s_data  ;
  logic         s_valid;
  logic         s_ready;

  p2s #(.N(N)) dut (.*);

  initial begin
    @(posedge clk) ;
    p_data  <= 8'd7;
    p_valid <= 0   ;
    s_ready <= 1   ;

    #(CLK_PERIOD*2) ;
    @(posedge clk)  ;
    p_data  <= 8'd62;
    p_valid <= 1    ;

    @(posedge clk)  ;
    p_valid <= 0    ;

    #(CLK_PERIOD*10);
    @(posedge clk)  ;
    p_data  <= 8'd52;
    p_valid <= 1    ;

    @(posedge clk)  ;
    p_valid <= 0    ;

    @(posedge clk)  ;
    s_ready <= 0    ;

    #(CLK_PERIOD*3) ;
    @(posedge clk)  ;
    s_ready <= 1    ;
  end
endmodule