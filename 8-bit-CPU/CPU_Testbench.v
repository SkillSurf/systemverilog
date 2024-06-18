`timescale 10ns / 1ns

module CPU_System_TB();
	// This testbench was used to test the overall assembled system.
	// There are 2 tests that can be carried out: a simple test using 6 instructions,
	// and a comprehensive test of the CPU's entire range of functionality.
	// The simple test can be carried out by setting TEST_1 to 1. By default,
	// TEST_1 = 0, which enables the full system test.
	// The simple test demonstrates the CPU's ability to handle an overflow (adding 250 & 10).
	// The extensive test demonstrate's the CPU's entire instruction set - while complicated,
	// the CPU's correct operation for this test can be verified by checking it does not
	// get caught in any traps, as indicated by the comments below - i.e. the program counter
	// never outputs an address of 0x0E, 0x11, 0x15 or 0x18, and will loop back to the beginning
	// of the test once complete.

  reg NCLR, CLK; // Active low reset and clock inputs to CPU.
	wire SERIAL_OUT; // Serial output of CPU.
	reg TEST_1; // Test select.

	System_toplevel DUT (.CLK(CLK), .NCLR(NCLR), .SERIAL_OUT(SERIAL_OUT)); // Assembled CPU + memory module instantiation.

  always #5 CLK = ~CLK; // 100 ns clock period.

  initial begin
    $dumpfile("dump.vcd"); // Dump waveform file
    $dumpvars(0);
		CLK = 0; // Initialise clock.
    NCLR = 0; // Initialise reset.
		TEST_1 = 0; // Flag to determine which test instructions to load into RAM.

		// Load the following instructions into the RAM:

		if (TEST_1 == 1) begin: SIMPLE_TEST
			DUT.RAM_1.memory[0] = 'b1010000000000110; // INPUT ACC, 6
			DUT.RAM_1.memory[1] = 'b0100000000001010; // ADD ACC, 10
			DUT.RAM_1.memory[2] = 'b1001110000000100; // JUMP NC, 4
			DUT.RAM_1.memory[3] = 'b0000000011111111; // LOAD ACC, 255
			DUT.RAM_1.memory[4] = 'b1110000000000111; // OUTPUT ACC, 7
			DUT.RAM_1.memory[5] = 'b1000000000000000; // JUMP, 0
			DUT.RAM_1.memory[6] = 'b0000000011111010; // DATA: 250
			DUT.RAM_1.memory[7] = 'b0000000000000000; // DATA: 0

		end else begin: FULL_INSTRUCTION_SET_TEST
			DUT.RAM_1.memory['h00] = 'b0000000000000001; // LOAD ACC 0x01     -
			DUT.RAM_1.memory['h01] = 'b0100000000000000; // ADD ACC, 0x00     - test NZ NC ACC=1
			DUT.RAM_1.memory['h02] = 'b0100000011111111; // ADD ACC, 0xFF     - test Z  C  ACC=0
			DUT.RAM_1.memory['h03] = 'b0000000010101010; // LOAD ACC 0xAA     -
			DUT.RAM_1.memory['h04] = 'b0001000000001111; // AND ACC, 0x0F     - test NZ NC ACC=0x0A
			DUT.RAM_1.memory['h05] = 'b0001000000000000; // AND ACC, 0x00     - test Z  NC ACC=0x00
			DUT.RAM_1.memory['h06] = 'b0000000000000001; // LOAD ACC 0x01     -
			DUT.RAM_1.memory['h07] = 'b0110000000000001; // SUB ACC, 0x01     - test Z  NC ACC=0x00
			DUT.RAM_1.memory['h08] = 'b0110000000000001; // SUB ACC, 0x01     - test NZ C  ACC=0xFF
			DUT.RAM_1.memory['h09] = 'b1110000011110000; // OUTPUT ACC, 0xF0  - test M[0xF0] = 0xFF
			DUT.RAM_1.memory['h0A] = 'b0000000000000000; // LOAD ACC 0x00     -
			DUT.RAM_1.memory['h0B] = 'b1010000011110000; // INPUT ACC, 0xF0   - test ACC = 0xFF
			DUT.RAM_1.memory['h0C] = 'b0100000000000000; // ADD ACC, 0x00     - test NZ NC ACC=0x01
			DUT.RAM_1.memory['h0D] = 'b1001010000001111; // JUMP NZ, 0x0F     - skip trap if correct
			DUT.RAM_1.memory['h0E] = 'b1000000000001110; // JUMP 0x0E         - trap
			DUT.RAM_1.memory['h0F] = 'b0100000000000001; // ADD ACC, 0x01     - test Z NC ACC=0x00
			DUT.RAM_1.memory['h10] = 'b1001000000010010; // JUMP Z, 0x12      - skip trap if correct
			DUT.RAM_1.memory['h11] = 'b1000000000010001; // JUMP 0x11         - trap
			DUT.RAM_1.memory['h12] = 'b0000000000000010; // LOAD ACC 0x02
			DUT.RAM_1.memory['h13] = 'b0100000011111111; // ADD ACC, 0xFF     - test NZ C ACC=0x01
			DUT.RAM_1.memory['h14] = 'b1001100000010110; // JUMP C, 0x16      - skip trap if correct
			DUT.RAM_1.memory['h15] = 'b1000000000010101; // JUMP 0x15         - trap
			DUT.RAM_1.memory['h16] = 'b0110000000000001; // SUB ACC, 0x01     - test Z  NC ACC=0x00
			DUT.RAM_1.memory['h17] = 'b1001110000011001; // JUMP NC, 0x19     - skip trap if correct
			DUT.RAM_1.memory['h18] = 'b1000000000011000; // JUMP 0x15         - trap
			DUT.RAM_1.memory['h19] = 'b1000000000000000; // JUMP 0x00         - loop
			end

		// Assert reset for 5 clock periods at the beginning of the simulation:
    repeat(5) begin
			@ (posedge CLK) begin
					NCLR = 0;
			end
		end
		NCLR = 1; // Turn off reset.

    #1000 $finish;
  end
endmodule