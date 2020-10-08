// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Thu Oct  8 14:35:03 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ ADC_SELECT_IO_sim_netlist.v
// Design      : ADC_SELECT_IO
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* DEV_W = "24" *) (* SYS_W = "6" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (data_in_from_pins_p,
    data_in_from_pins_n,
    data_in_to_device,
    in_delay_reset,
    in_delay_data_ce,
    in_delay_data_inc,
    in_delay_tap_in,
    in_delay_tap_out,
    bitslip,
    clk_in,
    clk_div_in,
    io_reset);
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

  wire [5:0]bitslip;
  wire clk_div_in;
  wire clk_in;
  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) (* IOSTANDARD = "LVDS_25" *) wire [5:0]data_in_from_pins_n;
  (* DIFF_TERM = 0 *) (* IBUF_LOW_PWR *) (* IOSTANDARD = "LVDS_25" *) wire [5:0]data_in_from_pins_p;
  wire [23:0]data_in_to_device;
  wire [5:0]in_delay_data_ce;
  wire [5:0]in_delay_data_inc;
  wire in_delay_reset;
  wire [29:0]in_delay_tap_in;
  wire [29:0]in_delay_tap_out;
  wire io_reset;

  (* DEV_W = "24" *) 
  (* SYS_W = "6" *) 
  (* num_serial_bits = "4" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz inst
       (.bitslip(bitslip),
        .clk_div_in(clk_div_in),
        .clk_in(clk_in),
        .data_in_from_pins_n(data_in_from_pins_n),
        .data_in_from_pins_p(data_in_from_pins_p),
        .data_in_to_device(data_in_to_device),
        .in_delay_data_ce(in_delay_data_ce),
        .in_delay_data_inc(in_delay_data_inc),
        .in_delay_reset(in_delay_reset),
        .in_delay_tap_in(in_delay_tap_in),
        .in_delay_tap_out(in_delay_tap_out),
        .io_reset(io_reset));
endmodule

(* DEV_W = "24" *) (* SYS_W = "6" *) (* num_serial_bits = "4" *) 
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ADC_SELECT_IO_selectio_wiz
   (data_in_from_pins_p,
    data_in_from_pins_n,
    data_in_to_device,
    in_delay_reset,
    in_delay_data_ce,
    in_delay_data_inc,
    in_delay_tap_in,
    in_delay_tap_out,
    bitslip,
    clk_in,
    clk_div_in,
    io_reset);
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

  wire [5:0]bitslip;
  wire clk_div_in;
  wire clk_in;
  wire data_in_from_pins_delay_0;
  wire data_in_from_pins_delay_1;
  wire data_in_from_pins_delay_2;
  wire data_in_from_pins_delay_3;
  wire data_in_from_pins_delay_4;
  wire data_in_from_pins_delay_5;
  wire data_in_from_pins_int_0;
  wire data_in_from_pins_int_1;
  wire data_in_from_pins_int_2;
  wire data_in_from_pins_int_3;
  wire data_in_from_pins_int_4;
  wire data_in_from_pins_int_5;
  wire [5:0]data_in_from_pins_n;
  wire [5:0]data_in_from_pins_p;
  wire [23:0]data_in_to_device;
  wire [5:0]in_delay_data_ce;
  wire [5:0]in_delay_data_inc;
  wire in_delay_reset;
  wire [29:0]in_delay_tap_in;
  wire [29:0]in_delay_tap_out;
  wire io_reset;
  wire \NLW_pins[0].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[4].iserdese2_master_SHIFTOUT2_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_O_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_Q5_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_Q6_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_Q7_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_Q8_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_SHIFTOUT1_UNCONNECTED ;
  wire \NLW_pins[5].iserdese2_master_SHIFTOUT2_UNCONNECTED ;

  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[0].ibufds_inst 
       (.I(data_in_from_pins_p[0]),
        .IB(data_in_from_pins_n[0]),
        .O(data_in_from_pins_int_0));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[0].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[0]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[4:0]),
        .CNTVALUEOUT(in_delay_tap_out[4:0]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_0),
        .IDATAIN(data_in_from_pins_int_0),
        .INC(in_delay_data_inc[0]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[0].iserdese2_master 
       (.BITSLIP(bitslip[0]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_0),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[0].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[18]),
        .Q2(data_in_to_device[12]),
        .Q3(data_in_to_device[6]),
        .Q4(data_in_to_device[0]),
        .Q5(\NLW_pins[0].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[0].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[0].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[0].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[0].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[0].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[1].ibufds_inst 
       (.I(data_in_from_pins_p[1]),
        .IB(data_in_from_pins_n[1]),
        .O(data_in_from_pins_int_1));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[1].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[1]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[9:5]),
        .CNTVALUEOUT(in_delay_tap_out[9:5]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_1),
        .IDATAIN(data_in_from_pins_int_1),
        .INC(in_delay_data_inc[1]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[1].iserdese2_master 
       (.BITSLIP(bitslip[1]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_1),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[1].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[19]),
        .Q2(data_in_to_device[13]),
        .Q3(data_in_to_device[7]),
        .Q4(data_in_to_device[1]),
        .Q5(\NLW_pins[1].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[1].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[1].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[1].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[1].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[1].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[2].ibufds_inst 
       (.I(data_in_from_pins_p[2]),
        .IB(data_in_from_pins_n[2]),
        .O(data_in_from_pins_int_2));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[2].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[2]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[14:10]),
        .CNTVALUEOUT(in_delay_tap_out[14:10]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_2),
        .IDATAIN(data_in_from_pins_int_2),
        .INC(in_delay_data_inc[2]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[2].iserdese2_master 
       (.BITSLIP(bitslip[2]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_2),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[2].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[20]),
        .Q2(data_in_to_device[14]),
        .Q3(data_in_to_device[8]),
        .Q4(data_in_to_device[2]),
        .Q5(\NLW_pins[2].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[2].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[2].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[2].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[2].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[2].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[3].ibufds_inst 
       (.I(data_in_from_pins_p[3]),
        .IB(data_in_from_pins_n[3]),
        .O(data_in_from_pins_int_3));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[3].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[3]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[19:15]),
        .CNTVALUEOUT(in_delay_tap_out[19:15]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_3),
        .IDATAIN(data_in_from_pins_int_3),
        .INC(in_delay_data_inc[3]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[3].iserdese2_master 
       (.BITSLIP(bitslip[3]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_3),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[3].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[21]),
        .Q2(data_in_to_device[15]),
        .Q3(data_in_to_device[9]),
        .Q4(data_in_to_device[3]),
        .Q5(\NLW_pins[3].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[3].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[3].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[3].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[3].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[3].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[4].ibufds_inst 
       (.I(data_in_from_pins_p[4]),
        .IB(data_in_from_pins_n[4]),
        .O(data_in_from_pins_int_4));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[4].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[4]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[24:20]),
        .CNTVALUEOUT(in_delay_tap_out[24:20]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_4),
        .IDATAIN(data_in_from_pins_int_4),
        .INC(in_delay_data_inc[4]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[4].iserdese2_master 
       (.BITSLIP(bitslip[4]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_4),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[4].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[22]),
        .Q2(data_in_to_device[16]),
        .Q3(data_in_to_device[10]),
        .Q4(data_in_to_device[4]),
        .Q5(\NLW_pins[4].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[4].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[4].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[4].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[4].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[4].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* CAPACITANCE = "DONT_CARE" *) 
  (* IBUF_DELAY_VALUE = "0" *) 
  (* IFD_DELAY_VALUE = "AUTO" *) 
  IBUFDS \pins[5].ibufds_inst 
       (.I(data_in_from_pins_p[5]),
        .IB(data_in_from_pins_n[5]),
        .O(data_in_from_pins_int_5));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* SIM_DELAY_D = "0" *) 
  IDELAYE2 #(
    .CINVCTRL_SEL("FALSE"),
    .DELAY_SRC("IDATAIN"),
    .HIGH_PERFORMANCE_MODE("FALSE"),
    .IDELAY_TYPE("VAR_LOAD"),
    .IDELAY_VALUE(0),
    .IS_C_INVERTED(1'b0),
    .IS_DATAIN_INVERTED(1'b0),
    .IS_IDATAIN_INVERTED(1'b0),
    .PIPE_SEL("FALSE"),
    .REFCLK_FREQUENCY(200.000000),
    .SIGNAL_PATTERN("DATA")) 
    \pins[5].idelaye2_bus 
       (.C(clk_div_in),
        .CE(in_delay_data_ce[5]),
        .CINVCTRL(1'b0),
        .CNTVALUEIN(in_delay_tap_in[29:25]),
        .CNTVALUEOUT(in_delay_tap_out[29:25]),
        .DATAIN(1'b0),
        .DATAOUT(data_in_from_pins_delay_5),
        .IDATAIN(data_in_from_pins_int_5),
        .INC(in_delay_data_inc[5]),
        .LD(in_delay_reset),
        .LDPIPEEN(1'b0),
        .REGRST(io_reset));
  (* BOX_TYPE = "PRIMITIVE" *) 
  (* OPT_MODIFIED = "MLO" *) 
  ISERDESE2 #(
    .DATA_RATE("DDR"),
    .DATA_WIDTH(4),
    .DYN_CLKDIV_INV_EN("FALSE"),
    .DYN_CLK_INV_EN("FALSE"),
    .INIT_Q1(1'b0),
    .INIT_Q2(1'b0),
    .INIT_Q3(1'b0),
    .INIT_Q4(1'b0),
    .INTERFACE_TYPE("NETWORKING"),
    .IOBDELAY("IFD"),
    .IS_CLKB_INVERTED(1'b1),
    .IS_CLKDIVP_INVERTED(1'b0),
    .IS_CLKDIV_INVERTED(1'b0),
    .IS_CLK_INVERTED(1'b0),
    .IS_D_INVERTED(1'b0),
    .IS_OCLKB_INVERTED(1'b0),
    .IS_OCLK_INVERTED(1'b0),
    .NUM_CE(2),
    .OFB_USED("FALSE"),
    .SERDES_MODE("MASTER"),
    .SRVAL_Q1(1'b0),
    .SRVAL_Q2(1'b0),
    .SRVAL_Q3(1'b0),
    .SRVAL_Q4(1'b0)) 
    \pins[5].iserdese2_master 
       (.BITSLIP(bitslip[5]),
        .CE1(1'b1),
        .CE2(1'b1),
        .CLK(clk_in),
        .CLKB(clk_in),
        .CLKDIV(clk_div_in),
        .CLKDIVP(1'b0),
        .D(1'b0),
        .DDLY(data_in_from_pins_delay_5),
        .DYNCLKDIVSEL(1'b0),
        .DYNCLKSEL(1'b0),
        .O(\NLW_pins[5].iserdese2_master_O_UNCONNECTED ),
        .OCLK(1'b0),
        .OCLKB(1'b0),
        .OFB(1'b0),
        .Q1(data_in_to_device[23]),
        .Q2(data_in_to_device[17]),
        .Q3(data_in_to_device[11]),
        .Q4(data_in_to_device[5]),
        .Q5(\NLW_pins[5].iserdese2_master_Q5_UNCONNECTED ),
        .Q6(\NLW_pins[5].iserdese2_master_Q6_UNCONNECTED ),
        .Q7(\NLW_pins[5].iserdese2_master_Q7_UNCONNECTED ),
        .Q8(\NLW_pins[5].iserdese2_master_Q8_UNCONNECTED ),
        .RST(io_reset),
        .SHIFTIN1(1'b0),
        .SHIFTIN2(1'b0),
        .SHIFTOUT1(\NLW_pins[5].iserdese2_master_SHIFTOUT1_UNCONNECTED ),
        .SHIFTOUT2(\NLW_pins[5].iserdese2_master_SHIFTOUT2_UNCONNECTED ));
endmodule
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

endmodule
`endif
