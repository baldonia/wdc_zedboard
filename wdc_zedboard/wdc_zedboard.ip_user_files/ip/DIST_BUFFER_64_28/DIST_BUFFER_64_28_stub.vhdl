-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Mon Oct  5 17:49:33 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/DIST_BUFFER_64_28/DIST_BUFFER_64_28_stub.vhdl
-- Design      : DIST_BUFFER_64_28
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DIST_BUFFER_64_28 is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    d : in STD_LOGIC_VECTOR ( 27 downto 0 );
    dpra : in STD_LOGIC_VECTOR ( 5 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    qdpo : out STD_LOGIC_VECTOR ( 27 downto 0 )
  );

end DIST_BUFFER_64_28;

architecture stub of DIST_BUFFER_64_28 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[5:0],d[27:0],dpra[5:0],clk,we,qdpo[27:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_13,Vivado 2019.1";
begin
end;
