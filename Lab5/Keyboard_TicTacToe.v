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
    output wire [0:17] oSymVector
    );

   reg [3:0] 	      counter;
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
	 counter       <= 4'd0;
	 
	 rSymMat[0][0] <= `X;  rSymMat[0][1] <= `EMPTY; rSymMat[0][2] <= `EMPTY;
	 rSymMat[1][0] <= `EMPTY;  rSymMat[1][1] <= `X; rSymMat[1][2] <= `EMPTY;
	 rSymMat[2][0] <= `EMPTY;  rSymMat[2][1] <= `EMPTY; rSymMat[2][2] <= `X;
      end
      else begin

	 case (iData)
	    `D:
	       begin
		  oCurrentPosX <= oCurrentPosX + 1;
		  oCurrentPosY <= oCurrentPosY;
	       end
	    `A:
	       begin
		  oCurrentPosX <= oCurrentPosX - 1;
		  oCurrentPosY <= oCurrentPosY;
	       end
	    `W:
	       begin
		  oCurrentPosX <= oCurrentPosX;
		  oCurrentPosY <= oCurrentPosY - 1;
	       end
	    `S:
	       begin
		  oCurrentPosX <= oCurrentPosX;
		  oCurrentPosY <= oCurrentPosY + 1;
	       end
	    `R:
	       begin
		  for (r=0; r<`NUM_BLOCKS_DIM; r=r+1) begin
		     for (c=0; c<`NUM_BLOCKS_DIM; c=c+1) begin
			rSymMat[r][c] <= 2'b00;
		     end
		  end 
		  counter <= 4'd0;
	       end
	    `ENTER:
	       begin
		  if (!iWinFlag && rSymMat[oCurrentPosY][oCurrentPosX] == `EMPTY) begin
		     rSymMat[oCurrentPosY][oCurrentPosX] <= (counter[0] == 0) ? `X : `O;
		     counter <= counter + 4'd1;
		  end
	       end
	    default:
	       begin
		  oCurrentPosX <= oCurrentPosX;
		  oCurrentPosY <= oCurrentPosY;
	       end

	 endcase
      end
   end

endmodule
