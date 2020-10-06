// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Oct  5 18:03:11 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/BUFFER_32K_28/BUFFER_32K_28_stub.v
// Design      : BUFFER_32K_28
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "blk_mem_gen_v8_4_3,Vivado 2019.1" *)
module BUFFER_32K_28(clka, wea, addra, dina, clkb, addrb, doutb)
/* synthesis syn_black_box black_box_pad_pin="clka,wea[0:0],addra[14:0],dina[27:0],clkb,addrb[14:0],doutb[27:0]" */;
  input clka;
  input [0:0]wea;
  input [14:0]addra;
  input [27:0]dina;
  input clkb;
  input [14:0]addrb;
  output [27:0]doutb;
endmodule
