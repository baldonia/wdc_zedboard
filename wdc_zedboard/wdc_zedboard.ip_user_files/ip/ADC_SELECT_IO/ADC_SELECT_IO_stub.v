// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Oct  8 14:35:03 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/ADC_SELECT_IO/ADC_SELECT_IO_stub.v
// Design      : ADC_SELECT_IO
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module ADC_SELECT_IO(data_in_from_pins_p, data_in_from_pins_n, 
  data_in_to_device, in_delay_reset, in_delay_data_ce, in_delay_data_inc, in_delay_tap_in, 
  in_delay_tap_out, bitslip, clk_in, clk_div_in, io_reset)
/* synthesis syn_black_box black_box_pad_pin="data_in_from_pins_p[5:0],data_in_from_pins_n[5:0],data_in_to_device[23:0],in_delay_reset,in_delay_data_ce[5:0],in_delay_data_inc[5:0],in_delay_tap_in[29:0],in_delay_tap_out[29:0],bitslip[5:0],clk_in,clk_div_in,io_reset" */;
  input [5:0]data_in_from_pins_p;
  input [5:0]data_in_from_pins_n;
  output [23:0]data_in_to_device;
  input in_delay_reset;
  input [5:0]in_delay_data_ce;
  input [5:0]in_delay_data_inc;
  input [29:0]in_delay_tap_in;
  output [29:0]in_delay_tap_out;
  input [5:0]bitslip;
  input clk_in;
  input clk_div_in;
  input io_reset;
endmodule
