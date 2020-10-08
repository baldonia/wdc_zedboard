// Aaron Fienberg
// September 2020
//
// Top level module for the CUPPA WDC prototype zedboard project

module top (
  // 100 MHz input clock  
  input GCLK,

  // ADC 0 
  // from ADC
  input DIG0_CLKOUT_P,
  input DIG0_CLKOUT_N,
  input DIG0_D0_D1_P,
  input DIG0_D2_D3_P,
  input DIG0_D4_D5_P,
  input DIG0_D6_D7_P,
  input DIG0_D8_D9_P,
  input DIG0_D10_D11_P,  
  input DIG0_D0_D1_N,
  input DIG0_D2_D3_N,
  input DIG0_D4_D5_N,
  input DIG0_D6_D7_N,
  input DIG0_D8_D9_N,
  input DIG0_D10_D11_N,

  // to ADC
  output DIG0_CLK_P,
  output DIG0_CLK_N,

  // ADC 1 
  // from ADC
  input DIG1_CLKOUT_P,
  input DIG1_CLKOUT_N,
  // to ADC
  output DIG1_CLK_P,
  output DIG1_CLK_N,

  // USB UART signals
  output UART_RXD,
  input UART_TXD,

  // User LEDs
  output LD0,
  output LD1,
  output LD2,
  output LD3,
  output LD4,
  output LD5,
  output LD6,
  output LD7,

  // WDC DAC controls
  output DAC0_CSn,
  output DAC1_CSn,
  output DAC_SCK,
  output DAC_SDI,

  // ADC serial interface
  output DIG0_SEN,
  output DIG1_SEN,
  output DIG_SCK,
  output DIG_SDATA,
  output DIG_RESET,
  output DIG_DFS,
  output DIG_OE,
  input DIG0_OVR_SDOUT,
  input DIG1_OVR_SDOUT
);
`include "cuppa_trig_bundle_inc.v"
`include "cuppa_wvb_conf_bundle_inc.v"


localparam N_CHANNELS = 2;
localparam[15:0] FW_VNUM = 16'ha;

localparam P_WVB_DATA_WIDTH = 28;
localparam P_HDR_WIDTH = 87;
localparam P_WVB_ADR_WIDTH = 15;

// PLL for ADC 0 input clock
wire i_dig0_clk;
wire i_dig1_clk;
IBUFGDS #(.DIFF_TERM("TRUE")) IBUFGDS_DIG0(.I(DIG0_CLKOUT_P), .IB(DIG0_CLKOUT_N), .O(i_dig0_clk));
IBUFGDS #(.DIFF_TERM("TRUE")) IBUFGDS_DIG1(.I(DIG1_CLKOUT_P), .IB(DIG1_CLKOUT_N), .O(i_dig1_clk));
wire clk_245_76_MHz;
wire clk_122_88_MHz;
wire dig0_pll_locked;
DIG0_MMCM dig0_mmcm_0
(
  .clk_in1(i_dig0_clk),
  .reset(1'b0),
  .locked(dig0_pll_locked),
  .clk_245_76_MHz(clk_245_76_MHz),
  .clk_122_88_MHz(clk_122_88_MHz)
);

assign LD0 = dig0_pll_locked;
assign LD1 = !dig0_pll_locked;

wire clk_125MHz;
wire ref_clk;
wire enc_clk0;
wire enc_clk1;
wire lclk_mmcm_locked;
LCLK_MMCM lclk_mmcm_0
(
  .clk_in1(GCLK),
  .clk_125MHz(clk_125MHz),
  .clk_200MHz(ref_clk),
  .clk_250MHz(enc_clk0),
  .clk_250MHz_180(enc_clk1),
  .reset(1'b0),
  .locked(lclk_mmcm_locked)  
);

wire   idelayctrl_rdy; 
IDELAYCTRL delayctrl(.RDY(idelayctrl_rdy),
                     .REFCLK(ref_clk),
                     .RST(!lclk_mmcm_locked));
assign LD3 = idelayctrl_rdy;

// forward encoder clocks to ADCs
wire i_dig0_clk_out;
ODDR #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"),
       .INIT(1'b0),
       .SRTYPE("SYNC")
     )
 clk_forward_0
 (
   .Q(i_dig0_clk_out),
   .C(enc_clk0),
   .D1(1'b0),
   .D2(1'b1),
   .CE(1'b1),
   .R(1'b0),
   .S(1'b0)
 );
OBUFDS obuf_dig_clock_0(.I(i_dig0_clk_out), .O(DIG0_CLK_P), .OB(DIG0_CLK_N));

wire i_dig1_clk_out;
ODDR #(
       .DDR_CLK_EDGE("OPPOSITE_EDGE"),
       .INIT(1'b0),
       .SRTYPE("SYNC")
     )
 clk_forward_1
 (
   .Q(i_dig1_clk_out),
   .C(enc_clk1),
   .D1(1'b0),
   .D2(1'b1),
   .CE(1'b1),
   .R(1'b0),
   .S(1'b0)
 );
OBUFDS obuf_dig_clock_1(.I(i_dig1_clk_out), .O(DIG1_CLK_P), .OB(DIG1_CLK_N));

// assign lclk = clk_125MHz;
// wire lclk_rst = !lclk_mmcm_locked;

assign LD2 = lclk_mmcm_locked;
// assign LD3 = !lclk_mmcm_locked;

assign lclk = clk_122_88_MHz;
wire lclk_rst = !dig0_pll_locked;

/////////////////////////////////////////////////////////////////////////
// cuppa register interface
// Addressing:
//     12'hfff: Version/build number
//     12'hffe: DIG 0 trig settings
//             [0] et
//             [1] gt
//             [2] lt
//             [3] thresh_trig_en
//             [4] ext_trig_en
//     12'hffd: DIG 0 trig threshold [11:0]
//     12'hffc: 
//             [i] sw_trig (channel i, up to 1)
//     12'hffb: DIG 0
//             [0] trig_mode
//     12'hffa:
//             [i] trig_arm (channel i)
//     12'hff9:
//             [i] trig_armed (channel i)
//     12'hff8: DIG 0
//             [0] cnst_run
//     12'hff7: DIG 0 const config [14:0]
//     12'hff6: DIG 0 test config  [14:0]
//     12'hff5: DIG 0 post config [14:0] 
//     12'hff4: DIG 0 pre config [5:0]
//     12'hefe: DIG 1 trig settings
//             [0] et
//             [1] gt
//             [2] lt
//             [3] thresh_trig_en
//             [4] ext_trig_en
//     12'hefd: DIG 1 trig threshold [11:0]
//     12'hefb: DIG 1
//             [0] trig_mode
//     12'hef8: DIG 1
//             [0] cnst_run
//     12'hef7: DIG 1 const config [14:0]
//     12'hef6: DIG 1 test config  [14:0]
//     12'hef5: DIG 1 post config [14:0] 
//     12'hef4: DIG 1 pre config [5:0]
//     12'hdff: dpram_len [10:0]
//     12'hdfe: 
//             [0] dpram_done  
//     12'hdfd: 
//             [0] dpram_sel (0: scratch dpram, 1: direct rdout (rd only))       
//     12'hdfc: DIG 0 n_waveforms in waveform buffer
//     12'hdfb: DIG 0 words used in waveform buffer
//     12'hdfa: waveform buffer overflow [1:0] (DIG 1, DIG 0)
//     12'hdf9: waveform buffer reset [1:0] (DIG 1, DIG 0)
//     12'hdf8: wvb_reader enable 
//     12'hdf7: wvb_reader dpram mode 
//     12'hdf6: wvb header full ([i] for channel i, up to 1)
//     12'hdf5: DIG 1 n_waveforms in waveform buffer
//     12'hdf4: DIG 1 words used in waveform buffer
// 
//     12'hbff: [0] DAC spi chip select (0 or 1)
//     12'hbfe: [0] DAC spi task reg
//     12'hbfd: [7:0] DAC spi wr data [23:16]
//     12'hbfc: [15:0] DAC spi wr data [15:0]
//
//     12'hbef: [0] dig spi chip select (0 or 1)
//     12'hbee: [0] dig spi task reg
//     12'hbed: [15:0] dig spi wr data
//     12'hbec: [7:0] dig spi rd data
//
//     12'hbdf: [0] dig_0 IO reset (defaults to 1)
//     12'hbde: [0] dig_0 delay reset
//     12'hbdd: DIG 0 IO tuning
//              [0] delay_inc
//              [1] delay_ce (resets automatically)
//              [2] bitslip (resets automatically)
//     12'hbdc: [13:0] DIG 0 delay tap out [29:16]
//     12'hbdb: DIG 0 delay tap out [15:0]
// 
//     12'8ff: LED toggle
//     12'8fe: dig 0 lock PE count
//     12'8fd: rst dig 0 lock PE
//     12'8fc: spi reset (resets DAC & ADC SPI masters)

wire led_toggle;

// LTC2612 DAC controls
wire        dac_spi_ack;
wire        dac_spi_wr_req;
wire [23:0] dac_spi_wr_data;
wire        dac_sel;

// ADC serial interface
wire        dig_spi_ack;
wire        dig_spi_req;
wire [15:0] dig_spi_wr_data;
wire [7:0]  dig_spi_rd_data;
wire        dig_sel;

// DIG 0 lvds IO
wire io_reset_0;
wire[5:0] bitslip_0;
wire in_delay_reset_0;
wire[5:0] in_delay_ce_0;
wire[5:0] in_delay_inc_0;
wire[29:0] in_delay_tap_out_0; 

// Dig 0 trigger / wvb conf
wire[L_WIDTH_CUPPA_TRIG_BUNDLE-1:0] cuppa_trig_bundle_0;
wire[L_WIDTH_CUPPA_TRIG_BUNDLE-1:0] cuppa_trig_bundle_1;
wire[L_WIDTH_CUPPA_WVB_CONF_BUNDLE-1:0] cuppa_wvb_conf_bundle_0;
wire[L_WIDTH_CUPPA_WVB_CONF_BUNDLE-1:0] cuppa_wvb_conf_bundle_1;

// Acquisition controls / status
wire[N_CHANNELS-1:0] cuppa_wvb_rst;
wire[N_CHANNELS-1:0] cuppa_wvb_armed;
wire[N_CHANNELS-1:0] cuppa_wvb_overflow;
wire[N_CHANNELS-1:0] cuppa_wvb_hdr_full; 

wire[15:0] cuppa_wvb_wused_0;
wire[15:0] cuppa_wvb_wused_1;
wire[9:0] cuppa_wvb_n_wvf_in_buf_0;
wire[9:0] cuppa_wvb_n_wvf_in_buf_1;

// wvb reader
wire[15:0] rdout_dpram_len;
wire rdout_dpram_run;
wire rdout_dpram_busy;
wire rdout_dpram_wren;
wire[9:0] rdout_dpram_wr_addr;
wire[31:0] rdout_dpram_data;
wire wvb_reader_enable;
wire wvb_reader_dpram_mode;

wire spi_rst;

cuppa CUPPA_0
(
  .clk(lclk),
  .rst(lclk_rst),
  .vnum(FW_VNUM),

  // DAC control
  .dac_sel(dac_sel),
  .dac_spi_wr_req(dac_spi_wr_req),
  .dac_spi_ack(dac_spi_ack),
  .dac_spi_wr_data(dac_spi_wr_data),

  // ADC digitizer serial control
  .dig_sel(dig_sel),
  .dig_spi_req(dig_spi_req),
  .dig_spi_ack(dig_spi_ack),
  .dig_spi_wr_data(dig_spi_wr_data),
  .dig_spi_rd_data(dig_spi_rd_data),

  // dig 0 LVDS IO
  .io_reset_0(io_reset_0),
  .bitslip_0(bitslip_0),
  .in_delay_reset_0(in_delay_reset_0),
  .in_delay_ce_0(in_delay_ce_0),
  .in_delay_inc_0(in_delay_inc_0),
  .in_delay_tap_out_0(in_delay_tap_out_0),

  // trig / wvb conf
  .trig_bundle_0(cuppa_trig_bundle_0),
  .trig_bundle_1(cuppa_trig_bundle_1),
  .wvb_conf_bundle_0(cuppa_wvb_conf_bundle_0),
  .wvb_conf_bundle_1(cuppa_wvb_conf_bundle_1),
  .wvb_rst(cuppa_wvb_rst),
  .wvb_armed(cuppa_wvb_armed),
  .wvb_overflow(cuppa_wvb_overflow),
  .wvb_hdr_full(cuppa_wvb_hdr_full),
  .wvb_n_wvf_in_buf_0(cuppa_wvb_n_wvf_in_buf_0),
  .wvb_n_wvf_in_buf_1(cuppa_wvb_n_wvf_in_buf_1),
  .wvb_wused_0(cuppa_wvb_wused_0),
  .wvb_wused_1(cuppa_wvb_wused_1),

  // wvb reader
  .dpram_len_in(rdout_dpram_len),
  .rdout_dpram_run(rdout_dpram_run),
  .dpram_busy(rdout_dpram_busy),
  .rdout_dpram_wren(rdout_dpram_wren),
  .rdout_dpram_wr_addr(rdout_dpram_wr_addr),
  .rdout_dpram_data(rdout_dpram_data),
  .wvb_reader_enable(wvb_reader_enable),
  .wvb_reader_dpram_mode(wvb_reader_dpram_mode),

  .dig0_mmcm_locked(dig0_pll_locked),

  .led_toggle(led_toggle),

  .spi_rst(spi_rst),

  .debug_txd(UART_TXD),
  .debug_rxd(UART_RXD),
  .debug_rts_n(1'b0),
  .debug_cts_n()
);

//
// LTC counter
//
reg[47:0] ltc = 0;
always @(posedge lclk) begin
  if (lclk_rst) begin
    ltc <= 0;
  end

  else begin
    ltc <= ltc + 1;
  end
end

// 
// fake data generation
// 
// to be replaced with SERDES + idelay, etc
wire[11:0] adc_stream_0_0;
wire[11:0] adc_stream_1_0;
// data_gen #(.P_ADC_RAMP_START(0)) FAKE_CHAN_0
//  (
//   .clk(lclk),
//   .rst(lclk_rst || cuppa_wvb_rst[0]),
//   .adc_stream_0(adc_stream_0_0),
//   .adc_stream_1(adc_stream_1_0)
//  );

// real data for channel 0
ads4129_lvds DIG0_LVDS
(
  .clk(lclk),
  .dclk(clk_245_76_MHz),
  .rst(lclk_rst || cuppa_wvb_rst[0]),

  .data_p({DIG0_D10_D11_P,
           DIG0_D8_D9_P,
           DIG0_D6_D7_P,
           DIG0_D4_D5_P,
           DIG0_D2_D3_P,
           DIG0_D0_D1_P}),

  .data_n({DIG0_D10_D11_N,
           DIG0_D8_D9_N,
           DIG0_D6_D7_N,
           DIG0_D4_D5_N,
           DIG0_D2_D3_N,
           DIG0_D0_D1_N}),

  .sample_0(adc_stream_0_0),
  .sample_1(adc_stream_1_0),

  .io_reset(io_reset_0),
  .bitslip(bitslip_0),
  .in_delay_reset(in_delay_reset_0),
  .in_delay_ce(in_delay_ce_0),
  .in_delay_inc(in_delay_inc_0),
  .in_delay_tap_out(in_delay_tap_out_0)
);

// to be replaced with SERDES + idelay, etc
wire[11:0] adc_stream_0_1;
wire[11:0] adc_stream_1_1;
data_gen #(.P_ADC_RAMP_START(1)) FAKE_CHAN_1
 (
  .clk(lclk),
  .rst(lclk_rst || cuppa_wvb_rst[1]),
  .adc_stream_0(adc_stream_0_1),
  .adc_stream_1(adc_stream_1_1)
 );

// Waveform acquisition modules

wire[N_CHANNELS-1:0] wvb_hdr_empty;
wire[N_CHANNELS-1:0] wvb_hdr_rdreq;
wire[N_CHANNELS-1:0] wvb_wvb_rdreq;
wire[N_CHANNELS-1:0] wvb_rddone;
wire[N_CHANNELS*P_WVB_DATA_WIDTH-1:0] wvb_data_out;
wire[N_CHANNELS*P_HDR_WIDTH-1:0] wvb_hdr_data;

waveform_acquisition #(.P_DATA_WIDTH(P_WVB_DATA_WIDTH),
                       .P_ADR_WIDTH(P_WVB_ADR_WIDTH),
                       .P_HDR_WIDTH(P_HDR_WIDTH)) 
WFM_ACQ_0
(
  .clk(lclk),
  .rst(lclk_rst || cuppa_wvb_rst[0]),
  
  // WVB reader interface
  .wvb_data_out(wvb_data_out[P_WVB_DATA_WIDTH*(0+1)-1:P_WVB_DATA_WIDTH*0]),
  .wvb_hdr_data_out(wvb_hdr_data[P_HDR_WIDTH*(0+1)-1:P_HDR_WIDTH*0]),  
  .wvb_hdr_full(cuppa_wvb_hdr_full[0]),
  .wvb_hdr_empty(wvb_hdr_empty[0]),
  .wvb_n_wvf_in_buf(cuppa_wvb_n_wvf_in_buf_0),
  .wvb_wused(cuppa_wvb_wused_0), 
  .wvb_hdr_rdreq(wvb_hdr_rdreq[0]), 
  .wvb_wvb_rdreq(wvb_wvb_rdreq[0]), 
  .wvb_wvb_rddone(wvb_rddone[0]), 
  
  // datastream
  .adc_samp_0_0(adc_stream_0_0),
  .adc_samp_1_0(adc_stream_1_0),

  // Local time counter
  .ltc_in(ltc), 
  
  // External
  .ext_trig_in(1'b0),
  .wvb_trig_out(),
  .wvb_trig_test_out(),

  // cuppa interface
  .cuppa_wvb_trig_bundle(cuppa_trig_bundle_0),
  .cuppa_wvb_config_bundle(cuppa_wvb_conf_bundle_0),  
  .cuppa_wvb_armed(cuppa_wvb_armed[0]), 
  .cuppa_wvb_overflow(cuppa_wvb_overflow[0])
);

waveform_acquisition #(.P_DATA_WIDTH(P_WVB_DATA_WIDTH),
                       .P_ADR_WIDTH(P_WVB_ADR_WIDTH),
                       .P_HDR_WIDTH(P_HDR_WIDTH))
WFM_ACQ_1
(
  .clk(lclk),
  .rst(lclk_rst || cuppa_wvb_rst[1]),
  
  // WVB reader interface
  .wvb_data_out(wvb_data_out[P_WVB_DATA_WIDTH*(1+1)-1:P_WVB_DATA_WIDTH*1]),
  .wvb_hdr_data_out(wvb_hdr_data[P_HDR_WIDTH*(1+1)-1:P_HDR_WIDTH*1]),  
  .wvb_hdr_full(cuppa_wvb_hdr_full[1]),
  .wvb_hdr_empty(wvb_hdr_empty[1]),
  .wvb_n_wvf_in_buf(cuppa_wvb_n_wvf_in_buf_1),
  .wvb_wused(cuppa_wvb_wused_1), 
  .wvb_hdr_rdreq(wvb_hdr_rdreq[1]), 
  .wvb_wvb_rdreq(wvb_wvb_rdreq[1]), 
  .wvb_wvb_rddone(wvb_rddone[1]), 
  
  // datastream
  .adc_samp_0_0(adc_stream_0_1),
  .adc_samp_1_0(adc_stream_1_1),

  // Local time counter
  .ltc_in(ltc), 
  
  // External
  .ext_trig_in(1'b0),
  .wvb_trig_out(),
  .wvb_trig_test_out(),

  // cuppa interface
  .cuppa_wvb_trig_bundle(cuppa_trig_bundle_1),
  .cuppa_wvb_config_bundle(cuppa_wvb_conf_bundle_1),  
  .cuppa_wvb_armed(cuppa_wvb_armed[1]), 
  .cuppa_wvb_overflow(cuppa_wvb_overflow[1])
);

// use LEDs for coarse buffer status indicators
assign LD4 = !wvb_hdr_empty[0];
assign LD5 = cuppa_wvb_overflow[0];
assign LD6 = !wvb_hdr_empty[1];
assign LD7 = cuppa_wvb_overflow[1];

//
// Waveform buffer reader
// 

wvb_reader #(.N_CHANNELS(N_CHANNELS),
             .P_DATA_WIDTH(P_WVB_DATA_WIDTH),
             .P_WVB_ADR_WIDTH(P_WVB_ADR_WIDTH),
             .P_HDR_WIDTH(P_HDR_WIDTH))
WVB_READER 
(
  .clk(lclk),
  .rst(lclk_rst),
  .en(wvb_reader_enable),

  // dpram interface 
  .dpram_data(rdout_dpram_data),
  .dpram_addr(rdout_dpram_wr_addr),
  .dpram_wren(rdout_dpram_wren),
  .dpram_len(rdout_dpram_len),
  .dpram_run(rdout_dpram_run),
  .dpram_busy(rdout_dpram_busy),
  .dpram_mode(wvb_reader_dpram_mode),

  // wvb interface
  .hdr_rdreq(wvb_hdr_rdreq),
  .wvb_rdreq(wvb_wvb_rdreq),
  .wvb_rddone(wvb_rddone),
  .wvb_data(wvb_data_out),
  .hdr_data(wvb_hdr_data),
  .hdr_empty(wvb_hdr_empty)
);

//
// LTC2612 DAC controls
//
wire        dac_spi_mosi;
wire        dac_spi_sclk; 
spi_master #(.P_RD_DATA_WIDTH(24),.P_WR_DATA_WIDTH(24)) DAC_SPI
 (
  // Outputs
  .rd_data (),
  .ack     (dac_spi_ack),
  .mosi    (dac_spi_mosi),
  .sclk    (dac_spi_sclk),
  // Inputs
  .clk     (lclk),
  .rst     (lclk_rst || spi_rst),
  // MOSI
  .nb_mosi (8'd24),
  .y0_mosi (1'b0),
  .n0_mosi (32'd1),
  .n1_mosi (32'd300),
  // MISO
  .nb_miso (8'd24),
  .n0_miso (32'd150),
  .n1_miso (32'd150),
  // SCLK
  .nb_sclk (8'd24),
  .y0_sclk (1'b0),
  .n0_sclk (32'd150),
  .n1_sclk (32'd150),
  .n2_sclk (32'd150),
  .wr_req  (dac_spi_wr_req),
  .wr_data (dac_spi_wr_data),
  .rd_req  (1'b0),
  .miso    (1'b0)
);
// associated output signal assignments
assign DAC0_CSn = !(dac_spi_wr_req && (dac_sel == 0));
assign DAC1_CSn = !(dac_spi_wr_req && (dac_sel == 1));
assign DAC_SCK = dac_spi_sclk;
assign DAC_SDI = dac_spi_mosi;

//
// ADS4129 serial controls
//
wire        dig_spi_mosi;
wire        dig_spi_miso;
wire        dig_spi_sclk;
spi_master #(.P_RD_DATA_WIDTH(8),.P_WR_DATA_WIDTH(16)) DIG_SPI
(
  // Outputs
  .rd_data (dig_spi_rd_data),
  .ack     (dig_spi_ack),
  .mosi    (dig_spi_mosi),
  .sclk    (dig_spi_sclk),
  // Inputs
  .clk     (lclk),
  .rst     (lclk_rst || spi_rst),
  // MOSI
  .nb_mosi (8'd16),
  .y0_mosi (1'b0),
  .n0_mosi (1),
  .n1_mosi (60),
  // MISO
  .nb_miso (8'd8),
  .n0_miso (450),
  .n1_miso (60),
  // SCLK
  .nb_sclk (8'd16),
  .y0_sclk (1'b1),
  .n0_sclk (30),
  .n1_sclk (30),
  .n2_sclk (30),
  .wr_req  (dig_spi_req),
  .wr_data (dig_spi_wr_data),
  .rd_req  (dig_spi_req),
  .miso    (dig_spi_miso)
); 
// associated input/output signal assignments
assign DIG0_SEN = !(dig_spi_req && (dig_sel == 0));
assign DIG1_SEN = !(dig_spi_req && (dig_sel == 1));
assign DIG_SCK = dig_spi_sclk;
assign DIG_SDATA = dig_spi_mosi;

assign dig_spi_miso = dig_sel == 0 ? DIG0_OVR_SDOUT : DIG1_OVR_SDOUT;
// for now hold reset at 0 
// (could add it to reg interface, but datasheet indicates that SW reset is sufficient)
assign DIG_RESET = 0;
// set DIG_DFS to 1'bz
assign DIG_DFS = 1'bz;
// drive DIG_OE high
assign DIG_OE = 1'b1;
// (leaving it out of the project entirely should work?)

//
// LED controls
//

// wire[7:0] LEDs;
// assign LD0 = led_toggle && LEDs[0];
// assign LD1 = led_toggle && LEDs[1];
// assign LD2 = led_toggle && LEDs[2];
// assign LD3 = led_toggle && LEDs[3];
// assign LD4 = led_toggle && LEDs[4];
// assign LD5 = led_toggle && LEDs[5];
// assign LD6 = led_toggle && LEDs[6];
// assign LD7 = led_toggle && LEDs[7];
// knight_rider KR_0
// (
//   .clk(lclk),
//   .rst(lclk_rst),
//   .y(LEDs)
// );

endmodule