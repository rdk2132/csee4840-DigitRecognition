// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vconv2_mem_read__Syms.h"


//======================

void Vconv2_mem_read::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vconv2_mem_read* t=(Vconv2_mem_read*)userthis;
    Vconv2_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vconv2_mem_read::traceChgThis(Vconv2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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

void Vconv2_mem_read::traceChgThis__2(Vconv2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBus  (c+1,(vlTOPp->conv2_mem_read__DOT__count),2);
    }
}

void Vconv2_mem_read::traceChgThis__3(Vconv2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit  (c+2,(vlTOPp->clk));
	vcdp->chgBit  (c+3,(vlTOPp->reset));
	vcdp->chgBit  (c+4,(vlTOPp->enable));
	vcdp->chgBus  (c+5,(vlTOPp->addr0),6);
	vcdp->chgBus  (c+6,(vlTOPp->addr1),6);
	vcdp->chgBus  (c+7,(vlTOPp->addr2),6);
	vcdp->chgBus  (c+8,(vlTOPp->addr3),6);
	vcdp->chgBit  (c+9,(vlTOPp->done));
    }
}
