module cuppa_wvb_hdr_bundle_0_fan_in
  (
   bundle,
   evt_ltc,
   start_addr,
   stop_addr,
   trig_src,
   cnst_run,
   pre_conf
  );

`include "cuppa_wvb_hdr_bundle_0_inc.v"

   output [86:0] bundle;
   input [47:0] evt_ltc;
   input [14:0] start_addr;
   input [14:0] stop_addr;
   input [1:0] trig_src;
   input [0:0] cnst_run;
   input [5:0] pre_conf;

assign bundle[47:0] = evt_ltc;
assign bundle[62:48] = start_addr;
assign bundle[77:63] = stop_addr;
assign bundle[79:78] = trig_src;
assign bundle[80:80] = cnst_run;
assign bundle[86:81] = pre_conf;


endmodule
