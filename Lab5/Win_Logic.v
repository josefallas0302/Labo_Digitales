`timescale 1ns / 1ps
`include "Defintions.v"


module WIN_LOGIC (
		  input wire [0:17] iSymVector,
		  output reg 	    oWinFlag,
		  output reg [14:0] oWinSeqPos
		  );

   
   wire [7:0]			    wWinFlag;
   wire [14:0] 			    wSeqPos [0:7];

   genvar 			    i;
   integer 			    j;
   
   function  isWin;
      input [5:0] data;  
      begin
	 isWin = (data[1:0] != `EMPTY) && (data[1:0]==data[3:2]) && (data[3:2]==data[5:4]);
      end
   endfunction


   assign wSeqPos[0]  = {5'd0, 5'd2, 5'd4};
   assign wSeqPos[1]  = {5'd6, 5'd8, 5'd10};
   assign wSeqPos[2]  = {5'd12, 5'd14, 5'd16};
   assign wSeqPos[3]  = {5'd0, 5'd6, 5'd12};
   assign wSeqPos[4]  = {5'd2, 5'd8, 5'd14};
   assign wSeqPos[5]  = {5'd4, 5'd10, 5'd16};
   assign wSeqPos[6]  = {5'd0, 5'd8, 5'd16};
   assign wSeqPos[7]  = {5'd4, 5'd8, 5'd12};

   
   generate
      for (i = 0; i < 8; i = i + 1)
	 begin: ISWIN
	    assign wWinFlag[i]  = isWin( {iSymVector[wSeqPos[i][0+:5] +: 2],
					  iSymVector[wSeqPos[i][5+:5] +: 2],
					  iSymVector[wSeqPos[i][10+:5] +: 2]}
					 );
	 end
   endgenerate

   
always @(wWinFlag) begin
   
   oWinFlag = 1'b0;
   for (j=0; j<8; j=j+1) begin
      oWinFlag = oWinFlag || wWinFlag[j];
   end

   oWinSeqPos = 15'd0;
   for (j=7; j>=0; j=j-1) begin
      oWinSeqPos  = wWinFlag[j] ? wSeqPos[j] : oWinSeqPos;
   end

end

endmodule
