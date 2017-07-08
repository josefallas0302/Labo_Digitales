`timescale 1ns / 1ps
`include "Defintions.v"
//TODO: Change hardcoded values to Defines

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
    input wire [0:17] iSymVector,
    output wire [2:0] oVGAColor,
    output wire       oVGAHorizontalSync,
    output wire       oVGAVerticalSync
    );


   wire [X_WIDTH-1:0] wTotalCol, wFrameCol;
   wire [Y_WIDTH-1:0] wTotalRow, wFrameRow;   
   wire [7:0] 	      wLocalCol, wLocalRow;
   wire 	      wColInFrame, wRowInFrame;
   wire [14:0] 	      wXPixelAddress, wOPixelAddress;   
   wire 	      wXPixelOut, wOPixelOut;
   wire 	      wDisplayOn;
   wire [2:0] 	      wVGAFrameColor;
   wire [1:0] 	      wCurrentSym;
   
   reg [X_WIDTH-1:0]  rOffsetFrameCol;
   reg [Y_WIDTH-1:0]  rOffsetFrameRow;
   reg [3:0] 	      rBlockPosX, rBlockPosY;
   reg 		      rSymPixelOut;
   reg		      clk25;
   
   
   
   
   initial begin
      clk25 = 1'b0;
   end
   
   always @(posedge Clock) clk25 <= ~clk25;

   x_mem xPixelMemory (
		       .clka(clk25),
		       .addra(wXPixelAddress),
		       .douta(wXPixelOut)
		       );
   
   
   o_mem oPixelMemory (
		       .clka(clk25),
		       .addra(wOPixelAddress),
		       .douta(wOPixelOut)
		       );



   VGA_CONTROLLER #(X_WIDTH,
		    Y_WIDTH,
		    X_SIZE, 
		    Y_SIZE) VGA_Control
      (
       .Clock(clk25),
       .Reset(Reset),
       .oVideoMemCol(wTotalCol),
       .oVideoMemRow(wTotalRow),
       .oVGAHorizontalSync(oVGAHorizontalSync),
       .oVGAVerticalSync(oVGAVerticalSync),
       .oDisplay(wDisplayOn)
       );



   
   assign wColInFrame = wTotalCol >= 95 && wTotalCol < 545;
   assign wRowInFrame = wTotalRow >= 15 && wTotalRow < 465;
   
   assign wFrameCol = wColInFrame ? wTotalCol-95 : 0;
   assign wFrameRow = wRowInFrame ? wTotalRow-15 : 0;

   assign wLocalCol  = wFrameCol - rOffsetFrameCol;
   assign wLocalRow  = wFrameRow - rOffsetFrameRow;

      
   assign wXPixelAddress = wLocalCol + 150 * wLocalRow;
   assign wOPixelAddress = wLocalCol + 150 * wLocalRow;
   


   assign wCurrentSym = iSymVector[(2*rBlockPosX + 6*rBlockPosY) +: 2];

   always @(*) begin
      case (wCurrentSym)
	 `X:      rSymPixelOut 	= wXPixelOut;
	 `O:      rSymPixelOut 	= wOPixelOut;
	 `EMPTY:  rSymPixelOut 	= 1'b0;
	 default: rSymPixelOut 	= 1'b0;
      endcase
   end
   
   assign wVGAFrameColor  = (rSymPixelOut == 1'b1) ? `COLOR_BLUE : `COLOR_WHITE;
   assign oVGAColor = (wColInFrame && wRowInFrame) ? wVGAFrameColor : `COLOR_BLACK;
      
   

   always @(posedge clk25)
      begin
	 if (Reset) begin
	    rOffsetFrameRow <= 0;
	    rOffsetFrameCol <= 0;
	    rBlockPosX      <= 0;
	    rBlockPosY      <= 0;
	 end
	 else begin
	    
	    if (wFrameCol >= 449) begin
	       rBlockPosX      <= 0;
	       rOffsetFrameCol <= 0;
	       
	       if (wFrameRow >= 449) begin
		  rBlockPosY      <= 0;
		  rOffsetFrameRow <= 0;
	       end
	       else begin
		  if (wLocalRow >= BLOCK_WIDTH_Y-1) begin
		     rOffsetFrameRow <= wFrameRow + 1;
		     rBlockPosY      <= rBlockPosY + 1;
		  end
	       end
	    end
	    else begin
	       if (wLocalCol >= BLOCK_WIDTH_X-1) begin
		  rOffsetFrameCol <= wFrameCol + 1;
		  rBlockPosX      <= rBlockPosX + 1;
	       end
	    end	       	    
	 end
      end   
   
endmodule
