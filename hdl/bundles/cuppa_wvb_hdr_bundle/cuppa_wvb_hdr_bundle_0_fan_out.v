module cuppa_wvb_hdr_bundle_0_fan_out
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

   input [86:0] bundle;
   output [47:0] evt_ltc;
   output [14:0] start_addr;
   output [14:0] stop_addr;
   output [1:0] trig_src;
   output [0:0] cnst_run;
   output [5:0] pre_conf;

assign evt_ltc = bundle[47:0];
assign start_addr = bundle[62:48];
assign stop_addr = bundle[77:63];
assign trig_src = bundle[79:78];
assign cnst_run = bundle[80:80];
assign pre_conf = bundle[86:81];

endmodule
