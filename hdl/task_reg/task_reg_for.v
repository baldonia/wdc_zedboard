//////////////////////////////////////////////////////////////////////////////////
// Tyler Anderson Tue 06/18/2019_11:03:58.05
//
// task_reg.v
//
// This is a task request register, which has the following properties
// 1.) Data bus writes a 1 in order to request task execution
// 2.) Logic writes a 0 when the task is complete
// 3.) Data bus writes are OR'ed with current contents 
/////////////////////////////////////////////////////////////////////////////////

module task_reg
  (
   input 	     clk,
   input 	     rst,
   // data bus
   input [11:0]      adr,
   input 	     wr,
   input [15:0]      data,
   // logic
   output reg [15:0] req = 0,
   input [15:0]      ack,
   output reg [15:0] val = 0
   );

   // Parameters
   parameter P_TASK_ADR=12'hffe; 
   
   // For the acknowledge
   reg [15:0] 	     ack_prev=0;
   always @(posedge clk)
     if(rst) ack_prev <= 0;
     else ack_prev <= ack; 
   
   // The main logic
   genvar 	     i;
   for(i=0; i<16; i=i+1)
     always @(posedge clk)
       if(rst)
	 begin
	    val[i] <= 0;
	    req[i] <= 0;
	 end
       else
	 begin
	    req[i] <= 0;
	    case(val[i])
	      0:
		begin
		   if((adr == P_TASK_ADR) && wr) 
		     begin 
			val[i] <= val[i] | data[i]; 
		     end
		end
	      1:
		begin
		   req[i] <= 1;
		   if(ack[i])
		     req[i] <= 0;
		   if(ack_prev[i] && !ack[i]) // negative edge
		     begin
			req[i] <= 0;
			val[i] <= 0; 
		     end
		end // case: 1
	    endcase
	 end // else: !if(rst)
endmodule

// For emacs verilog-mode
// Local Variables:
// verilog-library-directories:("." "../negedge_detector")
// End:
