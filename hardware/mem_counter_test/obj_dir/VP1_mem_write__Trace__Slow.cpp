// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VP1_mem_write__Syms.h"


//======================

void VP1_mem_write::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&VP1_mem_write::traceInit, &VP1_mem_write::traceFull, &VP1_mem_write::traceChg, this);
}
void VP1_mem_write::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    VP1_mem_write* t=(VP1_mem_write*)userthis;
    VP1_mem_write__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void VP1_mem_write::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VP1_mem_write* t=(VP1_mem_write*)userthis;
    VP1_mem_write__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void VP1_mem_write::traceInitThis(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void VP1_mem_write::traceFullThis(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VP1_mem_write::traceInitThis__1(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+1,"clk",-1);
	vcdp->declBit  (c+2,"reset",-1);
	vcdp->declBit  (c+3,"enable",-1);
	vcdp->declBus  (c+4,"addr0",-1,7,0);
	vcdp->declBus  (c+5,"addr1",-1,7,0);
	vcdp->declBit  (c+6,"done",-1);
	vcdp->declBit  (c+1,"P1_mem_write clk",-1);
	vcdp->declBit  (c+2,"P1_mem_write reset",-1);
	vcdp->declBit  (c+3,"P1_mem_write enable",-1);
	vcdp->declBus  (c+4,"P1_mem_write addr0",-1,7,0);
	vcdp->declBus  (c+5,"P1_mem_write addr1",-1,7,0);
	vcdp->declBit  (c+6,"P1_mem_write done",-1);
    }
}

void VP1_mem_write::traceFullThis__1(VP1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_write* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBit  (c+1,(vlTOPp->clk));
	vcdp->fullBit  (c+2,(vlTOPp->reset));
	vcdp->fullBit  (c+3,(vlTOPp->enable));
	vcdp->fullBus  (c+4,(vlTOPp->addr0),8);
	vcdp->fullBus  (c+5,(vlTOPp->addr1),8);
	vcdp->fullBit  (c+6,(vlTOPp->done));
    }
}
