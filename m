verilator --cc --exe  --trace-fst --trace-params --trace-structs --trace-underscore \
    clog2.v -exe test_clog2.cpp
make -C obj_dir -f Vclog2.mk

