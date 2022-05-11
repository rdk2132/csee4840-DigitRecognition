#include <iostream>
#include "VCNN.h"
#include <verilated.h>
#include <verilated_vcd_c.h>
#define IMAGE_METADATA_OFFSET 16

int gtime;
double sc_time_stamp () {       // Called by $time in Verilog
        return gtime;
}

int ctrl = 0;
void increment_control(VCNN* dut) {
  dut->address = 0;
  dut->write = 1;
  dut->read = 0;
  dut->writedata = ctrl + 1;
  ctrl++;
}

void write_img_address(VCNN* dut, int addr) {
  dut->address = 2;
  dut->write = 1;
  dut->read = 0;
  dut->writedata = addr;
}

void write_img_data(VCNN* dut, signed short data) {
  dut->address = 3;
  dut->write = 1;
  dut->read = 0;
  memcpy(&dut->writedata, &data, sizeof(signed short));
}

void get_return_ctrl(VCNN* dut) {
  dut->address = 1;
  dut->write = 0;
  dut->read = 1;
  dut->writedata = 0;
}

void dummy_op(VCNN* dut) {
  dut->address = 0;
  dut->write = 0;
  dut->read = 0;
  dut->writedata = 0;
}

int main(int argc, const char ** argv, const char ** env) {
  Verilated::commandArgs(argc, argv);
  //Verilated::debug(1);
  gtime = 0;

  unsigned char raw_image[28 * 28];
  signed short image_data[28 * 28];
  FILE* fp = fopen("../mnist/t10k-images-idx3-ubyte", "rb");
  if (!fp) {
    fprintf(stderr, "Could not read file\n");
    exit(1);
  }

  //dummy read, needed because of file format
  fread(raw_image, 1, IMAGE_METADATA_OFFSET, fp);
  fread(raw_image, 1, 28 * 28, fp);
  fclose(fp);


  for (int i = 0; i < 784; i++) {
    image_data[i] = raw_image[i] * 16;
    if (image_data[i] > 0) {
      fprintf(stderr, "image_data[%d] = %d\n", i, image_data[i]);
    }
  }
  /*for (int i = 0; i < 784; i++) {
    image_data[i] = i;
  }*/
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

  unsigned image_pos = 0;
  unsigned set_addr = 0;
  bool last_clk = true;
  for (gtime = 0 ; gtime < 200000 ; gtime += 10) {
    dut->clk = ((gtime % 20) >= 10) ? 1 : 0; // Simulate a 50 MHz clock
    if (gtime == 20) dut->reset = 1; // Pulse "reset" for two cycles
    if (gtime == 60) dut->reset = 0;
    if (gtime == 80) {
        increment_control(dut);
    }
    else if (gtime > 80 && image_pos < 28 * 28) {
        if (set_addr == 0 && gtime % 20 == 0) {
            write_img_address(dut, image_pos);
            set_addr = 1;
        }
        else if (gtime % 20 == 0) {
            write_img_data(dut, image_data[image_pos]);
            image_pos++;
            set_addr = 0;
        }
    }
    else if (image_pos == 28 * 28 && ctrl == 1) {
      increment_control(dut);
    }
    else if (image_pos >= 28 * 28 && gtime % 20 == 0) {
      if (dut->readdata == ctrl && ctrl < 6) {
        increment_control(dut);
      }
      else if (dut->readdata == ctrl && ctrl == 6) {
        //TODO: we are done, read output
        dummy_op(dut);
      }
      else {
        get_return_ctrl(dut);
      }
    }

    dut->eval();     // Run the simulation for a cycle
    tfp->dump(gtime); // Write the VCD file for this cycle

    last_clk = dut->clk;
  }

  tfp->close(); // Stop dumping the VCD file
  delete tfp;

  dut->final(); // Stop the simulation
  delete dut;

  return 0;
}

