// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Tracing implementation internals
#include "verilated_vcd_c.h"
#include "Vimg_mem_read__Syms.h"


//======================

void Vimg_mem_read::trace(VerilatedVcdC* tfp, int, int) {
    tfp->spTrace()->addCallback(&Vimg_mem_read::traceInit, &Vimg_mem_read::traceFull, &Vimg_mem_read::traceChg, this);
}
void Vimg_mem_read::traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->open()
    Vimg_mem_read* t=(Vimg_mem_read*)userthis;
    Vimg_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    if (!Verilated::calcUnusedSigs()) {
	VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Turning on wave traces requires Verilated::traceEverOn(true) call before time 0.");
    }
    vcdp->scopeEscape(' ');
    t->traceInitThis(vlSymsp, vcdp, code);
    vcdp->scopeEscape('.');
}
void Vimg_mem_read::traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code) {
    // Callback from vcd->dump()
    Vimg_mem_read* t=(Vimg_mem_read*)userthis;
    Vimg_mem_read__Syms* __restrict vlSymsp = t->__VlSymsp;  // Setup global symbol table
    t->traceFullThis(vlSymsp, vcdp, code);
}

//======================


void Vimg_mem_read::traceInitThis(Vimg_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    vcdp->module(vlSymsp->name());  // Setup signal names
    // Body
    {
	vlTOPp->traceInitThis__1(vlSymsp, vcdp, code);
    }
}

void Vimg_mem_read::traceFullThis(Vimg_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vlTOPp->traceFullThis__1(vlSymsp, vcdp, code);
    }
    // Final
    vlTOPp->__Vm_traceActivity = 0U;
}

void Vimg_mem_read::traceInitThis__1(Vimg_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->declBit  (c+4,"clk",-1);
	vcdp->declBit  (c+5,"reset",-1);
	vcdp->declBit  (c+6,"enable",-1);
	vcdp->declBus  (c+7,"addr0",-1,9,0);
	vcdp->declBus  (c+8,"addr1",-1,9,0);
	vcdp->declBus  (c+9,"addr2",-1,9,0);
	vcdp->declBus  (c+10,"addr3",-1,9,0);
	vcdp->declBit  (c+11,"done",-1);
	vcdp->declBit  (c+4,"img_mem_read clk",-1);
	vcdp->declBit  (c+5,"img_mem_read reset",-1);
	vcdp->declBit  (c+6,"img_mem_read enable",-1);
	vcdp->declBus  (c+7,"img_mem_read addr0",-1,9,0);
	vcdp->declBus  (c+8,"img_mem_read addr1",-1,9,0);
	vcdp->declBus  (c+9,"img_mem_read addr2",-1,9,0);
	vcdp->declBus  (c+10,"img_mem_read addr3",-1,9,0);
	vcdp->declBit  (c+11,"img_mem_read done",-1);
	vcdp->declBus  (c+1,"img_mem_read rowcount",-1,2,0);
	vcdp->declBus  (c+2,"img_mem_read columncount",-1,2,0);
	vcdp->declBus  (c+3,"img_mem_read i_count",-1,4,0);
    }
}

void Vimg_mem_read::traceFullThis__1(Vimg_mem_read__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code) {
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    int c=code;
    if (0 && vcdp && c) {}  // Prevent unused
    // Body
    {
	vcdp->fullBus  (c+1,(vlTOPp->img_mem_read__DOT__rowcount),3);
	vcdp->fullBus  (c+2,(vlTOPp->img_mem_read__DOT__columncount),3);
	vcdp->fullBus  (c+3,(vlTOPp->img_mem_read__DOT__i_count),5);
	vcdp->fullBit  (c+4,(vlTOPp->clk));
	vcdp->fullBit  (c+5,(vlTOPp->reset));
	vcdp->fullBit  (c+6,(vlTOPp->enable));
	vcdp->fullBus  (c+7,(vlTOPp->addr0),10);
	vcdp->fullBus  (c+8,(vlTOPp->addr1),10);
	vcdp->fullBus  (c+9,(vlTOPp->addr2),10);
	vcdp->fullBus  (c+10,(vlTOPp->addr3),10);
	vcdp->fullBit  (c+11,(vlTOPp->done));
    }
}
