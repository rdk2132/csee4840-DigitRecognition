// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VP2_mem_read__Syms.h"


//======================

void VP2_mem_read::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&VP2_mem_read::traceInit, &VP2_mem_read::traceFull, &VP2_mem_read::traceChg, this);
}
void VP2_mem_read::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    VP2_mem_read* t=(VP2_mem_read*)userthis;
    VP2_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void VP2_mem_read::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VP2_mem_read* t=(VP2_mem_read*)userthis;
    VP2_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void VP2_mem_read::traceInitThis(VP2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void VP2_mem_read::traceFullThis(VP2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VP2_mem_read::traceInitThis__1(VP2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+2,"clk",-1);
	vcdp->declBit  (c+3,"reset",-1);
	vcdp->declBit  (c+4,"enable",-1);
	vcdp->declBus  (c+5,"addr0",-1,3,0);
	vcdp->declBit  (c+6,"done",-1);
	vcdp->declBit  (c+2,"P2_mem_read clk",-1);
	vcdp->declBit  (c+3,"P2_mem_read reset",-1);
	vcdp->declBit  (c+4,"P2_mem_read enable",-1);
	vcdp->declBus  (c+5,"P2_mem_read addr0",-1,3,0);
	vcdp->declBit  (c+6,"P2_mem_read done",-1);
	vcdp->declBus  (c+1,"P2_mem_read count",-1,3,0);
    }
}

void VP2_mem_read::traceFullThis__1(VP2_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP2_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus  (c+1,(vlTOPp->P2_mem_read__DOT__count),4);
	vcdp->fullBit  (c+2,(vlTOPp->clk));
	vcdp->fullBit  (c+3,(vlTOPp->reset));
	vcdp->fullBit  (c+4,(vlTOPp->enable));
	vcdp->fullBus  (c+5,(vlTOPp->addr0),4);
	vcdp->fullBit  (c+6,(vlTOPp->done));
    }
}
