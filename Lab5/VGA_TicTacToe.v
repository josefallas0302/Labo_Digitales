`timescale 1ns / 1ps
`include "Defintions.v"
//TODO: Change hardcoded values to Defines

module VGA_TICTACTOE # (parameter X_WIDTH=8, 
			parameter Y_WIDTH=8
			)
   (
    input wire 	      Clock,
    input wire 	      Reset,
    input wire [3:0]  iMarkedBlockPosX,
    input wire [3:0]  iMarkedBlockPosY,
    input wire [0:17] iSymVector,
    input wire [14:0] iWinSeqPos,
    input wire 	      iWinFlag,
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
   wire 	      wMarkedPosPixelFlag, wFrameStripePixelFlag;
   wire 	      wDisplayOn;
   wire [1:0] 	      wCurrentSym;
   wire [4:0] 	      wSymPos;

   
   reg [X_WIDTH-1:0]  rOffsetFrameCol;
   reg [Y_WIDTH-1:0]  rOffsetFrameRow;
   reg [3:0] 	      rBlockPosX, rBlockPosY;
   reg 		      rSymPixelOut;
   reg [2:0] 	      rVGASymColor;
   reg [2:0] 	      rVGAFrameColor;
   reg [24:0] 	      rWinFxTimer;
   reg		      clk25;   
   
   
   
   initial begin
      clk25 = 1'b0;
   end
   
   always @(posedge Clock) clk25 <= ~clk25;

   X_ROM xPixelMemory (
		       .clka(clk25),
		       .addra(wXPixelAddress),
		       .douta(wXPixelOut)
		       );
   
   
   O_ROM oPixelMemory (
		       .clka(clk25),
		       .addra(wOPixelAddress),
		       .douta(wOPixelOut)
		       );



   VGA_CONTROLLER #(X_WIDTH,
		    Y_WIDTH) VGA_Control
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

   


   assign wSymPos = 2*rBlockPosX + 6*rBlockPosY;
   assign wCurrentSym  = iSymVector[wSymPos +: 2];
   
   always @(*) begin
      case (wCurrentSym)
	 `X:      rSymPixelOut 	= wXPixelOut;
	 `O:      rSymPixelOut 	= wOPixelOut;
	 `EMPTY:  rSymPixelOut 	= 1'b0;
	 default: rSymPixelOut 	= 1'b0;
      endcase
  
      if (rSymPixelOut == 1'b1) begin
	 if (iWinFlag && ( wSymPos == iWinSeqPos[0 +: 5]
			 ||wSymPos == iWinSeqPos[5 +: 5]
			 ||wSymPos == iWinSeqPos[10 +: 5])) begin
	    
	    rVGASymColor = (rWinFxTimer[24] == 1'b0) ? `COLOR_GREEN : `COLOR_BLUE;
	 end
	 else rVGASymColor = `COLOR_BLUE;
      end
      else rVGASymColor = `COLOR_BLACK;
   end

   

   assign wMarkedPosPixelFlag = (rBlockPosX == iMarkedBlockPosX 
				 && rBlockPosY == iMarkedBlockPosY
				 && ( wLocalCol < 3 || wLocalCol > 147 
				   || wLocalRow < 3 || wLocalRow > 147));

   assign wFrameStripePixelFlag  = ((wFrameCol > 147 && wFrameCol < 153) 
                                    ||(wFrameCol > 297 && wFrameCol < 303)
				    ||(wFrameRow > 147 && wFrameRow < 153) 
				    ||(wFrameRow > 297 && wFrameRow < 303)); 
   
   
   always @(*) begin
      if (wMarkedPosPixelFlag)
	 rVGAFrameColor  = `COLOR_CYAN;  //Selected position box
      else begin
	 if (wFrameStripePixelFlag)
	    rVGAFrameColor = `COLOR_MAGENTA;  //Frame stripes
	 else
	    rVGAFrameColor  = rVGASymColor;
      end
   end
           
   assign oVGAColor  = (wColInFrame && wRowInFrame) ? rVGAFrameColor : `COLOR_BLACK;


   

   always @(posedge clk25)
      begin
	 if (Reset) begin
	    rOffsetFrameRow <= 0;
	    rOffsetFrameCol <= 0;
	    rBlockPosX 	    <= 0;
	    rBlockPosY 	    <= 0;
	    rWinFxTimer     <= 0;
	 end
	 else begin
	    rWinFxTimer <= rWinFxTimer + 1;
	    
	    if (wFrameCol >= 449) begin
	       rBlockPosX      <= 0;
	       rOffsetFrameCol <= 0;
	       
	       if (wFrameRow >= 449) begin
		  rBlockPosY      <= 0;
		  rOffsetFrameRow <= 0;
	       end
	       else begin
		  if (wLocalRow >= 149) begin
		     rOffsetFrameRow <= wFrameRow + 1;
		     rBlockPosY      <= rBlockPosY + 1;
		  end
	       end
	    end
	    else begin
	       if (wLocalCol >= 149) begin
		  rOffsetFrameCol <= wFrameCol + 1;
		  rBlockPosX      <= rBlockPosX + 1;
	       end
	    end	       	    
	 end
      end   
   
endmodule
