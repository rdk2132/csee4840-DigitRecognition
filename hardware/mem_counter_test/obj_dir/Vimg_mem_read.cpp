// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Design implementation internals
// See Vimg_mem_read.h for the primary calling header

#include "Vimg_mem_read.h"     // For This
#include "Vimg_mem_read__Syms.h"


//--------------------
// STATIC VARIABLES


//--------------------

VL_CTOR_IMP(Vimg_mem_read) {
    Vimg_mem_read__Syms* __restrict vlSymsp = __VlSymsp = new Vimg_mem_read__Syms(this, name());
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Reset internal values
    
    // Reset structure values
    _ctor_var_reset();
}

void Vimg_mem_read::__Vconfigure(Vimg_mem_read__Syms* vlSymsp, bool first) {
    if (0 && first) {}  // Prevent unused
    this->__VlSymsp = vlSymsp;
}

Vimg_mem_read::~Vimg_mem_read() {
    delete __VlSymsp; __VlSymsp=NULL;
}

//--------------------


void Vimg_mem_read::eval() {
    VL_DEBUG_IF(VL_DBG_MSGF("+++++TOP Evaluate Vimg_mem_read::eval\n"); );
    Vimg_mem_read__Syms* __restrict vlSymsp = this->__VlSymsp;  // Setup global symbol table
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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

void Vimg_mem_read::_eval_initial_loop(Vimg_mem_read__Syms* __restrict vlSymsp) {
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

VL_INLINE_OPT void Vimg_mem_read::_sequent__TOP__1(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_sequent__TOP__1\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Variables
    VL_SIG8(__Vdly__img_mem_read__DOT__i_count,4,0);
    VL_SIG8(__Vdly__img_mem_read__DOT__columncount,2,0);
    VL_SIG8(__Vdly__img_mem_read__DOT__rowcount,2,0);
    VL_SIG16(__Vdly__addr0,9,0);
    VL_SIG16(__Vdly__addr1,9,0);
    VL_SIG16(__Vdly__addr2,9,0);
    VL_SIG16(__Vdly__addr3,9,0);
    // Body
    __Vdly__addr0 = vlTOPp->addr0;
    __Vdly__img_mem_read__DOT__i_count = vlTOPp->img_mem_read__DOT__i_count;
    __Vdly__addr1 = vlTOPp->addr1;
    __Vdly__addr2 = vlTOPp->addr2;
    __Vdly__img_mem_read__DOT__columncount = vlTOPp->img_mem_read__DOT__columncount;
    __Vdly__img_mem_read__DOT__rowcount = vlTOPp->img_mem_read__DOT__rowcount;
    __Vdly__addr3 = vlTOPp->addr3;
    // ALWAYS at img_mem_read.sv:12
    if (vlTOPp->reset) {
	__Vdly__addr0 = 0U;
	__Vdly__img_mem_read__DOT__i_count = 0U;
	__Vdly__addr1 = 0xa8U;
	__Vdly__addr2 = 0x150U;
	__Vdly__addr3 = 0x1f8U;
    } else {
	if (((IData)(vlTOPp->enable) & (~ (IData)(vlTOPp->done)))) {
	    if ((((0x17U == (IData)(vlTOPp->img_mem_read__DOT__i_count)) 
		  & (4U == (IData)(vlTOPp->img_mem_read__DOT__rowcount))) 
		 & (4U == (IData)(vlTOPp->img_mem_read__DOT__columncount)))) {
		__Vdly__addr0 = (0x3ffU & ((IData)(vlTOPp->addr0) 
					   - (IData)(0x6fU)));
		__Vdly__img_mem_read__DOT__i_count = 0U;
		__Vdly__img_mem_read__DOT__columncount = 0U;
		__Vdly__img_mem_read__DOT__rowcount = 0U;
		__Vdly__addr1 = (0x3ffU & ((IData)(vlTOPp->addr1) 
					   - (IData)(0x6fU)));
		__Vdly__addr2 = (0x3ffU & ((IData)(vlTOPp->addr2) 
					   - (IData)(0x6fU)));
		__Vdly__addr3 = (0x3ffU & ((IData)(vlTOPp->addr3) 
					   - (IData)(0x6fU)));
	    } else {
		if (((4U == (IData)(vlTOPp->img_mem_read__DOT__rowcount)) 
		     & (4U == (IData)(vlTOPp->img_mem_read__DOT__columncount)))) {
		    __Vdly__img_mem_read__DOT__i_count 
			= (0x1fU & ((IData)(1U) + (IData)(vlTOPp->img_mem_read__DOT__i_count)));
		    __Vdly__addr0 = (0x3ffU & ((IData)(vlTOPp->addr0) 
					       - (IData)(0x73U)));
		    __Vdly__img_mem_read__DOT__columncount = 0U;
		    __Vdly__img_mem_read__DOT__rowcount = 0U;
		    __Vdly__addr1 = (0x3ffU & ((IData)(vlTOPp->addr1) 
					       - (IData)(0x73U)));
		    __Vdly__addr2 = (0x3ffU & ((IData)(vlTOPp->addr2) 
					       - (IData)(0x73U)));
		    __Vdly__addr3 = (0x3ffU & ((IData)(vlTOPp->addr3) 
					       - (IData)(0x73U)));
		} else {
		    if ((4U == (IData)(vlTOPp->img_mem_read__DOT__columncount))) {
			__Vdly__img_mem_read__DOT__rowcount 
			    = (7U & ((IData)(1U) + (IData)(vlTOPp->img_mem_read__DOT__rowcount)));
			__Vdly__addr0 = (0x3ffU & ((IData)(0x18U) 
						   + (IData)(vlTOPp->addr0)));
			__Vdly__img_mem_read__DOT__columncount = 0U;
			__Vdly__addr1 = (0x3ffU & ((IData)(0x18U) 
						   + (IData)(vlTOPp->addr1)));
			__Vdly__addr2 = (0x3ffU & ((IData)(0x18U) 
						   + (IData)(vlTOPp->addr2)));
			__Vdly__addr3 = (0x3ffU & ((IData)(0x18U) 
						   + (IData)(vlTOPp->addr3)));
		    } else {
			__Vdly__img_mem_read__DOT__columncount 
			    = (7U & ((IData)(1U) + (IData)(vlTOPp->img_mem_read__DOT__columncount)));
			__Vdly__addr0 = (0x3ffU & ((IData)(1U) 
						   + (IData)(vlTOPp->addr0)));
			__Vdly__addr1 = (0x3ffU & ((IData)(1U) 
						   + (IData)(vlTOPp->addr1)));
			__Vdly__addr2 = (0x3ffU & ((IData)(1U) 
						   + (IData)(vlTOPp->addr2)));
			__Vdly__addr3 = (0x3ffU & ((IData)(1U) 
						   + (IData)(vlTOPp->addr3)));
		    }
		}
	    }
	}
    }
    vlTOPp->img_mem_read__DOT__i_count = __Vdly__img_mem_read__DOT__i_count;
    vlTOPp->img_mem_read__DOT__rowcount = __Vdly__img_mem_read__DOT__rowcount;
    vlTOPp->img_mem_read__DOT__columncount = __Vdly__img_mem_read__DOT__columncount;
    vlTOPp->addr0 = __Vdly__addr0;
    vlTOPp->addr1 = __Vdly__addr1;
    vlTOPp->addr2 = __Vdly__addr2;
    vlTOPp->addr3 = __Vdly__addr3;
    // ALWAYS at img_mem_read.sv:61
    if ((0x30fU == (IData)(vlTOPp->addr3))) {
	vlTOPp->done = 1U;
    }
}

void Vimg_mem_read::_settle__TOP__2(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_settle__TOP__2\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // ALWAYS at img_mem_read.sv:61
    if ((0x30fU == (IData)(vlTOPp->addr3))) {
	vlTOPp->done = 1U;
    }
}

void Vimg_mem_read::_eval(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_eval\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
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

void Vimg_mem_read::_eval_initial(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_eval_initial\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vimg_mem_read::final() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::final\n"); );
    // Variables
    Vimg_mem_read__Syms* __restrict vlSymsp = this->__VlSymsp;
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
}

void Vimg_mem_read::_eval_settle(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_eval_settle\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    vlTOPp->_settle__TOP__2(vlSymsp);
}

VL_INLINE_OPT QData Vimg_mem_read::_change_request(Vimg_mem_read__Syms* __restrict vlSymsp) {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_change_request\n"); );
    Vimg_mem_read* __restrict vlTOPp VL_ATTR_UNUSED = vlSymsp->TOPp;
    // Body
    // Change detection
    QData __req = false;  // Logically a bool
    return __req;
}

#ifdef VL_DEBUG
void Vimg_mem_read::_eval_debug_assertions() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_eval_debug_assertions\n"); );
    // Body
    if (VL_UNLIKELY((clk & 0xfeU))) {
	Verilated::overWidthError("clk");}
    if (VL_UNLIKELY((reset & 0xfeU))) {
	Verilated::overWidthError("reset");}
    if (VL_UNLIKELY((enable & 0xfeU))) {
	Verilated::overWidthError("enable");}
}
#endif // VL_DEBUG

void Vimg_mem_read::_ctor_var_reset() {
    VL_DEBUG_IF(VL_DBG_MSGF("+    Vimg_mem_read::_ctor_var_reset\n"); );
    // Body
    clk = VL_RAND_RESET_I(1);
    reset = VL_RAND_RESET_I(1);
    enable = VL_RAND_RESET_I(1);
    addr0 = VL_RAND_RESET_I(10);
    addr1 = VL_RAND_RESET_I(10);
    addr2 = VL_RAND_RESET_I(10);
    addr3 = VL_RAND_RESET_I(10);
    done = VL_RAND_RESET_I(1);
    img_mem_read__DOT__rowcount = VL_RAND_RESET_I(3);
    img_mem_read__DOT__columncount = VL_RAND_RESET_I(3);
    img_mem_read__DOT__i_count = VL_RAND_RESET_I(5);
    __Vclklast__TOP__clk = VL_RAND_RESET_I(1);
    __Vclklast__TOP__reset = VL_RAND_RESET_I(1);
    __Vm_traceActivity = VL_RAND_RESET_I(32);
}
