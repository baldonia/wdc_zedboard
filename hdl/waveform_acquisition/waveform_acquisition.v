// Aaron Fienberg
// October 2020
//
// waveform acquisition for the wdc zedboard prototype
// 
// Includes triggering and buffering
//

module waveform_acquisition #(parameter P_DATA_WIDTH = 28,
                              parameter P_ADC_BIT_WIDTH = 12,
                              parameter P_ADR_WIDTH = 15,
                              parameter P_HDR_WIDTH = 87,
                              parameter P_LTC_WIDTH = 48,
                              parameter P_N_WVF_IN_BUF_WIDTH = 10,
                              parameter P_WVB_TRIG_BUNDLE_WIDTH = 18,
                              parameter P_WVB_CONFIG_BUNDLE_WIDTH = 54)
(
  input clk,
  input rst,
  
  // WVB reader interface
  output[P_DATA_WIDTH-1:0] wvb_data_out,
  output[P_HDR_WIDTH-1:0]  wvb_hdr_data_out,  
  output wvb_hdr_full,
  output wvb_hdr_empty,
  output[P_N_WVF_IN_BUF_WIDTH-1:0] wvb_n_wvf_in_buf,
  output [P_ADR_WIDTH+1:0] wvb_wused, 
  input wvb_hdr_rdreq, 
  input wvb_wvb_rdreq, 
  input wvb_wvb_rddone, 
  
  // raw datastream 
  input[P_ADC_BIT_WIDTH-1:0] adc_samp_0_0,
  input[P_ADC_BIT_WIDTH-1:0] adc_samp_1_0,

  // Local time counter
  input [P_LTC_WIDTH-1:0] ltc_in, 
  
  // External
  input ext_trig_in,
  output wvb_trig_out,
  output wvb_trig_test_out,

  // Rate scaler
  // input[P_RATE_SCALER_CTRL_BUNDLE_WIDTH-1:0] rate_scaler_ctrl_bundle, 
  // output[P_RATE_SCALER_STS_BUNDLE_WIDTH-1:0] rate_scaler_sts_bundle,

  // cuppa interface
  input[P_WVB_TRIG_BUNDLE_WIDTH-1:0] cuppa_wvb_trig_bundle,
  input[P_WVB_CONFIG_BUNDLE_WIDTH-1:0] cuppa_wvb_config_bundle,  
  output          cuppa_wvb_armed, 
  output          cuppa_wvb_overflow
);

// register synchronous reset & cuppa bundles
(* max_fanout = 20 *) reg i_rst = 0;
(* DONT_TOUCH = "true" *) reg[P_WVB_TRIG_BUNDLE_WIDTH-1:0] i_cuppa_wvb_trig_bundle = 0;
(* DONT_TOUCH = "true" *) reg[P_WVB_CONFIG_BUNDLE_WIDTH-1:0] i_cuppa_wvb_config_bundle= 0;
always @(posedge clk) begin
  i_rst <= rst;
  i_cuppa_wvb_trig_bundle <= cuppa_wvb_trig_bundle;
  i_cuppa_wvb_config_bundle <= cuppa_wvb_config_bundle;
end

// trig fan out
wire wvb_trig_et;
wire wvb_trig_gt;    
wire wvb_trig_lt;   
wire wvb_trig_run;
wire [P_ADC_BIT_WIDTH-1:0] wvb_trig_thr;   
wire wvb_trig_thresh_trig_en; 
wire wvb_trig_ext_trig_en; 
cuppa_trig_bundle_fan_out TRIG_FAN_OUT
  (
   .bundle(i_cuppa_wvb_trig_bundle),
   .trig_et(wvb_trig_et),
   .trig_gt(wvb_trig_gt),
   .trig_lt(wvb_trig_lt),
   .trig_run(wvb_trig_run),
   .trig_thresh(wvb_trig_thr),
   .thresh_trig_en(wvb_trig_thresh_trig_en),
   .ext_trig_en(wvb_trig_ext_trig_en)
  );

// wvb config bundle fan out
wire[14:0] wvb_cnst_config;
wire[14:0] wvb_post_config;
wire[5:0] wvb_pre_config;
wire[14:0] wvb_test_config;
wire wvb_arm;
wire wvb_trig_mode;
wire wvb_cnst_run;

cuppa_wvb_conf_bundle_fan_out CONF_FAN_OUT
  (
   .bundle(i_cuppa_wvb_config_bundle),
   .cnst_conf(wvb_cnst_config),
   .test_conf(wvb_test_config),
   .post_conf(wvb_post_config),
   .pre_conf(wvb_pre_config),
   .arm(wvb_arm),
   .trig_mode(wvb_trig_mode),
   .cnst_run(wvb_cnst_run)
  );

wire[P_ADC_BIT_WIDTH-1:0] adc_samp_0_1;
wire[P_ADC_BIT_WIDTH-1:0] adc_samp_1_1;
wire[1:0] trig_src; 
wire[1:0] thresh_tot;
wire wvb_trig;
cuppa_trigger CUPPA_TRIG
  (
   .clk(clk),
   .rst(i_rst),

   // data stream in and out
   .adc_stream_in_0(adc_samp_0_0),
   .adc_stream_in_1(adc_samp_1_0),
   .adc_stream_out_0(adc_samp_0_1),
   .adc_stream_out_1(adc_samp_1_1),
   
   // threshold trigger settings 
   .gt(wvb_trig_gt),
   .et(wvb_trig_et),
   .lt(wvb_trig_lt),
   .thr(wvb_trig_thr),
   .thresh_trig_en(wvb_trig_thresh_trig_en),

   // sw trig
   .run(wvb_trig_run),

   // ext trig
   .ext_trig_en(wvb_trig_ext_trig_en),
   .ext_run(ext_trig_in),
      
   // trigger outputs
   .trig_src(trig_src),
   .trig(wvb_trig),
   .thresh_tot(thresh_tot)
  );
assign wvb_trig_out = wvb_trig;

wire [P_DATA_WIDTH-1:0] buff_stream = {adc_samp_1_1, thresh_tot[1], 1'b0,
                                       adc_samp_0_1, thresh_tot[0], 1'b0};

waveform_buffer 
  #(.P_DATA_WIDTH(P_DATA_WIDTH),
    .P_ADR_WIDTH(P_ADR_WIDTH),
    .P_HDR_WIDTH(P_HDR_WIDTH),
    .P_LTC_WIDTH(P_LTC_WIDTH),
    .P_N_WVF_IN_BUF_WIDTH(P_N_WVF_IN_BUF_WIDTH)
   )
 WVB
  (
   // Outputs
   .wvb_wused(wvb_wused),
   .n_wvf_in_buf(wvb_n_wvf_in_buf),
   .wvb_overflow(cuppa_wvb_overflow),
   .armed(cuppa_wvb_armed),   
   .wvb_data_out(wvb_data_out),
   .hdr_data_out(wvb_hdr_data_out),
   .hdr_full(wvb_hdr_full),
   .hdr_empty(wvb_hdr_empty),

   // Inputs
   .clk(clk),
   .rst(i_rst),
   .ltc_in(ltc_in),
   .stream_in(buff_stream),
   .trig(wvb_trig),
   .trig_src(trig_src),
   .arm(wvb_arm),

   .wvb_rdreq(wvb_wvb_rdreq),
   .hdr_rdreq(wvb_hdr_rdreq),
   .wvb_rddone(wvb_wvb_rddone),

   // Config inputs
   .pre_conf(wvb_pre_config),
   .post_conf(wvb_post_config),
   .test_conf(wvb_test_config),
   .cnst_run(wvb_cnst_run),
   .cnst_conf(wvb_cnst_config),
   .trig_mode(wvb_trig_mode)
  );

endmodule