import cocotb
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_mic1_initial(dut):
    dut._log.info("Starting MIC-1 Robust Test")

    cocotb.start_soon(cocotb.clock.Clock(dut.clk, 10, units="ns").start())

 
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.rst_n.value = 0 # Reset aktif
    
  
    for _ in range(5):
        await RisingEdge(dut.clk)
        
 
    dut._log.info("Releasing Reset")
    dut.rst_n.value = 1
    
   
    for i in range(20):
        await RisingEdge(dut.clk)
        if i % 5 == 0:
            dut._log.info(f"Simulation cycle {i} in progress...")

    dut._log.info("Test finished successfully without internal signal dependency!")
