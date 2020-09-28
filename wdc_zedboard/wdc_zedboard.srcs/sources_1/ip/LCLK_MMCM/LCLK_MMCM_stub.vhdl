-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Sep 28 14:06:52 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/LCLK_MMCM/LCLK_MMCM_stub.vhdl
-- Design      : LCLK_MMCM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity LCLK_MMCM is
  Port ( 
    clk_125MHz : out STD_LOGIC;
    clk_200MHz : out STD_LOGIC;
    clk_250MHz : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end LCLK_MMCM;

architecture stub of LCLK_MMCM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_125MHz,clk_200MHz,clk_250MHz,reset,locked,clk_in1";
begin
end;
