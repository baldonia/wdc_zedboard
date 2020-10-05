// Aaron Fienberg
// October 2020
//
// trigger logic for wdc zedboard prototype
//

module cuppa_trigger
(
  input clk,
  input rst,
  
  // data streams in and out
  input[11:0] adc_stream_in_0,
  input[11:0] adc_stream_in_1,
  output reg[11:0] adc_stream_out_0 = 0,
  output reg[11:0] adc_stream_out_1 = 0,
  
  // threshold trigger settings 
  input gt,
  input et,
  input lt,
  input[11:0] thr,
  input thresh_trig_en,
  // sw trig
  input run,
  
  // ext trig
  input ext_trig_en,
  input ext_run,
    
  // trigger outputs
  output reg[1:0] trig_src = 0,
  output reg trig = 0,
  output reg[1:0] thresh_tot = 0
);
`include "trigger_src_inc.v"

// register synchronous reset
(* DONT_TOUCH = "true" *) reg i_rst = 0;
always @(posedge clk) begin
  i_rst <= rst;
end

// posedge detector on ext_run and run
wire ext_run_p;
posedge_detector PEDGE_EXTRUN(.clk(clk), .rst_n(!i_rst), .a(ext_run), .y(ext_run_p));
wire run_p;
posedge_detector PEDGE_RUN(.clk(clk), .rst_n(!i_rst), .a(run), .y(run_p));

// comparator for threshold triggering
wire[1:0] i_thresh_tot;
cmp CMP(.a(adc_stream_in_0), .b(thr), .y(i_thresh_tot[0]), .gt(gt), .et(et), .lt(lt));
cmp CMP(.a(adc_stream_in_1), .b(thr), .y(i_thresh_tot[1]), .gt(gt), .et(et), .lt(lt));

always @(posedge clk) begin
  if (i_rst) begin
    adc_stream_out_0 <= 0;
    adc_stream_out_1 <= 0;

    thresh_tot <= 2'b0;

    trig_src <= 2'b0;
    trig <= 0;
  end
 
  else begin
    adc_stream_out_0 <= adc_stream_in_0;
    adc_stream_out_1 <= adc_stream_in_1;

    thresh_tot <= i_thresh_tot;
    
    if (ext_trig_en && ext_run_p) begin
      trig_src <= TRIG_SRC_EXT;
      trig <= 1;
    end

    else if (thresh_trig_en && (|i_thresh_tot)) begin
      trig_src <= TRIG_SRC_THRESH;
      trig <= 1;
    end

    else if (run_p) begin
      trig_src <= TRIG_SRC_SW;
      trig <= 1;
    end

    else begin
      trig_src <= 0;
      trig <= 0;
    end
  end
end


endmodule