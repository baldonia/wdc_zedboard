// Aaron Fienberg
// October 2020
//
// WDC zedboard waveform buffer write controller
//

module wvb_wr_ctrl #(parameter P_DATA_WIDTH = 28,
                     parameter P_ADR_WIDTH = 15,
                     parameter P_HDR_WIDTH = 87,
                     parameter P_LTC_WIDTH = 48,
                     parameter P_CONST_CONF_WIDTH = 15,
                     parameter P_TEST_CONF_WIDTH = 15,
                     parameter P_PRE_CONF_WIDTH = 6,
                     parameter P_POST_CONF_WIDTH = 15)
(
  input clk,
  input rst,

  // Outputs
  output reg overflow_out = 0,
  output reg armed = 0,
  output reg eoe = 0,
  (*max_fanout=5*) output reg[P_ADR_WIDTH-1:0] wvb_wr_addr = 0,
  output wvb_wren,
  output[P_HDR_WIDTH-1:0] hdr_data,
  output hdr_wren,

  // Inputs
  input[P_LTC_WIDTH-1:0] ltc,
  input[P_PRE_CONF_WIDTH-1:0] pre_config,
  input[P_POST_CONF_WIDTH-1:0] post_config,
  input[P_TEST_CONF_WIDTH-1:0] test_config,
  input[P_CONST_CONF_WIDTH-1:0] cnst_config,
  input trig_mode,
  input cnst_run,
  input arm,
  input trig,
  input[1:0] trig_src,  
  input overflow_in
);
`include "trigger_src_inc.v"

// register synchronous rst
(* DONT_TOUCH = "true" *) reg i_rst = 0;
always @(posedge clk) begin
  i_rst <= rst;
end

// Internals
reg[P_ADR_WIDTH-1:0] i_evt_len = 0;
reg[P_LTC_WIDTH-1:0] i_evt_ltc = 0;
reg[P_PRE_CONF_WIDTH-1:0] i_pre_conf = 0;
reg[P_PRE_CONF_WIDTH-1:0] i_pre_cnt_max = 0;
reg[P_POST_CONF_WIDTH-1:0] i_post_conf = 0;
reg[P_POST_CONF_WIDTH-1:0] i_post_cnt_max = 0;
reg[P_TEST_CONF_WIDTH-1:0] i_test_conf = 0;
reg[P_TEST_CONF_WIDTH-1:0] i_test_cnt_max = 0;
reg[P_CONST_CONF_WIDTH-1:0] i_const_conf = 0;
reg[P_CONST_CONF_WIDTH-1:0] i_const_cnt_max = 0;
reg[P_ADR_WIDTH-1:0] i_start_addr = 0;
reg[P_ADR_WIDTH-1:0] i_stop_addr = 0;
reg i_cnst_run = 0;
reg[1:0] i_trig_src = 0;

// FSM states
localparam
  S_IDLE = 0,
  S_PRE = 1,
  S_SOT = 2,
  S_POST = 3,
  S_TEST = 4,
  S_CONST = 5;

reg[2:0] fsm = S_IDLE;
reg[31:0] cnt = 0;

// minimum values for various length configs
localparam PRE_CONF_MIN = 3,
           POST_CONF_MIN = 2,
           TEST_CONF_MIN = 3,
           CONST_CONF_MIN = 3;
// update interal length conf values
always @(posedge clk) begin
  if (i_rst) begin
    i_pre_conf <= 0;
    i_post_conf <= 0;
    i_test_conf <= 0;
    i_const_conf <= 0;

    i_pre_cnt_max <= 0;
    i_post_cnt_max <= 0;
    i_test_cnt_max <= 0;
    i_const_cnt_max <= 0;
  end

  else if (fsm == S_IDLE) begin
    i_pre_conf <= pre_config >= PRE_CONF_MIN ? pre_config : PRE_CONF_MIN;
    i_post_conf <= post_config >= POST_CONF_MIN ? post_config : POST_CONF_MIN;
    i_test_conf <= test_config >= TEST_CONF_MIN ? test_config : TEST_CONF_MIN;
    i_const_conf <= cnst_config >= CONST_CONF_MIN ? cnst_config : CONST_CONF_MIN;

    i_pre_cnt_max <= i_pre_conf - 1;
    i_post_cnt_max <= i_post_conf - 1;
    i_test_cnt_max <= i_test_conf - 1;
    i_const_cnt_max <= i_const_conf - 1;
  end
end

// latch header values when fsm is in the idle state
always @(posedge clk) begin
  if (i_rst) begin
    i_evt_ltc <= 0;
    i_start_addr <= 0;
    i_trig_src <= 0;
    i_cnst_run <= 0;
  end

  else if (fsm == S_IDLE) begin
    i_evt_ltc <= ltc;
    i_trig_src <= trig_src;
    i_start_addr <= wvb_wr_addr;
    i_cnst_run <= cnst_run;
  end
end
// stop addr will always update along with wvb_wr_addr
always @(*) i_stop_addr = wvb_wr_addr;

// overflow control
// an overflow will stop all writes
// until the write controller is reset
always @(posedge clk) begin
  if (i_rst) begin
    overflow_out <= 0;
  end

  else if (overflow_in || overflow_out) begin
    overflow_out <= 1;
  end
end

// count the number of writes
reg[P_ADR_WIDTH-1:0] n_writes = 0;
always @(posedge clk) begin
  if (i_rst) begin
    n_writes <= 0;
  end
  
  else begin
    n_writes <= 0;
    if (wvb_wren && fsm != S_IDLE) begin
      n_writes <= n_writes + 1;
    end
  end
end

// evt_len written into the header should be n_writes + 2
always @(*) i_evt_len = n_writes + 2;

// handle trigger arm logic
always @(posedge clk) begin
  if (i_rst) begin
    armed <= 0;
  end

  else begin
    if (arm) begin
      armed <= 1;
    end

    else if (hdr_wren) begin
      armed <= 0;
    end
  end
end

// signal that this is the final write of a waveform
reg final_write = 0;
reg final_cnt_check = 0;

// quick test; register cnt comparisons to help
// with timing of header_wren
always @(posedge clk) begin
  if (i_rst) begin
    final_cnt_check <= 0;
  end

  else begin
    // check against cnt_max - 1 so that final_cnt_check
    // will be true on the cycle where cnt == i_<x>_cnt_max 
    case (fsm) 
      S_IDLE:  final_cnt_check <= 0;
      S_PRE:   final_cnt_check <= 0;
      S_SOT:   final_cnt_check <= 0;
      S_POST:  final_cnt_check <= cnt == i_post_cnt_max - 1;
      S_CONST: final_cnt_check <= cnt == i_const_cnt_max - 1;
      S_TEST:  final_cnt_check <= cnt == i_test_cnt_max - 1;
      default: final_cnt_check <= 0;
  endcase
  end
end

// "final write" logic
always @(*) begin
  case (fsm) 
    S_IDLE:  final_write = 0;
    S_PRE:   final_write = 0;
    S_SOT:   final_write = 0;
    S_POST:  final_write = !trig && final_cnt_check;
    S_CONST: final_write = final_cnt_check;
    S_TEST:  final_write = final_cnt_check;
    default: final_write = 0;
  endcase
end

assign hdr_wren = wvb_wren && (final_write || overflow_in);
always @(*) eoe = hdr_wren;

// wvb_wren logic
wire write_condition = (trig && !overflow_in) || (fsm != S_IDLE);
wire mode_0_condition = (trig_mode == 0);
wire mode_1_condition = (trig_mode == 1) && armed; 
assign wvb_wren = !overflow_out && write_condition && (mode_0_condition || mode_1_condition);

// header bundle fan_in
cuppa_wvb_hdr_bundle_0_fan_in HDR_FAN_IN
(
  .bundle(hdr_data),
  .evt_ltc(i_evt_ltc),
  .start_addr(i_start_addr),
  .stop_addr(i_stop_addr),
  .trig_src(i_trig_src),
  .cnst_run(i_cnst_run),
  .pre_conf(i_pre_conf)
);


// FSM logic

// how extra wait count for retriggering logic
reg[P_ADR_WIDTH-1:0] sot_cnt = 0;

always @(posedge clk) begin
  if (i_rst || overflow_out) begin
    cnt <= 0;
    fsm <= S_IDLE;
    wvb_wr_addr <= 0;
    sot_cnt <= 0;
  end

  else begin
    // always advance write address following a write
    // except for when we're about to overflow
    if (wvb_wren && !overflow_in) begin
      wvb_wr_addr <= wvb_wr_addr + 1;
    end

    case (fsm)

      S_IDLE: begin
        cnt <= 0;

        // trigger
        if (wvb_wren) begin
          cnt <= 1;
          
          if ((trig_src == TRIG_SRC_SW) || 
              (trig_src == TRIG_SRC_EXT)) begin
            fsm <= S_TEST;
          end

          else if (i_cnst_run) begin
            fsm <= S_CONST;
          end

          else begin
            // default case: one sample over threshold
            sot_cnt <= 1;
            
            fsm <= S_PRE;
          end
        end
      end

      S_PRE: begin
        cnt <= cnt + 1;
        
        if (trig) begin
          // if a trigger occurs during pretrigger readout,
          // we must extend the SOT window to "cnt + 1" cycles                  
          sot_cnt <= cnt + 1;
        end
        
        if (cnt == i_pre_cnt_max) begin
          cnt <= 0;
          fsm <= S_SOT;
        end
      end

      S_SOT: begin
        cnt <= cnt + 1;

        if (trig) begin
          // if a trigger occurs during the SOT state, 
          // we must wait i_pre_conf cycles before
          // continuing to S_POST
          cnt <= 0; 
          sot_cnt <= i_pre_conf;
        end

        else if (cnt == sot_cnt - 1) begin
          cnt <= 0;
          fsm <= S_POST;
        end
      end

      S_POST: begin
        cnt <= cnt + 1;
        
        if (trig) begin
          // if a trigger occurs during the POST state, 
          // we must wait i_pre_conf cycles 
          // and restart the post count
          cnt <= 0; 
          sot_cnt <= i_pre_conf;
          fsm <= S_SOT;
        end
        
        else begin
          if (cnt == i_post_cnt_max) begin
            cnt <= 0;
            fsm <= S_IDLE;
          end  
        end
      end

      S_TEST: begin
        cnt <= cnt + 1;

        if (cnt == i_test_cnt_max) begin
          cnt <= 0;
          fsm <= S_IDLE;
        end
      end

      S_CONST: begin
        cnt <= cnt + 1;

        if (cnt == i_const_cnt_max) begin
          cnt <= 0;
          fsm <= S_IDLE;
        end
      end

      default: begin
        fsm <= S_IDLE;
      end

    endcase
  end
end

endmodule