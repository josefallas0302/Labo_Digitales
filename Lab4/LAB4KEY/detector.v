`timescale 1us / 1ns
`include "Defintions.v"
`include "Collaterals.v"

module Detector

	(
	input 	wire Reset,
	input 	wire Clock,
	input 	wire [7:0]  iData,
	output  [3:0] oNextPositionX,
	output  [3:0] oNextPositionY
	);

reg [3:0] wCurrentPositionX ;
reg [3:0] wCurrentPositionY ;
wire [3:0] wNextPositionX ;
wire [3:0] wNextPositionY ;
wire [3:0] oNextPositionX ;
wire [3:0] oNextPositionY ;
reg [6:0] wUpCounter	;
wire wNextEnableCounter;
reg wEnableCounter;

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
			if (oData == `W || `A || `S || `D) begin
				wNextEnableCounter = 1'b1;
			end
			else if (wUpcounter == 7'd200) begin
				wNextEnableCounter = 1'b0;
			end
			else begin
				wNextEnableCounter = 1'b0;
			end



			case (oData)

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
endmodule 
