// Verilated -*- C++ -*-
// DESCRIPTION: Verilator output: Primary design header
//
// This header should be included by all source files instantiating the design.
// The class here is then constructed to instantiate the design.
// See the Verilator manual for examples.

#ifndef _Vconv1_mem_write_H_
#define _Vconv1_mem_write_H_

#include "verilated.h"

class Vconv1_mem_write__Syms;
class VerilatedVcd;

//----------

VL_MODULE(Vconv1_mem_write) {
  public:
    
    // PORTS
    // The application code writes and reads these signals to
    // propagate new values into/out from the Verilated model.
    VL_IN8(clk,0,0);
    VL_IN8(reset,0,0);
    VL_IN8(enable,0,0);
    VL_OUT8(done,0,0);
    VL_OUT16(addr0,9,0);
    VL_OUT16(addr1,9,0);
    
    // LOCAL SIGNALS
    // Internals; generally not touched by application code
    
    // LOCAL VARIABLES
    // Internals; generally not touched by application code
    VL_SIG8(__Vclklast__TOP__clk,0,0);
    VL_SIG8(__Vclklast__TOP__reset,0,0);
    VL_SIG(__Vm_traceActivity,31,0);
    
    // INTERNAL VARIABLES
    // Internals; generally not touched by application code
    Vconv1_mem_write__Syms* __VlSymsp;  // Symbol table
    
    // PARAMETERS
    // Parameters marked /*verilator public*/ for use by application code
    
    // CONSTRUCTORS
  private:
    VL_UNCOPYABLE(Vconv1_mem_write);  ///< Copying not allowed
  public:
    /// Construct the model; called by application code
    /// The special name  may be used to make a wrapper with a
    /// single model invisible with respect to DPI scope names.
    Vconv1_mem_write(const char* name="TOP");
    /// Destroy the model; called (often implicitly) by application code
    ~Vconv1_mem_write();
    /// Trace signals in the model; called by application code
    void trace(VerilatedVcdC* tfp, int levels, int options=0);
    
    // API METHODS
    /// Evaluate the model.  Application must call when inputs change.
    void eval();
    /// Simulation complete, run final blocks.  Application must call on completion.
    void final();
    
    // INTERNAL METHODS
  private:
    static void _eval_initial_loop(Vconv1_mem_write__Syms* __restrict vlSymsp);
  public:
    void __Vconfigure(Vconv1_mem_write__Syms* symsp, bool first);
  private:
    static QData _change_request(Vconv1_mem_write__Syms* __restrict vlSymsp);
    void _ctor_var_reset();
  public:
    static void _eval(Vconv1_mem_write__Syms* __restrict vlSymsp);
  private:
#ifdef VL_DEBUG
    void _eval_debug_assertions();
#endif // VL_DEBUG
  public:
    static void _eval_initial(Vconv1_mem_write__Syms* __restrict vlSymsp);
    static void _eval_settle(Vconv1_mem_write__Syms* __restrict vlSymsp);
    static void _sequent__TOP__1(Vconv1_mem_write__Syms* __restrict vlSymsp);
    static void _settle__TOP__2(Vconv1_mem_write__Syms* __restrict vlSymsp);
    static void traceChgThis(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceChgThis__2(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceFullThis__1(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInitThis(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInitThis__1(Vconv1_mem_write__Syms* __restrict vlSymsp, VerilatedVcd* vcdp, uint32_t code);
    static void traceInit(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceFull(VerilatedVcd* vcdp, void* userthis, uint32_t code);
    static void traceChg(VerilatedVcd* vcdp, void* userthis, uint32_t code);
} VL_ATTR_ALIGNED(128);

#endif // guard
