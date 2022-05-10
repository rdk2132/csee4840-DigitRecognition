#include <iostream>
#include "VMAC.h"
#include <verilated.h>
#include <verilated_vcd_c.h>

int main(int argc, const char ** argv, const char ** env) {
  Verilated::commandArgs(argc, argv);

  // Treat the argument on the command-line as the place to start
  //int n;
  //if (argc > 1 && argv[1][0] != '+') n = atoi(argv[1]);
  //else n = 7; // Default

  VMAC * dut = new VMAC;  // Instantiate the collatz module

  // clken dumping a VCD file
  
  Verilated::traceEverOn(true);
  VerilatedVcdC * tfp = new VerilatedVcdC;
  dut->trace(tfp, 99);
  tfp->open("MAC.vcd");

  // Initial values
  
  dut->aclr = 0;
  dut->clken = 0;
  dut->dataa = 0;
  dut->datab = 0;
  dut->sload = 0;

  std::cout << dut->datab << '\n'; // Print the starting value of the sequence

  bool last_clk = true;
  int time;
  for (time = 0 ; time < 10000 ; time += 10) {
    dut->clk = ((time % 20) >= 10) ? 1 : 0; // Simulate a 50 MHz clock
    if (time == 20) dut->aclr = 1; // Pulse "aclr" for two cycles
    if (time == 60) dut->aclr = 0;
    if (time == 80) dut->clken = 1;
    if (time == 100) dut->dataa = dut->datab = 1;
    if (time == 120)
    {
      dut->dataa = 2;
      dut->datab = 2;
    }
    if (time == 140)
    {
      dut->dataa = 3;
      dut->datab = 3;
    }
    if (time == 160)
    {
      dut->dataa = 4;
      dut->datab = 4;
    }
    if (time == 180)
    {
      dut->dataa = 5;
      dut->datab = 5;
      std::cout << dut->datab << '\n';
    }

    dut->eval();     // Run the simulation for a cycle
    tfp->dump(time); // Write the VCD file for this cycle
  }
  
  tfp->close(); // Stop dumping the VCD file
  delete tfp;

  dut->final(); // Stop the simulation
  delete dut;

  return 0;
}

