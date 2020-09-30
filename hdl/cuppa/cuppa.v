// Aaron Fienberg
// September 2020
//
// Like xdom, but for cuppa
// provides the cuppa register interface

module cuppa
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

  // turn KR pattern on and off
  output reg led_toggle = 1,

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

//////////////////////////////////////////////////////////////////////////////
// Read registers
reg[15:0] reg_dpram_rd_data;

always @(*) begin
  case(y_adr)
    12'hfff: begin y_rd_data =       vnum;                                  end
    12'hbff: begin y_rd_data =       dac_sel;                               end
    12'hbfe: begin y_rd_data =       dac_task_val;                          end
    12'hbfd: begin y_rd_data =       {8'b0, dac_spi_wr_data[23:16]};        end
    12'hbfc: begin y_rd_data =       dac_spi_wr_data[15:0];                 end    
    12'h8ff: begin y_rd_data =       {15'h0, led_toggle};                   end
    default: 
      begin
  	    y_rd_data = reg_dpram_rd_data;
      end 
  endcase
end

///////////////////////////////////////////////////////////////////////////////
// Write registers (not task regs)
always @(posedge clk) begin
  if (y_wr) 
    case (y_adr)
      12'hbff: begin dac_sel <= y_wr_data[0];                               end
      12'hbfd: begin dac_spi_wr_data[23:16] <= y_wr_data[7:0];              end
      12'hbfc: begin dac_spi_wr_data[15:0] <= y_wr_data;                    end
      12'h8ff: begin led_toggle <= y_wr_data[0];                            end
      default: begin																										    end
    endcase
end

// scratch DPRAM for comms testing currently 
wire[15:0] scratch_dpram_reg_out;
SCRATCH_DPRAM PG_DPRAM
(
  .clka(clk),
  .wea(y_wr && (y_adr[11]==0)),
  .addra(y_adr[10:0]),
  .dina(y_wr_data),
  .douta(scratch_dpram_reg_out),
  .clkb(clk),
  .web(1'b0),
  .addrb(11'b0),
  .dinb(16'b0),
  .doutb()
);

// placeholder for DPRAM mux
always @(*) begin
	reg_dpram_rd_data = scratch_dpram_reg_out;
end

endmodule