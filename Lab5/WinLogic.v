`timescale 1ns / 1ps
`include "Defintions.v"


module WIN_LOGIC (
		  input wire [0:17] iSymVector,
		  output reg 	    oWinFlag,
		  output reg [11:0] oWinSeqPos
		  );

   
   wire [7:0]			    wWinFlag;
   wire [5:0] 			    wLineData [0:7];
   wire [11:0] 			    wSeqPos [0:7];
   

   function  isWin;
      input [5:0] data;  
      begin
	 isWin = (data[1:0]==data[3:2]) && (data[3:2]==data[5:4]);
      end
   endfunction


   assign wSeqPos[0]  = {4'd0, 4'd2, 4'd4};
   assign wSeqPos[1]  = {4'd6, 4'd8, 4'd10};
   assign wSeqPos[2]  = {4'd12, 4'd14, 4'd16};
   assign wSeqPos[3]  = {4'd0, 4'd6, 4'd12};
   assign wSeqPos[4]  = {4'd2, 4'd8, 4'd14};
   assign wSeqPos[5]  = {4'd4, 4'd10, 4'd16};
   assign wSeqPos[6]  = {4'd0, 4'd8, 4'd16};
   assign wSeqPos[7]  = {4'd4, 4'd8, 4'd12};


   genvar i;
   generate
      for (i = 0; i < 8; i = i + 1)
	 begin: ISWIN
	    assign wLineData[i] = {iSymVector[wSeqPos[i][0+:4] +: 2],
				   iSymVector[wSeqPos[i][4+:4] +: 2],
				   iSymVector[wSeqPos[i][8+:4] +: 2]};
	    
	    assign wWinFlag[i]  = isWin(wLineData[i]);
	 end
   endgenerate

integer j;
   
always @(wWinFlag) begin
   
   oWinFlag = 1'b0;
   for (j=0; j<8; j=j+1) begin
      oWinFlag = oWinFlag || wWinFlag[j];
   end

   if (wWinFlag[0])      oWinSeqPos  = wSeqPos[0];
   else if (wWinFlag[1]) oWinSeqPos  = wSeqPos[1];
   else if (wWinFlag[2]) oWinSeqPos  = wSeqPos[2];
   else if (wWinFlag[3]) oWinSeqPos  = wSeqPos[3];
   else if (wWinFlag[4]) oWinSeqPos  = wSeqPos[4];
   else if (wWinFlag[5]) oWinSeqPos  = wSeqPos[5];
   else if (wWinFlag[6]) oWinSeqPos  = wSeqPos[6];
   else if (wWinFlag[7]) oWinSeqPos  = wSeqPos[7];
   else oWinSeqPos = 12'd0;
end

endmodule
