module cuppa_trig_bundle_fan_in
  (
   bundle,
   trig_et,
   trig_gt,
   trig_lt,
   trig_run,
   trig_thresh,
   thresh_trig_en,
   ext_trig_en
  );

`include "cuppa_trig_bundle_inc.v"

   output [17:0] bundle;
   input [0:0] trig_et;
   input [0:0] trig_gt;
   input [0:0] trig_lt;
   input [0:0] trig_run;
   input [11:0] trig_thresh;
   input [0:0] thresh_trig_en;
   input [0:0] ext_trig_en;

assign bundle[0:0] = trig_et;
assign bundle[1:1] = trig_gt;
assign bundle[2:2] = trig_lt;
assign bundle[3:3] = trig_run;
assign bundle[15:4] = trig_thresh;
assign bundle[16:16] = thresh_trig_en;
assign bundle[17:17] = ext_trig_en;


endmodule
