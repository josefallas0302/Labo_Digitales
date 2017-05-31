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
	reg contador [3:0] = 4'h0;


	reg  [7:0] rTempData;
	wire [7:0] wData;

	assign oData = wData;

assign wTempData [contador] = PS2_DATA; 
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_DATA
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(rCurrentState == contador = 4'h9),
       .D(rTempData), 
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
					contador <= 4'h0;
					rCurrentState <= rNextState;

				`STATE_CONCATENATE:
					contador <= contador + 1'b1;
					rCurrentState <= rNextState;

				default:
					rCurrentState <= `STATE_IDLE;

			endcase
		end

always @ (negedge CLK)
		if(contador < 4'd8)
			rTempData[contador] <= PS2_DATA;
		
		else
			rTempData <= rTempData;


always @ (*)

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













			if (PS2_DATA == 1'b0 && contador == 4'h0) // Estoy en Estado IDLE y me llegó un cero 
				begin 
					rNextState <= `STATE_CONCATENATE;
				end
			if (PS2_DATA == 1'b0 && contador == 4'h0) // Estoy en Estado IDLE y me llegó un cero 
				begin 
					rNextState <= `STATE_CONCATENATE;
				end


			else if (PS2_DATA == 1 && contador == 10)
				begin
					rNextState <= `STATE_IDLE;
				end
			else
				begin 
					rNextState <=
				end



