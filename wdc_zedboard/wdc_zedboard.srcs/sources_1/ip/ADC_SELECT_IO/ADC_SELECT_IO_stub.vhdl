-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Oct  8 14:35:03 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/ADC_SELECT_IO/ADC_SELECT_IO_stub.vhdl
-- Design      : ADC_SELECT_IO
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ADC_SELECT_IO is
  Port ( 
    data_in_from_pins_p : in STD_LOGIC_VECTOR ( 5 downto 0 );
    data_in_from_pins_n : in STD_LOGIC_VECTOR ( 5 downto 0 );
    data_in_to_device : out STD_LOGIC_VECTOR ( 23 downto 0 );
    in_delay_reset : in STD_LOGIC;
    in_delay_data_ce : in STD_LOGIC_VECTOR ( 5 downto 0 );
    in_delay_data_inc : in STD_LOGIC_VECTOR ( 5 downto 0 );
    in_delay_tap_in : in STD_LOGIC_VECTOR ( 29 downto 0 );
    in_delay_tap_out : out STD_LOGIC_VECTOR ( 29 downto 0 );
    bitslip : in STD_LOGIC_VECTOR ( 5 downto 0 );
    clk_in : in STD_LOGIC;
    clk_div_in : in STD_LOGIC;
    io_reset : in STD_LOGIC
  );

end ADC_SELECT_IO;

architecture stub of ADC_SELECT_IO is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "data_in_from_pins_p[5:0],data_in_from_pins_n[5:0],data_in_to_device[23:0],in_delay_reset,in_delay_data_ce[5:0],in_delay_data_inc[5:0],in_delay_tap_in[29:0],in_delay_tap_out[29:0],bitslip[5:0],clk_in,clk_div_in,io_reset";
begin
end;
