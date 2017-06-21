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


   always @(negedge iKeyboardFlag or posedge Reset) begin
      if (Reset) 
	 begin
	    oCurrentPositionX <= 4'd2;
	    oCurrentPositionY <= 4'd2;
	 end
      else
	 begin

	    case (iData)
	       
	       `D:
		  begin
		     oCurrentPositionX <= oCurrentPositionX + 1;
		     oCurrentPositionY <= oCurrentPositionY;
		  end
	       
	       `A:
		  begin
		     oCurrentPositionX <= oCurrentPositionX - 1;
		     oCurrentPositionY <= oCurrentPositionY;
		  end
	       
	       `W:
		  begin
		     oCurrentPositionX <= oCurrentPositionX;
		     oCurrentPositionY <= oCurrentPositionY - 1;
		  end
	       
	       `S:
		  begin
		     oCurrentPositionX <= oCurrentPositionX;
		     oCurrentPositionY <= oCurrentPositionY + 1;
		  end
	       
	       default:
		  begin
		     oCurrentPositionX <= oCurrentPositionX;
		     oCurrentPositionY <= oCurrentPositionY;
		  end
	       
	    endcase

	 end
   end

endmodule 

