# {System}Verilog for ASIC/FPGA Design & Simulation

This repository contains the examples for the course: [SystemVerilog for ASIC/FPGA Design & Simulation](https://www.skillsurf.lk/verilog-for-ASIC-FPGA-design-simulation).
The examples have been tested on Xilinx Vivado and Synopsys DesignCompiler. Full system, AXI Stream system and their submodules have been tested on Icarus Verilog as well.  

## Full System: Matrix Vector Multiplier (AXI-Stream) with UART Interface

#### RTL **Design:**

- **`mvm_uart_system.v`**: Full system, implemented on FPGA, and as an ASIC, with UART serial (rx, tx) I/O
  - **`uart_rx.sv`**: Receives the matrix `k[R,C]` and input vector `x[C]` as UART serial input and converts to parallel AXI Stream
  - **`axis_matvec_mul.v`**: Wrapper to make the simple latency-based matvec_mul into AXI Stream module
    - **`matvec_mul.sv`**: Multiplies `k[R,C]` and `x[C]` to produce `y[R]` in clog2(C) clock cycles 
    - **`skid_buffer.sv`**: Breaks the combinational path from m_ready to s_ready and "skids" the data into a buffer when `m_ready=0`
  - **`uart_tx.sv`**: Converts output vector `y[R]` from parallel AXI Stream into serial UART output

To synthesize the full system with Synopsys DesignCompiler, first edit `asic_flow/run_dc.tcl` and add the path to PDK next to `target_library`

```
mkdir asic_flow/syn
cd asic_flow/syn
dc_shell -f ../run_dc.tcl
```


#### Testbench:

- **`mvm_uart_system_tb.sv`**: Randomize `k` & `x`, drives TX & monitors RX in parallel, asserts `y_exp==exp`
  - **`mvm_uart_system.v`**: Top module
  
To test the full system with Icarus Verilog:
```
iverilog -g2012 -o compiled rtl/mvm_uart_system.v rtl/uart_rx.sv rtl/uart_tx.sv rtl/axis_matvec_mul.v rtl/matvec_mul.sv rtl/skid_buffer.sv tb/mvm_uart_system_tb.sv tb/simple_axis_tb.sv && vvp compiled
```
  
## AXI-Stream IP: Matrix Vector Multiplier

#### RTL **Design:** 
- **`axis_matvec_mul.v`** and submodules as described above

#### Testbench:

- **`axis_matvec_mul_tb.sv`**: Randomize `k` & `x`, drives slave & monitors master in parallel, asserts `y_exp==exp`
  - **`axis_matvec_mul.v`**: Top module as described above
  - **`simple_axis_tb.sv`**
    - `AXIS_Source`: parametrized module with task `axis_push` to send a packet with `N_BEATS` on a bus with `W_BUS` width, while randomly toggling `s_valid` with given probability
    - `AXIS_Sink`: parametrized module with task `axis_pull` to receive a packet with `N_BEATS` from a bus with `W_BUS` width, while randomly toggling `m_ready` with given probability 

To test the AXI Stream IP with Icarus Verilog:
```
iverilog -g2012 -o compiled rtl/axis_matvec_mul.v rtl/matvec_mul.sv rtl/skid_buffer.sv tb/axis_matvec_mul_tb.sv tb/simple_axis_tb.sv && vvp compiled
```




## Examples: Basic to advanced

Each example introduces digital design concepts and synthesisable (RTL) & non-synthesisable (verification) features of SystemVerilog.

### Combinational circuits
- **`full_adder`**
  - Adds 2 bits and carry-in bit to produce 1 bit and carry-out bit
  - **RTL:** 3 ways of combinational assignments, module, port, logical operators
  - **Verification:** Initial block, dump waveform, delays, assertions, string formatting, read internal signals, `$display`
- **`n_bit_adder`** 
  - Chaining `full_adder` into a ripple carry adder
  - **Design:** Hierarchical design, parametrization
  - **RTL:** Vectors, endian, packed/unpacked, parameters, module instantiation, synthesizable for loop
  - **Verification:** Literals, randomizing with constraints (`std::randomize`), repeat loop
- **`alu`**
  - Combinational ALU
  - **RTL:** signed type, if-else vs unique case
  - **Verification:** Classes & objects, constructors, rand members, bit (2-state) vs logic (4-state)
- **`function_lut`**
  - Implementing functions and lookup tables 
  - **RTL:** static vs automatic, 2 ways to return, recursive functions, inverse functions, LUTs as arrays, synthesizing a function vs filling up a LUT.
- **`decoder_example`**
  - Writing a 435-line instruction decoder in 95-lines
  - **RTL:** last assignment wins (remove duplicate lines), group common cases in `case`
    
### Sequential circuits:

- **`counter`**
  - N-bit counter with increment signal
  - **Design:** clock enable, synchronous active-high reset
  - **RTL:** always_ff, non-blocking statements
  - **Verification:** Clock generation
- **`fir_filter`**
  - Order N, (N+1 tap) fir_filter
  - **Design:** Width of multipliers & adders, shift registers, asynchronous active-low reset
  - **RTL:** array as parameter, Adding N numbers with `always_comb y += x`, `$signed()`
  - **Verification:** File read & write, queues: (`push_front`, `pop_back`) 
- **`fir_filter_2`**: 
  - **Design:** Retiming to increase frequency from 476 MHz to 1 GHz (2.1x)

### Advanced:

- **`p2s`**
  - Parallel to Serial Converter with AXI Stream input (slave) and output (master ports)
  - **Design:** State machines, AXI Stream protocol & signals, shift register
  - **RTL:** 3-procedure coding style of state machines
- **`uart_rx`**, **`uart_tx`**
  - Convert between UART & AXI Stream buses
  - **Design:** UART protocol, Nested counters, 
  - **RTL:** 1-procedure coding style of state machines
  - **Verification:** Randomizing with `$urandom` & `$urandom_range`, driving & monitoring signals in parallel, `wait`
- **`simple_axis_tb`**
  - Randomized modules to verify AXI Stream functionality of other modules
  - **Verification:** 
    - `AXIS_Source` - randomly toggle `s_valid` with given probability and send data. Scramble data on `s_valid=0`
    - `AXIS_Sink` - randomly toggle `m_ready` with given probability and receive data
- **`skid_buffer`**
  - **Design:** skidding data when `m_ready=0`
  - **Verification:** Parallel AXI Stream driver & monitor
- **`matvec_mul`**
  - **Design:** parametrized adder trees
  - **RTL:** packed multidimensional arrays
  - **Verification:** 
    - Simple testbench: `foreach` loop, `typedef`
    - Testbench with classes: virtual class to parametrize functions, streaming operator
