// Aaron Fienberg
// October 2020
//
// WDC zedboard prototype waveform buffer storage
//

module waveform_buffer_storage #(parameter P_DATA_WIDTH = 28,
	                               parameter P_ADR_WIDTH = 15,
	                               parameter P_HDR_WIDTH = 87,
	                               parameter P_N_WVF_IN_BUF_WIDTH = 10)
(
	input clk,
	input rst,

	output[P_DATA_WIDTH-1:0] wvb_data_out,
	output[P_HDR_WIDTH-1:0] hdr_data_out,
	output hdr_full,
	output hdr_empty,
	output[P_N_WVF_IN_BUF_WIDTH-1:0] n_wvf_in_buf,

	input eoe_in,
	input[P_DATA_WIDTH-1:0] wvb_data_in,
	input[P_ADR_WIDTH-1:0] wvb_wr_addr,
	input[P_ADR_WIDTH-1:0] wvb_rd_addr,
  input wvb_wrreq,
  input[P_HDR_WIDTH-1:0] hdr_data_in,
  input hdr_wrreq,
  input hdr_rdreq
);

wire[P_DATA_WIDTH-1:0] buff_din = {wvb_data_in[P_DATA_WIDTH-1:1], eoe_in};

wire[9:0] hdr_data_cnt;
generate

  if (P_ADR_WIDTH == 15 && P_HDR_WIDTH == 87 && P_DATA_WIDTH == 28) begin
    BUFFER_32K_28 WAVEFORM_BUFFER 
      ( 
       .clka(clk),
       .wea(wvb_wrreq),
       .addra(wvb_wr_addr),
       .dina(buff_din),
       .clkb(clk),
       .addrb(wvb_rd_addr),
       .doutb(wvb_data_out)
      );
    
    FIFO_1024_87 HDR_FIFO_FMT_0 
     (
       .clk(clk),
       .srst(rst),
       .din(hdr_data_in),
       .wr_en(hdr_wrreq),
       .rd_en(hdr_rdreq),
       .dout(hdr_data_out),
       .full(hdr_full),
       .empty(hdr_empty),
       .data_count(hdr_data_cnt)
     );
    
    assign n_wvf_in_buf = hdr_full ? 10'd1023 : hdr_data_cnt;

  end

  else begin
    invalid_p_adr_width invalid_module_conf();
  end


endgenerate

endmodule	                               