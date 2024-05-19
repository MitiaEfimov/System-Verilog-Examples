rem recreate a temp folder for all the simulation files
rd /s /q sim
md sim
cd sim
rem compile Verilog files for simulation
@REM iVerilog ..\Chapter_2\combTestWithEnums.sv
iVerilog -g 2012 -g assertions -s regWithBenefits_test ..\Chapter_3\tests\regWithBenefits_test.sv ..\Chapter_3\regWithBenefits.sv 
rem run the simulation
vvp -l a.lst -n a.out -vcd
rem Show the simulation reults in GTKWave
GTKWave dump.vcd

rem return to the parent folder
cd ..