`timescale 1us / 1ns
`include "Defintions.v"

module Detector

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
   
   genvar 	      i,j;
   generate
   for (i=0; i<3; i=i+1) begin: SYMMAT_ROW
      for (j=0; j<3; j=j+1) begin: SYMMAT_COL
	 assign oSymVector[2*(j+3*i) +: 2] = rSymMat[i][j];
      end
   end
   endgenerate   
   
   
   
   always @(negedge iKeyboardFlag or posedge Reset) begin
      if (Reset) begin
	 oCurrentPosX  <= 2'd1;
	 oCurrentPosY  <= 2'd1;
	 counter       <= 4'd0;
	 
	 rSymMat[0][0] <= `O;  rSymMat[0][1] <= `O; rSymMat[0][2] <= `O;
	 rSymMat[1][0] <= `X;  rSymMat[1][1] <= `O; rSymMat[1][2] <= `X;
	 rSymMat[2][0] <= `O;  rSymMat[2][1] <= `X; rSymMat[2][2] <= `O;
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
		  for (r=0; r<3; r=r+1) begin
		     for (c=0; c<3; c=c+1) begin
			rSymMat[r][c] <= 2'b0;
		     end
		  end 
		  counter <= 4'd0;
	       end

	    `ENTER:
	       begin
		  if (!iWinFlag && rSymMat[oCurrentPosY][oCurrentPosX] == `EMPTY)
		     rSymMat[oCurrentPosY][oCurrentPosX] <= (counter[0] == 0) ? `X : `O;
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
