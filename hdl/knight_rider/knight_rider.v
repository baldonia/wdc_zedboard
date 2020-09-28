// Aaron Fienberg
// Sept 2019
//
// module to generate a knight rider LED pattern

module knight_rider #(parameter TICKS_PER_STATE=32'd20_000_000) (
  input clk,
  input rst,  
  output reg[7:0] y=0
);

// counter
reg[31:0] cnt = 0;

localparam S_LEFT = 1'd0,
           S_RIGHT = 1'd1;
reg fsm=S_LEFT;

always @(posedge clk) begin
  if (rst || y == 0) begin
    cnt <= 0;
    y <= 1;

    fsm <= S_LEFT;
  end

  else begin
    cnt <= cnt + 1;
    
    if (cnt >= TICKS_PER_STATE - 1) begin
    
      cnt <= 0;
      
      case (fsm) 
       
        S_LEFT: begin
          y <= y << 1;
          if (y == 8'h40) begin
            fsm <= S_RIGHT;
          end
        end

        S_RIGHT: begin
          y <= y >> 1;
          if (y == 4'h2) begin
            fsm <= S_LEFT;
          end
        end

        default: begin
          cnt <= 0;
          y <= 1;
          fsm <= S_LEFT;
        end
    
      endcase    
    end
  end
end

endmodule