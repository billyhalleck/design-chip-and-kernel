# Makefile
SIM ?= icarus
TOPLEVEL_LANG ?= verilog
SRC_DIR = $(PWD)/../src

 (project.v icindeki modul ismi)
DUT = tt_um_mic1_cpu

# Verilog kaynak 
VERILOG_SOURCES += $(PWD)/tb.v
VERILOG_SOURCES += $(SRC_DIR)/project.v

# En ust seviye 
TOPLEVEL = tb

# Python test dosyasi (test.py)
COCOTB_TEST_MODULES = test

include $(shell cocotb-config --makefiles)/Makefile.sim
