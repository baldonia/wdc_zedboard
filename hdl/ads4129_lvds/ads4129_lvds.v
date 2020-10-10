// Aaron Fienberg
// October 2020
//
// ADS4129 LVDS interface for the prototype WDC zedboard project
//
// Outputs two parallel 12-bit words
//

module ads4129_lvds #(parameter P_ODD_CHANNEL="FALSE")
(
  input clk, // 125 MHz
  input dclk, // 250 MHz
  input rst, // logic clk reset

  // raw data in/out
  input[5:0] data_p,
  input[5:0] data_n,

  output reg[11:0] sample_0 = 0,
  output reg[11:0] sample_1 = 0,

  // IDELAY / bitslip controls
  // all should be synchronous to 125 MHz clk
  // here I assume that the external driver of these signals
  // ensures they are high for the correct number of clk cycles
  input io_reset,

  input[5:0] bitslip,

  input in_delay_reset,
  input[5:0] in_delay_ce,
  input[5:0] in_delay_inc,

  output[29:0] in_delay_tap_out
);

wire[23:0] raw_bits_out;
ADC_SELECT_IO ADC_IO_0
(
  .clk_in(dclk),
  .clk_div_in(clk),
  .io_reset(io_reset),

  .data_in_from_pins_p(data_p),
  .data_in_from_pins_n(data_n),
  .data_in_to_device(raw_bits_out),

  // .bitslip(bitslip),
  // do not allow bitslips for now
  .bitslip(6'b0),

  .in_delay_reset(in_delay_reset),
  .in_delay_data_ce(in_delay_ce),
  .in_delay_data_inc(in_delay_inc),
  .in_delay_tap_in(29'b0),
  .in_delay_tap_out(in_delay_tap_out)
);

generate

wire[23:0] adjusted_raw_bits_out;
if (P_ODD_CHANNEL == "FALSE") begin
  // don't need to do anything special for the even channel
  assign adjusted_raw_bits_out = raw_bits_out;
end

else if (P_ODD_CHANNEL == "TRUE") begin
  // the odd channel's data captured using the clock from the
  // even channel will be off by one bit.
  // Here I manually bitslip to handle that
  reg[5:0] last_upper = 0;
  always @(posedge clk) begin
    last_upper <= raw_bits_out[23:18];
  end

  assign adjusted_raw_bits_out = {raw_bits_out[17:0],
                                  last_upper};
end

else begin
  invalid_parameter p_odd_chan_must_be_true_or_false();
end

endgenerate

// select_io wiz presents data as a sequence of
// 6-bit words; [5:0] are the even bits of the of the first word
// here I manually interleave the bits to build the ADC words
wire[11:0] i_sample_0 = {adjusted_raw_bits_out[11],
                         adjusted_raw_bits_out[5],
                         adjusted_raw_bits_out[10],
                         adjusted_raw_bits_out[4],
                         adjusted_raw_bits_out[9],
                         adjusted_raw_bits_out[3],
                         adjusted_raw_bits_out[8],
                         adjusted_raw_bits_out[2],
                         adjusted_raw_bits_out[7],
                         adjusted_raw_bits_out[1],
                         adjusted_raw_bits_out[6],
                         adjusted_raw_bits_out[0]};

wire[11:0] i_sample_1 = {adjusted_raw_bits_out[23],
                         adjusted_raw_bits_out[17],
                         adjusted_raw_bits_out[22],
                         adjusted_raw_bits_out[16],
                         adjusted_raw_bits_out[21],
                         adjusted_raw_bits_out[15],
                         adjusted_raw_bits_out[20],
                         adjusted_raw_bits_out[14],
                         adjusted_raw_bits_out[19],
                         adjusted_raw_bits_out[13],
                         adjusted_raw_bits_out[18],
                         adjusted_raw_bits_out[12]};

always @(posedge clk) begin

  if (rst) begin
    sample_0 <= 0;
    sample_1 <= 0;
  end

  else begin
    sample_0 <= i_sample_0;
    sample_1 <= i_sample_1;
  end
end


endmodule