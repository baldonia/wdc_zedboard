// Aaron Fienberg
// September 2020
//
// Top level module for the CUPPA WDC prototype zedboard project

module top (
	// 100 MHz input clock	
	input GCLK,

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

wire[7:0] LEDs;
assign LD0 = LEDs[0];
assign LD1 = LEDs[1];
assign LD2 = LEDs[2];
assign LD3 = LEDs[3];
assign LD4 = LEDs[4];
assign LD5 = LEDs[5];
assign LD6 = LEDs[6];
assign LD7 = LEDs[7];
knight_rider KR_0
(
	.clk(lclk),
	.rst(lclk_rst),
	.y(LEDs)
);

endmodule