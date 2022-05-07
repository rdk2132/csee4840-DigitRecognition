// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vconv1_mem_read__Syms.h"


//======================

void Vconv1_mem_read::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vconv1_mem_read* t=(Vconv1_mem_read*)userthis;
    Vconv1_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vconv1_mem_read::traceChgThis(Vconv1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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

void Vconv1_mem_read::traceChgThis__2(Vconv1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus  (c+1,(vlTOPp->conv1_mem_read__DOT__count),4);
    }
}

void Vconv1_mem_read::traceChgThis__3(Vconv1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit  (c+2,(vlTOPp->clk));
	vcdp->chgBit  (c+3,(vlTOPp->reset));
	vcdp->chgBit  (c+4,(vlTOPp->enable));
	vcdp->chgBus  (c+5,(vlTOPp->addr0),10);
	vcdp->chgBus  (c+6,(vlTOPp->addr1),10);
	vcdp->chgBus  (c+7,(vlTOPp->addr2),10);
	vcdp->chgBus  (c+8,(vlTOPp->addr3),10);
	vcdp->chgBit  (c+9,(vlTOPp->done));
    }
}
