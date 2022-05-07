// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vconv1_k_mem_read__Syms.h"


//======================

void Vconv1_k_mem_read::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vconv1_k_mem_read::traceInit, &Vconv1_k_mem_read::traceFull, &Vconv1_k_mem_read::traceChg, this);
}
void Vconv1_k_mem_read::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vconv1_k_mem_read* t=(Vconv1_k_mem_read*)userthis;
    Vconv1_k_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vconv1_k_mem_read::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vconv1_k_mem_read* t=(Vconv1_k_mem_read*)userthis;
    Vconv1_k_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vconv1_k_mem_read::traceInitThis(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vconv1_k_mem_read::traceFullThis(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vconv1_k_mem_read::traceInitThis__1(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+1,"clk",-1);
	vcdp->declBit  (c+2,"reset",-1);
	vcdp->declBit  (c+3,"enable",-1);
	vcdp->declBus  (c+4,"addr0",-1,5,0);
	vcdp->declBus  (c+5,"addr1",-1,5,0);
	vcdp->declBit  (c+6,"done",-1);
	vcdp->declBit  (c+1,"conv1_k_mem_read clk",-1);
	vcdp->declBit  (c+2,"conv1_k_mem_read reset",-1);
	vcdp->declBit  (c+3,"conv1_k_mem_read enable",-1);
	vcdp->declBus  (c+4,"conv1_k_mem_read addr0",-1,5,0);
	vcdp->declBus  (c+5,"conv1_k_mem_read addr1",-1,5,0);
	vcdp->declBit  (c+6,"conv1_k_mem_read done",-1);
    }
}

void Vconv1_k_mem_read::traceFullThis__1(Vconv1_k_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vconv1_k_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBit  (c+1,(vlTOPp->clk));
	vcdp->fullBit  (c+2,(vlTOPp->reset));
	vcdp->fullBit  (c+3,(vlTOPp->enable));
	vcdp->fullBus  (c+4,(vlTOPp->addr0),6);
	vcdp->fullBus  (c+5,(vlTOPp->addr1),6);
	vcdp->fullBit  (c+6,(vlTOPp->done));
    }
}
