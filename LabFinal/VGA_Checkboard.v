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

   wire [X_WIDTH-1:0] wTotalCol;
   wire [Y_WIDTH-1:0] wTotalRow;

   reg [X_WIDTH-1:0]  rSnapshotTotalCol;
   reg [Y_WIDTH-1:0]  rSnapshotTotalRow;
   
   wire [7:0] 	      wLocalCol, wLocalRow;
   
   reg [3:0] 	      rBlockPosX, rBlockPosY;
   
   
   wire 	      wNormalColorId;
   wire [1:0] 	      wFinalColorId;
   
   wire 	      wDisplayOn;

   reg		      clk25;
   
   initial begin
      clk25 = 1'b0;
   end
   
   always @(posedge Clock) clk25 <= ~clk25;

   
   assign wNormalColorId  = (rBlockPosY[0] == 1'b0) ? rBlockPosX[0] : ~rBlockPosX[0];
   
   assign wFinalColorId = (rBlockPosX == iMarkedBlockPosX 
   			   && rBlockPosY == iMarkedBlockPosY) ? 2'b10 : {1'b0, wNormalColorId};
   
   always @(*) begin
      case (wFinalColorId)
   	 2'b00: oVGAColor  = `COLOR_BLACK;
   	 2'b01: oVGAColor  = `COLOR_WHITE;
   	 2'b10: oVGAColor  = `COLOR_RED;
   	 2'b11: oVGAColor  = `COLOR_BLACK;
      endcase
   end

   assign wLocalCol  = wTotalCol - rSnapshotTotalCol;
   assign wLocalRow  = wTotalRow - rSnapshotTotalRow;

   
   always @(posedge clk25)
      begin
	 if (Reset)
	    begin
	       rSnapshotTotalRow <= 0;
	       rSnapshotTotalCol <= 0;
	       rBlockPosX 	 <= 0;
	       rBlockPosY 	 <= 0;
	    end
	 else
	    begin
	       
	       if (wTotalCol >= 639)
		  begin
		     rBlockPosX        <= 0;
		     rSnapshotTotalCol <= 0;

		  
		     if (wTotalRow >= 479)
			begin
			   rBlockPosY        <= 0;
			   rSnapshotTotalRow <= 0;
			end
		     else 
			begin
			   if (wLocalRow >= BLOCK_WIDTH_Y-1)
			      begin
				 rSnapshotTotalRow <= wTotalRow + 1;
				 rBlockPosY        <= rBlockPosY + 1;
			      end
			end
		  end
	       else 
		  begin
		     if (wLocalCol >= BLOCK_WIDTH_X-1)
			begin
			   rSnapshotTotalCol <= wTotalCol + 1;
			   rBlockPosX        <= rBlockPosX + 1;
			end
		  end	       
	       
	    end
      end
   
  
   VGA_CONTROLLER #(X_WIDTH,
		     Y_WIDTH,
		     X_SIZE, 
		     Y_SIZE) VGA_Control
      (
       //.Clock(Clock),
       .Clock(clk25),
       .Reset(Reset),
       .oVideoMemCol(wTotalCol),
       .oVideoMemRow(wTotalRow),
       .oVGAHorizontalSync(oVGAHorizontalSync),
       .oVGAVerticalSync(oVGAVerticalSync),
       .oDisplay(wDisplayOn)
       );

   
endmodule
