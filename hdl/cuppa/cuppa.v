// Aaron Fienberg
// September 2020
//
// Like xdom, but for cuppa
// provides the cuppa register interface

module cuppa #(parameter N_CHANNELS = 2)
(
  input clk,
  input rst,

  // Version number
  input [15:0]      vnum,

  // DAC SPI controls
  output reg dac_sel = 0,
  output dac_spi_wr_req,
  input dac_spi_ack,
  output reg[23:0] dac_spi_wr_data = 0,

  // dig SPI controls
  output reg dig_sel = 0,
  output dig_spi_req,
  input dig_spi_ack,
  output reg[15:0] dig_spi_wr_data = 0,
  input[7:0] dig_spi_rd_data,

  // DIG 0 LVDS IO
  output reg io_reset_0 = 1,
  output reg[5:0] bitslip_0 = 0,
  output reg in_delay_reset_0 = 0,
  output reg[5:0] in_delay_ce_0 = 0,
  output reg[5:0] in_delay_inc_0 = 0,
  input[29:0] in_delay_tap_out_0,

  // DIG 1 LVDS IO
  output reg io_reset_1 = 1,
  output reg[5:0] bitslip_1 = 0,
  output reg in_delay_reset_1 = 0,
  output reg[5:0] in_delay_ce_1 = 0,
  output reg[5:0] in_delay_inc_1 = 0,
  input[29:0] in_delay_tap_out_1,

  // turn KR pattern on and off
  output reg led_toggle = 1,

  // trigger/wvb conf
  output[17:0] trig_bundle_0,
  output[17:0] trig_bundle_1,
  output[53:0] wvb_conf_bundle_0,
  output[53:0] wvb_conf_bundle_1,
  output reg[N_CHANNELS-1:0] wvb_rst = 0,

  input[N_CHANNELS-1:0] wvb_armed,
  input[N_CHANNELS-1:0] wvb_overflow,
  input[N_CHANNELS-1:0] wvb_hdr_full,
  input[9:0] wvb_n_wvf_in_buf_0,
  input[9:0] wvb_n_wvf_in_buf_1,
  input[15:0] wvb_wused_0,
  input[15:0] wvb_wused_1,

  output reg[N_CHANNELS-1:0] trig_link_enable,

  // wvb reader
  input[15:0] dpram_len_in,
  input rdout_dpram_run,
  output reg dpram_busy = 0,
  input rdout_dpram_wren,
  input[9:0] rdout_dpram_wr_addr,
  input[31:0] rdout_dpram_data,
  output reg wvb_reader_enable = 0,
  output reg wvb_reader_dpram_mode = 0,

  input dig0_mmcm_locked,

  output reg spi_rst = 0,

  // Debug FT232R I/O
  input             debug_txd,
  output            debug_rxd,
  input             debug_rts_n,
  output            debug_cts_n
);

///////////////////////////////////////////////////////////////////////////////
// 1.) Debug UART
wire [11:0] debug_logic_adr;
wire [15:0] debug_logic_wr_data;
wire        debug_logic_wr_req;
wire        debug_logic_rd_req;
wire        debug_err_req;
wire [31:0] debug_err_data;
wire [15:0] debug_logic_rd_data;
wire        debug_logic_ack;
wire        debug_err_ack;
ft232r_proc_buffered UART_DEBUG_0
 (
  // Outputs
  .rxd              (debug_rxd),
  .cts_n            (debug_cts_n),
  .logic_adr        (debug_logic_adr[11:0]),
  .logic_wr_data    (debug_logic_wr_data[15:0]),
  .logic_wr_req     (debug_logic_wr_req),
  .logic_rd_req     (debug_logic_rd_req),
  .err_req          (debug_err_req),
  .err_data         (debug_err_data[31:0]),
  // Inputs
  .clk              (clk),
  .rst              (rst),
  .txd              (debug_txd),
  .rts_n            (debug_rts_n),
  .logic_rd_data    (debug_logic_rd_data[15:0]),
  .logic_ack        (debug_logic_ack),
  .err_ack          (debug_err_ack)
);

//////////////////////////////////////////////////////////////////////////////
// 2.) Command, repsonse, status
wire [11:0] y_adr;
wire [15:0] y_wr_data;
wire        y_wr;
reg [15:0] y_rd_data;
crs_master CRSM_0
 (
  // Outputs
  .y_adr            (y_adr[11:0]),
  .y_wr_data        (y_wr_data[15:0]),
  .y_wr             (y_wr),
  .a0_ack           (debug_logic_ack),
  .a0_rd_data       (debug_logic_rd_data[15:0]),
  .a0_buf_rd        (),
  .a1_ack           (),
  .a1_rd_data       (),
  .a1_buf_rd        (),
  .a2_ack           (),
  .a2_rd_data       (),
  .a2_buf_rd        (),
  .a3_ack           (),
  .a3_rd_data       (),
  .a3_buf_rd        (),
  // Inputs
  .clk              (clk),
  .rst              (rst),
  .y_rd_data        (y_rd_data[15:0]),
  .a0_wr_req        (debug_logic_wr_req),
  .a0_bwr_req       (1'b0),
  .a0_rd_req        (debug_logic_rd_req),
  .a0_wr_data       (debug_logic_wr_data[15:0]),
  .a0_adr           (debug_logic_adr[11:0]),
  .a0_buf_empty     (1'b1),
  .a0_buf_wr_data   (),
  .a1_wr_req        (),
  .a1_bwr_req       (),
  .a1_rd_req        (),
  .a1_wr_data       (),
  .a1_adr           (),
  .a1_buf_empty     (),
  .a1_buf_wr_data   (),
  .a2_wr_req        (),
  .a2_bwr_req       (),
  .a2_rd_req        (),
  .a2_wr_data       (),
  .a2_adr           (),
  .a2_buf_empty     (),
  .a2_buf_wr_data   (),
  .a3_wr_req        (),
  .a3_bwr_req       (),
  .a3_rd_req        (),
  .a3_wr_data       (),
  .a3_adr           (),
  .a3_buf_empty     (),
  .a3_buf_wr_data   ()
);

// task regs
wire[15:0] dac_task_val;
wire[15:0] dac_task_req;
wire[15:0] dac_task_ack;
task_reg #(.P_TASK_ADR(12'hbfe)) DAC_SPI_TASK_0
(
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(dac_task_req),
  .ack(dac_task_ack),
  .val(dac_task_val)
);
assign dac_spi_wr_req = dac_task_req[0];
assign dac_task_ack[0] = dac_spi_ack;

wire[15:0] dig_task_val;
wire[15:0] dig_task_req;
wire[15:0] dig_task_ack;
task_reg #(.P_TASK_ADR(12'hbee)) DIG_SPI_TASK
(
  .clk(clk),
  .rst(rst),
  .adr(y_adr),
  .data(y_wr_data),
  .wr(y_wr),
  .req(dig_task_req),
  .ack(dig_task_ack),
  .val(dig_task_val)
);
assign dig_spi_req = dig_task_req[0];
assign dig_task_ack[0] = dig_spi_ack;

// Dig 0 wvb trig bundle
reg wvb_trig_et_0 = 0;
reg wvb_trig_gt_0 = 0;
reg wvb_trig_lt_0 = 0;
reg wvb_trig_run_0 = 0;
reg [11:0] wvb_trig_thr_0 = 0;
reg wvb_trig_thresh_trig_en_0 = 0;
reg wvb_trig_ext_trig_en_0 = 0;
cuppa_trig_bundle_fan_in TRIG_FAN_IN_0
  (
   .bundle(trig_bundle_0),
   .trig_et(wvb_trig_et_0),
   .trig_gt(wvb_trig_gt_0),
   .trig_lt(wvb_trig_lt_0),
   .trig_run(wvb_trig_run_0),
   .trig_thresh(wvb_trig_thr_0),
   .thresh_trig_en(wvb_trig_thresh_trig_en_0),
   .ext_trig_en(wvb_trig_ext_trig_en_0)
  );

// Dig 1 wvb trig bundle
reg wvb_trig_et_1 = 0;
reg wvb_trig_gt_1 = 0;
reg wvb_trig_lt_1 = 0;
reg wvb_trig_run_1 = 0;
reg [11:0] wvb_trig_thr_1 = 0;
reg wvb_trig_thresh_trig_en_1 = 0;
reg wvb_trig_ext_trig_en_1 = 0;
cuppa_trig_bundle_fan_in TRIG_FAN_IN_1
  (
   .bundle(trig_bundle_1),
   .trig_et(wvb_trig_et_1),
   .trig_gt(wvb_trig_gt_1),
   .trig_lt(wvb_trig_lt_1),
   .trig_run(wvb_trig_run_1),
   .trig_thresh(wvb_trig_thr_1),
   .thresh_trig_en(wvb_trig_thresh_trig_en_1),
   .ext_trig_en(wvb_trig_ext_trig_en_1)
  );

// Dig 0 wvb conf bundle
reg[14:0] wvb_cnst_config_0 = 0;
reg[14:0] wvb_post_config_0 = 0;
reg[5:0] wvb_pre_config_0 = 0;
reg[14:0] wvb_test_config_0 = 0;
reg wvb_arm_0 = 0;
reg wvb_trig_mode_0 = 0;
reg wvb_cnst_run_0 = 0;
cuppa_wvb_conf_bundle_fan_in WVB_CONF_FAN_IN_0
  (
   .bundle(wvb_conf_bundle_0),
   .cnst_conf(wvb_cnst_config_0),
   .test_conf(wvb_test_config_0),
   .post_conf(wvb_post_config_0),
   .pre_conf(wvb_pre_config_0),
   .arm(wvb_arm_0),
   .trig_mode(wvb_trig_mode_0),
   .cnst_run(wvb_cnst_run_0)
  );

// Dig 1 wvb conf bundle
reg[14:0] wvb_cnst_config_1 = 0;
reg[14:0] wvb_post_config_1 = 0;
reg[5:0] wvb_pre_config_1 = 0;
reg[14:0] wvb_test_config_1 = 0;
reg wvb_arm_1 = 0;
reg wvb_trig_mode_1 = 0;
reg wvb_cnst_run_1 = 0;
cuppa_wvb_conf_bundle_fan_in WVB_CONF_FAN_IN_1
  (
   .bundle(wvb_conf_bundle_1),
   .cnst_conf(wvb_cnst_config_1),
   .test_conf(wvb_test_config_1),
   .post_conf(wvb_post_config_1),
   .pre_conf(wvb_pre_config_1),
   .arm(wvb_arm_1),
   .trig_mode(wvb_trig_mode_1),
   .cnst_run(wvb_cnst_run_1)
  );

//////////////////////////////////////////////////////////////////////////////
// Read registers
reg[15:0] reg_dpram_rd_data;

reg[15:0] dpram_len;
reg dpram_done = 0;
reg dpram_sel = 0;
reg[15:0] xdom_dpram_rd_data;

reg[15:0] lock_pe_cnt = 0;
reg rst_lock_pe_cnt = 0;

always @(*) begin
  case(y_adr)
    12'hfff: begin y_rd_data =       vnum;                                  end
    12'hffe: begin y_rd_data =       {11'b0,
                                      wvb_trig_ext_trig_en_0,
                                      wvb_trig_thresh_trig_en_0,
                                      wvb_trig_lt_0,
                                      wvb_trig_gt_0,
                                      wvb_trig_et_0};                       end
    12'hffd: begin y_rd_data =       {4'b0, wvb_trig_thr_0};                end
    12'hffc: begin y_rd_data =       {14'b0, wvb_trig_run_1,
                                             wvb_trig_run_0};               end
    12'hffb: begin y_rd_data =       {15'b0, wvb_trig_mode_0};              end
    12'hffa: begin y_rd_data =       {14'b0, wvb_arm_1,
                                             wvb_arm_0};                    end
    12'hff9: begin y_rd_data =       {14'b0, wvb_armed};                    end
    12'hff8: begin y_rd_data =       {15'b0, wvb_cnst_run_0};               end
    12'hff7: begin y_rd_data =       {1'b0, wvb_cnst_config_0};             end
    12'hff6: begin y_rd_data =       {1'b0, wvb_test_config_0};             end
    12'hff5: begin y_rd_data =       {1'b0, wvb_post_config_0};             end
    12'hff4: begin y_rd_data =       {10'b0, wvb_pre_config_0};             end
    12'hefe: begin y_rd_data =       {11'b0,
                                      wvb_trig_ext_trig_en_1,
                                      wvb_trig_thresh_trig_en_1,
                                      wvb_trig_lt_1,
                                      wvb_trig_gt_1,
                                      wvb_trig_et_1};                       end
    12'hefd: begin y_rd_data =       {4'b0, wvb_trig_thr_1};                end
    12'hefb: begin y_rd_data =       {15'b0, wvb_trig_mode_1};              end
    12'hef8: begin y_rd_data =       {15'b0, wvb_cnst_run_1};               end
    12'hef7: begin y_rd_data =       {1'b0, wvb_cnst_config_1};             end
    12'hef6: begin y_rd_data =       {1'b0, wvb_test_config_1};             end
    12'hef5: begin y_rd_data =       {1'b0, wvb_post_config_1};             end
    12'hef4: begin y_rd_data =       {10'b0, wvb_pre_config_1};             end
    12'hef3: begin y_rd_data =       {14'b0, trig_link_enable};             end
    12'hdff: begin y_rd_data =       dpram_len;                             end
    12'hdfe: begin y_rd_data =       {15'b0, dpram_done};                   end
    12'hdfd: begin y_rd_data =       {15'b0, dpram_sel};                    end
    12'hdfc: begin y_rd_data =       {6'b0, wvb_n_wvf_in_buf_0};            end
    12'hdfb: begin y_rd_data =       wvb_wused_0;                           end
    12'hdfa: begin y_rd_data =       {14'b0, wvb_overflow};                 end
    12'hdf9: begin y_rd_data =       {14'b0, wvb_rst};                      end
    12'hdf8: begin y_rd_data =       {15'b0, wvb_reader_enable};            end
    12'hdf7: begin y_rd_data =       {15'b0, wvb_reader_dpram_mode};        end
    12'hdf6: begin y_rd_data =       {14'b0, wvb_hdr_full};                 end
    12'hdf5: begin y_rd_data =       {6'b0, wvb_n_wvf_in_buf_1};            end
    12'hdf4: begin y_rd_data =       wvb_wused_1;                           end
    12'hbff: begin y_rd_data =       dac_sel;                               end
    12'hbfe: begin y_rd_data =       dac_task_val;                          end
    12'hbfd: begin y_rd_data =       {8'b0, dac_spi_wr_data[23:16]};        end
    12'hbfc: begin y_rd_data =       dac_spi_wr_data[15:0];                 end
    12'hbef: begin y_rd_data =       dig_sel;                               end
    12'hbee: begin y_rd_data =       dig_task_val;                          end
    12'hbed: begin y_rd_data =       dig_spi_wr_data;                       end
    12'hbec: begin y_rd_data =       {8'b0, dig_spi_rd_data};               end
    12'hbdf: begin y_rd_data =       {15'b0, io_reset_0};                   end
    12'hbde: begin y_rd_data =       {15'b0, in_delay_reset_0};             end
    12'hbdd: begin y_rd_data =       {13'b0, bitslip_0[0],
                                             in_delay_ce_0[0],
                                             in_delay_inc_0[0]};            end
    12'hbdc: begin y_rd_data =       {2'b0, in_delay_tap_out_0[29:16]};     end
    12'hbdb: begin y_rd_data =       in_delay_tap_out_0[15:0];              end
    12'hbda: begin y_rd_data =       {15'b0, io_reset_1};                   end
    12'hbd9: begin y_rd_data =       {15'b0, in_delay_reset_1};             end
    12'hbd8: begin y_rd_data =       {13'b0, bitslip_1[0],
                                             in_delay_ce_1[0],
                                             in_delay_inc_1[0]};            end
    12'hbd7: begin y_rd_data =       {2'b0, in_delay_tap_out_1[29:16]};     end
    12'hbd6: begin y_rd_data =       in_delay_tap_out_1[15:0];              end
    12'h8ff: begin y_rd_data =       {15'b0, led_toggle};                   end
    12'h8fe: begin y_rd_data =       lock_pe_cnt;                           end
    12'h8fd: begin y_rd_data =       {15'b0, rst_lock_pe_cnt};              end
    12'h8fc: begin y_rd_data =       {15'b0, spi_rst};                      end
    default:
      begin
  	    y_rd_data = xdom_dpram_rd_data;
      end
  endcase
end

///////////////////////////////////////////////////////////////////////////////
// Write registers (not task regs)
always @(posedge clk) begin
  wvb_trig_run_0 <= 0;
  wvb_trig_run_1 <= 0;

  dpram_done <= 0;

  wvb_arm_0 <= 0;
  wvb_arm_1 <= 0;

  rst_lock_pe_cnt <= 0;

  in_delay_ce_0 <= 6'b0;
  bitslip_0 <= 6'b0;
  in_delay_ce_1 <= 6'b0;
  bitslip_1 <= 6'b0;

  if (y_wr)
    case (y_adr)
      12'hffe: begin
        wvb_trig_et_0 <= y_wr_data[0];
        wvb_trig_gt_0 <= y_wr_data[1];
        wvb_trig_lt_0 <= y_wr_data[2];
        wvb_trig_thresh_trig_en_0 <= y_wr_data[3];
        wvb_trig_ext_trig_en_0 <= y_wr_data[4];
      end
      12'hffd: begin wvb_trig_thr_0 <= y_wr_data[11:0];                     end
      12'hffc: begin wvb_trig_run_0 <= y_wr_data[0];
                     wvb_trig_run_1 <= y_wr_data[1];                        end
      12'hffb: begin wvb_trig_mode_0 <= y_wr_data[0];                       end
      12'hffa: begin wvb_arm_0 <= y_wr_data[0];
                     wvb_arm_1 <= y_wr_data[1];                             end
      12'hff8: begin wvb_cnst_run_0 <= y_wr_data[0];                        end
      12'hff7: begin wvb_cnst_config_0 <= y_wr_data[14:0];                  end
      12'hff6: begin wvb_test_config_0 <= y_wr_data[14:0];                  end
      12'hff5: begin wvb_post_config_0 <= y_wr_data[14:0];                  end
      12'hff4: begin wvb_pre_config_0 <= y_wr_data[5:0];                    end
      12'hefe: begin
        wvb_trig_et_1 <= y_wr_data[0];
        wvb_trig_gt_1 <= y_wr_data[1];
        wvb_trig_lt_1 <= y_wr_data[2];
        wvb_trig_thresh_trig_en_1 <= y_wr_data[3];
        wvb_trig_ext_trig_en_1 <= y_wr_data[4];
      end
      12'hefd: begin wvb_trig_thr_1 <= y_wr_data[11:0];                     end
      12'hefb: begin wvb_trig_mode_1 <= y_wr_data[0];                       end
      12'hef8: begin wvb_cnst_run_1 <= y_wr_data[0];                        end
      12'hef7: begin wvb_cnst_config_1 <= y_wr_data[14:0];                  end
      12'hef6: begin wvb_test_config_1 <= y_wr_data[14:0];                  end
      12'hef5: begin wvb_post_config_1 <= y_wr_data[14:0];                  end
      12'hef4: begin wvb_pre_config_1 <= y_wr_data[5:0];                    end
      12'hef3: begin trig_link_enable <= y_wr_data[1:0];                    end
      12'hdfe: begin dpram_done <= y_wr_data[0];                            end
      12'hdfd: begin dpram_sel <= y_wr_data[0];                             end
      12'hdf9: begin wvb_rst[1:0] <= y_wr_data[1:0];                        end
      12'hdf8: begin wvb_reader_enable <= y_wr_data[0];                     end
      12'hdf7: begin wvb_reader_dpram_mode <= y_wr_data[0];                 end
      12'hbff: begin dac_sel <= y_wr_data[0];                               end
      12'hbfd: begin dac_spi_wr_data[23:16] <= y_wr_data[7:0];              end
      12'hbfc: begin dac_spi_wr_data[15:0] <= y_wr_data;                    end
      12'hbef: begin dig_sel <= y_wr_data[0];                               end
      12'hbed: begin dig_spi_wr_data <= y_wr_data;                          end
      12'hbdf: begin io_reset_0 <= y_wr_data[0];                            end
      12'hbde: begin in_delay_reset_0 <= y_wr_data[0];                      end
      12'hbdd: begin
        in_delay_inc_0[5:0] <= {6{y_wr_data[0]}};
        in_delay_ce_0[5:0] <= {6{y_wr_data[1]}};
        bitslip_0[5:0] <= {6{y_wr_data[2]}};
      end
      12'hbda: begin io_reset_1 <= y_wr_data[0];                            end
      12'hbd9: begin in_delay_reset_1 <= y_wr_data[0];                      end
      12'hbd8: begin
        in_delay_inc_1[5:0] <= {6{y_wr_data[0]}};
        in_delay_ce_1[5:0] <= {6{y_wr_data[1]}};
        bitslip_1[5:0] <= {6{y_wr_data[2]}};
      end
      12'h8ff: begin led_toggle <= y_wr_data[0];                            end
      12'h8fd: begin rst_lock_pe_cnt <= y_wr_data[0];                       end
      12'h8fc: begin spi_rst <= y_wr_data[0];                               end
      default: begin																										    end
    endcase
end

// scratch DPRAM for comms testing currently
wire[15:0] scratch_dpram_rd_data;
SCRATCH_DPRAM PG_DPRAM
(
  .clka(clk),
  .wea(y_wr && (y_adr[11]==0)),
  .addra(y_adr[10:0]),
  .dina(y_wr_data),
  .douta(scratch_dpram_rd_data),
  .clkb(clk),
  .web(1'b0),
  .addrb(11'b0),
  .dinb(16'b0),
  .doutb()
);

// direct readout DPRAM (rd only from xdom)
wire[15:0] direct_rdout_dpram_data;
DIRECT_RDOUT_DPRAM RDOUT_DPRAM
(
  .clka(clk),
  .wea(rdout_dpram_wren),
  .addra(rdout_dpram_wr_addr),
  .dina(rdout_dpram_data),
  .clkb(clk),
  .addrb(y_adr[10:0]),
  .doutb(direct_rdout_dpram_data)
);

//
// place rbd logic here for now
//
always @(posedge clk) begin
  if (rst) begin
    dpram_busy <= 0;
    dpram_len <= 0;
  end

  else begin
    if (rdout_dpram_run) begin
      dpram_len <= dpram_len_in;
      dpram_busy <= 1;
    end

    else if (dpram_done) begin
      dpram_busy <= 0;
      dpram_len <= 0;
    end
  end
end

//
// DPRAM read mux
//
always @(*) begin
  case (dpram_sel)
    0: xdom_dpram_rd_data = scratch_dpram_rd_data;
    1: xdom_dpram_rd_data = direct_rdout_dpram_data;
    default: xdom_dpram_rd_data = scratch_dpram_rd_data;
  endcase
end

// count dig 0 lock PE
wire dig0_lock_s;
wire dig0_lock_pe;
sync SYNC0(.clk(clk), .rst_n(!rst),
           .a(dig0_mmcm_locked), .y(dig0_lock_s));
posedge_detector LOCK_PE(.clk(clk), .rst_n(!rst),
                         .a(dig0_lock_s), .y(dig0_lock_pe));

always @(posedge clk) begin
  if (rst_lock_pe_cnt) begin
    lock_pe_cnt <= 0;
  end

  else if (dig0_lock_pe && (lock_pe_cnt != 16'hffff)) begin
    lock_pe_cnt <= lock_pe_cnt + 1;
  end
end



endmodule