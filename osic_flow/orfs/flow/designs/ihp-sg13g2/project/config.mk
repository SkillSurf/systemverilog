export DESIGN_NAME = project
export PLATFORM    = ihp-sg13g2

export VERILOG_FILES = $(FLOW_HOME)/../../verilog/rtl/$(DESIGN_NAME).v
export SDC_FILE      = $(DESIGN_HOME)/$(PLATFORM)/$(DESIGN_NICKNAME)/constraint.sdc

export USE_FILL = 1

export PLACE_DENSITY ?= 0.8
#export CORE_UTILIZATION = 60
export TNS_END_PERCENT = 100

export DIE_AREA    = 0 0 120 120  # Increase the die area
export CORE_AREA   = 20 20 100 100  # Adjust core area accordingly
# Suppress errors due to empty cells
export GDS_ALLOW_EMPTY=$(DESIGN_NAME)_DEF_FILL