`timescale 1ns / 1ps
`include "Defintions.v"


module VGA_CHECKBOARD_PIXEL_GEN # (parameter X_WIDTH=8, 
				   parameter Y_WIDTH=8, 
				   parameter X_SIZE=256, 
				   parameter Y_SIZE=256,
				   parameter BLOCK_WIDTH_X=64,
				   parameter BLOCK_WIDTH_Y=64
				)
   (
    input wire 	      Clock,
    input wire 	      Reset,
    input wire [3:0]  iMarkedBlockPosX,
    input wire [3:0]  iMarkedBlockPosY,
    output reg [2:0] oVGAColor,
    output wire       oVGAHorizontalSync,
    output wire       oVGAVerticalSync
    );

   wire [X_WIDTH-1:0] wVideoCol;
   wire [Y_WIDTH-1:0] wVideoRow;

   wire 	      wNormalColorId;
   wire [1:0] 	      wFinalColorId;
   
   wire [3:0] 	      wBlockPosX, wBlockPosY;

   assign wBlockPosX  = wVideoCol/BLOCK_WIDTH_X;
   assign wBlockPosY  = wVideoRow/BLOCK_WIDTH_Y;
   
   assign wNormalColorId  = (wBlockPosY[0] == 1'b0) ? {1'b0, wBlockPosX[0]} : {1'b0, ~wBlockPosX[0]};
   
   assign wFinalColorId = (wBlockPosX == iMarkedBlockPosX 
			   && wBlockPosY == iMarkedBlockPosY) ? 2'b10 : wNormalColorId;
   
   
   always @(*) begin
      case (wFinalColorId)
	 2'b00: oVGAColor  = `COLOR_BLACK;
	 2'b01: oVGAColor  = `COLOR_WHITE;
	 2'b10: oVGAColor  = `COLOR_RED;
	 2'b11: oVGAColor  = `COLOR_BLACK;
      endcase
   end

   
  
   VGA_CONTROLLER #(X_WIDTH,
		     Y_WIDTH,
		     X_SIZE, 
		     Y_SIZE) VGA_Control
      (
       .Clock(Clock),
       .Reset(Reset),
       .oVideoMemCol(wVideoCol),
       .oVideoMemRow(wVideoRow),
       .oVGAHorizontalSync(oVGAHorizontalSync),
       .oVGAVerticalSync(oVGAVerticalSync),
       .oDisplay()
       );

   
endmodule
