// Aaron Fienberg
// September 2020
//
// Top level module for the CUPPA WDC prototype zedboard project

module top (
  // 100 MHz input clock  
  input GCLK,

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
  output LD7
);

localparam[15:0] FW_VNUM = 16'h1;

wire lclk;
wire ref_clk;
wire enc_clk;
wire lclk_mmcm_locked;
LCLK_MMCM lclk_mmcm_0
(
  .clk_in1(GCLK),
  .clk_125MHz(lclk),
  .clk_200MHz(ref_clk),
  .clk_250MHz(enc_clk),
  .reset(1'b0),
  .locked(lclk_mmcm_locked)  
);
wire lclk_rst = !lclk_mmcm_locked;

/////////////////////////////////////////////////////////////////////////
// cuppa register interface
// Addressing:
//     12'hfff: Version/build number
//     12'8ff: LED toggle

wire led_toggle;

cuppa CUPPA_0
(
  .clk(lclk),
  .rst(lclk_rst),
  .vnum(FW_VNUM),
  .led_toggle(led_toggle),
  .debug_txd(UART_TXD),
  .debug_rxd(UART_RXD),
  .debug_rts_n(1'b0),
  .debug_cts_n()
);

wire[7:0] LEDs;
assign LD0 = led_toggle && LEDs[0];
assign LD1 = led_toggle && LEDs[1];
assign LD2 = led_toggle && LEDs[2];
assign LD3 = led_toggle && LEDs[3];
assign LD4 = led_toggle && LEDs[4];
assign LD5 = led_toggle && LEDs[5];
assign LD6 = led_toggle && LEDs[6];
assign LD7 = led_toggle && LEDs[7];
knight_rider KR_0
(
  .clk(lclk),
  .rst(lclk_rst),
  .y(LEDs)
);

endmodule