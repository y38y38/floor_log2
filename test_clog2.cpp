#include <iostream>
#include <verilated.h>
#include "Vclog2.h"
#include <verilated_fst_c.h> 
#include <math.h>

int time_counter = 0;
int main(int argc, char** argv) {
	Verilated::commandArgs(argc, argv);

	// Instantiate DUT
	Vclog2 *dut = new Vclog2();
	// Trace DUMP ON
	Verilated::traceEverOn(true);
	VerilatedFstC* tfp = new VerilatedFstC;

	dut->trace(tfp, 100);  // Trace 100 levels of hierarchy
	tfp->open("simx.fst");

	// Format
	dut->reset_n = 0;
	dut->clk = 0;

	// Reset Time
	while (time_counter < 10) {
		dut->eval();
		tfp->dump(time_counter);  // 波形ダンプ用の記述を追加
		time_counter++;
	}
	// Release reset
	dut->reset_n = 1;
	dut->val=0;
	while (time_counter < 4000 && !Verilated::gotFinish()) {
		dut->clk = !dut->clk; // Toggle clock
		if (dut->clk)
			dut->val++;
		// Evaluate DUT
		dut->eval();
		if (dut->clk) {
			int c_lang_result = (int)floor(log2(dut->val));
			if (c_lang_result != dut->out_val) {
				printf("%d %d %f %f\n", dut->val, dut->out_val, floor(log2(dut->val)), log2(dut->val));
			}
		}
		tfp->dump(time_counter);  // 波形ダンプ用の記述を追加
		time_counter++;

	}

	dut->final();
	tfp->close(); 
}