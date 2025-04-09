#!/bin/bash

# =====================================================
# Master's Thesis: Threshold-Based Sampling ASIC with FOSS tools.
# Author: Simon Dorrer
# Last Modified: 05.12.2024
# Description: This .sh file takes a Verilog file and runs the OpenROAD flow-scripts (ORFS) for the IHP SG13G2 PDK with it.
# In the end, the digital layout is displayed with OpenROAD.
# =====================================================

set -e -x

cd $(dirname "$0")

# Run "env.sh" to initialize the paths to OpenROAD, OpenSTA, Yosys and kLayout
source env.sh

# Go into the "flow" folder
cd flow

# Remove existing files
make nuke

# Run ORFS (set the correct design in the Makefile)
make

# Display layout
make gui_final

# Finish
echo "------ ORFS was run successfully! ------"