`timescale 1ns / 1ps
`include "Defintions.v"

`define STATE_RESET 0
`define STATE_DISPLAY 1 
`define STATE_PULSE 2
`define STATE_FRONT_PORCH 3
`define STATE_BACK_PORCH 4


module VGA_CONTROLLER # (parameter X_WIDTH=8, 
			 parameter Y_WIDTH=8,
			 parameter X_SIZE=256, 
			 parameter Y_SIZE=256
			 )
   (
    input wire 		     Clock,
    input wire 		     Reset,
    output wire [X_WIDTH-1:0] oVideoMemCol,
    output wire [Y_WIDTH-1:0] oVideoMemRow,
    output wire 	     oVGAHorizontalSync,
    output wire 	     oVGAVerticalSync,
    output wire 	     oDisplay
    );

   reg		      clk25;

   reg [X_WIDTH-1:0] 	      hCount;
   reg [Y_WIDTH-1:0] 	      vCount;

   initial begin
      clk25 = 1'b0;
   end
   
   always @(posedge Clock) clk25 <= ~clk25;


   assign oVGAHorizontalSync = (hCount >= 648 && hCount <= 744)? 1'b0 : 1'b1;
   assign oVGAVerticalSync = (vCount >= 488 && vCount <= 489)? 1'b0 : 1'b1;
   assign oDisplay = (hCount <= 639 && vCount <= 479)? 1'b1 : 1'b0;

   assign oVideoMemCol 	= (oDisplay == 1'b1) ? hCount : 0;
   assign oVideoMemRow 	= (oDisplay == 1'b1) ? vCount : 0;
 
   
   always @(posedge clk25) 
      begin
	 if(Reset) 
	    begin
	       hCount <= 0;
	       vCount <= 0;
	    end
	 else
	    begin
	       if (hCount < 799)
		  hCount <= hCount + 1;
	       else
		  begin
		     hCount <= 0;
		     if (vCount < 524)
			vCount <= vCount + 1;
		     else
			vCount <= 0;
		  end
	    end
      end
   

endmodule
