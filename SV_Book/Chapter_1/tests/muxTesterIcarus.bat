rem recreate a temp folder for all the simulation files
rd /s /q sim
md sim
cd sim
rem compile Verilog files for simulation
iVerilog -g 2012 -s muxTester ..\muxTester.sv 
rem run the simulation
vvp -la.lst -n a.out -vcd
rem Show the simulation reults in GTKWave
rem GTKWave dump.vcd

rem return to the parent folder
cd ..