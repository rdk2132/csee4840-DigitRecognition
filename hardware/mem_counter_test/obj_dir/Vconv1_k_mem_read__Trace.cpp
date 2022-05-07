// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vconv1_k_mem_read__Syms.h"


//======================

void Vconv1_k_mem_read::traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vconv1_k_mem_read* t=(Vconv1_k_mem_read*)userthis;
    Vconv1_k_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (vlSymsp->getClearActivity()) {
	t->traceChgThis(vlSymsp, vcdp, code);
    }
}

//======================


void Vconv1_k_mem_read::traceChgThis(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceChgThis__2(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vconv1_k_mem_read::traceChgThis__2(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->chgBit  (c+1,(vlTOPp->clk));
	vcdp->chgBit  (c+2,(vlTOPp->reset));
	vcdp->chgBit  (c+3,(vlTOPp->enable));
	vcdp->chgBus  (c+4,(vlTOPp->addr0),6);
	vcdp->chgBus  (c+5,(vlTOPp->addr1),6);
	vcdp->chgBit  (c+6,(vlTOPp->done));
    }
}
