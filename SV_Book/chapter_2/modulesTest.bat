rem recreate a temp folder for all the simulation files
rd /s /q sim
md sim
cd sim

rem compile Verilog files for simulation
iVerilog -g 2012 ..\custom_bcdADD.sv

rem run the simulation
vvp -l a.lst -n a.out -vcd

rem show the simulation results in GTKWave
@REM GTKWave dump.vcd

rem return to the parent folder
cd ..
