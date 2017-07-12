`timescale 1us / 1ns
`include "Defintions.v"

module KEYBOARD_TICTACTOE

   (
    input wire 	       Reset,
    input wire 	       Clock,
    input wire [7:0]   iData,
    input wire 	       iKeyboardFlag,
    input wire 	       iWinFlag,
    output reg 	       oKeyboardReset,
    output reg [3:0]   oCurrentPosX,
    output reg [3:0]   oCurrentPosY,
    output wire [0:17] oSymVector,
    output reg [3:0]   oTurnCounter
    );

   //reg [3:0] 	       oTurnCounter;
   reg [1:0] 	      rSymMat [0:2][0:2];
   
   integer 	      r,c;
   
   //--------------------------------------------------------------------
   // Symbol matrix 2D to 1D port array conversion
   //--------------------------------------------------------------------
   genvar 	      i,j;
   generate
   for (i=0; i<`NUM_BLOCKS_DIM; i=i+1) begin: SYMMAT_ROW
      for (j=0; j<`NUM_BLOCKS_DIM; j=j+1) begin: SYMMAT_COL
	 assign oSymVector[2*(j+`NUM_BLOCKS_DIM*i) +: 2] = rSymMat[i][j];
      end
   end
   endgenerate   
   
   //--------------------------------------------------------------------
   // Keyboard Value Parse Logic
   //--------------------------------------------------------------------   
   always @(negedge iKeyboardFlag or posedge Reset) begin
      if (Reset) begin
	 oCurrentPosX  <= 2'd0;
	 oCurrentPosY  <= 2'd1;
	 oTurnCounter  <= 4'd0;
	 
	 rSymMat[0][0] <= `X;  rSymMat[0][1] <= `X; rSymMat[0][2] <= `O;
	 rSymMat[1][0] <= `O;  rSymMat[1][1] <= `O; rSymMat[1][2] <= `X;
	 rSymMat[2][0] <= `O;  rSymMat[2][1] <= `O; rSymMat[2][2] <= `X;
      end
      else begin

	 case (iData)
	    `D: oCurrentPosX <= oCurrentPosX + 1;
	    `A: oCurrentPosX <= oCurrentPosX - 1;
	    `W: oCurrentPosY <= oCurrentPosY - 1;
	    `S: oCurrentPosY <= oCurrentPosY + 1;
	    `R:
	       begin
		  for (r=0; r<`NUM_BLOCKS_DIM; r=r+1) begin
		     for (c=0; c<`NUM_BLOCKS_DIM; c=c+1) begin
			rSymMat[r][c] <= 2'b00;
		     end
		  end 
		  oTurnCounter <= 4'd0;
	       end
	    `ENTER:
	       begin
		  if (!iWinFlag && rSymMat[oCurrentPosY][oCurrentPosX] == `EMPTY) begin
		     rSymMat[oCurrentPosY][oCurrentPosX] <= (oTurnCounter[0] == 0) ? `X : `O;
		     oTurnCounter <= oTurnCounter + 4'd1;
		  end
	       end
	 endcase

      end
   end

endmodule
