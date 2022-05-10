#include <iostream>
#include "VCNN.h"
#include <verilated.h>
#include <verilated_vcd_c.h>

int gtime;
double sc_time_stamp () {       // Called by $time in Verilog
        return gtime;
}

int main(int argc, const char ** argv, const char ** env) {
  Verilated::commandArgs(argc, argv);
  //Verilated::debug(1);
  gtime = 0;
  // Treat the argument on the command-line as the place to start
  //int n;
  //if (argc > 1 && argv[1][0] != '+') n = atoi(argv[1]);
  //else n = 7; // Default

  VCNN * dut = new VCNN;  // Instantiate the collatz module

  // Enable dumping a VCD file
  
  Verilated::traceEverOn(true);
  VerilatedVcdC * tfp = new VerilatedVcdC;
  dut->trace(tfp, 99);
  tfp->open("CNN.vcd");

  // Initial values
  
  dut->clk = 0;
  dut->reset = 1;
  dut->write = 0;
  dut->read = 0;
  dut->chipselect = 1;
  dut->writedata = 0;
  dut->address = 0;

  //std::cout << dut->n; // Print the starting value of the sequence

  bool last_clk = true;
  for (gtime = 0 ; gtime < 10000 ; gtime += 10) {
    dut->clk = ((gtime % 20) >= 10) ? 1 : 0; // Simulate a 50 MHz clock
    if (gtime == 20) dut->reset = 1; // Pulse "reset" for two cycles
    if (gtime == 60) dut->reset = 0;
    if (gtime == 80) dut->write = 1;

    dut->eval();     // Run the simulation for a cycle
    tfp->dump(gtime); // Write the VCD file for this cycle

    last_clk = dut->clk;
    std::cout << gtime << "\n";
  }

  //std::cout << std::endl;

  // Once "done" is received, run a few more clock cycles
  
  /*for (int k = 0 ; k < 1000 ; k++, time += 10) {
    dut->clk = ((time % 20) >= 10) ? 1 : 0;
      dut->eval();
      tfp->dump(time);
  }*/
  
  tfp->close(); // Stop dumping the VCD file
  delete tfp;

  dut->final(); // Stop the simulation
  delete dut;

  return 0;
}

