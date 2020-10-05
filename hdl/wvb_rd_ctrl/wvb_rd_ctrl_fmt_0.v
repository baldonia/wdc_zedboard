// Aaron Fienberg
// October 2020
//
// wdc zedboard waveform buffer read control format 0
//
// DPRAM mode 0: truncate after first DPRAM
// DPRAM mode 1: extend across multiple DPRAMs
//
// rd_ctrl_more signal indicates that after filling one DPRAM, there
// is still more data to write.
//
// Writes 32-bit words; order of 16-bit sub-words within the 32-bit words
// set so that, when read as a sequence of 16-bit words through the 
// direct readout DPRAM read port, the order will be as written below
//
// Waveform Format 0:
//
// CHANNEL      - [15] 1
//                [14:8] Waveform Format
//                [7:0]  Channel Number
// EVT_LEN      - Number of samples in the waveform
// HDR_0        - [15:10] - preconf (will be 0 for hdr fmt 1)
//                   [9] - cnst run mode
//                  [8:2] - 0
//                  [1:0] - trigger type (sw, thresh, link, ext)
// LTC_2        - LTC[47:32]
// LTC_1        - LTC[31:16]
// LTC_0        - LTC[15:0]
// ADC_WORD_0     - {2'b0, ADC_WORD_0, TOT_0, 0}
// ADC_WORD_1     - {2'b0, ADC_WORD_1, TOT_1, EOE}
// .... (repeat of ADC_WORD_0, ADC_WORD_1 words)
// FTR_1 - repeat of EVT_LEN
// FTR_0 - repeat of HDR_0
//
//

module wvb_rd_ctrl_fmt_0 #(parameter P_WVB_ADR_WIDTH = 15,
                           parameter P_DATA_WIDTH = 28,
                           parameter P_HDR_WIDTH = 87)
(
  input clk,
  input rst,

  // wvb_reader interface
  input req,
  input[7:0] idx,
  input dpram_mode,
  output reg ack = 0,
  output reg rd_ctrl_more = 0,

  // WVB interface
  input[P_DATA_WIDTH-1:0] wvb_data,
  input[P_HDR_WIDTH-1:0] hdr_data,
  output reg wvb_rdreq = 0,
  output reg wvb_rddone = 0,

  // DPRAM interface
  output reg[9:0] dpram_a = 0,
  output reg[31:0] dpram_data = 0,
  output reg dpram_wren = 0,
  output reg[15:0] dpram_len = 0
);


// header fan out
wire[P_WVB_ADR_WIDTH-1:0] start_addr;
wire[P_WVB_ADR_WIDTH-1:0] stop_addr;
wire[47:0] evt_ltc;
wire[1:0] trig_src;
wire cnst_run;
wire[4:0] pre_conf;

cuppa_wvb_hdr_bundle_0_fan_out HDR_FAN_OUT 
(
  .bundle(hdr_data),
  .evt_ltc(evt_ltc),
  .start_addr(start_addr),
  .stop_addr(stop_addr),
  .trig_src(trig_src),
  .cnst_run(cnst_run),
  .pre_conf(pre_conf)
);

// calculate evt_len 
wire[P_WVB_ADR_WIDTH-1:0] addr_diff = stop_addr - start_addr;
wire[15:0] evt_len = addr_diff + 16'd1;

// decode wvb_data
wire[11:0] wvb_adc_1 = wvb_data[27:16];
wire[11:0] wvb_adc_0 = wvb_data[13:2];
wire wvb_tot_1 = wvb_data[15];
wire wvb_tot_0 = wvb_data[1];
wire wvb_eoe = wvb_data[0];

// header 0 word
wire[15:0] hdr_0 = {pre_conf, cnst_run, 8'b0, trig_src};

// constants
localparam L_FMT = 8'h80;
localparam L_DPRAM_A_LAST_DATA=10'd1021;
localparam L_DPRAM_A_LAST_DATA_CONTINUE=10'd1022;
localparam L_DPRAM_A_LAST = 10'd1023;
localparam L_DPRAM_A_STOP_STREAM = 10'd1017;
localparam L_RD_WAIT_CNT_MAX = 4;

// FSM logic
localparam 
  S_IDLE = 0,
  S_CHAN_LEN = 1,
  S_HDR_0_LTC_2 = 2,
  S_LTC_1_LTC_0 = 3,
  S_SAMPLE_WORD = 4,
  S_FTR = 5,
  S_ACK = 6,
  S_REQ_WAIT = 7,
  S_RD_WAIT = 8,
  S_START_STREAM = 9;

reg[3:0] fsm = S_IDLE;
reg loop_s_ftr = 0;
reg[31:0] wait_cnt = 0;
// register evt_len for improved timing
reg[15:0] evt_len_reg = 0;

always @(posedge clk) begin
  if (rst) begin
    ack <= 0;
    rd_ctrl_more <= 0;
    wvb_rdreq <= 0;
    wvb_rddone <= 0;
    dpram_a <= 0;
    dpram_data <= 0;
    dpram_wren <= 0;
    dpram_len <= 0;

    loop_s_ftr <= 0;
    wait_cnt <= 0;
    evt_len_reg <= 0;

    fsm <= S_IDLE;
  end

  else begin
    ack <= 0;
    dpram_wren <= 0;
    wvb_rddone <= 0;
    wvb_rdreq <= 0;

    case (fsm)
      S_IDLE: begin
        dpram_a <= 0;
        dpram_len <= 0;
        rd_ctrl_more <= 0;
        
        loop_s_ftr <= 0;
        wait_cnt <= 0;
        evt_len_reg <= 0;

        if (req) begin          
          // begin streaming the sample data
          wvb_rdreq <= 1;     
          evt_len_reg <= evt_len;
          
          fsm <= S_START_STREAM;
        end
      end

      S_START_STREAM: begin
        wvb_rdreq <= 1;
        fsm <= S_CHAN_LEN;
      end

      S_CHAN_LEN: begin
        dpram_data <= {evt_len_reg, L_FMT, idx};
                
        wvb_rdreq <= 1;        
        dpram_wren <= 1;        
        fsm <= S_HDR_0_LTC_2;
      end

      S_HDR_0_LTC_2: begin
        dpram_data <= {evt_ltc[47:32], hdr_0};
        
        wvb_rdreq <= 1;
        dpram_wren <= 1;
        dpram_a <= dpram_a + 1;
        fsm <= S_LTC_1_LTC_0;
      end

      S_LTC_1_LTC_0: begin
        dpram_data <= {evt_ltc[15:0], evt_ltc[31:16]};

        wvb_rdreq <= 1;
        dpram_wren <= 1;
        dpram_a <= dpram_a + 1;
        fsm <= S_SAMPLE_WORD;
      end

      S_SAMPLE_WORD: begin
        dpram_data <= {2'b0, wvb_adc_1, wvb_tot_1, wvb_eoe,
                       2'b0, wvb_adc_0, wvb_tot_0, 1'b0};

        // stop streaming data when nearing end of DPRAM
        // (but not if dpram_a == L_DPRAM_LAST, which
        //  indicates we're starting a new DPRAM in mode 1)
        if ( (dpram_a < L_DPRAM_A_STOP_STREAM) ||
             (dpram_a == L_DPRAM_A_LAST) ) begin
          wvb_rdreq <= 1;          
        end

        dpram_wren <= 1;
        dpram_a <= dpram_a + 1;

        fsm <= S_SAMPLE_WORD;

        if (dpram_mode == 0) begin
          if ((dpram_a == L_DPRAM_A_LAST_DATA) 
               || wvb_eoe)  begin
            // in dpram mode 0, stop writing data if we 
            // reach end of DPRAM or if we see the EOE
            wvb_rddone <= 1;
            fsm <= S_FTR;
          end
        end

        else if (dpram_mode == 1) begin          
          if (wvb_eoe) begin
            fsm <= S_FTR;
            wvb_rddone <= 1;
          end

          else if (dpram_a == L_DPRAM_A_LAST_DATA_CONTINUE) begin
            fsm <= S_ACK;
            rd_ctrl_more <= 1;
          end
        end
      end

      S_FTR: begin
        if (dpram_a != L_DPRAM_A_LAST || loop_s_ftr) begin
          dpram_data <= {hdr_0, evt_len_reg};

          dpram_wren <= 1;
          dpram_a <= dpram_a + 1;

          loop_s_ftr <= 0;

          rd_ctrl_more <= 0;
          fsm <= S_ACK;
        end

        else begin
          loop_s_ftr <= 1;
          rd_ctrl_more <= 1;

          fsm <= S_ACK;
        end
      end

      S_ACK: begin
        // convert to number of 16 bit words
        dpram_len <= (dpram_a + 16'd1) << 1'b1; 
        ack <= 1;

        if (!req) begin
          ack <= 0;
          dpram_len <= 0;

          if (rd_ctrl_more) begin
            fsm <= S_REQ_WAIT;
          end

          else begin
            fsm <= S_IDLE;
          end
        end
      end

      S_REQ_WAIT: begin
        if (req) begin
          if (loop_s_ftr) begin
            fsm <= S_FTR;
          end

          else begin
            wvb_rdreq <= 1;
            wait_cnt <= 0;
            fsm <= S_RD_WAIT;
          end
        end
      end

      S_RD_WAIT: begin
        wait_cnt <= wait_cnt + 1;
        wvb_rdreq <= 1;
        
        if (wait_cnt == L_RD_WAIT_CNT_MAX) begin
          fsm <= S_SAMPLE_WORD;  
        end
      end

      default: begin
        fsm <= S_IDLE;
      end
    endcase
  end
end

endmodule