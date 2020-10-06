// Aaron Fienberg
// October 2020
//
// generates fake ADC data to faciliate testing the buffering
// and readout firmware
//

module data_gen #(parameter[11:0] P_ADC_RAMP_START = 0)                  
(
  input clk,
  input rst,
  output reg[11:0] adc_stream_0 = P_ADC_RAMP_START,
  output reg[11:0] adc_stream_1 = P_ADC_RAMP_START + 1'b1
);

// register synchronous reset
(* DONT_TOUCH = "true" *) reg i_rst = 0;
always @(posedge clk) begin
  i_rst <= rst;
end

always @(posedge clk) begin
  if (i_rst) begin
    adc_stream_0 <= P_ADC_RAMP_START;
    adc_stream_1 <= P_ADC_RAMP_START + 1;
  end

  else begin
    adc_stream_0 <= adc_stream_0 + 2'd2;
    adc_stream_1 <= adc_stream_1 + 2'd2;
  end
end

endmodule
