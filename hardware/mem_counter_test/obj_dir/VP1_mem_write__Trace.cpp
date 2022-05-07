// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VP1_mem_write__Syms.h"


//======================

void VP1_mem_write::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VP1_mem_write* t=(VP1_mem_write*)userthis;
    VP1_mem_write__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void VP1_mem_write::traceChgThis(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VP1_mem_write::traceChgThis__2(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit  (c+1,(vlTOPp->clk));
	vcdp->chgBit  (c+2,(vlTOPp->reset));
	vcdp->chgBit  (c+3,(vlTOPp->enable));
	vcdp->chgBus  (c+4,(vlTOPp->addr0),8);
	vcdp->chgBus  (c+5,(vlTOPp->addr1),8);
	vcdp->chgBit  (c+6,(vlTOPp->done));
    }
}
