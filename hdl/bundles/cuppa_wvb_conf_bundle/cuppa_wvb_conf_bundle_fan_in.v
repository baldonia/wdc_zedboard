module cuppa_wvb_conf_bundle_fan_in
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

   output [53:0] bundle;
   input [14:0] cnst_conf;
   input [14:0] test_conf;
   input [14:0] post_conf;
   input [5:0] pre_conf;
   input [0:0] arm;
   input [0:0] trig_mode;
   input [0:0] cnst_run;

assign bundle[14:0] = cnst_conf;
assign bundle[29:15] = test_conf;
assign bundle[44:30] = post_conf;
assign bundle[50:45] = pre_conf;
assign bundle[51:51] = arm;
assign bundle[52:52] = trig_mode;
assign bundle[53:53] = cnst_run;


endmodule
