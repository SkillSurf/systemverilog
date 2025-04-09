# SG13G2_ASIC-Design-Template
## Introduction

This template repository is suited for analog-digital mixed signal design with the 130nm BiCMOS open-source SG13G2 PDK by IHP and the IIC-OSIC-Tools by IIC JKU. 

IHP SG13G2 PDK: https://github.com/IHP-GmbH/IHP-Open-PDK

IIC-OSIC-Tools: https://github.com/iic-jku/IIC-OSIC-TOOLS

The installation of IIC-OSIC-Tools is explained under `SG13G2_ASIC-Design-Template/doc/Docker-Tutorial.pdf` or in this YouTube video: https://www.youtube.com/watch?v=azgFzleiBW8&t=1943s.

The recommended folder structure makes it easy to automate with shell scripts. VHDL files are read and converted into Verilog files (`vhdl2verilog.sh`). If Verilog files are available directly, this step can be skipped. With OpenROAD flow-scripts (ORFS) the newly generated Verilog file is synthesized and a layout is created. The synthesized Verilog file is then converted into a `.xspice` file with `qflow` scripts (`vlog2Verilog`, `vlog2Spice`, `spi2xspice.py`) which can be included into `Xschem` for analog-digital mixed simulation. All these scripts are automated with `run_all.sh` and can be cleaned again with `clean_all.sh`. The template contains a 4-Bit counter with an enable input to get a better understanding of the structure and the file paths within the scripts.

I have also made a short video on how to use this repo: https://www.youtube.com/watch?v=UrUOg9s7gsM

If you want to use other OpenROAD-compatible PDKs, just add the corresponding files to the `orfs/flow/platforms` folder. These files can be found at https://github.com/The-OpenROAD-Project/OpenROAD-flow-scripts.

## How to use this template for your design

#### Step-by-step introduction:

1. Clone or download this repo and copy it into the `foss/designs` folder of your IIC-OSIC-Tools environment.
2. Copy the `.designinit` file from `foss/designs/SG13G2_ASIC-Design-Template` to `foss/designs` and check the path for Xschem. This will change the used PDK to SG13G2 by IHP.
   **Update:** The path to Xschem is now set with the `xschemrc` file. Just start Xschem within the `xschem` folder and everything will be set up.
3. Rename the repo as you wish.
4. Execute `clean_all.sh` to remove any build files.
5. Add your VHDL code to the `vhdl` folder. It is advised that the same folder structure with `rtl` and `sim` is used.
6. Add your `Xschem` files and testbenches to the `xschem` folder
7. Adapt VHDL paths in `vhdl2verilog.sh` in the `verilog` folder. If the design is already done in Verilog, this step can be skipped. Do not forget to also comment out this step in `run_all.sh`.
8. Add config files to `orfs/flow/designs/ihp-sg13g2`. It is a good idea to copy an existing folder (e.g. `counter_board`) and adapt these files. Do not forget to set the path to the Verilog file in `config.mk` and set up the `constraint.sdc` and `autotuner.json`.
9. Adapt name and Verilog path in `run_all.sh`.
10. In the Xschem testbench, include the generated .xspice file with an absolute path, otherwise, ngspice will not find the file. For example, `.include /foss/designs/SG13G2_ASIC-Design-Template/xspice/counter_board/counter_board.xspice`
11. Create a symbol with all needed pins (also VDD and VSS) and assign the pin order with `SHIFT+S`. The pin order can be found in the `.xspice` file (left signal = 0 to right signal = N-1). In the properties (open with `q`), the type should be set to `type=primitive`. It is recommended to check the `.sym` file in a text editor if everything was set correctly.

For more detailed information, please refer to Option B in `SG13G2_ASIC-Design-Template/doc/AMS_simulation.pdf` or the YouTube video.

#### Hierarchical synthesis:

If you want to see the area per module / entity of your digital core, you can set `export SYNTH_HIERARCHICAL=1` in `run_all.sh` and open the hierarchy browser in the OpenROAD GUI. If it is disabled, check the box under `Windows/Hierarchy Browser`.

**Note that the mixed-signal simulation in Xschem will not work if `SYNTH_HIERARCHICAL=1` is set. Hence, this line must be commented out for simulation.**

#### Simulation details:

The VHDL code is simulated with `GHDL` & `GTKWave` (counter_tb.gtkw ) or `Modelsim` (sim.do). The VHDL simulation can be executed with `simulate_vhdl.sh`. The Verilog code is simulated with `verilator` & `iverilog` & `GTKWave` or `Modelsim` (sim_verilog_tb.do or sim_vhdl_tb.do). The Verilog simulation can be executed with `simulate_verilog.sh`. Alternatively, one can use `Surfer` instead of `GTKWave`. Further information can be found in the YouTube video.

#### Exporting Ngspice data and plotting them with Python:

The data can not only be shown within Xschem but, of course, exported as a .txt file, read with Python and the function `loadngspicecol` in `ngspice2python.py`, and finally plotted with Matplotlib. If you navigate into `foss/designs/SG13G2_ASIC-Design-Template/python/plot_simulations` and execute `python3 plot_counter_board_tb_tran.py`, the plot will pop up.

<img src="python\plot_simulations\figures\counter_board_simulation.svg" width="1200"/>

**Figure 1**: Ngspice data plotted with Python
