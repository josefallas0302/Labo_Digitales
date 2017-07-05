`timescale 1us / 1ns
`include "Defintions.v"

module Detector

	(
	input wire Reset,
	input wire Clock,
	input wire [7:0] iData,
	input wire iKeyboardFlag,
	output reg oKeyboardReset,
	output reg [3:0] oCurrentPositionX,
	output reg [3:0] oCurrentPositionY,
	output reg flagReset,
	output reg flagSym
	);

	reg [1:0] Pos [2:0][2:0];

/* reg [1:0] P00;
	reg [1:0] P01;
	reg [1:0] P02;
	reg [1:0] P10;
	reg [1:0] P11;
	reg [1:0] P12;
	reg [1:0] P20;
	reg [1:0] P21;
	reg [1:0] P22;*/

	reg [3:0] counter;
	reg [1:0] sym;


   always @(negedge iKeyboardFlag or posedge Reset) begin
      if (Reset)
	 begin
	    oCurrentPositionX <= 2'd2;
	   	oCurrentPositionY <= 2'd2;
			flagReset <= 0;
			flagSym   <= 0;
			counter   <= 4'd0;
	 end
      else
	 begin

	    case (iData)

	       `D:
		  begin
		    oCurrentPositionX <= oCurrentPositionX + 1;
		    oCurrentPositionY <= oCurrentPositionY;
			 	flagReset <= 0;
			 	flagSym   <= 0;
			 	counter   <= counter;
		  end

	       `A:
		  begin
		     oCurrentPositionX <= oCurrentPositionX - 1;
		     oCurrentPositionY <= oCurrentPositionY;
			 flagReset <= 0;
			 flagSym   <= 0;
			 counter   <= counter;
		  end

	       `W:
		  begin
		    oCurrentPositionX <= oCurrentPositionX;
		    oCurrentPositionY <= oCurrentPositionY - 1;
			 	flagReset <= 0;
			 	flagSym   <= 0;
			 	counter   <= counter;
		  end

	       `S:
		  begin
		    oCurrentPositionX <= oCurrentPositionX;
		    oCurrentPositionY <= oCurrentPositionY + 1;
			 	flagReset <= 0;
			 	flagSym   <= 0;
			 	counter   <= counter;
		  end

		   `R:
		  begin
			 	flagReset <= 1;
			 	flagSym   <= 0;
			 	oCurrentPositionX <= oCurrentPositionX;
		   	oCurrentPositionY <= oCurrentPositionY + 1;
			 	counter   <= counter;
		  end

		   `ENTER:
		  begin
		   	flagReset <= 0;
			 	flagSym   <= 1;
			 	counter   <= counter + 1;
		  end

	       default:
		  begin
				oCurrentPositionX <= oCurrentPositionX;
		   	oCurrentPositionY <= oCurrentPositionY;
			 	flagReset <= 0;
			 	flagSym   <= 0;
			 	counter   <= 4'd0;
		  end

	    endcase
	end
   end

	always @(posedge flagReset)
		begin
		  Pos [0][0] <= 2'b0;
			Pos [0][1] <= 2'b0;
			Pos [0][2] <= 2'b0;
			Pos [1][0] <= 2'b0;
			Pos [1][1] <= 2'b0;
			Pos [1][2] <= 2'b0;
			Pos [2][0] <= 2'b0;
			Pos [2][1] <= 2'b0;
			Pos [2][2] <= 2'b0;
			counter    <= 4'd0;
		end

	always @(posedge flagSym)
		begin
			if (counter %2 != 0)
				sym <= 2'b01; //equis
			else
				sym <= 2'b10; //círculo

		if (Pos[oCurrentPositionX][oCurrentPositionY] == 2'b0)
			Pos[oCurrentPositionX][oCurrentPositionY] <= sym;
	end

endmodule
