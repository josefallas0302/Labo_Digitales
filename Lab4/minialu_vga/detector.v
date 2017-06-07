`timescale 1us / 1ns
`include "Defintions.v"
`include "Collaterals.v"

module Detector

	(
	input 	wire Reset,
	input 	wire Clock,
	input 	wire [7:0]  iData,
	output  [3:0] oNextPositionX,
	output  [3:0] oNextPositionX
	);

reg [3:0] wCurrentPositionX ;
reg [3:0] wCurrentPositionY ;
wire [3:0] wNextPositionX ;
wire [3:0] wNextPositionY ;
wire [3:0] oNextPositionX ;
wire [3:0] oNextPositionY ;
reg [6:0] wUpCounter	;

wire wEnableCounter;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FF_DATA_X
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wUpcounter == 4'd0),
       .D(wNextPositionX), 
       .Q(oNextPositionX)
       );


FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FF_DATA_Y
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wUpcounter == 4'd0),
       .D(wNextPositionY), 
       .Q(oNextPositionY)
       );


always @(posedge Clock) begin
	if (Reset) begin
		wCurrentPositionY <= 4'b0;
		wCurrentPositionY <= 4'b0;
		oNextPositionX <= 4'b0;
		oNextPositionY <= 4'b0;
		wUpCounter <= 7'b0;

	end

	wCurrentPositionY <= oNextPositionY;
	wCurrentPositionX <= oNextPositionX;


    if (wEnableCounter && wUpCounter<7'd200) begin

    	wUpCounter <= wUpCounter + 1;
	end
	else begin
		wUpCounter <= 7'b0;
		wEnableCounter <= 0
		//EARING ON 	
	end
end
always @(*) begin
			if (oData == `W || `A || `S || `D) begin
				wEnableCounter = 1'b1;
			end
			else begin
				wEnableCounter = 1'b0;
			end

			case (oData)

				`D:
					wNextPositionX = wCurrentPositionX + 1;
					wNextPositionY = wCurrentPositionY;

				`A:
					wNextPositionX = wCurrentPositionX - 1;
					wNextPositionY = wCurrentPositionY;
				
				`W:
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY + 1;
				
				`S:
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY - 1;
				
				default:
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY;

					
			endcase
	end
end

endmodule 