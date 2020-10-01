// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Oct  1 17:53:40 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/DIG0_MMCM/DIG0_MMCM_stub.v
// Design      : DIG0_MMCM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module DIG0_MMCM(clk_245_76_MHz, clk_122_88_MHz, reset, locked, 
  clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_245_76_MHz,clk_122_88_MHz,reset,locked,clk_in1" */;
  output clk_245_76_MHz;
  output clk_122_88_MHz;
  input reset;
  output locked;
  input clk_in1;
endmodule
