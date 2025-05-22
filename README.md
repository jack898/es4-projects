## ES4 Projects
Some of my projects from [ES4 - Introduction to Digital Logic](https://www.ece.tufts.edu/es/4/) in Fall 2024 at Tufts University. Each Lab folder contains the official project specification (spec.pdf), my lab report (labXreport.pdf), and the Lattice Radiant project files. (LabX)


### Technical Details
* Each project is written in VHDL-2008 using the Lattice Radiant tool suite, and flashed onto a Lattice iCE40 UP5K UG48 FPGA, specifically the [UPduino 3.0](https://upduino.readthedocs.io/en/latest/introduction/introduction.html)
* For each Lattice Radiant project directory, source/impl_1 contains the VHDL source code
* Each project is organized hierarchically with a top module in top.vhd which contains various submodules

### Summaries
#### Lab 5 ALU and seven-segment Display
Contains a basic 4-bit ALU with bitwise AND, OR, addition, and subtraction which displays its output as 1 hex digit, 0-F, on a LTD-4608JR dual seven-segment display.
#### Lab 6 Double-digit seven-segment Display
Takes a 6-bit base 2 number and displays it as a 2-digit base 10 number on the LTD-4608JR dual seven-segment display by flashing at high frequency between digits. 
#### Lab 7 Visual Looper with RAM
Uses iCE40's built-in RAM to record and playback a button sequence on a set of LEDs.
