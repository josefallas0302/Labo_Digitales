`timescale 1us / 1ns
`include "Collaterals.v"

`define STATE_IDLE 0 
`define STATE_CONCATENATE 1

module keyboard 
	(
	input 		wire Reset,
	input 		wire Clock,
	input 	   wire [10:0] PS2_DATA,
	output 	wire [7:0]  oData
	);

	reg rCurrentState,rNextState;
	reg [3:0] contador = 4'h0;


	reg  [7:0] wTempData;


FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_DATA
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(contador == 4'd8),
       .D(wTempData), 
       .Q(oData)
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
			wTempData[contador] <= PS2_DATA;
		
		else
			wTempData <= wTempData;
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
							rNextState = rCurrentState;	//
						end
				default:
					rNextState <= `STATE_IDLE;

		
		endcase
	end
endmodule


