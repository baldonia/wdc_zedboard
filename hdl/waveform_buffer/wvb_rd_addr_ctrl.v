// Aaron Fienberg
// October 2020
//
// WDC zedboard buffer rd addr controller
//

module wvb_rd_addr_ctrl #(parameter P_ADR_WIDTH = 15,
                          parameter P_HDR_WIDTH = 87)
(
	input clk,
	input rst,

	input[P_HDR_WIDTH-1:0] hdr_data,
	input hdr_rdreq,
	input wvb_rdreq,
	input wvb_rddone,

	output reg[P_ADR_WIDTH-1:0] wvb_rd_addr = 0
);

// header fan out
wire[P_ADR_WIDTH-1:0] start_addr;
wire[P_ADR_WIDTH-1:0] stop_addr;

cuppa_wvb_hdr_bundle_0_fan_out HDR_FAN_OUT 
(
	.bundle(hdr_data),
	.evt_ltc(),
	.start_addr(start_addr),
	.stop_addr(stop_addr),
	.trig_src(),
	.cnst_run(),
	.pre_conf()
);


// determines delay between hdr_rdreq and 
// start addr updating
localparam HDR_WAIT_CNT = 2;

reg[2:0] hdr_rd_cnt = 0;
always @(posedge clk) begin
	if (rst) begin
		hdr_rd_cnt <= 0;
	end

	else begin
		if (hdr_rdreq) begin
			hdr_rd_cnt <= 1;
		end

		else if (hdr_rd_cnt >= HDR_WAIT_CNT) begin
			hdr_rd_cnt <= 0;
		end

		else if (hdr_rd_cnt > 0 && 
			       (hdr_rd_cnt < HDR_WAIT_CNT))  begin
			hdr_rd_cnt <= hdr_rd_cnt + 1;
		end
	end
end

// process to update wvb_rd_addr
always @(posedge clk) begin
	if (rst) begin
		wvb_rd_addr <= -1;
	end

	else begin

		if (hdr_rd_cnt == HDR_WAIT_CNT) begin
			wvb_rd_addr <= start_addr;
		end

		else if ((hdr_rd_cnt == 0) && wvb_rdreq) begin
			wvb_rd_addr <= wvb_rd_addr + 1;
		end

		else if (wvb_rddone) begin
			wvb_rd_addr <= stop_addr + 1;
		end

	end

end

endmodule