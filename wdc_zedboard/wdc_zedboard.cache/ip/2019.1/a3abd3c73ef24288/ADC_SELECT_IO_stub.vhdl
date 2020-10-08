-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Oct  8 14:35:03 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ADC_SELECT_IO_stub.vhdl
-- Design      : ADC_SELECT_IO
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
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

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "data_in_from_pins_p[5:0],data_in_from_pins_n[5:0],data_in_to_device[23:0],in_delay_reset,in_delay_data_ce[5:0],in_delay_data_inc[5:0],in_delay_tap_in[29:0],in_delay_tap_out[29:0],bitslip[5:0],clk_in,clk_div_in,io_reset";
begin
end;
