mkdir obj_dir
verilator -trace -Wall -cc ../mem_counters/$1.sv -exe $1.cpp -top-module $1;
make -j -C obj_dir -f V$1.mk;
./obj_dir/V$1;
