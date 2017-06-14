`timescale 1us / 1ns
`include "detector.v"
`include "keyboard.v"
`include "keyboard.ucf"


module BlockPosition
	(
		input  wire Reset,
		input  wire Clock,
		input  wire Ps
		input  wire PS2_DATA,
		output wire [3:0]  oNextPositionX,
		output wire [3:0]  oNextPositionY	
	);
	
	wire [7:0] oData;

keyboard kb
	(
	.Reset(Reset),
	.Clock(Clock),
	.PS2_DATA(PS2_DATA),
	.oData(oData)
	);

Detector dtr
	(
	.Reset(Reset),
    .Clock(Clock),
	.iData(oData),
	.oNextPositionX(oNextPositionX),
	.oNextPositionY(oNextPositionY)
	);

endmodule 

