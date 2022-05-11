mkdir obj_dir
verilator -trace -Wall -Wno-DEFPARAM -Wno-PINCONNECTEMPTY -Wno-UNOPTFLAT -Wno-ASSIGNDLY -Wno-LATCH --top-module CNN -cc ./*.sv math/*.sv routing/*.sv mem_counters/*.sv ROMs/*mem.v RAMs/*mem.v altera_mf.v -exe CNN.cpp --build -Wno-fatal;
./obj_dir/VCNN;
