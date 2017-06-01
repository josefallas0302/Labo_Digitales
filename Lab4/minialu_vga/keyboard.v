`timescale 1us / 1ns
`include "Defintions.v"
`include "Collaterals.v"

`define STATE_IDLE 0 
`define STATE_CONCATENATE 1

module keyboard 
	(
	input 	wire Reset,
	input 	wire Clock,
	input 	wire [10:0] PS2_DATA,
	output 	wire [7:0]  oData
	);

	reg rCurrentState,rNextState;
	reg contador [3:0];


	reg  [7:0] wTempData;
	wire [7:0] wData;

assign oData = wData;



FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_DATA
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(contador == 4'd9),
       .D(wTempData), 
       .Q(wData)
       );


always @ (posedge Clock)

	begin
	//Defaults
	if(Reset)
		begin
			rCurrentState <= `STATE_IDLE;
			contador <= 4'h0;
		end
	else 
		begin
			case (rCurrentState)
				`STATE_IDLE:
					begin
					contador <= 4'h0;
					rCurrentState <= rNextState;
					end
					
				`STATE_CONCATENATE:
					begin
					contador <= contador + 1'b1;
					rCurrentState <= rNextState;
					end
					
				default:
					rCurrentState <= `STATE_IDLE;

			endcase
		end
	end

always @ (negedge Clock)
	begin
		if(contador < 4'd8)
			rTempData[contador] <= PS2_DATA;
		
		else
			rTempData <= rTempData;
	end

always @ (*)
	begin
		case (rCurrentState)
				`STATE_IDLE:
					if(PS2_DATA)
						begin
							rNextState = `STATE_IDLE;
						end
					else
						begin
							rNextState = `STATE_CONCATENATE;
						end
					
				`STATE_CONCATENATE:
					if(contador == 4'h9)
						begin
							rNextState = `STATE_IDLE;
						end
					else
						begin
							rNextState = rCurrent_State;	//
						end
				default:
					rCurrentState <= `STATE_IDLE;

		
		endcase
	end
endmodule


