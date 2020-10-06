// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Oct  5 17:49:33 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/DIST_BUFFER_64_28/DIST_BUFFER_64_28_stub.v
// Design      : DIST_BUFFER_64_28
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *)
module DIST_BUFFER_64_28(a, d, dpra, clk, we, qdpo)
/* synthesis syn_black_box black_box_pad_pin="a[5:0],d[27:0],dpra[5:0],clk,we,qdpo[27:0]" */;
  input [5:0]a;
  input [27:0]d;
  input [5:0]dpra;
  input clk;
  input we;
  output [27:0]qdpo;
endmodule
