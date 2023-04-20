`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/16/2023 09:40:43 PM
// Design Name: 
// Module Name: test_logic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module fpga_module(
    input  logic clk, rstn, rx, 
    //input  logic [NUM_WORDS-1:0][BITS_PER_WORD-1:0] s_data,
    output logic tx//, s_ready
    );
    
    mvm_uart_system #(
        .CLOCKS_PER_PULSE(1085), //200_000_000/9600
        .BITS_PER_WORD(8),
        .W_Y_OUT(32),
        .R(8),.C(8),.W_X(8),.W_K(8)
    ) mvm_uart_system_0 (.*);
    
//    logic [0:0][7:0] s_data;
//    logic s_valid;
//    logic s_ready;
    
//    logic m_valid;
//    logic [7:0] m_data;
    
//    always_comb begin
//        s_data[0] = m_data;
//        s_valid = m_valid;
//    end
    
//    uart_tx #(
//        .CLOCKS_PER_PULSE(1085), //200_000_000/9600
//        .BITS_PER_WORD(8),
//        .W_OUT(8) //R*C*W_K + C*W_X
//    ) uart_tx_0 (.*);
    
//    uart_rx #(
//            .CLOCKS_PER_PULSE(1085), //200_000_000/9600
//            .BITS_PER_WORD(8),
//            .W_OUT(8) //R*C*W_K + C*W_X
//        ) uart_rx_0 (.*);
endmodule
