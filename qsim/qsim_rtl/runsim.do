##################################################
#  Modelsim do file to run simuilation
#  MS 7/2015
##################################################

vlib work 
vmap work work

# Include Netlist and Testbench
vlog +acc -incr ../../rtl/lfsr1/lfsr1.v 
vlog +acc -incr test_lfsr.v 

# Run Simulator 
vsim +acc -t ps -lib work testbench 
do waveformat.do   
run -all
