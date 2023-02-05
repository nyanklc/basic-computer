# Makefile

# defaults
SIM ?= icarus
TOPLEVEL_LANG ?= verilog

VERILOG_SOURCES += $(PWD)/BC_I.v
VERILOG_SOURCES += $(PWD)/mem.v
VERILOG_SOURCES += $(PWD)/controller.v
VERILOG_SOURCES += $(PWD)/dpath.v
VERILOG_SOURCES += $(PWD)/regist.v
VERILOG_SOURCES += $(PWD)/alu.v
VERILOG_SOURCES += $(PWD)/BUS_encoder.v
VERILOG_SOURCES += $(PWD)/opcode_decoder.v
VERILOG_SOURCES += $(PWD)/multiplex.v
VERILOG_SOURCES += $(PWD)/SC.v

# TOPLEVEL is the name of the toplevel module in your Verilog or VHDL file
TOPLEVEL = BC_I

# MODULE is the basename of the Python test file
MODULE = test

# include cocotb's make rules to take care of the simulator setup
include $(shell cocotb-config --makefiles)/Makefile.sim
