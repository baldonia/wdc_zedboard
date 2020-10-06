// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (win64) Build 2552052 Fri May 24 14:49:42 MDT 2019
// Date        : Mon Oct  5 17:49:33 2020
// Host        : LAPTOP-GBOUD091 running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode funcsim
//               c:/Users/atfie/watchman-ne1/wdc_zedboard/wdc_zedboard/wdc_zedboard.srcs/sources_1/ip/DIST_BUFFER_64_28/DIST_BUFFER_64_28_sim_netlist.v
// Design      : DIST_BUFFER_64_28
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7z020clg484-1
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "DIST_BUFFER_64_28,dist_mem_gen_v8_0_13,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_13,Vivado 2019.1" *) 
(* NotValidForBitStream *)
module DIST_BUFFER_64_28
   (a,
    d,
    dpra,
    clk,
    we,
    qdpo);
  input [5:0]a;
  input [27:0]d;
  input [5:0]dpra;
  input clk;
  input we;
  output [27:0]qdpo;

  wire [5:0]a;
  wire clk;
  wire [27:0]d;
  wire [5:0]dpra;
  wire [27:0]qdpo;
  wire we;
  wire [27:0]NLW_U0_dpo_UNCONNECTED;
  wire [27:0]NLW_U0_qspo_UNCONNECTED;
  wire [27:0]NLW_U0_spo_UNCONNECTED;

  (* C_FAMILY = "zynq" *) 
  (* C_HAS_CLK = "1" *) 
  (* C_HAS_D = "1" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "1" *) 
  (* C_HAS_QDPO = "1" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_QSPO = "0" *) 
  (* C_HAS_QSPO_RST = "0" *) 
  (* C_HAS_QSPO_SRST = "0" *) 
  (* C_HAS_SPO = "0" *) 
  (* C_HAS_WE = "1" *) 
  (* C_MEM_TYPE = "4" *) 
  (* C_REG_DPRA_INPUT = "1" *) 
  (* c_addr_width = "6" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "64" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_i_ce = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_mem_init_file = "no_coe_file_loaded" *) 
  (* c_parser_type = "1" *) 
  (* c_pipeline_stages = "0" *) 
  (* c_qce_joined = "0" *) 
  (* c_qualify_we = "0" *) 
  (* c_read_mif = "0" *) 
  (* c_reg_a_d_inputs = "1" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "28" *) 
  DIST_BUFFER_64_28_dist_mem_gen_v8_0_13 U0
       (.a(a),
        .clk(clk),
        .d(d),
        .dpo(NLW_U0_dpo_UNCONNECTED[27:0]),
        .dpra(dpra),
        .i_ce(1'b1),
        .qdpo(qdpo),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[27:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(NLW_U0_spo_UNCONNECTED[27:0]),
        .we(we));
endmodule

(* C_ADDR_WIDTH = "6" *) (* C_DEFAULT_DATA = "0" *) (* C_DEPTH = "64" *) 
(* C_ELABORATION_DIR = "./" *) (* C_FAMILY = "zynq" *) (* C_HAS_CLK = "1" *) 
(* C_HAS_D = "1" *) (* C_HAS_DPO = "0" *) (* C_HAS_DPRA = "1" *) 
(* C_HAS_I_CE = "0" *) (* C_HAS_QDPO = "1" *) (* C_HAS_QDPO_CE = "0" *) 
(* C_HAS_QDPO_CLK = "0" *) (* C_HAS_QDPO_RST = "0" *) (* C_HAS_QDPO_SRST = "0" *) 
(* C_HAS_QSPO = "0" *) (* C_HAS_QSPO_CE = "0" *) (* C_HAS_QSPO_RST = "0" *) 
(* C_HAS_QSPO_SRST = "0" *) (* C_HAS_SPO = "0" *) (* C_HAS_WE = "1" *) 
(* C_MEM_INIT_FILE = "no_coe_file_loaded" *) (* C_MEM_TYPE = "4" *) (* C_PARSER_TYPE = "1" *) 
(* C_PIPELINE_STAGES = "0" *) (* C_QCE_JOINED = "0" *) (* C_QUALIFY_WE = "0" *) 
(* C_READ_MIF = "0" *) (* C_REG_A_D_INPUTS = "1" *) (* C_REG_DPRA_INPUT = "1" *) 
(* C_SYNC_ENABLE = "1" *) (* C_WIDTH = "28" *) (* ORIG_REF_NAME = "dist_mem_gen_v8_0_13" *) 
module DIST_BUFFER_64_28_dist_mem_gen_v8_0_13
   (a,
    d,
    dpra,
    clk,
    we,
    i_ce,
    qspo_ce,
    qdpo_ce,
    qdpo_clk,
    qspo_rst,
    qdpo_rst,
    qspo_srst,
    qdpo_srst,
    spo,
    dpo,
    qspo,
    qdpo);
  input [5:0]a;
  input [27:0]d;
  input [5:0]dpra;
  input clk;
  input we;
  input i_ce;
  input qspo_ce;
  input qdpo_ce;
  input qdpo_clk;
  input qspo_rst;
  input qdpo_rst;
  input qspo_srst;
  input qdpo_srst;
  output [27:0]spo;
  output [27:0]dpo;
  output [27:0]qspo;
  output [27:0]qdpo;

  wire \<const0> ;
  wire [5:0]a;
  wire clk;
  wire [27:0]d;
  wire [5:0]dpra;
  wire [27:0]qdpo;
  wire we;

  assign dpo[27] = \<const0> ;
  assign dpo[26] = \<const0> ;
  assign dpo[25] = \<const0> ;
  assign dpo[24] = \<const0> ;
  assign dpo[23] = \<const0> ;
  assign dpo[22] = \<const0> ;
  assign dpo[21] = \<const0> ;
  assign dpo[20] = \<const0> ;
  assign dpo[19] = \<const0> ;
  assign dpo[18] = \<const0> ;
  assign dpo[17] = \<const0> ;
  assign dpo[16] = \<const0> ;
  assign dpo[15] = \<const0> ;
  assign dpo[14] = \<const0> ;
  assign dpo[13] = \<const0> ;
  assign dpo[12] = \<const0> ;
  assign dpo[11] = \<const0> ;
  assign dpo[10] = \<const0> ;
  assign dpo[9] = \<const0> ;
  assign dpo[8] = \<const0> ;
  assign dpo[7] = \<const0> ;
  assign dpo[6] = \<const0> ;
  assign dpo[5] = \<const0> ;
  assign dpo[4] = \<const0> ;
  assign dpo[3] = \<const0> ;
  assign dpo[2] = \<const0> ;
  assign dpo[1] = \<const0> ;
  assign dpo[0] = \<const0> ;
  assign qspo[27] = \<const0> ;
  assign qspo[26] = \<const0> ;
  assign qspo[25] = \<const0> ;
  assign qspo[24] = \<const0> ;
  assign qspo[23] = \<const0> ;
  assign qspo[22] = \<const0> ;
  assign qspo[21] = \<const0> ;
  assign qspo[20] = \<const0> ;
  assign qspo[19] = \<const0> ;
  assign qspo[18] = \<const0> ;
  assign qspo[17] = \<const0> ;
  assign qspo[16] = \<const0> ;
  assign qspo[15] = \<const0> ;
  assign qspo[14] = \<const0> ;
  assign qspo[13] = \<const0> ;
  assign qspo[12] = \<const0> ;
  assign qspo[11] = \<const0> ;
  assign qspo[10] = \<const0> ;
  assign qspo[9] = \<const0> ;
  assign qspo[8] = \<const0> ;
  assign qspo[7] = \<const0> ;
  assign qspo[6] = \<const0> ;
  assign qspo[5] = \<const0> ;
  assign qspo[4] = \<const0> ;
  assign qspo[3] = \<const0> ;
  assign qspo[2] = \<const0> ;
  assign qspo[1] = \<const0> ;
  assign qspo[0] = \<const0> ;
  assign spo[27] = \<const0> ;
  assign spo[26] = \<const0> ;
  assign spo[25] = \<const0> ;
  assign spo[24] = \<const0> ;
  assign spo[23] = \<const0> ;
  assign spo[22] = \<const0> ;
  assign spo[21] = \<const0> ;
  assign spo[20] = \<const0> ;
  assign spo[19] = \<const0> ;
  assign spo[18] = \<const0> ;
  assign spo[17] = \<const0> ;
  assign spo[16] = \<const0> ;
  assign spo[15] = \<const0> ;
  assign spo[14] = \<const0> ;
  assign spo[13] = \<const0> ;
  assign spo[12] = \<const0> ;
  assign spo[11] = \<const0> ;
  assign spo[10] = \<const0> ;
  assign spo[9] = \<const0> ;
  assign spo[8] = \<const0> ;
  assign spo[7] = \<const0> ;
  assign spo[6] = \<const0> ;
  assign spo[5] = \<const0> ;
  assign spo[4] = \<const0> ;
  assign spo[3] = \<const0> ;
  assign spo[2] = \<const0> ;
  assign spo[1] = \<const0> ;
  assign spo[0] = \<const0> ;
  GND GND
       (.G(\<const0> ));
  DIST_BUFFER_64_28_dist_mem_gen_v8_0_13_synth \synth_options.dist_mem_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .dpra(dpra),
        .qdpo(qdpo),
        .we(we));
endmodule

(* ORIG_REF_NAME = "dist_mem_gen_v8_0_13_synth" *) 
module DIST_BUFFER_64_28_dist_mem_gen_v8_0_13_synth
   (qdpo,
    a,
    clk,
    d,
    dpra,
    we);
  output [27:0]qdpo;
  input [5:0]a;
  input clk;
  input [27:0]d;
  input [5:0]dpra;
  input we;

  wire [5:0]a;
  wire clk;
  wire [27:0]d;
  wire [5:0]dpra;
  wire [27:0]qdpo;
  wire we;

  DIST_BUFFER_64_28_sdpram \gen_sdp_ram.sdpram_inst 
       (.a(a),
        .clk(clk),
        .d(d),
        .dpra(dpra),
        .qdpo(qdpo),
        .we(we));
endmodule

(* ORIG_REF_NAME = "sdpram" *) 
module DIST_BUFFER_64_28_sdpram
   (qdpo,
    a,
    clk,
    d,
    dpra,
    we);
  output [27:0]qdpo;
  input [5:0]a;
  input clk;
  input [27:0]d;
  input [5:0]dpra;
  input we;

  wire [5:0]a;
  wire [5:0]a_reg;
  wire clk;
  wire [27:0]d;
  wire [27:0]d_reg;
  wire [5:0]dpra;
  (* RTL_KEEP = "true" *) wire [27:0]qsdpo_int;
  wire [27:0]sdpo_int;
  wire [5:0]sdpra_reg;
  wire we;
  wire we_reg;
  wire NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_27_27_DOB_UNCONNECTED;
  wire NLW_ram_reg_0_63_27_27_DOC_UNCONNECTED;
  wire NLW_ram_reg_0_63_27_27_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED;
  wire NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED;

  assign qdpo[27:0] = qsdpo_int;
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(a[0]),
        .Q(a_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(a[1]),
        .Q(a_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(a[2]),
        .Q(a_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(a[3]),
        .Q(a_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(a[4]),
        .Q(a_reg[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \a_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(a[5]),
        .Q(a_reg[5]),
        .R(1'b0));
  FDRE \d_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(d[0]),
        .Q(d_reg[0]),
        .R(1'b0));
  FDRE \d_reg_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(d[10]),
        .Q(d_reg[10]),
        .R(1'b0));
  FDRE \d_reg_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(d[11]),
        .Q(d_reg[11]),
        .R(1'b0));
  FDRE \d_reg_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(d[12]),
        .Q(d_reg[12]),
        .R(1'b0));
  FDRE \d_reg_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(d[13]),
        .Q(d_reg[13]),
        .R(1'b0));
  FDRE \d_reg_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(d[14]),
        .Q(d_reg[14]),
        .R(1'b0));
  FDRE \d_reg_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(d[15]),
        .Q(d_reg[15]),
        .R(1'b0));
  FDRE \d_reg_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(d[16]),
        .Q(d_reg[16]),
        .R(1'b0));
  FDRE \d_reg_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(d[17]),
        .Q(d_reg[17]),
        .R(1'b0));
  FDRE \d_reg_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(d[18]),
        .Q(d_reg[18]),
        .R(1'b0));
  FDRE \d_reg_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(d[19]),
        .Q(d_reg[19]),
        .R(1'b0));
  FDRE \d_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(d[1]),
        .Q(d_reg[1]),
        .R(1'b0));
  FDRE \d_reg_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(d[20]),
        .Q(d_reg[20]),
        .R(1'b0));
  FDRE \d_reg_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(d[21]),
        .Q(d_reg[21]),
        .R(1'b0));
  FDRE \d_reg_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(d[22]),
        .Q(d_reg[22]),
        .R(1'b0));
  FDRE \d_reg_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(d[23]),
        .Q(d_reg[23]),
        .R(1'b0));
  FDRE \d_reg_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(d[24]),
        .Q(d_reg[24]),
        .R(1'b0));
  FDRE \d_reg_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(d[25]),
        .Q(d_reg[25]),
        .R(1'b0));
  FDRE \d_reg_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(d[26]),
        .Q(d_reg[26]),
        .R(1'b0));
  FDRE \d_reg_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(d[27]),
        .Q(d_reg[27]),
        .R(1'b0));
  FDRE \d_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(d[2]),
        .Q(d_reg[2]),
        .R(1'b0));
  FDRE \d_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(d[3]),
        .Q(d_reg[3]),
        .R(1'b0));
  FDRE \d_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(d[4]),
        .Q(d_reg[4]),
        .R(1'b0));
  FDRE \d_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(d[5]),
        .Q(d_reg[5]),
        .R(1'b0));
  FDRE \d_reg_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(d[6]),
        .Q(d_reg[6]),
        .R(1'b0));
  FDRE \d_reg_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(d[7]),
        .Q(d_reg[7]),
        .R(1'b0));
  FDRE \d_reg_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(d[8]),
        .Q(d_reg[8]),
        .R(1'b0));
  FDRE \d_reg_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(d[9]),
        .Q(d_reg[9]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[0]),
        .Q(qsdpo_int[0]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[10] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[10]),
        .Q(qsdpo_int[10]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[11] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[11]),
        .Q(qsdpo_int[11]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[12] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[12]),
        .Q(qsdpo_int[12]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[13] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[13]),
        .Q(qsdpo_int[13]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[14] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[14]),
        .Q(qsdpo_int[14]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[15] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[15]),
        .Q(qsdpo_int[15]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[16] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[16]),
        .Q(qsdpo_int[16]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[17] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[17]),
        .Q(qsdpo_int[17]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[18] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[18]),
        .Q(qsdpo_int[18]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[19] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[19]),
        .Q(qsdpo_int[19]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[1]),
        .Q(qsdpo_int[1]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[20] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[20]),
        .Q(qsdpo_int[20]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[21] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[21]),
        .Q(qsdpo_int[21]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[22] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[22]),
        .Q(qsdpo_int[22]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[23] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[23]),
        .Q(qsdpo_int[23]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[24] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[24]),
        .Q(qsdpo_int[24]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[25] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[25]),
        .Q(qsdpo_int[25]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[26] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[26]),
        .Q(qsdpo_int[26]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[27] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[27]),
        .Q(qsdpo_int[27]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[2]),
        .Q(qsdpo_int[2]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[3]),
        .Q(qsdpo_int[3]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[4]),
        .Q(qsdpo_int[4]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[5]),
        .Q(qsdpo_int[5]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[6] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[6]),
        .Q(qsdpo_int[6]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[7] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[7]),
        .Q(qsdpo_int[7]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[8] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[8]),
        .Q(qsdpo_int[8]),
        .R(1'b0));
  (* KEEP = "yes" *) 
  (* equivalent_register_removal = "no" *) 
  FDRE #(
    .INIT(1'b0)) 
    \qsdpo_int_reg[9] 
       (.C(clk),
        .CE(1'b1),
        .D(sdpo_int[9]),
        .Q(qsdpo_int[9]),
        .R(1'b0));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "0" *) 
  (* ram_slice_end = "2" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_0_2
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[0]),
        .DIB(d_reg[1]),
        .DIC(d_reg[2]),
        .DID(1'b0),
        .DOA(sdpo_int[0]),
        .DOB(sdpo_int[1]),
        .DOC(sdpo_int[2]),
        .DOD(NLW_ram_reg_0_63_0_2_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "12" *) 
  (* ram_slice_end = "14" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_12_14
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[12]),
        .DIB(d_reg[13]),
        .DIC(d_reg[14]),
        .DID(1'b0),
        .DOA(sdpo_int[12]),
        .DOB(sdpo_int[13]),
        .DOC(sdpo_int[14]),
        .DOD(NLW_ram_reg_0_63_12_14_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "15" *) 
  (* ram_slice_end = "17" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_15_17
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[15]),
        .DIB(d_reg[16]),
        .DIC(d_reg[17]),
        .DID(1'b0),
        .DOA(sdpo_int[15]),
        .DOB(sdpo_int[16]),
        .DOC(sdpo_int[17]),
        .DOD(NLW_ram_reg_0_63_15_17_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "18" *) 
  (* ram_slice_end = "20" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_18_20
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[18]),
        .DIB(d_reg[19]),
        .DIC(d_reg[20]),
        .DID(1'b0),
        .DOA(sdpo_int[18]),
        .DOB(sdpo_int[19]),
        .DOC(sdpo_int[20]),
        .DOD(NLW_ram_reg_0_63_18_20_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "21" *) 
  (* ram_slice_end = "23" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_21_23
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[21]),
        .DIB(d_reg[22]),
        .DIC(d_reg[23]),
        .DID(1'b0),
        .DOA(sdpo_int[21]),
        .DOB(sdpo_int[22]),
        .DOC(sdpo_int[23]),
        .DOD(NLW_ram_reg_0_63_21_23_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "24" *) 
  (* ram_slice_end = "26" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_24_26
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[24]),
        .DIB(d_reg[25]),
        .DIC(d_reg[26]),
        .DID(1'b0),
        .DOA(sdpo_int[24]),
        .DOB(sdpo_int[25]),
        .DOC(sdpo_int[26]),
        .DOD(NLW_ram_reg_0_63_24_26_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "27" *) 
  (* ram_slice_end = "27" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_27_27
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[27]),
        .DIB(1'b0),
        .DIC(1'b0),
        .DID(1'b0),
        .DOA(sdpo_int[27]),
        .DOB(NLW_ram_reg_0_63_27_27_DOB_UNCONNECTED),
        .DOC(NLW_ram_reg_0_63_27_27_DOC_UNCONNECTED),
        .DOD(NLW_ram_reg_0_63_27_27_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "3" *) 
  (* ram_slice_end = "5" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_3_5
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[3]),
        .DIB(d_reg[4]),
        .DIC(d_reg[5]),
        .DID(1'b0),
        .DOA(sdpo_int[3]),
        .DOB(sdpo_int[4]),
        .DOC(sdpo_int[5]),
        .DOD(NLW_ram_reg_0_63_3_5_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "6" *) 
  (* ram_slice_end = "8" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_6_8
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[6]),
        .DIB(d_reg[7]),
        .DIC(d_reg[8]),
        .DID(1'b0),
        .DOA(sdpo_int[6]),
        .DOB(sdpo_int[7]),
        .DOC(sdpo_int[8]),
        .DOD(NLW_ram_reg_0_63_6_8_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  (* METHODOLOGY_DRC_VIOS = "" *) 
  (* RTL_RAM_BITS = "1792" *) 
  (* RTL_RAM_NAME = "synth_options.dist_mem_inst/gen_sdp_ram.sdpram_inst/ram" *) 
  (* ram_addr_begin = "0" *) 
  (* ram_addr_end = "63" *) 
  (* ram_offset = "0" *) 
  (* ram_slice_begin = "9" *) 
  (* ram_slice_end = "11" *) 
  RAM64M #(
    .INIT_A(64'h0000000000000000),
    .INIT_B(64'h0000000000000000),
    .INIT_C(64'h0000000000000000),
    .INIT_D(64'h0000000000000000)) 
    ram_reg_0_63_9_11
       (.ADDRA(sdpra_reg),
        .ADDRB(sdpra_reg),
        .ADDRC(sdpra_reg),
        .ADDRD(a_reg),
        .DIA(d_reg[9]),
        .DIB(d_reg[10]),
        .DIC(d_reg[11]),
        .DID(1'b0),
        .DOA(sdpo_int[9]),
        .DOB(sdpo_int[10]),
        .DOC(sdpo_int[11]),
        .DOD(NLW_ram_reg_0_63_9_11_DOD_UNCONNECTED),
        .WCLK(clk),
        .WE(we_reg));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[0] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[0]),
        .Q(sdpra_reg[0]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[1] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[1]),
        .Q(sdpra_reg[1]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[2] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[2]),
        .Q(sdpra_reg[2]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[3] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[3]),
        .Q(sdpra_reg[3]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[4] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[4]),
        .Q(sdpra_reg[4]),
        .R(1'b0));
  FDRE #(
    .INIT(1'b0)) 
    \sdpra_reg_reg[5] 
       (.C(clk),
        .CE(1'b1),
        .D(dpra[5]),
        .Q(sdpra_reg[5]),
        .R(1'b0));
  FDRE we_reg_reg
       (.C(clk),
        .CE(1'b1),
        .D(we),
        .Q(we_reg),
        .R(1'b0));
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
