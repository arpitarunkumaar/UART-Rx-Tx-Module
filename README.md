# UART Communication System in Verilog

This project provides a Verilog-based UART (Universal Asynchronous Receiver Transmitter) communication system, capable of serial data transmission and reception. It includes transmitter (`uart_tx`) and receiver (`uart_rx`) modules, integrated into a top-level module (`uart_cm_top`) for bidirectional communication. This implementation is designed for the Terasic P0150 FPGA board, based on an Intel Cyclone V GX FPGA.

## Features
- **UART Transmitter (`uart_tx`)**: Transmits 8-bit data, handling idle, start, data, and stop states.
- **UART Receiver (`uart_rx`)**: Receives 8-bit data, detecting start, data, and stop bits.
- **Configurable Baud Rate**: Adjust the `CLKS_PER_BIT` parameter to set the desired baud rate.
- **Loopback Example**: Demonstrates basic functionality by receiving data, incrementing it, and sending it back out via UART.
