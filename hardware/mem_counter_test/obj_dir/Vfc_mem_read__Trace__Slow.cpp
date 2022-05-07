// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vfc_mem_read__Syms.h"


//======================

void Vfc_mem_read::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vfc_mem_read::traceInit, &Vfc_mem_read::traceFull, &Vfc_mem_read::traceChg, this);
}
void Vfc_mem_read::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vfc_mem_read* t=(Vfc_mem_read*)userthis;
    Vfc_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vfc_mem_read::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vfc_mem_read* t=(Vfc_mem_read*)userthis;
    Vfc_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vfc_mem_read::traceInitThis(Vfc_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vfc_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vfc_mem_read::traceFullThis(Vfc_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vfc_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vfc_mem_read::traceInitThis__1(Vfc_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vfc_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+1,"clk",-1);
	vcdp->declBit  (c+2,"reset",-1);
	vcdp->declBit  (c+3,"enable",-1);
	vcdp->declBus  (c+4,"addr0",-1,8,0);
	vcdp->declBus  (c+5,"addr1",-1,8,0);
	vcdp->declBit  (c+6,"done",-1);
	vcdp->declBit  (c+1,"fc_mem_read clk",-1);
	vcdp->declBit  (c+2,"fc_mem_read reset",-1);
	vcdp->declBit  (c+3,"fc_mem_read enable",-1);
	vcdp->declBus  (c+4,"fc_mem_read addr0",-1,8,0);
	vcdp->declBus  (c+5,"fc_mem_read addr1",-1,8,0);
	vcdp->declBit  (c+6,"fc_mem_read done",-1);
    }
}

void Vfc_mem_read::traceFullThis__1(Vfc_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vfc_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBit  (c+1,(vlTOPp->clk));
	vcdp->fullBit  (c+2,(vlTOPp->reset));
	vcdp->fullBit  (c+3,(vlTOPp->enable));
	vcdp->fullBus  (c+4,(vlTOPp->addr0),9);
	vcdp->fullBus  (c+5,(vlTOPp->addr1),9);
	vcdp->fullBit  (c+6,(vlTOPp->done));
    }
}
