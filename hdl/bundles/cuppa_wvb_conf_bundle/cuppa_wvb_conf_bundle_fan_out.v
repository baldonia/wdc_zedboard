module cuppa_wvb_conf_bundle_fan_out
  (
   bundle,
   cnst_conf,
   test_conf,
   post_conf,
   pre_conf,
   arm,
   trig_mode,
   cnst_run
  );

`include "cuppa_wvb_conf_bundle_inc.v"

   input [53:0] bundle;
   output [14:0] cnst_conf;
   output [14:0] test_conf;
   output [14:0] post_conf;
   output [5:0] pre_conf;
   output [0:0] arm;
   output [0:0] trig_mode;
   output [0:0] cnst_run;

assign cnst_conf = bundle[14:0];
assign test_conf = bundle[29:15];
assign post_conf = bundle[44:30];
assign pre_conf = bundle[50:45];
assign arm = bundle[51:51];
assign trig_mode = bundle[52:52];
assign cnst_run = bundle[53:53];

endmodule
