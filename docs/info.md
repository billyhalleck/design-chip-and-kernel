## How it works
This is a MIC-1 microprocessor implementation. It uses a 32-bit datapath with an 8-bit external interface to fit TinyTapeout constraints.

## How to test
After reset, the PC starts at 0. You can provide instructions via the ui_in pins.

## External hardware

* **RAM/ROM Emulator:** A microcontroller (like an Arduino or ESP32) or an FPGA to act as the external memory, providing instructions to the `ui_in` bus.
* **Logic Analyzer:** To monitor the 8-bit output bus (`uo_out`) for memory addresses and data.
* **Clock Source:** Although provided by the Tiny Tapeout board, an external function generator can be used for manual stepping.
