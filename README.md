# Table of content
- Introduction
- Description
- Block Diagram
- List of files

# Introduction
The Count Up and Down Counter is a digital circuit that allows for counting in both upward and downward directions. It is a versatile component commonly used in various applications, such as timers, frequency dividers, and control systems.

# Description
- 5-bit counter
- Asynchronous negative edge reset
- Count Value loaded from "IN" port on a positive clock edge when "Load" signal is high, Load has highest priority
- Count value incremented by 1 on a positive clock edge when "Up" signal is high.
- Count value decremented by 1 on a positive clock edge when "Down" signal is high, Down has higher priority than "Up" signal
- Increment stops at 31
- Decrement stops at 0
- "High" flag active high whenever count value is 31
- "Low" flag active high whenever count value is 0

# Block Diagram
![Screenshot of up_Dn_Counter](https://github.com/FatmaAli99/UP_DOWN_COUNTER/blob/main/Block%20diagram.PNG)

# List of files
- README.md: this file
- Up_Dn_Counter.v: RTL code (verilog)   
- Up_Dn_Counter_tb.v: testbench code (verilog)
- schematic.PNG: design schematic generated on Vivado
- Block diagram.PNG: Screenshot of the block diagram
 


