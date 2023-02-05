# test_my_design.py (extended)

import cocotb
from cocotb.triggers import FallingEdge, Timer
import time

async def generate_clock(dut):
    """Generate clock pulses."""

    for cycle in range(10):
        dut.clk.value = 0
        time.sleep(0.001)
        dut.clk.value = 1
        time.sleep(0.001)


@cocotb.test()
async def my_second_test(dut):
    """Try accessing the design."""

    await cocotb.start(generate_clock(dut))  # run the clock "in the background"
    print("here")

    await Timer(5, units="ns")  # wait a bit
    print("here2")

    await FallingEdge(dut.clk)  # wait for falling edge/"negedge"

    dut._log.info("my_signal_1 is %s", dut.PC.value)
    assert dut.AR.value[0] == 0, "my_signal_2[0] is not 0!"
