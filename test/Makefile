# Makefile
# Tiny Tapeout compatible cocotb Makefile

SIM ?= icarus
TOPLEVEL_LANG ?= verilog
FST ?= -fst

# Source directory
SRC_DIR := $(PWD)/../src

# Project source files (src klasörü içindekiler)
PROJECT_SOURCES := $(SRC_DIR)/project.v

# RTL simulation build directory
SIM_BUILD := sim_build/rtl

# Verilog sources
VERILOG_SOURCES := $(PROJECT_SOURCES)

# Include testbench
VERILOG_SOURCES += $(PWD)/tb.v

# Include path for design files
COMPILE_ARGS += -I$(SRC_DIR)

# Top level testbench module
TOPLEVEL := tb

# Cocotb test module (test.py dosyasının adı)
COCOTB_TEST_MODULES := test

# Include cocotb make rules
include $(shell cocotb-config --makefiles)/Makefile.sim
