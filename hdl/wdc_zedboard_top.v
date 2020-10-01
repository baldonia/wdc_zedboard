// Aaron Fienberg
// September 2020
//
// Top level module for the CUPPA WDC prototype zedboard project

module top (
  // 100 MHz input clock  
  input GCLK,

  // ADC 0 input clock
  input DIG0_CLKOUT_P,
  input DIG0_CLKOUT_N,

  // ADC 1 input 
  input DIG1_CLKOUT_P,
  input DIG1_CLKOUT_N,

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
  // output DIG_OE, ATF: leaving this out should leave ADC outputs always enabled 
  input DIG0_OVR_SDOUT,
  input DIG1_OVR_SDOUT
);

localparam[15:0] FW_VNUM = 16'h5;

// PLL for ADC 0 input clock
wire i_dig0_clk;
wire i_dig1_clk;
IBUFGDS #(.DIFF_TERM(1)) IBUFGDS_DIG0(.I(DIG0_CLKOUT_P), .IB(DIG0_CLKOUT_N), .O(i_dig0_clk));
IBUFGDS #(.DIFF_TERM(1)) IBUFGDS_DIG1(.I(DIG1_CLKOUT_P), .IB(DIG1_CLKOUT_N), .O(i_dig1_clk));
wire clk_245_76_MHz;
wire clk_122_88_MHz;
wire dig0_pll_locked;
DIG0_MMCM dig0_mmcm_0
(
  .clk_in1(i_dig1_clk),
  .reset(1'b0),
  .locked(dig0_pll_locked),
  .clk_245_76_MHz(clk_245_76_MHz),
  .clk_122_88_MHz(clk_122_88_MHz)
);

assign LD0 = dig0_pll_locked;
assign LD1 = !dig0_pll_locked;

wire clk_125MHz;
wire ref_clk;
wire enc_clk;
wire lclk_mmcm_locked;
LCLK_MMCM lclk_mmcm_0
(
  .clk_in1(GCLK),
  .clk_125MHz(clk_125MHz),
  .clk_200MHz(ref_clk),
  .clk_250MHz(enc_clk),
  .reset(1'b0),
  .locked(lclk_mmcm_locked)  
);

assign lclk = clk_125MHz;
wire lclk_rst = !lclk_mmcm_locked;

assign LD2 = lclk_mmcm_locked;
assign LD3 = !lclk_mmcm_locked;

// assign lclk = clk_122_88_MHz;
// assign lclk_rst = dig0_pll_locked;

/////////////////////////////////////////////////////////////////////////
// cuppa register interface
// Addressing:
//     12'hfff: Version/build number
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
//     12'8ff: LED toggle

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

  .led_toggle(led_toggle),

  .debug_txd(UART_TXD),
  .debug_rxd(UART_RXD),
  .debug_rts_n(1'b0),
  .debug_cts_n()
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
  .rst     (lclk_rst),
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
// LTC2612 DAC controls
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
  .rst     (lclk_rst),
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
// tie DIG_DFS to 0 to get twos complement DDR LVDS
assign DIG_DFS = 0;
// set DIG_OE to high impedence
// assign DIG_OE = 1'bz;
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