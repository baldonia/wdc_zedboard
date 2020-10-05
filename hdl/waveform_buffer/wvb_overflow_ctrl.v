// Aaron Fienberg
// October 2020
//
// WDC zedboard buffer overflow controller
//

module wvb_overflow_ctrl #(parameter P_ADR_WIDTH = 15,
	                         parameter P_HDR_WIDTH = 87)
(
	input clk,
	input rst,

	output overflow,
	output[P_ADR_WIDTH:0] wvb_wused,

	input[P_ADR_WIDTH-1:0] wvb_wr_addr,
	input wvb_rddone,

	input[P_HDR_WIDTH-1:0] hdr_data,
	input hdr_full
);

// header fan out
wire[P_ADR_WIDTH-1:0] stop_addr;

cuppa_wvb_hdr_bundle_0_fan_out HDR_FAN_OUT 
(
  .bundle(hdr_data),
  .evt_ltc(),
  .start_addr(),
  .stop_addr(stop_addr),
  .trig_src(),
  .cnst_run(),
  .pre_conf()
);

reg[P_ADR_WIDTH-1:0] last_rd_addr = -1;
always @(posedge clk) begin
	if (rst) begin
		last_rd_addr <= -1;
	end

	// stop addr is the last written address of the
	// event. So, after an event has been read, the next
	// address to read is stop_addr + 1
	else if (wvb_rddone) begin
		last_rd_addr <= stop_addr;
	end
end

// overflow condition: hdr_full or wr_addr == last_rd_addr
assign overflow = hdr_full || (wvb_wr_addr == last_rd_addr);

// calculate number of words used
wire[P_ADR_WIDTH-1:0] next_rd_addr = last_rd_addr + 1;
assign wvb_wused = wvb_wr_addr - next_rd_addr;

endmodule