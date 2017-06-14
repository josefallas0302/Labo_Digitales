`timescale 1us / 1ns
`include "Defintions.v"

module Detector

	(
	input 	wire Reset,
	input 	wire Clock,
	input 	wire [7:0]  iData,
	output  wire [3:0] oNextPositionX,
	output  wire [3:0] oNextPositionY
	);

reg [3:0] wCurrentPositionX;
reg [3:0] wCurrentPositionY;
reg [3:0] wNextPositionX;
reg [3:0] wNextPositionY;
reg [6:0] wUpCounter;
reg wNextEnableCounter;
reg wEnableCounter;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FF_DATA_X
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wUpCounter == 4'd0),
       .D(wNextPositionX), 
       .Q(oNextPositionX)
       );


FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FF_DATA_Y
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wUpCounter == 4'd0),
       .D(wNextPositionY), 
       .Q(oNextPositionY)
       );


always @(posedge Clock) begin
	if (Reset) begin
		wCurrentPositionY <= 4'd2;
		wCurrentPositionY <= 4'd2;
		wUpCounter <= 7'b0;

	end
	else begin

	wEnableCounter <= wNextEnableCounter;

	wCurrentPositionY <= oNextPositionY;
	wCurrentPositionX <= oNextPositionX;


    if (wEnableCounter) begin

    	wUpCounter <= wUpCounter + 1;
	end
	else begin
		wUpCounter <= 7'b0;

		end
	end
end


always @(*) begin
			if (iData == `W || `A || `S || `D) begin
				wNextEnableCounter = 1'b1;
			end
			else if (wUpCounter == 7'd200) begin
				wNextEnableCounter = 1'b0;
			end
			else begin
				wNextEnableCounter = 1'b0;
			end



			case (iData)

				`D:
				begin
					wNextPositionX = wCurrentPositionX + 1;
					wNextPositionY = wCurrentPositionY;
				end
				
				`A:
					begin
					wNextPositionX = wCurrentPositionX - 1;
					wNextPositionY = wCurrentPositionY;
					end
				
				`W:
					begin
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY + 1;
					end
				
				`S:
					begin
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY - 1;
					end
					
				default:
					begin
					wNextPositionX = wCurrentPositionX;
					wNextPositionY = wCurrentPositionY;
					end
					
			endcase
	end

endmodule 

