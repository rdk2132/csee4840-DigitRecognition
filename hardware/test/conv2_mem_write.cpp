#include <iostream>
#include "Vconv2_mem_write.h"
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, const char ** argv, const char ** env) {
  Verilated::commandArgs(argc, argv);

  // Treat the argument on the command-line as the place to start
  //int n;
  //if (argc > 1 && argv[1][0] != '+') n = atoi(argv[1]);
  //else n = 7; // Default

  Vconv2_mem_write * dut = new Vconv2_mem_write;  // Instantiate the collatz module

  // Enable dumping a VCD file
  
  Verilated::traceEverOn(true);
  VerilatedVcdC * tfp = new VerilatedVcdC;
  dut->trace(tfp, 99);
  tfp->open("conv2_mem_write.vcd");

  // Initial values
  
  dut->reset = 0;
  dut->enable = 0;

  //std::cout << dut->n; // Print the starting value of the sequence

  bool last_clk = true;
  int time;
  for (time = 0 ; time < 10000 ; time += 10) {
    dut->clk = ((time % 20) >= 10) ? 1 : 0; // Simulate a 50 MHz clock
    if (time == 20) dut->reset = 1; // Pulse "reset" for two cycles
    if (time == 60) dut->reset = 0;
    if (time == 80) dut->enable = 1;

    dut->eval();     // Run the simulation for a cycle
    tfp->dump(time); // Write the VCD file for this cycle

    if (dut->clk && !last_clk && dut->enable) {
      //if (time >= 60) std::cout << ' ' << dut->addr0; // Print the next value
      if (dut->done) break; // Stop once "done" appears
    }
    last_clk = dut->clk;
  }

  //std::cout << std::endl;

  // Once "done" is received, run a few more clock cycles
  
  for (int k = 0 ; k < 1000 ; k++, time += 10) {
    dut->clk = ((time % 20) >= 10) ? 1 : 0;
      dut->eval();
      tfp->dump(time);
  }
  
  tfp->close(); // Stop dumping the VCD file
  delete tfp;

  dut->final(); // Stop the simulation
  delete dut;

  return 0;
}

