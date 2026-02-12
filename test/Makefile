# Makefile
# Tiny Tapeout MIC-1 CPU Test Configuration

SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src

# Test edilecek ana modül
DUT = tt_um_mic1_cpu

# Kaynak dosyaları
VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(SRC_DIR)/project.v

# Testbench üst modül adı
TOPLEVEL = tb

# Python test dosyasının adı
COCOTB_TEST_MODULES = test

# Cocotb kütüphanelerini dahil et
include $(shell cocotb-config --makefiles)/Makefile.sim
