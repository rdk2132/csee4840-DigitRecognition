// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "VP1_mem_read__Syms.h"


//======================

void VP1_mem_read::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&VP1_mem_read::traceInit, &VP1_mem_read::traceFull, &VP1_mem_read::traceChg, this);
}
void VP1_mem_read::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    VP1_mem_read* t=(VP1_mem_read*)userthis;
    VP1_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void VP1_mem_read::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    VP1_mem_read* t=(VP1_mem_read*)userthis;
    VP1_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void VP1_mem_read::traceInitThis(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void VP1_mem_read::traceFullThis(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void VP1_mem_read::traceInitThis__1(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+4,"clk",-1);
	vcdp->declBit  (c+5,"reset",-1);
	vcdp->declBit  (c+6,"enable",-1);
	vcdp->declBus  (c+7,"addr0",-1,7,0);
	vcdp->declBus  (c+8,"addr1",-1,7,0);
	vcdp->declBit  (c+9,"done",-1);
	vcdp->declBit  (c+4,"P1_mem_read clk",-1);
	vcdp->declBit  (c+5,"P1_mem_read reset",-1);
	vcdp->declBit  (c+6,"P1_mem_read enable",-1);
	vcdp->declBus  (c+7,"P1_mem_read addr0",-1,7,0);
	vcdp->declBus  (c+8,"P1_mem_read addr1",-1,7,0);
	vcdp->declBit  (c+9,"P1_mem_read done",-1);
	vcdp->declBus  (c+1,"P1_mem_read rowcount",-1,2,0);
	vcdp->declBus  (c+2,"P1_mem_read columncount",-1,2,0);
	vcdp->declBus  (c+3,"P1_mem_read i_count",-1,2,0);
    }
}

void VP1_mem_read::traceFullThis__1(VP1_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    VP1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus  (c+1,(vlTOPp->P1_mem_read__DOT__rowcount),3);
	vcdp->fullBus  (c+2,(vlTOPp->P1_mem_read__DOT__columncount),3);
	vcdp->fullBus  (c+3,(vlTOPp->P1_mem_read__DOT__i_count),3);
	vcdp->fullBit  (c+4,(vlTOPp->clk));
	vcdp->fullBit  (c+5,(vlTOPp->reset));
	vcdp->fullBit  (c+6,(vlTOPp->enable));
	vcdp->fullBus  (c+7,(vlTOPp->addr0),8);
	vcdp->fullBus  (c+8,(vlTOPp->addr1),8);
	vcdp->fullBit  (c+9,(vlTOPp->done));
    }
}
