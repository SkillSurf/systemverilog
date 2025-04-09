/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module project (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
); 

  localparam 
    CLOCKS_PER_PULSE = 50_000_000/19200,
    BITS_PER_WORD    = 8                ,
    PACKET_SIZE_TX   = BITS_PER_WORD + 5,
    W_Y_OUT          = 8                ,
    R                = 2                ,
    C                = 2                ,
    W_X              = 4                ,
    W_K              = 2                ;

  mvm_uart_system #(
    .CLOCKS_PER_PULSE (CLOCKS_PER_PULSE),
    .BITS_PER_WORD    (BITS_PER_WORD   ),
    .PACKET_SIZE_TX   (PACKET_SIZE_TX  ),
    .W_Y_OUT          (W_Y_OUT         ),
    .R                (R               ), 
    .C                (C               ), 
    .W_X              (W_X             ), 
    .W_K              (W_K             )
  ) MVM_UART_SYSTEM (
    .clk (clk), 
    .rstn(rst_n), 
    .rx  (ui_in [0]),
    .tx  (uo_out[0])
  );

  // All output pins must be assigned. If not used, assign to 0.
  assign uo_out[7:1] = 0;
  assign uio_out = 0;
  assign uio_oe  = 0;

  // List all unused inputs to prevent warnings
  wire _unused = &{uio_in, ui_in[7:1], ena, clk, rst_n, 1'b0};

endmodule
