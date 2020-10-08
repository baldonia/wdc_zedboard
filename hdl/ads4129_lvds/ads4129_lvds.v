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

  .bitslip(bitslip),

  .in_delay_reset(in_delay_reset),
  .in_delay_data_ce(in_delay_ce),
  .in_delay_data_inc(in_delay_inc),
  .in_delay_tap_in(29'b0),
  .in_delay_tap_out(in_delay_tap_out)
);

generate
// code to assemble the even channel ADC words
if (P_ODD_CHANNEL == "FALSE") begin
  // select_io wiz presents data as a sequence of
  // 6-bit words; [5:0] are the even bits of the of the first word
  // here I manually interleave the bits to build the ADC words

  wire[11:0] i_sample_0 = {raw_bits_out[11],
                           raw_bits_out[5],
                           raw_bits_out[10],
                           raw_bits_out[4],
                           raw_bits_out[9],
                           raw_bits_out[3],
                           raw_bits_out[8],
                           raw_bits_out[2],
                           raw_bits_out[7],
                           raw_bits_out[1],
                           raw_bits_out[6],
                           raw_bits_out[0]};

  wire[11:0] i_sample_1 = {raw_bits_out[23],
                           raw_bits_out[17],
                           raw_bits_out[22],
                           raw_bits_out[16],
                           raw_bits_out[21],
                           raw_bits_out[15],
                           raw_bits_out[20],
                           raw_bits_out[14],
                           raw_bits_out[19],
                           raw_bits_out[13],
                           raw_bits_out[18],
                           raw_bits_out[12]};

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

end

else begin
  not_yet_implemented odd_chan_not_yet_implemented();
end

endgenerate


endmodule