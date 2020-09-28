// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Sep 28 14:06:52 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/LCLK_MMCM/LCLK_MMCM_stub.v
// Design      : LCLK_MMCM
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module LCLK_MMCM(clk_125MHz, clk_200MHz, clk_250MHz, reset, 
  locked, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_125MHz,clk_200MHz,clk_250MHz,reset,locked,clk_in1" */;
  output clk_125MHz;
  output clk_200MHz;
  output clk_250MHz;
  input reset;
  output locked;
  input clk_in1;
endmodule
