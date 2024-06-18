module System_toplevel(NCLR, CLK, SERIAL_OUT);
	// This is the design for the assembled CPU and memory.
	
	// System Inputs and outputs:
	input wire NCLR, CLK; // Active low reset and clock signals.
	output reg SERIAL_OUT; // Serial output port.

	// Internal nets:
	wire SYS_CLR; // Internal system reset (active high).
	wire EN_IR; // Enable instruction register.
	wire EN_PC; // Enable program counter register.
	wire EN_DA; // Enable accumulator register.
	wire [15:0] IR_OUT; // Instruction register output.
	wire [15:0] RAM_OUT; // Data Out port of RAM.
	wire [7:0] PCR_OUT; // Program counter register output.
	wire MUX_A_SEL; // Mux A input select signal.
	wire MUX_B_SEL; // Mux B input select signal.
	wire MUX_C_SEL; // Mux C input select signal.
	wire [7:0] ACCR_OUT; // Accumulator register output.
	wire [7:0] ALU_IN_A; // A port input of ALU.
	wire [7:0] ALU_IN_B; // B port input of ALU.
	wire [7:0] ALU_OUT; // output port of ALU.
	wire [4:0] ALU_SEL; // ALU operation select.
	wire CARRY; // Carry out of ALU.
	reg ZERO; // Zero is the unary NOR of ALU_OUT.
	wire[7:0] ADDRESS; // RAM memory address.
	wire RAM_WE; // RAM write enable, 1 for write, 0 for read.
	wire FDCE_OUT; // Output of serial output flip flop.

	// Register SYSTEM_RESET_REG toggles the system reset to each block in the CPU:
	register #(.WIDTH(1)) SYSTEM_RESET_REG (.CLK(CLK), .CLR(1'b0), 
																					.CE(1'b1), .D(!NCLR), .Q(SYS_CLR));
																					
  register #(.WIDTH(16)) INSTRUCTION_REG (.CLK(CLK), .CLR(SYS_CLR), .CE(EN_IR),
																					.D(RAM_OUT), .Q(IR_OUT));
																					
	register #(.WIDTH(8)) PROGRAM_COUNTER_REG (.CLK(CLK), .CLR(SYS_CLR), .CE(EN_PC),
																						 .D(ALU_OUT), .Q(PCR_OUT));
																						 
	mux_2_1 #(.WIDTH(8)) MUX_A (.SEL(MUX_A_SEL), .A(ACCR_OUT), .B(PCR_OUT), .Y(ALU_IN_A));
	
	mux_2_1 #(.WIDTH(8)) MUX_B (.SEL(MUX_B_SEL), .A(RAM_OUT[7:0]), .B(IR_OUT[7:0]), .Y(ALU_IN_B));
	
	Arithmetic_Logic_Unit ALU (.A(ALU_IN_A), .B(ALU_IN_B), .SEL(ALU_SEL), .Cout(CARRY), .Y(ALU_OUT));
	
	always @ (ALU_OUT) begin
		ZERO = !(|ALU_OUT);
	end
		
	register #(.WIDTH(8)) ACCUMULATOR_REG (.CLK(CLK), .CLR(SYS_CLR), .CE(EN_DA),
																					.D(ALU_OUT), .Q(ACCR_OUT));
	
	mux_2_1 #(.WIDTH(8)) MUX_C (.SEL(MUX_C_SEL), .A(PCR_OUT), .B(IR_OUT[7:0]), .Y(ADDRESS));
	
	decoder_2 DECODER (.IR(IR_OUT[15:8]), .Carry(CARRY), .Zero(ZERO), .CLK(CLK), .CE(1'b1),
										 .CLR(SYS_CLR), .MUXA(MUX_A_SEL), .MUXB(MUX_B_SEL), . MUXC(MUX_C_SEL),
										 .EN_DA(EN_DA), .EN_PC(EN_PC), .EN_IR(EN_IR), .RAM_WE(RAM_WE),
										 .ALU_SEL(ALU_SEL));
	
	RAM #(.DATA_WIDTH(16), .ADDRESS_WIDTH(8)) RAM_1  (.clk(!CLK), .en(1'b1), 
													.data_in({8'b0,ACCR_OUT}), .address(ADDRESS), .write(RAM_WE),
													.data_out(RAM_OUT));
													
	register #(.WIDTH(1)) FDCE (.CLK(CLK), .CLR(SYS_CLR), .CE(&ADDRESS), .D(ACCR_OUT[0]),
															.Q(FDCE_OUT)); // Register controlling the serial output of the CPU.
	always @ (FDCE_OUT) begin
		SERIAL_OUT = !FDCE_OUT;
		end
	
endmodule

module mux_2_1 #(parameter WIDTH = 8) (SEL, A, B, Y);
	// 2x1 Multiplexer
	
	// Inputs and outputs:
  input wire SEL; // 1 bit input select.
  input wire [WIDTH-1:0] A, B; // 8 bit input vectors by default.
  output reg [WIDTH-1:0] Y; // 8 bit output vector by default.
  
  always @(SEL or A or B) begin
    // Level sensitive - triggers always block whenever A or B or SEL changes.
    if (SEL == 1'b0) begin // If select is 0, output is A.
    	Y = A;
    end else if (SEL == 1'b1) begin // If select is 1, output is B.
      Y = B;
    end else begin
      Y = 'bx;
    end
  end
endmodule
  
module Arithmetic_Logic_Unit (A, B, SEL, Y, Cout);
	// ALU
	
	// Inputs and outputs:
  input wire [4:0] SEL; // ALU operation select.
  input wire [7:0] A,B; // ALU input ports.
  output reg [7:0] Y; // ALU output port.
  output reg Cout; // ALU carry out.
  
  // Parameters define ALU operation to carry out:
  parameter ADD = 5'b00000; // Add A + B.
  parameter AND = 5'b00001; // Bitwise AND of A & B.
  parameter IN_A = 5'b00010; // Input A passed to output.
  parameter IN_B = 5'b00011; // Input B passed to output.
  parameter SUBTRACT = 5'b01100; // Subtract A - B.
  parameter INCR_A = 5'b10100; // Increment A (A+1).
  parameter IN_A_2 = 5'b10000; // Input A passed to output.
  parameter ADD_A_B_1 = 5'b00100; // Add (A+B)+1.
  parameter SUB_A_B_1 = 5'b01000; // Subtract (A-B)-1.
  
  always @ (A or B or SEL) begin
    case(SEL)
      	ADD: {Cout,Y} = A + B;
        AND: Y = A & B;
        IN_A: Y = A;
        IN_B: Y = B;
      	SUBTRACT: {Cout, Y} = A - B;
      	INCR_A: {Cout, Y} = A + 1;
        IN_A_2: Y = A;
      	ADD_A_B_1: {Cout, Y} = (A + B) + 1;
        SUB_A_B_1: {Cout, Y} = (A - B) - 1;
      default: Y = 'bx;
    endcase
  end
endmodule

module register #(parameter WIDTH = 8) (D, CLK, CE, CLR, Q);
  // Variable data width register
	
	// Inputs and outputs:
  input wire [WIDTH-1:0] D; // Input data.
  input wire CLK, CE, CLR; // Clock, enable and reset inputs.
  output reg [WIDTH-1:0] Q; // Output data.
  
  always @ (posedge CLK or CLR) begin
    if (CLR == 1'b1) begin // Asynchronous reset.
    	Q <= 'b0;
  	end else begin
      if (CE == 1'b1) // Data at D passed to output Q.
        	Q <= D;
      	else
        	Q <= Q; // Data on Q doesn't change.
   		end
  	end
endmodule
  
module sequence_generator #(parameter WIDTH = 4) (CLK, CLR, CE, Q);
	// Ring counter to track current state - Fetch, Decode, Execute or Increment.
	
	// Inputs and outputs:
  input wire CLK, CLR, CE; // Clock, reset and enable inputs.
  output reg [WIDTH-1:0] Q; // 4 bit (default) output vector - one hot encoded.
	
  always @ (posedge CLK or CLR) begin
    if (CLR == 1'b1) begin // Asynchronous reset.
      // Reset sets Q to 1000 - i.e. resets CPU to Fetch phase.
      Q[WIDTH-1] <= 1;
      Q[WIDTH-2:0] <= 0;
  	end else begin
      if (CE == 1'b1) begin
        // Increment counter if enabled, thus entering the next phase of the
        // Fetch, Decode, Execute and Increment cycle.
        Q[WIDTH-1] <= Q[0];
      	Q = Q >> 1;
      end else begin
        	Q <= Q; // Do not increment counter.
        end
   	end
  end
endmodule

module instruction_decoder (A, OUTPUT_BUS);
  // Instruction decoder converts the high byte of the 16 bit instruction
  // (which was collected and loaded into the instruction register during
  // the Fetch phase) into a one-hot encoded value which indicates what action
  // needs to be excuted in the Execute phase.
  
	// Inputs and outputs:
  input wire [7:0] A; // 8 bit instruction input.
  output reg [10:0] OUTPUT_BUS; // 11 bit one hot encoded output instruction.
	
  // The 11 one-hot coded options are shown in the case statement.
  always @ (A) begin
    case (A[7:4])
      'b0000: OUTPUT_BUS = 11'b10000000000; // Load = OUTPUT_BUS[10]
      'b0100: OUTPUT_BUS = 11'b01000000000; // Add = OUTPUT_BUS[9]
      'b0001: OUTPUT_BUS = 11'b00100000000; // BitAnd = OUTPUT_BUS[8]
      'b0110: OUTPUT_BUS = 11'b00010000000; // Sub = OUTPUT_BUS[7]
      'b1010: OUTPUT_BUS = 11'b00001000000; // Input = OUTPUT_BUS[6]
      'b1110: OUTPUT_BUS = 11'b00000100000; // Output = OUTPUT_BUS[5]
      'b1000: OUTPUT_BUS = 11'b00000010000; // Jump U = OUTPUT_BUS[4]
      'b1001: begin
        case (A[3:2])
          'b00: OUTPUT_BUS = 11'b00000001000; // Jump Z = OUTPUT_BUS[3]
          'b10: OUTPUT_BUS = 11'b00000000100; // Jump C = OUTPUT_BUS[2]
          'b01: OUTPUT_BUS = 11'b00000000010; // Jump NZ = OUTPUT_BUS[1]
          'b11: OUTPUT_BUS = 11'b00000000001; // Jump NC = OUTPUT_BUS[0]
          default: OUTPUT_BUS = 'bx;
        endcase
      end
      default: OUTPUT_BUS = 'bx;
    endcase
  end
endmodule

module decoder_2 (IR, Carry, Zero, CLK, CE, CLR, MUXA, MUXB, MUXC, EN_DA, EN_PC, EN_IR, RAM_WE, ALU_SEL);
	// Decoder - decodes instructions and outputs control signals to execute instructions.
	
	// Inputs and outputs:
	input wire [7:0] IR; // 8 bit instruction input.
  input wire Carry, Zero, CLK, CE, CLR; // Carry from ALU, Zero from ALU, clock, enable and reset.
  output reg MUXA, MUXB, MUXC, EN_DA, EN_PC, EN_IR, RAM_WE; // As defined in System_toplevel module.
  output reg [4:0] ALU_SEL; // ALU operation select.
	
	// Internal Nets:
	wire FETCH, DECODE, EXECUTE, INCREMENT; // Track current state in Fetch, Decode, Execute & Increment.
	wire CARRY_REG, ZERO_REG; // Store outputs of 2 bit register.
	wire[10:0] INSTRUCTION; // Track current instruction from instruction_decoder.
	reg[10:0] INSTRUCTION_VALID; // INSTRUCTION only available in DECODE and EXECUTE states.
	reg LOAD, ADD, BITAND, SUB, INPUT, OUTPUT, JUMP, JUMPZ, JUMPC, JUMPNZ, JUMPNC;
	reg EN_ST; // If current instruction is ADD, SUB, or BITAND, enable 2 bit register.
	reg JUMP_TAKEN;
	wire JUMP_NOT_TAKEN;
  reg [4:0] JUMP_CONDITIONS;
  reg [4:0] JUMP_INSTRUCTIONS;
	
	sequence_generator #(.WIDTH(4)) SEQ_GEN (.CLK(CLK), .CE(CE), .CLR(CLR), 
												.Q({FETCH,DECODE,EXECUTE,INCREMENT}));
	instruction_decoder INST_DEC (.A(IR), .OUTPUT_BUS(INSTRUCTION));
	register #(.WIDTH(2)) REG_2_BIT (.CLK(CLK), .CLR(CLR), .CE(EN_ST), .D({Zero,Carry}), 
																		.Q({ZERO_REG,CARRY_REG}));
	register #(.WIDTH(1)) FDC (.CLK(CLK), .CLR(CLR), .CE(1'b1), .D(!JUMP_TAKEN), .Q(JUMP_NOT_TAKEN));
	
	always @ (FETCH or DECODE or EXECUTE or INCREMENT or INSTRUCTION or CARRY_REG or ZERO_REG) begin
		// Instruction only valid during DECODE and EXECUTE states:
		if (DECODE | EXECUTE) begin
      INSTRUCTION_VALID = INSTRUCTION;
    end else begin
      INSTRUCTION_VALID ='b0;
    end
		
		// Instructions defined by one hot encoding:
		LOAD = INSTRUCTION_VALID[10];
		ADD = INSTRUCTION_VALID[9];
		BITAND = INSTRUCTION_VALID[8];
		SUB = INSTRUCTION_VALID[7];
		INPUT = INSTRUCTION_VALID[6];
		OUTPUT = INSTRUCTION_VALID[5];
		JUMP = INSTRUCTION_VALID[4];
		JUMPZ = INSTRUCTION_VALID[3];
		JUMPC = INSTRUCTION_VALID[2];
		JUMPNZ = INSTRUCTION_VALID[1];
		JUMPNC = INSTRUCTION_VALID[0];
		
		// 2 bit status register only enabled during an add, subtract or bitwise AND operations:
		EN_ST = (ADD || SUB || BITAND);
		
		// 11 bit vector for Jump conditions:
		JUMP_CONDITIONS = {1'b1,ZERO_REG,CARRY_REG,!ZERO_REG,!CARRY_REG};
		// Concatenating all the Jump instructions available
		JUMP_INSTRUCTIONS = {JUMP, JUMPZ, JUMPC, JUMPNZ, JUMPNC};
		
		// Detects if any Jump was taken for any Jump instruction type:
		JUMP_TAKEN = |(JUMP_INSTRUCTIONS & JUMP_CONDITIONS); // Program counter register is not incremented if a Jump was taken.
		
		// Conditions for outputs of decoder:
		RAM_WE = (EXECUTE & OUTPUT);
		ALU_SEL[0] = (BITAND | INPUT | LOAD | JUMP | JUMPZ | JUMPNZ | JUMPC | JUMPNC);
		ALU_SEL[1] = (LOAD | INPUT | OUTPUT | JUMP | JUMPZ | JUMPNZ | JUMPC | JUMPNC);
		ALU_SEL[2] = (INCREMENT | SUB);
		ALU_SEL[3] = SUB;
		ALU_SEL[4]  = INCREMENT;
		MUXA = INCREMENT;
		MUXB = (LOAD | ADD | BITAND | SUB);
		MUXC = (INPUT | OUTPUT);
		EN_IR = FETCH;
		EN_DA = (EXECUTE & (LOAD | ADD | SUB | BITAND | INPUT));
		EN_PC = ((INCREMENT & JUMP_NOT_TAKEN) | (EXECUTE & JUMP_TAKEN));
		end
endmodule

module RAM #(parameter DATA_WIDTH = 16,  
             parameter ADDRESS_WIDTH = 8) (clk, en, data_in, address, write, data_out);
  localparam ADDRESS_DEPTH = 2**(ADDRESS_WIDTH);
	
	// Inputs and outputs:
  input wire clk, en; // Clock and enable signal - Enable = 1 by default for this application.
  input wire [DATA_WIDTH-1:0] data_in; // Data input for write operation.
  input wire [ADDRESS_WIDTH-1:0] address; // Input for memory address to be written to/read from.
  input wire write; // Indicates 1 for write operation, 0 for read operation.
  output reg [DATA_WIDTH-1:0] data_out; // Data output for read operation.
  
  reg [DATA_WIDTH-1:0] memory [0:ADDRESS_DEPTH-1]; // 256x16 bit memory array.
  
  always @ (posedge clk) begin
    if (en && write) begin: WRITE_OPERATION
      memory[address] <= data_in; // Write data at input to address.
    end else if (en && ~write) begin: READ_OPERATION
      data_out <= memory[address]; // Pass data at address to data output.
    end else begin
      data_out <= {DATA_WIDTH{1'bz}};
    end
  end
endmodule