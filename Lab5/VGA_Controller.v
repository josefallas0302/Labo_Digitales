`timescale 1ns / 1ps
`include "Defintions.v"


module VGA_CONTROLLER # (parameter X_WIDTH=8, 
			 parameter Y_WIDTH=8
			 )
   (
    input wire 		      Clock,
    input wire 		      Reset,
    output wire [X_WIDTH-1:0] oVideoMemCol,
    output wire [Y_WIDTH-1:0] oVideoMemRow,
    output wire 	      oVGAHorizontalSync,
    output wire 	      oVGAVerticalSync,
    output wire 	      oDisplay
    );

   reg [X_WIDTH-1:0] 	      rHCount;
   reg [Y_WIDTH-1:0] 	      rVCount;


   assign oVGAHorizontalSync = !(rHCount >= `HSYNC_START && rHCount < `HSYNC_END);
   assign oVGAVerticalSync = !(rVCount >= `VSYNC_START && rVCount < `VSYNC_END);
   assign oDisplay = (rHCount < `VGA_X_RES && rVCount < `VGA_Y_RES);

   assign oVideoMemCol 	= (oDisplay == 1'b1) ? rHCount : 0;
   assign oVideoMemRow 	= (oDisplay == 1'b1) ? rVCount : 0;

   
   always @(posedge Clock) begin
      if(Reset) begin
	 rHCount <= 0;
	 rVCount <= 0;
      end
      else begin
	 if (rHCount < `H_TOTAL_T)
	    rHCount <= rHCount + 1;
	 else begin
	    rHCount <= 0;
	    if (rVCount < `V_TOTAL_T) 
	       rVCount <= rVCount + 1;
	    else
	       rVCount <= 0;
	 end
      end
   end
   
endmodule
