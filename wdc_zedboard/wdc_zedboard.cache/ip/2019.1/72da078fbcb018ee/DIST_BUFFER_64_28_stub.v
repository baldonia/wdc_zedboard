// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Oct  5 17:44:22 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ DIST_BUFFER_64_28_stub.v
// Design      : DIST_BUFFER_64_28
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(a, d, dpra, clk, we, qdpo_clk, qdpo)
/* synthesis syn_black_box black_box_pad_pin="a[5:0],d[27:0],dpra[5:0],clk,we,qdpo_clk,qdpo[27:0]" */;
  input [5:0]a;
  input [27:0]d;
  input [5:0]dpra;
  input clk;
  input we;
  input qdpo_clk;
  output [27:0]qdpo;
endmodule
