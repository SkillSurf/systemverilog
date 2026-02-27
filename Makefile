SHELL := /bin/bash

VERILATOR ?= verilator

# Default TB (full MVM + UART)
TB ?= mvm_uart_system_tb
TB_FILE ?= tb/$(TB).sv
BUILD_DIR ?= build/veri/$(TB)

# Always include all IPs
IPS := \
	alu.sv \
	axis_matvec_mul.v \
	counter.sv \
	divider.sv \
	example.sv \
	fir_filter.sv \
	full_adder.sv \
	function_lut.sv \
	matvec_mul.sv \
	mvm_uart_system.v \
	n_adder.sv \
	p2s.sv \
	skid_buffer.sv \
	uart_rx.sv \
	uart_tx.sv

RTL_SRCS := $(addprefix rtl/,$(IPS))

# Always include simple_axis_tb.sv
TB_SRCS := $(TB_FILE) tb/simple_axis_vip.sv

TBS := \
	alu_tb \
	axis_matvec_mul_tb \
	counter_tb \
	example_tb \
	fir_filter_tb \
	full_adder_tb \
	function_lut_tb \
	matvec_mul_tb \
	mvm_uart_system_tb \
	n_adder_tb \
	p2s_tb \
	simple_axis_tb \
	skid_buffer_tb \
	uart_rx_tb \
	uart_tx_tb


.PHONY: test all clean

# Run one TB (compile ALL IPs + this TB + simple_axis_vip)
# Example:
#   make test TB=uart_rx_tb
test:
	mkdir -p "$(BUILD_DIR)"
	$(VERILATOR) --binary --sv --timing --assert -Wall \
		-Wno-UNUSEDSIGNAL -Wno-DECLFILENAME -Wno-WIDTHEXPAND -Wno-PROCASSINIT \
		-Irtl -Itb \
		--top-module $(TB) \
		-Mdir "$(BUILD_DIR)" \
		$(RTL_SRCS) $(TB_SRCS)
	./$(BUILD_DIR)/V$(TB)

# Run all TBs in explicit list; each run gets ALL IPs
all:
	@set -e; \
	for tb in $(TBS); do \
		echo "=== $$tb ==="; \
		$(MAKE) --no-print-directory test \
			TB="$$tb" \
			TB_FILE="tb/$$tb.sv"; \
	done

clean:
	rm -rf build obj_dir
	find . -type f \( \
		-name "dump.vcd" -o \
		-name "*.vcd" -o \
		-name "*.fst" -o \
		-name "*.vpd" -o \
		-name "*.log" -o \
		-name "coverage.dat" -o \
		-name "verilator_coverage.dat" \
	\) -delete
	rm -f run a.out compiled