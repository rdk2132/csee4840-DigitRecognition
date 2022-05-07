// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vconv2_mem_write__Syms.h"


//======================

void Vconv2_mem_write::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vconv2_mem_write::traceInit, &Vconv2_mem_write::traceFull, &Vconv2_mem_write::traceChg, this);
}
void Vconv2_mem_write::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vconv2_mem_write* t=(Vconv2_mem_write*)userthis;
    Vconv2_mem_write__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vconv2_mem_write::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vconv2_mem_write* t=(Vconv2_mem_write*)userthis;
    Vconv2_mem_write__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vconv2_mem_write::traceInitThis(Vconv2_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vconv2_mem_write::traceFullThis(Vconv2_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vconv2_mem_write::traceInitThis__1(Vconv2_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+2,"clk",-1);
	vcdp->declBit  (c+3,"reset",-1);
	vcdp->declBit  (c+4,"enable",-1);
	vcdp->declBus  (c+5,"addr0",-1,5,0);
	vcdp->declBit  (c+6,"done",-1);
	vcdp->declBit  (c+2,"conv2_mem_write clk",-1);
	vcdp->declBit  (c+3,"conv2_mem_write reset",-1);
	vcdp->declBit  (c+4,"conv2_mem_write enable",-1);
	vcdp->declBus  (c+5,"conv2_mem_write addr0",-1,5,0);
	vcdp->declBit  (c+6,"conv2_mem_write done",-1);
	vcdp->declBus  (c+1,"conv2_mem_write count",-1,1,0);
    }
}

void Vconv2_mem_write::traceFullThis__1(Vconv2_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv2_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus  (c+1,(vlTOPp->conv2_mem_write__DOT__count),2);
	vcdp->fullBit  (c+2,(vlTOPp->clk));
	vcdp->fullBit  (c+3,(vlTOPp->reset));
	vcdp->fullBit  (c+4,(vlTOPp->enable));
	vcdp->fullBus  (c+5,(vlTOPp->addr0),6);
	vcdp->fullBit  (c+6,(vlTOPp->done));
    }
}
