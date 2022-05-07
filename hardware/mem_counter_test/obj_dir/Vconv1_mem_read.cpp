// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vconv1_mem_read.h for the primary calling header

#include "Vconv1_mem_read.h"   // For This
#include "Vconv1_mem_read__Syms.h"


//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vconv1_mem_read) {
    Vconv1_mem_read__Syms* __restrict vlSymsp = __VlSymsp = new Vconv1_mem_read__Syms(this, name());
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vconv1_mem_read::__Vconfigure(Vconv1_mem_read__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vconv1_mem_read::~Vconv1_mem_read() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vconv1_mem_read::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vconv1_mem_read::eval\n"); );
    Vconv1_mem_read__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
#ifdef VL_DEBUG
    // Debug assertions
    _eval_debug_assertions();
#endif // VL_DEBUG
    // Initialize
    if (VL_UNLIKELY(!vlSymsp->__Vm_didInit)) _eval_initial_loop(vlSymsp);
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
	VL_DEBUG_IF(VL_DBG_MSGF("+ Clock loop\n"););
	vlSymsp->__Vm_activity = true;
	_eval(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) {
	    // About to fail, so enable debug to see what's not settling.
	    // Note you must run make with OPT=-DVL_DEBUG for debug prints.
	    int __Vsaved_debug = Verilated::debug();
	    Verilated::debug(1);
	    __Vchange = _change_request(vlSymsp);
	    Verilated::debug(__Vsaved_debug);
	    VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't converge");
	} else {
	    __Vchange = _change_request(vlSymsp);
	}
    } while (VL_UNLIKELY(__Vchange));
}

void Vconv1_mem_read::_eval_initial_loop(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    vlSymsp->__Vm_didInit = true;
    _eval_initial(vlSymsp);
    vlSymsp->__Vm_activity = true;
    // Evaluate till stable
    int __VclockLoop = 0;
    QData __Vchange = 1;
    do {
	_eval_settle(vlSymsp);
	_eval(vlSymsp);
	if (VL_UNLIKELY(++__VclockLoop > 100)) {
	    // About to fail, so enable debug to see what's not settling.
	    // Note you must run make with OPT=-DVL_DEBUG for debug prints.
	    int __Vsaved_debug = Verilated::debug();
	    Verilated::debug(1);
	    __Vchange = _change_request(vlSymsp);
	    Verilated::debug(__Vsaved_debug);
	    VL_FATAL_MT(__FILE__,__LINE__,__FILE__,"Verilated model didn't DC converge");
	} else {
	    __Vchange = _change_request(vlSymsp);
	}
    } while (VL_UNLIKELY(__Vchange));
}

//--------------------
// Internal Methods

VL_INLINE_OPT void Vconv1_mem_read::_sequent__TOP__1(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_sequent__TOP__1\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    VL_SIG8(__Vdly__conv1_mem_read__DOT__count,3,0);
    VL_SIG16(__Vdly__addr0,9,0);
    VL_SIG16(__Vdly__addr1,9,0);
    VL_SIG16(__Vdly__addr2,9,0);
    VL_SIG16(__Vdly__addr3,9,0);
    // Body
    __Vdly__addr0 = vlTOPp->addr0;
    __Vdly__conv1_mem_read__DOT__count = vlTOPp->conv1_mem_read__DOT__count;
    __Vdly__addr1 = vlTOPp->addr1;
    __Vdly__addr2 = vlTOPp->addr2;
    __Vdly__addr3 = vlTOPp->addr3;
    // ALWAYS at conv1_mem_read.sv:7
    if (vlTOPp->reset) {
	__Vdly__addr0 = 0U;
	__Vdly__conv1_mem_read__DOT__count = 0U;
	__Vdly__addr1 = 1U;
	__Vdly__addr2 = 0x18U;
	__Vdly__addr3 = 0x19U;
    } else {
	if (((IData)(vlTOPp->enable) & (~ (IData)(vlTOPp->done)))) {
	    if ((0xbU == (IData)(vlTOPp->conv1_mem_read__DOT__count))) {
		__Vdly__addr0 = (0x3ffU & ((IData)(0x1aU) 
					   + (IData)(vlTOPp->addr0)));
		__Vdly__conv1_mem_read__DOT__count = 0U;
		__Vdly__addr1 = (0x3ffU & ((IData)(0x1aU) 
					   + (IData)(vlTOPp->addr1)));
		__Vdly__addr2 = (0x3ffU & ((IData)(0x1aU) 
					   + (IData)(vlTOPp->addr2)));
		__Vdly__addr3 = (0x3ffU & ((IData)(0x1aU) 
					   + (IData)(vlTOPp->addr3)));
	    } else {
		__Vdly__conv1_mem_read__DOT__count 
		    = (0xfU & ((IData)(1U) + (IData)(vlTOPp->conv1_mem_read__DOT__count)));
		__Vdly__addr0 = (0x3ffU & ((IData)(2U) 
					   + (IData)(vlTOPp->addr0)));
		__Vdly__addr1 = (0x3ffU & ((IData)(2U) 
					   + (IData)(vlTOPp->addr1)));
		__Vdly__addr2 = (0x3ffU & ((IData)(2U) 
					   + (IData)(vlTOPp->addr2)));
		__Vdly__addr3 = (0x3ffU & ((IData)(2U) 
					   + (IData)(vlTOPp->addr3)));
	    }
	}
    }
    vlTOPp->conv1_mem_read__DOT__count = __Vdly__conv1_mem_read__DOT__count;
    vlTOPp->addr0 = __Vdly__addr0;
    vlTOPp->addr1 = __Vdly__addr1;
    vlTOPp->addr2 = __Vdly__addr2;
    vlTOPp->addr3 = __Vdly__addr3;
    // ALWAYS at conv1_mem_read.sv:34
    if ((0x23fU == (IData)(vlTOPp->addr3))) {
	vlTOPp->done = 1U;
    }
}

void Vconv1_mem_read::_settle__TOP__2(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_settle__TOP__2\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // ALWAYS at conv1_mem_read.sv:34
    if ((0x23fU == (IData)(vlTOPp->addr3))) {
	vlTOPp->done = 1U;
    }
}

void Vconv1_mem_read::_eval(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_eval\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    if ((((IData)(vlTOPp->clk) & (~ (IData)(vlTOPp->__Vclklast__TOP__clk))) 
	 | ((IData)(vlTOPp->reset) & (~ (IData)(vlTOPp->__Vclklast__TOP__reset))))) {
	vlTOPp->_sequent__TOP__1(vlSymsp);
	vlTOPp->__Vm_traceActivity = (2U | vlTOPp->__Vm_traceActivity);
    }
    // Final
    vlTOPp->__Vclklast__TOP__clk = vlTOPp->clk;
    vlTOPp->__Vclklast__TOP__reset = vlTOPp->reset;
}

void Vconv1_mem_read::_eval_initial(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_eval_initial\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vconv1_mem_read::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::final\n"); );
    // Variables
    Vconv1_mem_read__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vconv1_mem_read::_eval_settle(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_eval_settle\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__2(vlSymsp);
}

VL_INLINE_OPT QData Vconv1_mem_read::_change_request(Vconv1_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_change_request\n"); );
    Vconv1_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vconv1_mem_read::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clk & 0xfeU))) {
	Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
	Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((enable & 0xfeU))) {
	Verilated::overWidthError("enable");}
}
#endif // VL_DEBUG

void Vconv1_mem_read::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vconv1_mem_read::_ctor_var_reset\n"); );
    // Body
    clk = VL_RAND_RESET_I(1);
    reset = VL_RAND_RESET_I(1);
    enable = VL_RAND_RESET_I(1);
    addr0 = VL_RAND_RESET_I(10);
    addr1 = VL_RAND_RESET_I(10);
    addr2 = VL_RAND_RESET_I(10);
    addr3 = VL_RAND_RESET_I(10);
    done = VL_RAND_RESET_I(1);
    conv1_mem_read__DOT__count = VL_RAND_RESET_I(4);
    __Vclklast__TOP__clk = VL_RAND_RESET_I(1);
    __Vclklast__TOP__reset = VL_RAND_RESET_I(1);
    __Vm_traceActivity = VL_RAND_RESET_I(32);
}
