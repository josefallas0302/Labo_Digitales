`timescale 1ns / 1ps
`include "Defintions.v"

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
    input wire [3:0]  iTurnCounter,
    output wire [2:0] oVGAColor,
    output wire       oVGAHorizontalSync,
    output wire       oVGAVerticalSync
    );

   //--------------------------------------------------------------------
   // Wires/Regs declaration
   //--------------------------------------------------------------------
   wire [X_WIDTH-1:0] wTotalCol, wFrameCol;
   wire [Y_WIDTH-1:0] wTotalRow, wFrameRow;   
   wire [11:0] 	      wLocalCol, wLocalRow;
   wire signed [11:0] wLocalColRotTrans, wLocalRowRotTrans, wPhaseIn;
   wire [11:0] 	      wLocalColRotated, wLocalRowRotated;
   wire [11:0] 	      wLocalColMux, wLocalRowMux;
   wire 	      wPixelInFrame;
   wire [14:0] 	      wSymPixelAddr;
   wire 	      wXPixelOut, wOPixelOut;
   wire 	      wMarkedPosPixelFlag, wFrameStripePixelFlag;
   wire 	      wDisplayOn;
   wire 	      wInWinnerBlock;
   wire [1:0] 	      wCurrentSym;
   wire [4:0] 	      wSymPos;
   wire 	      wNoWinnerFlag;
   
   reg [X_WIDTH-1:0]  rOffsetFrameCol;
   reg [Y_WIDTH-1:0]  rOffsetFrameRow;
   reg [3:0] 	      rBlockPosX, rBlockPosY;
   reg 		      rSymPixelOut;
   reg [2:0] 	      rVGASymColor;
   reg [2:0] 	      rVGAFrameColor;
   reg [31:0] 	      rWinFxTimer;
   reg		      clk25;   
   
   
   initial clk25 = 1'b0;   
   always @(posedge Clock) clk25 <= ~clk25;


   //--------------------------------------------------------------------------------------
   // VGA Controller
   //--------------------------------------------------------------------------------------
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

   //--------------------------------------------------------------------------------------
   // X and O symbols ROM 
   //--------------------------------------------------------------------------------------
   X_ROM xPixelMemory (
		       .clka(clk25),
		       .addra(wSymPixelAddr),
		       .douta(wXPixelOut)
		       );
   
   O_ROM oPixelMemory (
   		       .clka(clk25),
   		       .addra(wSymPixelAddr),
   		       .douta(wOPixelOut)
   		       );


   //--------------------------------------------------------------------------------------
   // Row/Col definitions
   //--------------------------------------------------------------------------------------
   assign wPixelInFrame = (wTotalCol >= `FRAME_START_X) && (wTotalCol < `FRAME_END_X) && 
			  (wTotalRow >= `FRAME_START_Y) && (wTotalRow < `FRAME_END_Y);

   assign wFrameCol  = wTotalCol - `FRAME_START_X;
   assign wFrameRow  = wTotalRow - `FRAME_START_Y;
   
   assign wLocalCol  = wFrameCol - rOffsetFrameCol;
   assign wLocalRow  = wFrameRow - rOffsetFrameRow;

   assign wSymPos = 2*(rBlockPosX + `NUM_BLOCKS_DIM * rBlockPosY);
   assign wCurrentSym  = iSymVector[wSymPos +: 2];
   
   assign wInWinnerBlock = iWinFlag && ( wSymPos == iWinSeqPos[0 +: 5] ||
					 wSymPos == iWinSeqPos[5 +: 5] ||
					 wSymPos == iWinSeqPos[10 +: 5] );

   assign wNoWinnerFlag = !iWinFlag && (iTurnCounter >= 4'd9);
   
   
   //--------------------------------------------------------------------------------------
   // Rotation FX logic
   //--------------------------------------------------------------------------------------
   assign wPhaseIn  = rWinFxTimer[24:13];   
   Rotate rotate (
		  .x_in(wLocalCol+10-`FRAME_BLOCK_DIM/2),
		  .y_in(wLocalRow-`FRAME_BLOCK_DIM/2),
		  .phase_in(wPhaseIn),
		  .x_out(wLocalColRotTrans),
		  .y_out(wLocalRowRotTrans),
		  .clk(Clock)
		  );

   assign wLocalColRotated = (wLocalColRotTrans+`FRAME_BLOCK_DIM/2 < 0)? 
			      0 :(wLocalColRotTrans+`FRAME_BLOCK_DIM/2 >`FRAME_BLOCK_DIM-1)? 
			     `FRAME_BLOCK_DIM-1 : wLocalColRotTrans+`FRAME_BLOCK_DIM/2;

   assign wLocalRowRotated = (wLocalRowRotTrans+`FRAME_BLOCK_DIM/2 < 0)? 
			      0 :(wLocalRowRotTrans+`FRAME_BLOCK_DIM/2 >`FRAME_BLOCK_DIM-1)? 
			      `FRAME_BLOCK_DIM-1 : wLocalRowRotTrans+`FRAME_BLOCK_DIM/2;
   
   
   //--------------------------------------------------------------------------------------
   // Symbols color definition
   //--------------------------------------------------------------------------------------
   assign wLocalColMux = wInWinnerBlock ? wLocalColRotated : wLocalCol;   
   assign wLocalRowMux = wInWinnerBlock ? wLocalRowRotated : wLocalRow;
   assign wSymPixelAddr = wPixelInFrame ? (wLocalColMux +`FRAME_BLOCK_DIM*wLocalRowMux) : 0;

   
   always @(*) begin
      case (wCurrentSym)
	 `X:      rSymPixelOut 	= wXPixelOut;
	 `O:      rSymPixelOut 	= wOPixelOut;
	 `EMPTY:  rSymPixelOut 	= 1'b0;
	 default: rSymPixelOut 	= 1'b0;
      endcase
  
      if (rSymPixelOut == 1'b1) begin
	 if (wInWinnerBlock) begin
	    rVGASymColor = (rWinFxTimer[23] == 1'b0) ? `COLOR_GREEN : `COLOR_BLUE;
	 end
	 else begin
	    if (wNoWinnerFlag) begin
	       rVGASymColor = (rWinFxTimer[23] == 1'b0) ? `COLOR_RED : `COLOR_BLUE;
	    end
	    else 
	       rVGASymColor  = `COLOR_BLUE;
	 end
      end
      else rVGASymColor = `COLOR_BLACK;
   end
   

   //--------------------------------------------------------------------------------------
   // Frame color definition
   //--------------------------------------------------------------------------------------
   assign wMarkedPosPixelFlag = (rBlockPosX == iMarkedBlockPosX && 
				 rBlockPosY == iMarkedBlockPosY && 
				 (wLocalCol < `FRAME_MARKED_START || 
				  wLocalCol >= `FRAME_MARKED_END  || 
				  wLocalRow < `FRAME_MARKED_START ||
				  wLocalRow >= `FRAME_MARKED_END  ));

   assign wFrameStripePixelFlag = ((wFrameCol > `FRAME_STRIPE_START && 
				    wFrameCol < `FRAME_STRIPE_END) || 
				   (wFrameCol > `FRAME_STRIPE_START+`FRAME_BLOCK_DIM && 
				    wFrameCol < `FRAME_STRIPE_END+`FRAME_BLOCK_DIM) || 
				   (wFrameRow > `FRAME_STRIPE_START && 
				    wFrameRow < `FRAME_STRIPE_END) || 
				   (wFrameRow > `FRAME_STRIPE_START+`FRAME_BLOCK_DIM && 
				    wFrameRow < `FRAME_STRIPE_END+`FRAME_BLOCK_DIM)); 
   
   always @(*) begin
      if (wMarkedPosPixelFlag && !iWinFlag && !wNoWinnerFlag) //Selected position box
	 rVGAFrameColor  = `COLOR_CYAN;  
      else begin
	 if (wFrameStripePixelFlag) //Frame stripes
	    rVGAFrameColor = (iWinFlag && ~rWinFxTimer[21]) ? `COLOR_WHITE : `COLOR_MAGENTA;
	 else
	    rVGAFrameColor  = rVGASymColor;
      end
   end

   //--------------------------------------------------------------------------------------
   // Final color definition
   //--------------------------------------------------------------------------------------
   assign oVGAColor  = wPixelInFrame ? rVGAFrameColor : `COLOR_BLACK;


   //--------------------------------------------------------------------------------------
   // Sequential logic (Block position, Fx-Timer, Row-Col)
   //--------------------------------------------------------------------------------------
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
	    if (wPixelInFrame) begin
	       if (wFrameCol == `FRAME_TOTAL_DIM-1) begin
		  rBlockPosX      <= 0;
		  rOffsetFrameCol <= 0;
		  
		  if (wFrameRow == `FRAME_TOTAL_DIM-1) begin
		     rBlockPosY      <= 0;
		     rOffsetFrameRow <= 0;
		  end
		  else begin
		     if (wLocalRow == `FRAME_BLOCK_DIM-1) begin
			rOffsetFrameRow <= wFrameRow + 1;
			rBlockPosY      <= rBlockPosY + 1;
		     end
		  end
	       end
	       else begin
		  if (wLocalCol == `FRAME_BLOCK_DIM-1) begin
		     rOffsetFrameCol <= wFrameCol + 1;
		     rBlockPosX      <= rBlockPosX + 1;
		  end
	       end
	    end	       	    
	 end
      end   
   
endmodule
