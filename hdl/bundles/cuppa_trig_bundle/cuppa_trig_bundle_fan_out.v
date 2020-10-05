module cuppa_trig_bundle_fan_out
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

   input [17:0] bundle;
   output [0:0] trig_et;
   output [0:0] trig_gt;
   output [0:0] trig_lt;
   output [0:0] trig_run;
   output [11:0] trig_thresh;
   output [0:0] thresh_trig_en;
   output [0:0] ext_trig_en;

assign trig_et = bundle[0:0];
assign trig_gt = bundle[1:1];
assign trig_lt = bundle[2:2];
assign trig_run = bundle[3:3];
assign trig_thresh = bundle[15:4];
assign thresh_trig_en = bundle[16:16];
assign ext_trig_en = bundle[17:17];

endmodule
