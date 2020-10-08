-- Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
-- Date        : Thu Oct  8 14:35:03 2020
-- Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ADC_SELECT_IO_sim_netlist.vhdl
-- Design      : ADC_SELECT_IO
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xc7z020clg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz is
  port (
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
  attribute DEV_W : integer;
  attribute DEV_W of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz : entity is 24;
  attribute SYS_W : integer;
  attribute SYS_W of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz : entity is 6;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz : entity is 4;
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz is
  signal data_in_from_pins_delay_0 : STD_LOGIC;
  signal data_in_from_pins_delay_1 : STD_LOGIC;
  signal data_in_from_pins_delay_2 : STD_LOGIC;
  signal data_in_from_pins_delay_3 : STD_LOGIC;
  signal data_in_from_pins_delay_4 : STD_LOGIC;
  signal data_in_from_pins_delay_5 : STD_LOGIC;
  signal data_in_from_pins_int_0 : STD_LOGIC;
  signal data_in_from_pins_int_1 : STD_LOGIC;
  signal data_in_from_pins_int_2 : STD_LOGIC;
  signal data_in_from_pins_int_3 : STD_LOGIC;
  signal data_in_from_pins_int_4 : STD_LOGIC;
  signal data_in_from_pins_int_5 : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[4].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_O_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_Q5_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_Q6_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_Q7_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_Q8_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_SHIFTOUT1_UNCONNECTED\ : STD_LOGIC;
  signal \NLW_pins[5].iserdese2_master_SHIFTOUT2_UNCONNECTED\ : STD_LOGIC;
  attribute BOX_TYPE : string;
  attribute BOX_TYPE of \pins[0].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE : string;
  attribute CAPACITANCE of \pins[0].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE : string;
  attribute IBUF_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE : string;
  attribute IFD_DELAY_VALUE of \pins[0].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[0].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D : integer;
  attribute SIM_DELAY_D of \pins[0].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[0].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED : string;
  attribute OPT_MODIFIED of \pins[0].iserdese2_master\ : label is "MLO";
  attribute BOX_TYPE of \pins[1].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[1].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[1].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[1].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[1].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \pins[1].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[1].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED of \pins[1].iserdese2_master\ : label is "MLO";
  attribute BOX_TYPE of \pins[2].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[2].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[2].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[2].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[2].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \pins[2].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[2].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED of \pins[2].iserdese2_master\ : label is "MLO";
  attribute BOX_TYPE of \pins[3].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[3].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[3].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[3].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[3].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \pins[3].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[3].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED of \pins[3].iserdese2_master\ : label is "MLO";
  attribute BOX_TYPE of \pins[4].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[4].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[4].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[4].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[4].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \pins[4].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[4].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED of \pins[4].iserdese2_master\ : label is "MLO";
  attribute BOX_TYPE of \pins[5].ibufds_inst\ : label is "PRIMITIVE";
  attribute CAPACITANCE of \pins[5].ibufds_inst\ : label is "DONT_CARE";
  attribute IBUF_DELAY_VALUE of \pins[5].ibufds_inst\ : label is "0";
  attribute IFD_DELAY_VALUE of \pins[5].ibufds_inst\ : label is "AUTO";
  attribute BOX_TYPE of \pins[5].idelaye2_bus\ : label is "PRIMITIVE";
  attribute SIM_DELAY_D of \pins[5].idelaye2_bus\ : label is 0;
  attribute BOX_TYPE of \pins[5].iserdese2_master\ : label is "PRIMITIVE";
  attribute OPT_MODIFIED of \pins[5].iserdese2_master\ : label is "MLO";
begin
\pins[0].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(0),
      IB => data_in_from_pins_n(0),
      O => data_in_from_pins_int_0
    );
\pins[0].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(0),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(4 downto 0),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(4 downto 0),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_0,
      IDATAIN => data_in_from_pins_int_0,
      INC => in_delay_data_inc(0),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[0].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(0),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_0,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[0].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(18),
      Q2 => data_in_to_device(12),
      Q3 => data_in_to_device(6),
      Q4 => data_in_to_device(0),
      Q5 => \NLW_pins[0].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[0].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[0].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[1].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(1),
      IB => data_in_from_pins_n(1),
      O => data_in_from_pins_int_1
    );
\pins[1].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(1),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(9 downto 5),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(9 downto 5),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_1,
      IDATAIN => data_in_from_pins_int_1,
      INC => in_delay_data_inc(1),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[1].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(1),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_1,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[1].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(19),
      Q2 => data_in_to_device(13),
      Q3 => data_in_to_device(7),
      Q4 => data_in_to_device(1),
      Q5 => \NLW_pins[1].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[1].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[1].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[1].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[2].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(2),
      IB => data_in_from_pins_n(2),
      O => data_in_from_pins_int_2
    );
\pins[2].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(2),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(14 downto 10),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(14 downto 10),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_2,
      IDATAIN => data_in_from_pins_int_2,
      INC => in_delay_data_inc(2),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[2].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(2),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_2,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[2].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(20),
      Q2 => data_in_to_device(14),
      Q3 => data_in_to_device(8),
      Q4 => data_in_to_device(2),
      Q5 => \NLW_pins[2].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[2].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[2].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[2].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[3].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(3),
      IB => data_in_from_pins_n(3),
      O => data_in_from_pins_int_3
    );
\pins[3].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(3),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(19 downto 15),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(19 downto 15),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_3,
      IDATAIN => data_in_from_pins_int_3,
      INC => in_delay_data_inc(3),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[3].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(3),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_3,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[3].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(21),
      Q2 => data_in_to_device(15),
      Q3 => data_in_to_device(9),
      Q4 => data_in_to_device(3),
      Q5 => \NLW_pins[3].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[3].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[3].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[3].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[4].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(4),
      IB => data_in_from_pins_n(4),
      O => data_in_from_pins_int_4
    );
\pins[4].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(4),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(24 downto 20),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(24 downto 20),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_4,
      IDATAIN => data_in_from_pins_int_4,
      INC => in_delay_data_inc(4),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[4].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(4),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_4,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[4].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(22),
      Q2 => data_in_to_device(16),
      Q3 => data_in_to_device(10),
      Q4 => data_in_to_device(4),
      Q5 => \NLW_pins[4].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[4].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[4].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[4].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[4].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[4].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
\pins[5].ibufds_inst\: unisim.vcomponents.IBUFDS
     port map (
      I => data_in_from_pins_p(5),
      IB => data_in_from_pins_n(5),
      O => data_in_from_pins_int_5
    );
\pins[5].idelaye2_bus\: unisim.vcomponents.IDELAYE2
    generic map(
      CINVCTRL_SEL => "FALSE",
      DELAY_SRC => "IDATAIN",
      HIGH_PERFORMANCE_MODE => "FALSE",
      IDELAY_TYPE => "VAR_LOAD",
      IDELAY_VALUE => 0,
      IS_C_INVERTED => '0',
      IS_DATAIN_INVERTED => '0',
      IS_IDATAIN_INVERTED => '0',
      PIPE_SEL => "FALSE",
      REFCLK_FREQUENCY => 200.000000,
      SIGNAL_PATTERN => "DATA"
    )
        port map (
      C => clk_div_in,
      CE => in_delay_data_ce(5),
      CINVCTRL => '0',
      CNTVALUEIN(4 downto 0) => in_delay_tap_in(29 downto 25),
      CNTVALUEOUT(4 downto 0) => in_delay_tap_out(29 downto 25),
      DATAIN => '0',
      DATAOUT => data_in_from_pins_delay_5,
      IDATAIN => data_in_from_pins_int_5,
      INC => in_delay_data_inc(5),
      LD => in_delay_reset,
      LDPIPEEN => '0',
      REGRST => io_reset
    );
\pins[5].iserdese2_master\: unisim.vcomponents.ISERDESE2
    generic map(
      DATA_RATE => "DDR",
      DATA_WIDTH => 4,
      DYN_CLKDIV_INV_EN => "FALSE",
      DYN_CLK_INV_EN => "FALSE",
      INIT_Q1 => '0',
      INIT_Q2 => '0',
      INIT_Q3 => '0',
      INIT_Q4 => '0',
      INTERFACE_TYPE => "NETWORKING",
      IOBDELAY => "IFD",
      IS_CLKB_INVERTED => '1',
      IS_CLKDIVP_INVERTED => '0',
      IS_CLKDIV_INVERTED => '0',
      IS_CLK_INVERTED => '0',
      IS_D_INVERTED => '0',
      IS_OCLKB_INVERTED => '0',
      IS_OCLK_INVERTED => '0',
      NUM_CE => 2,
      OFB_USED => "FALSE",
      SERDES_MODE => "MASTER",
      SRVAL_Q1 => '0',
      SRVAL_Q2 => '0',
      SRVAL_Q3 => '0',
      SRVAL_Q4 => '0'
    )
        port map (
      BITSLIP => bitslip(5),
      CE1 => '1',
      CE2 => '1',
      CLK => clk_in,
      CLKB => clk_in,
      CLKDIV => clk_div_in,
      CLKDIVP => '0',
      D => '0',
      DDLY => data_in_from_pins_delay_5,
      DYNCLKDIVSEL => '0',
      DYNCLKSEL => '0',
      O => \NLW_pins[5].iserdese2_master_O_UNCONNECTED\,
      OCLK => '0',
      OCLKB => '0',
      OFB => '0',
      Q1 => data_in_to_device(23),
      Q2 => data_in_to_device(17),
      Q3 => data_in_to_device(11),
      Q4 => data_in_to_device(5),
      Q5 => \NLW_pins[5].iserdese2_master_Q5_UNCONNECTED\,
      Q6 => \NLW_pins[5].iserdese2_master_Q6_UNCONNECTED\,
      Q7 => \NLW_pins[5].iserdese2_master_Q7_UNCONNECTED\,
      Q8 => \NLW_pins[5].iserdese2_master_Q8_UNCONNECTED\,
      RST => io_reset,
      SHIFTIN1 => '0',
      SHIFTIN2 => '0',
      SHIFTOUT1 => \NLW_pins[5].iserdese2_master_SHIFTOUT1_UNCONNECTED\,
      SHIFTOUT2 => \NLW_pins[5].iserdese2_master_SHIFTOUT2_UNCONNECTED\
    );
end STRUCTURE;
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  port (
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
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is true;
  attribute DEV_W : integer;
  attribute DEV_W of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is 24;
  attribute SYS_W : integer;
  attribute SYS_W of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix : entity is 6;
end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture STRUCTURE of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  attribute DEV_W of inst : label is 24;
  attribute SYS_W of inst : label is 6;
  attribute num_serial_bits : integer;
  attribute num_serial_bits of inst : label is 4;
begin
inst: entity work.decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz
     port map (
      bitslip(5 downto 0) => bitslip(5 downto 0),
      clk_div_in => clk_div_in,
      clk_in => clk_in,
      data_in_from_pins_n(5 downto 0) => data_in_from_pins_n(5 downto 0),
      data_in_from_pins_p(5 downto 0) => data_in_from_pins_p(5 downto 0),
      data_in_to_device(23 downto 0) => data_in_to_device(23 downto 0),
      in_delay_data_ce(5 downto 0) => in_delay_data_ce(5 downto 0),
      in_delay_data_inc(5 downto 0) => in_delay_data_inc(5 downto 0),
      in_delay_reset => in_delay_reset,
      in_delay_tap_in(29 downto 0) => in_delay_tap_in(29 downto 0),
      in_delay_tap_out(29 downto 0) => in_delay_tap_out(29 downto 0),
      io_reset => io_reset
    );
end STRUCTURE;
