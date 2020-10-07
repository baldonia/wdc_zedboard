-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Fri Oct  2 14:21:18 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top DIG0_MMCM -prefix
--               DIG0_MMCM_ DIG0_MMCM_stub.vhdl
-- Design      : DIG0_MMCM
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIG0_MMCM is
  Port ( 
    clk_245_76_MHz : out STD_LOGIC;
    clk_122_88_MHz : out STD_LOGIC;
    reset : in STD_LOGIC;
    locked : out STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end DIG0_MMCM;

architecture stub of DIG0_MMCM is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_245_76_MHz,clk_122_88_MHz,reset,locked,clk_in1";
begin
end;
