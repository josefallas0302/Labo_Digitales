`timescale 1ns / 1ps
`include "Defintions.v"
`define LOOP1 8'd8
`define LOOP2 8'd19
`define JMP_O 8'd36
`define JMP_L 8'd39
`define JMP_A 8'd42
`define JMP_SPC 8'd45
`define JMP_M 8'd48
`define JMP_U 8'd51
`define JMP_N 8'd54
`define JMP_D 8'd57

`define LONG_WAIT 8'd140
`define SHORT_WAIT 8'd148
`define CMD 8'd152
`define CHAR 8'd163

`define EXIT 8'd174

module ROM
   (
    input wire [15:0] iAddress,
    output reg [27:0] oInstruction
    );
   always @ ( iAddress )
      begin
	 case (iAddress)

	    0: oInstruction  = {`NOP , 24'd4000 };

	    1: oInstruction    = {`STO , `R2, 16'd1};
	    2: oInstruction    = {`STO , `R7, 16'd4};
	    3: oInstruction    = {`STO , `R6, 16'h0030};  

	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
