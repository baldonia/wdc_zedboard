//////////////////////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Tue 06/18/2019_12:47:27.74
//
// tb.v
//
// Task registers from address bus
//////////////////////////////////////////////////////////////////////////////////////////////////

`timescale 1ns/1ns

//////////////////////////////////////////////////////////////////////////////////////////////////
// Test cases
//////////////////////////////////////////////////////////////////////////////////////////////////
// `define TEST_CASE_1
`define TEST_CASE_2

module tb;
   
   //////////////////////////////////////////////////////////////////////
   // I/O
   //////////////////////////////////////////////////////////////////////   
   parameter CLK_PERIOD = 10;
   reg clk;
   reg rst;

   // Connections
   /*AUTOWIRE*/
   // Beginning of automatic wires (for undeclared instantiated-module outputs)
   wire [15:0]		req;			// From UUT_0 of task_reg.v
   wire [15:0]		val;			// From UUT_0 of task_reg.v
   // End of automatics
   /*AUTOREGINPUT*/
   // Beginning of automatic reg inputs (for undeclared instantiated-module inputs)
   reg [15:0]		ack;			// To UUT_0 of task_reg.v
   reg [11:0]		adr;			// To UUT_0 of task_reg.v
   reg [15:0]		data;			// To UUT_0 of task_reg.v
   reg			wr;			// To UUT_0 of task_reg.v
   // End of automatics
   
   //////////////////////////////////////////////////////////////////////
   // Clock Driver
   //////////////////////////////////////////////////////////////////////
   always @(clk)
     #(CLK_PERIOD / 2.0) clk <= !clk;
				   
   //////////////////////////////////////////////////////////////////////
   // Simulated interfaces
   //////////////////////////////////////////////////////////////////////   
      
   //////////////////////////////////////////////////////////////////////
   // UUT
   //////////////////////////////////////////////////////////////////////   
   task_reg #(.P_TASK_ADR(12'hffe)) UUT_0(/*AUTOINST*/
					  // Outputs
					  .req			(req[15:0]),
					  .val			(val[15:0]),
					  // Inputs
					  .clk			(clk),
					  .rst			(rst),
					  .adr			(adr[11:0]),
					  .wr			(wr),
					  .data			(data[15:0]),
					  .ack			(ack[15:0])); 
   

   //////////////////////////////////////////////////////////////////////
   // Test case
   //////////////////////////////////////////////////////////////////////   
   `ifdef TEST_CASE_1
   integer 		i; 
   initial
     begin
	i = 0; 
	clk = 0;
	rst = 1;
	ack = 0;
	adr = 0;
	data = 0;
	wr = 0; 
	// Reset	
	#(10 * CLK_PERIOD);
	rst = 1'b0;
	#(20* CLK_PERIOD);

	// Logging
	$display("");
	$display("------------------------------------------------------");
	$display("Test Case: TEST_CASE_1");

	// Stimulate UUT
	for(i=0; i<16; i=i+1)
	  begin
	     @(posedge clk) 
	       begin 
		  adr <= 12'hffe; 
		  wr <= 1; 
		  data <= 16'h0001 << i; 
	       end 
	     @(posedge clk) wr <= 0; 
	     wait(req[i]==1); #1; 
	     @(posedge clk) ack[i] <= 1;
	     wait(req[i]==0); #1; 
	     @(posedge clk) ack[i] <= 0;
	     #(10*CLK_PERIOD); 
	  end
     end
   `endif //  `ifdef TEST_CASE_1
	
   `ifdef TEST_CASE_2 // run 2 tasks at the same time and make sure they work
   integer j; 
   initial
     begin
	ack = 0;
	j = 0;
     end
   always @(posedge clk)
     begin
	for(j=0; j<16; j=j+1)
	  ack[j] <= req[j];
     end
   integer 		i; 
   initial
     begin
	i = 0; 
	clk = 0;
	rst = 1;
	adr = 0;
	data = 0;
	wr = 0; 
	// Reset	
	#(10 * CLK_PERIOD);
	rst = 1'b0;
	#(20* CLK_PERIOD);

	// Logging
	$display("");
	$display("------------------------------------------------------");
	$display("Test Case: TEST_CASE_2");

	// Stimulate UUT
	for(i=0; i<16; i=i+1)
	  begin
	     @(posedge clk) 
	       begin 
		  adr <= 12'hffe; 
		  wr <= 1; 
		  data <= 16'h0001 << i; 
	       end
	     @(posedge clk) 
	       begin 
		  adr <= 12'hffe; 
		  wr <= 1; 
		  data <= 16'h0002 << i; 
	       end
	     @(posedge clk) wr <= 0; 
	     #(10*CLK_PERIOD); 
	  end	
     end
   `endif

   //////////////////////////////////////////////////////////////////////
   // Tasks (e.g., writing data, etc.)
   //////////////////////////////////////////////////////////////////////   
   
   
   
endmodule

// Local Variables:
// verilog-library-flags:("-y ../")
// End:
   
