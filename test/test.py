import cocotb
from cocotb.triggers import Timer, RisingEdge

@cocotb.test()
async def test_mic1_initial(dut):
    dut._log.info("Starting MIC-1 Basic Test")

    # Saati baslat
    dut.clk.value = 0
    
    # Reset islemi
    dut.rst_n.value = 0
    dut.ena.value = 1
    dut.ui_in.value = 0
    
    # 20ns bekle (unit="ns" olarak guncellendi)
    await Timer(20, unit="ns")
    dut.rst_n.value = 1
    
    # Birkac cevrim bekle ve PC'nin arttigini gozlemle
    for i in range(10):
        await RisingEdge(dut.clk)
        # Sinyal yolunu kontrol ederek yazdir
        try:
            pc_val = dut.user_project.PC.value
            dut._log.info(f"Cycle {i}: PC is {pc_val}")
        except AttributeError:
            dut._log.info(f"Cycle {i}: PC signal not found directly, checking uo_out")

    dut._log.info("Basic test finished!")
