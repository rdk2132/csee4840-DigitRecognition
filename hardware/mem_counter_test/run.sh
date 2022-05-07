mkdir obj_dir
verilator -trace -Wall -cc $1.sv -exe $1.cpp -top-module $1;
cd obj_dir
make -j -f V$1.mk;
cd ..;
./obj_dir/V$1;
