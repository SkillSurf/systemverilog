# {System}Verilog for ASIC/FPGA Design & Simulation

This repository contains the examples for the short course: [SystemVerilog for ASIC/FPGA Design & Simulation](https://www.skillsurf.lk/verilog-for-ASIC-FPGA-design-simulation). The 64-hour hands-on course was delivered collaborating with Synopsys, teaching 271 participants from 13 countries, through basic (full adder, counter) to advanced (Parameterized AXI-Stream Matrix Multiplier with UART I/O) examples, testing each with randomized transactional testbenches, implementing the final system on FPGA \& testing with Python, and taking it through the ASIC flow with Synopsys tools.

## Feedback from the participants

> Course was well organized in a way for both beginners & intermediate students. Practical problems & projects oriented teaching style is really made easier to learn and grasp fundamentals & more. Thank you very much for the well confident lecture panel & organizers.

> This course is a good start for my long journey. Absolutely good. Lectures were good. Hope more things from ENTC, Synopsys and Skill Surf. Good Luck.

> The things I learned from this course - the insights, tactics, and guidance - felt more valuable than everything else I gained from this course. Never been to a course like this well prepared ...  hats-off to the entire team .. And their effort should be high appreciated ...These kind of initiatives deserves  to reach much more audience .. Wishing the team the best in their future endeavors ..

> Actually the instructors were very knowledgeable on this area and gave not only the theoretical knowledge but always gave an industrial approach. Giving access to the session recordings and other lecture materials though the moodle is also very convenient for us and it is highly appreciated.I am very grateful to have this course well with a discount also, as this knowledge is very difficult to occupy from a country like ours where there are not much resource persons in this domain.The content is okay but the sessions were much lengthy.So in next iteration of the course if the number of session hours within a day can be reduced it will be more convenient for the participants.

> Dr./Mr. Abarajithan was well-prepared for the lectures and explained System Verilog programming very clearly, while also highlighting the opportunities in this field. The course content covered the basics of FPGA programming, which is helpful for beginners who are taking their baby steps in this field. As a beginner, I am satisfied with following this course.

> The course was very interesting, and I was a total beginner for the SystemVerilog. But, at the end with the help of the teachers and the instructors I was able to grab the content in my best. I am willing to join future courses and waiting for them. Thank you very much.



---


The examples given in this repo have been tested on Xilinx Vivado and Synopsys DesignCompiler. Full system, AXI Stream system and their submodules have been tested on Icarus Verilog as well.  

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

---


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
