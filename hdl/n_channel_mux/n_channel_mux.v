// Aaron Fienberg
// August 2020
//
// Parameters: N inputs, input-width, selector width 
//
// Inputs: N input-width width signals 
//         output selector
// Output: One input-width wide signal 
//         equal to the selected input channel
//
// Purely combinational logic

module n_channel_mux #(parameter N_INPUTS = 8,
	                     parameter INPUT_WIDTH = 22,
	                     parameter SEL_WIDTH = 5)

(
	input[N_INPUTS*INPUT_WIDTH-1:0] in,
	input[SEL_WIDTH-1:0] sel,
	output reg[INPUT_WIDTH-1:0] out = 0
);

wire[INPUT_WIDTH-1:0] input_array[0:N_INPUTS-1];

generate
	genvar i_in;
	for (i_in = 0; i_in < N_INPUTS; i_in = i_in + 1) begin
		assign input_array[i_in] = 
		    in[INPUT_WIDTH*(i_in+1) - 1 : INPUT_WIDTH*i_in];
	end
endgenerate

always @(*) begin
  out = input_array[sel];
end

endmodule