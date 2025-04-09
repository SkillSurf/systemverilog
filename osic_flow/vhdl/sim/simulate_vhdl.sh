#!/bin/bash

# =====================================================
# Author: Simon Dorrer
# Last Modified: 07.12.2024
# Description: This .sh file verifies and simulates a VHDL testbench with GHDL and GTKWave.
# =====================================================

set -e -x

cd $(dirname "$0")

name=$1

RTL=${RTL:-../rtl}
SRC_FOLDER=${SRC_FOLDER:-.}

mkdir -p build

# Check syntax of sources with GHDL
echo "------ Check syntax of sources with GHDL ------"
ghdl -s --std=93c --work=counter --workdir=build \
  "$RTL"/constants_p.vhd \
  "$RTL"/"$name"_ea.vhd \
  "$RTL"/"$name"_board.vhd \
  "$SRC_FOLDER"/"$name"_tb.vhd
  
# Analyze sources with GHDL
echo "------ Analyze sources with GHDL ------"
ghdl -a --std=93c --work=counter --workdir=build \
  "$RTL"/constants_p.vhd \
  "$RTL"/"$name"_ea.vhd \
  "$RTL"/"$name"_board.vhd \
  "$SRC_FOLDER"/"$name"_tb.vhd
  
# Elaborate testbench with GHDL
echo "------ Elaborate testbench with GHDL ------"
ghdl -e --std=93c --work=counter --workdir=build "$name"_tb
  
# Run testbench with GHDL
echo "------ Run testbench with GHDL ------"
# ghdl -r --std=93c --work=counter --workdir=build "$name"_tb --stop-time=500ns --vcd="$SRC_FOLDER"/"$name"_tb.vcd
ghdl -r --std=93c --work=counter --workdir=build "$name"_tb --assert-level=error --vcd="$SRC_FOLDER"/"$name"_tb.vcd || true

# View simulation with GTKWave
echo "------ View simulation with GTKWave ------"

if [ -e "$SRC_FOLDER"/"$name"_tb.gtkw ]
then
  gtkwave "$SRC_FOLDER"/"$name"_tb.gtkw
else
  gtkwave "$SRC_FOLDER"/"$name"_tb.vcd
fi

# Clean
rm -rf build
rm -f  *.o
rm -f  *.vcd
rm -f  "$name"_tb

# Finish
echo "------ The design was analyzed and simulated successfully! ------"