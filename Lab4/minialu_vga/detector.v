`timescale 1us / 1ns
`include "Defintions.v"

module Detector

	(
	input wire 	 Reset,
	input wire 	 Clock,
	input wire [7:0] iData,
	input wire 	 iKeyboardFlag,
	output reg 	 oKeyboardReset,
	output reg [3:0] oCurrentPositionX,
	output reg [3:0] oCurrentPositionY
	);

   reg [3:0] 		 rNextPositionX;
   reg [3:0] 		 rNextPositionY;

   reg [31:0] 		 rUpCounter;
   reg 			 rCounterEnable;

   wire [7:0] 		 wCurrentData;
   
   assign wCurrentData = (iKeyboardFlag == 1'b1) ? iData : 8'hf0;
   
   
   always @(posedge Clock) begin
      if (Reset) 
	 begin
	    oCurrentPositionX <= 4'd2;
	    oCurrentPositionY <= 4'd2;
	    rUpCounter 	      <= 32'b0;
	    rCounterEnable    <= 1'b0;
	 end
      else 
	 begin

	    if ((rUpCounter == 1'b0) &&
		((wCurrentData == `W) 
		 || (wCurrentData == `A) 
		 || (wCurrentData == `S) 
		 || (wCurrentData == `D))) 
	       begin
		  rCounterEnable <= 1'b1;
		  oKeyboardReset <= 1'b1;
	       end
	    else
	       begin
		  oKeyboardReset <= 1'b0;
		  if (rUpCounter >= 32'd10000000) 
		     rCounterEnable <= 1'b0;
	       end


	    // if ((rUpCounter == 1'b0) &&
	    // 	((iData == `W) || (iData == `A) || (iData == `S) || (iData == `D))) 
	    //    begin
	    // 	  rCounterEnable <= 1'b1;
	    // 	  oKeyboardReset <= 1'b1;
	    //    end
	    // else
	    //    begin
	    // 	  oKeyboardReset <= 1'b0;
	    // 	  if (rUpCounter >= 32'd10000000) 
	    // 	     rCounterEnable <= 1'b0;
	    //    end


	    //rCounterEnable <= rNextCounterEnable;
	    
	    if (rCounterEnable) 
	       rUpCounter <= rUpCounter + 1;
	    else 
	       rUpCounter <= 32'b0;


	    if (rUpCounter == 32'b0)
	       begin
		  oCurrentPositionY <= rNextPositionY;
		  oCurrentPositionX <= rNextPositionX;
	       end
	    else
	       begin
		  oCurrentPositionY <= oCurrentPositionY;
		  oCurrentPositionX <= oCurrentPositionX;
	       end

	 end
   end


   always @(*) begin
      

      case (wCurrentData)

	 `D:
	    begin
	       rNextPositionX = oCurrentPositionX + 1;
	       rNextPositionY = oCurrentPositionY;
	    end
	 
	 `A:
	    begin
	       rNextPositionX = oCurrentPositionX - 1;
	       rNextPositionY = oCurrentPositionY;
	    end
	 
	 `W:
	    begin
	       rNextPositionX = oCurrentPositionX;
	       rNextPositionY = oCurrentPositionY - 1;
	    end
	 
	 `S:
	    begin
	       rNextPositionX = oCurrentPositionX;
	       rNextPositionY = oCurrentPositionY + 1;
	    end
	 
	 default:
	    begin
	       rNextPositionX = oCurrentPositionX;
	       rNextPositionY = oCurrentPositionY;
	    end
	 
      endcase
   end

endmodule 

