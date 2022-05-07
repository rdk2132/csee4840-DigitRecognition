// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VP1_mem_read__Syms.h"


//======================

void VP1_mem_read::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VP1_mem_read* t=(VP1_mem_read*)userthis;
    VP1_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void VP1_mem_read::traceChgThis(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	if (VL_UNLIKELY((2U & vlTOPp->__Vm_traceActivity))) {
	    vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
	}
	vlTOPp->traceChgThis__3(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VP1_mem_read::traceChgThis__2(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus  (c+1,(vlTOPp->P1_mem_read__DOT__rowcount),3);
	vcdp->chgBus  (c+2,(vlTOPp->P1_mem_read__DOT__columncount),3);
	vcdp->chgBus  (c+3,(vlTOPp->P1_mem_read__DOT__i_count),3);
    }
}

void VP1_mem_read::traceChgThis__3(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit  (c+4,(vlTOPp->clk));
	vcdp->chgBit  (c+5,(vlTOPp->reset));
	vcdp->chgBit  (c+6,(vlTOPp->enable));
	vcdp->chgBus  (c+7,(vlTOPp->addr0),8);
	vcdp->chgBus  (c+8,(vlTOPp->addr1),8);
	vcdp->chgBit  (c+9,(vlTOPp->done));
    }
}
