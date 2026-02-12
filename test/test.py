# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_mic1_initial(dut):
    dut._log.info("Starting MIC-1 Basic Test")

    # Saati başlat
    dut.clk.value = 0
    await Timer(10, units="ns")
    
    # Reset işlemi
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    await Timer(20, units="ns")
    dut.rst_n.value = 1
    
    # Birkaç çevrim bekle ve PC'nin arttığını gözlemle
    for i in range(10):
        await RisingEdge(dut.clk)
        dut._log.info(f"Cycle {i}: PC is {dut.user_project.PC.value}")

    dut._log.info("Basic test finished!")
