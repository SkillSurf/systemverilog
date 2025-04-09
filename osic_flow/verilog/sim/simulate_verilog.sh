#!/bin/bash

# =====================================================
# Author: Simon Dorrer
# Last Modified: 07.12.2024
# Description: This .sh file verifies and simulates a verilog testbench with Verilator, IVerilog and GTKWave.
# =====================================================

set -e -x

cd $(dirname "$0")

GREEN='\033[1;32m'
NC='\033[0m'

name=$1

RTL=${RTL:-../rtl}
SRC_FOLDER=${SRC_FOLDER:-.}

echo -e "${GREEN}Verilator:------------------------------------------ ${NC}"
verilator --lint-only "$RTL"/"$name"_board.v
  
echo -e "${GREEN}IVerilog:------------------------------------------- ${NC}"
iverilog -g2005 "$RTL"/"$name"_board.v "$SRC_FOLDER"/"$name"_tb.v

echo -e "${GREEN}a:-------------------------------------------------- ${NC}"
./a.out

echo -e "${GREEN}GTKWave:-------------------------------------------- ${NC}"
if [ -e "$SRC_FOLDER"/"$name"_tb.gtkw ]
then
  gtkwave "$SRC_FOLDER"/"$name"_tb.gtkw
else
  gtkwave "$SRC_FOLDER"/"$name"_tb.vcd
fi

# Clean
rm -f a.out
rm -f *.vcd

echo -e "${GREEN}Generated files were removed------------------------ ${NC}"