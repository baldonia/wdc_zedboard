// Aaron Fienberg
// October 2020
//
// WDC zedboard prototype wfm buffer module 
//

module waveform_buffer 
#(
   parameter P_DATA_WIDTH = 28,
   parameter P_ADR_WIDTH = 15,
   parameter P_HDR_WIDTH = 87,
   parameter P_LTC_WIDTH = 48,
   parameter P_N_WVF_IN_BUF_WIDTH = 10,
   parameter P_CONST_CONF_WIDTH = 15,
   parameter P_TEST_CONF_WIDTH = 15,
   parameter P_PRE_CONF_WIDTH = 6,
   parameter P_POST_CONF_WIDTH = 15
 )
(
  input clk,
  input rst,
  
  // Outputs
  output[P_ADR_WIDTH:0] wvb_wused,
  output[P_N_WVF_IN_BUF_WIDTH-1:0] n_wvf_in_buf,
  output wvb_overflow,
  output armed,
  output[P_DATA_WIDTH-1:0] wvb_data_out,
  output[P_HDR_WIDTH-1:0] hdr_data_out,
  output hdr_full,
  output hdr_empty,

  // Inputs
  input[P_LTC_WIDTH-1:0] ltc_in,
  input[P_DATA_WIDTH-1:0] stream_in,
  input trig,
  input[1:0] trig_src,
  input arm,

  input wvb_rdreq,
  input hdr_rdreq,
  input wvb_rddone,

  // Config inputs
  input[P_PRE_CONF_WIDTH-1:0] pre_conf,
  input[P_POST_CONF_WIDTH-1:0] post_conf,
  input[P_TEST_CONF_WIDTH-1:0] test_conf,
  input[P_CONST_CONF_WIDTH-1:0] cnst_conf,
  input cnst_run,
  input trig_mode
);

// register synchronous reset
(* DONT_TOUCH = "true"*) reg i_rst = 0;
always @(posedge clk) begin
  i_rst <= rst;
end

// pretrigger buffer
wire [P_DATA_WIDTH-1:0] ptb_out;
wire ptb_rdy;
pretrigger_buffer #(.P_PRE_CONF_WIDTH(P_PRE_CONF_WIDTH), 
                    .P_DATA_WIDTH(P_DATA_WIDTH),
                    .P_USE_DISTRIBUTED_RAM(1))
 PTB
  (
   .clk(clk),
   .rst(i_rst),
   .stream_in(stream_in),
   .rdy(ptb_rdy),
   .ptb_out(ptb_out),
   .size_config(pre_conf)
  );
 
// WVB storage
wire [P_ADR_WIDTH-1:0]  wvb_wr_addr;
wire [P_ADR_WIDTH-1:0]  wvb_rd_addr;
wire      wvb_wrreq; 
wire [P_HDR_WIDTH-1:0]  hdr_data_in;
wire      hdr_wrreq; 
wire                    eoe; 
waveform_buffer_storage 
  #(
    .P_DATA_WIDTH(P_DATA_WIDTH),
    .P_ADR_WIDTH(P_ADR_WIDTH),
    .P_HDR_WIDTH(P_HDR_WIDTH),
    .P_N_WVF_IN_BUF_WIDTH(P_N_WVF_IN_BUF_WIDTH)
    )
 WBS
  (
   .clk(clk),
   .rst(i_rst),

   // Outputs
   .wvb_data_out(wvb_data_out),
   .hdr_data_out(hdr_data_out),
   .hdr_full(hdr_full),
   .hdr_empty(hdr_empty),
   .n_wvf_in_buf(n_wvf_in_buf),

   // Inputs
   .eoe_in(eoe),
   .wvb_data_in(ptb_out),
   .wvb_wr_addr(wvb_wr_addr),
   .wvb_rd_addr(wvb_rd_addr), 
   .wvb_wrreq(wvb_wrreq),
   .hdr_data_in(hdr_data_in),
   .hdr_wrreq(hdr_wrreq),
   .hdr_rdreq(hdr_rdreq)
  );

// write controller 
wire overflow_in;
wvb_wr_ctrl
  #(
    .P_DATA_WIDTH(P_DATA_WIDTH),
    .P_ADR_WIDTH(P_ADR_WIDTH),
    .P_HDR_WIDTH(P_HDR_WIDTH),
    .P_LTC_WIDTH(P_LTC_WIDTH),
    .P_CONST_CONF_WIDTH(P_CONST_CONF_WIDTH),
    .P_TEST_CONF_WIDTH(P_TEST_CONF_WIDTH),
    .P_PRE_CONF_WIDTH(P_PRE_CONF_WIDTH),
    .P_POST_CONF_WIDTH(P_POST_CONF_WIDTH)
   )
 WR_CTRL
  (
   .clk(clk),
   .rst(i_rst),

   // Outputs
   .overflow_out(wvb_overflow),
   .armed(armed),
   .eoe(eoe),
   .wvb_wr_addr(wvb_wr_addr),
   .wvb_wren(wvb_wrreq),
   .hdr_data(hdr_data_in),
   .hdr_wren(hdr_wrreq),

   // Inputs
   .ltc(ltc_in),
   .pre_config(pre_conf),
   .post_config(post_conf),
   .test_config(test_conf),
   .cnst_config(cnst_conf),
   .trig_mode(trig_mode),
   .cnst_run(cnst_run),
   .arm(arm),
   .trig(trig && ptb_rdy),
   .trig_src(trig_src),   
   .overflow_in(overflow_in)   
  );

// read address controller 
wvb_rd_addr_ctrl 
 #(
   .P_ADR_WIDTH(P_ADR_WIDTH),
   .P_HDR_WIDTH(P_HDR_WIDTH)
  ) 
 RD_ADDR
  (
   .clk          (clk),
   .rst          (i_rst),

   .hdr_data     (hdr_data_out),
   .hdr_rdreq    (hdr_rdreq),
   .wvb_rdreq    (wvb_rdreq),
   .wvb_rddone   (wvb_rddone),
   .wvb_rd_addr  (wvb_rd_addr)
  ); 

// overflow controller
wvb_overflow_ctrl
 #(
   .P_ADR_WIDTH(P_ADR_WIDTH),
   .P_HDR_WIDTH(P_HDR_WIDTH)
  )
 OVERFLOW_CTRL
  (
   .clk(clk),
   .rst(i_rst),

   // Outputs
   .overflow(overflow_in),
   .wvb_wused(wvb_wused),

   // Inputs   
   .wvb_rddone(wvb_rddone),
   .wvb_wr_addr(wvb_wr_addr),
   .hdr_data(hdr_data_out),
   .hdr_full(hdr_full)
  );

endmodule