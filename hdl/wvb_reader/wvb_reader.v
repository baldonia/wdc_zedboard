// Aaron Fienberg
// October 2020
//
// WDC zedboard waveform buffer reader
//
// cycles between multiple input channels
//
// the WVB reader transfers data from the waveform buffers to DPRAMs
// in 32-bit words
//

module wvb_reader #(parameter P_DATA_WIDTH = 28,
                    parameter N_CHANNELS = 2,
                    parameter P_WVB_ADR_WIDTH = 15,
                    parameter P_DPRAM_ADR_WIDTH = 10,
                    parameter P_HDR_WIDTH = 87,
                    parameter P_FMT = 0
                   )
(
  input clk,
  input rst,
  input en, //enable

  // DPRAM interface

  // Outputs
  output[31:0] dpram_data,
  output[P_DPRAM_ADR_WIDTH-1:0] dpram_addr,
  output dpram_wren,
  output reg[15:0] dpram_len = 0,
  output reg dpram_run = 0,

  // Inputs
  input dpram_busy,
  input dpram_mode,

  // WVB interface

  // Outputs
  output[N_CHANNELS-1:0] hdr_rdreq,
  output[N_CHANNELS-1:0] wvb_rdreq,
  output[N_CHANNELS-1:0] wvb_rddone,

  // Inputs
  input[N_CHANNELS*P_DATA_WIDTH-1:0] wvb_data,
  input[N_CHANNELS*P_HDR_WIDTH-1:0] hdr_data,
  input[N_CHANNELS-1:0] hdr_empty
);

// handle multiplexing/demultiplexing
(* max_fanout = 20 *) reg[4:0] chan_index = 0; 
wire[P_DATA_WIDTH-1:0] wvb_data_mux_out;
wire[P_HDR_WIDTH-1:0] hdr_data_mux_out;
wire hdr_empty_mux_out;

// register signals going into muxes 
// Note: currently not registering hdr_empty to simplify
// state machine logic
reg[N_CHANNELS*P_DATA_WIDTH-1:0] wvb_data_reg = 0;
reg[N_CHANNELS*P_HDR_WIDTH-1:0] hdr_data_reg = 0;
// reg[N_CHANNELS-1:0] hdr_empty_reg = 0;
// also register data coming out of the mux
reg[P_DATA_WIDTH-1:0] wvb_data_mux_out_reg = 0;
reg[P_HDR_WIDTH-1:0] hdr_data_mux_out_reg = 0;
// reg hdr_empty_mux_out_reg = 0;
always @(posedge clk) begin
  if (rst) begin
    wvb_data_reg <= 0;
    hdr_data_reg <= 0;
    // hdr_empty_reg <= 0;
    wvb_data_mux_out_reg <= 0;
    hdr_data_mux_out_reg <= 0;
    // hdr_empty_mux_out_reg <= 0;
  end

  else begin
    wvb_data_reg <= wvb_data;
    hdr_data_reg <= hdr_data;
    // hdr_empty_reg <= hdr_empty;
    wvb_data_mux_out_reg <= wvb_data_mux_out;
    hdr_data_mux_out_reg <= hdr_data_mux_out;
    // hdr_empty_mux_out_reg <= hdr_empty_mux_out;
  end
end

n_channel_mux #(.N_INPUTS(N_CHANNELS), 
                .INPUT_WIDTH(P_DATA_WIDTH)) WVB_DATA_MUX
  (
   .in(wvb_data_reg),
   .sel(chan_index),
   .out(wvb_data_mux_out)  
  );

n_channel_mux #(.N_INPUTS(N_CHANNELS), 
                .INPUT_WIDTH(P_HDR_WIDTH)) HDR_DATA_MUX
  (
   .in(hdr_data_reg),
   .sel(chan_index),
   .out(hdr_data_mux_out)  
  );

n_channel_mux #(.N_INPUTS(N_CHANNELS), 
                .INPUT_WIDTH(1)) HDR_EMPTY_MUX
  (
   .in(hdr_empty),
   .sel(chan_index),
   .out(hdr_empty_mux_out)  
  );

reg i_hdr_rdreq = 0;
wire i_wvb_rdreq;
wire i_wvb_rddone;
generate
  genvar i;
  for (i = 0; i < N_CHANNELS; i = i + 1) begin : reader_demux
    assign hdr_rdreq[i] = i_hdr_rdreq && (chan_index == i);
    assign wvb_rdreq[i] = i_wvb_rdreq && (chan_index == i);
    assign wvb_rddone[i] = i_wvb_rddone && (chan_index == i);
  end
endgenerate

//
// Read controller instantiation
//

reg rd_ctrl_req = 0;
wire rd_ctrl_ack;
wire rd_ctrl_more; // indicates that there is more data to write in the next DPRAM
wire[15:0] rd_ctrl_dpram_len;

// read controller
wvb_rd_ctrl_fmt_0 #(.P_WVB_ADR_WIDTH(P_WVB_ADR_WIDTH),
                    .P_HDR_WIDTH(P_HDR_WIDTH)) 
RD_CTRL
  (
   .clk(clk),
   .rst(rst),
   .req(rd_ctrl_req),
   .idx({3'b0, chan_index}),
   .dpram_mode(dpram_mode),
   .ack(rd_ctrl_ack),
   .rd_ctrl_more(rd_ctrl_more),
   .wvb_data(wvb_data_mux_out_reg),
   .hdr_data(hdr_data_mux_out_reg),
   .wvb_rdreq(i_wvb_rdreq),
   .wvb_rddone(i_wvb_rddone),
   .dpram_a(dpram_addr),
   .dpram_data(dpram_data),
   .dpram_wren(dpram_wren),
   .dpram_len(rd_ctrl_dpram_len)
  );

// FSM logic
reg[3:0] fsm = 0;
localparam
  S_IDLE = 0,
  S_HDR_WAIT = 1,
  S_RD_CTRL_REQ = 2,
  S_DPRAM_RUN = 3,
  S_DPRAM_BUSY = 4,
  S_DPRAM_DONE = 5;


reg[31:0] cnt = 0;
localparam HDR_WT_CNT = 3;

always @(posedge clk) begin
  if (rst || !en) begin
    fsm <= S_IDLE;

    cnt <= 0;
    rd_ctrl_req <= 0;
    i_hdr_rdreq <= 0;
    dpram_run <= 0;
    dpram_len <= 0;
    chan_index <= 0;
  end

  else begin
    i_hdr_rdreq <= 0;
    dpram_run <= 0;

    case (fsm) 
      S_IDLE: begin
        rd_ctrl_req <= 0;
        cnt <= 0;

        if (!hdr_empty_mux_out && !dpram_busy && !rd_ctrl_ack) begin
          i_hdr_rdreq <= 1;
          fsm <= S_HDR_WAIT;
        end

        else begin
          // cycle to the next channel
          chan_index <= (chan_index + 1) % N_CHANNELS;
          fsm <= S_IDLE;
        end
      end

      S_HDR_WAIT: begin
        // wait for HDR to become available
        cnt <= cnt + 1;
        if (cnt == HDR_WT_CNT - 1) begin
          cnt <= 0;
          fsm <= S_RD_CTRL_REQ;
        end
      end 
    
      S_RD_CTRL_REQ: begin
        rd_ctrl_req <= 1;
        // wait for ack
        if (rd_ctrl_ack) begin
          rd_ctrl_req <= 0;
          dpram_len <= rd_ctrl_dpram_len;
          fsm <= S_DPRAM_RUN;
        end
      end

      S_DPRAM_RUN: begin
        if (!dpram_busy) begin
          dpram_run <= 1;
          fsm <= S_DPRAM_BUSY;
        end
      end

      S_DPRAM_BUSY: begin
        // wait for DPRAM to become busy
        if (dpram_busy) begin
          fsm <= S_DPRAM_DONE;
        end
      end

      S_DPRAM_DONE: begin
        // wait for DPRAM to be done (no longer busy)
        if (!dpram_busy) begin
          if (dpram_mode == 1 && rd_ctrl_more) begin
            // more data to read
            if (!rd_ctrl_ack) begin
              fsm <= S_RD_CTRL_REQ;
            end
          end

          else begin
            // cycle to the next channel
            chan_index <= (chan_index + 1) % N_CHANNELS;
            fsm <= S_IDLE;
          end
        end
      end

      default: begin
        fsm <= S_IDLE;
      end
    
    endcase
  end
end

endmodule