`timescale 1ns / 1ps
`include "Defintions.v"
`define LOOP1 8'd10
`define LOOP2 8'd7
module ROM
   (
    input wire [15:0] iAddress,
    output reg [27:0] oInstruction
    );
   always @ ( iAddress )
      begin
	 case (iAddress)
		 0: oInstruction = {`NOP , 24'd4000 };
		 1: oInstruction = {`STO , `R2, 16'd0};
		 2: oInstruction = {`STO , `R3, 16'd1};
		 3: oInstruction = {`STO , `R4, 16'd4};
		 4: oInstruction = {`STO , `R5, 16'd50};
		 5: oInstruction = {`STO , `R6, 16'd2000};
		 6: oInstruction = {`STO , `R7, 16'd11}; 
		 7: oInstruction = {`STO , `R8, 16'd10}; 
		 
		 //INICIO:
		 8: oInstruction = {`STO , `R1, `H};
		 9: oInstruction = {`SUB , `R7, `R7, `R3};
		 
		 //MAIN:
		 10: oInstruction = {`LCD , 4'b0, `R1, 8'b0};
		 //LOOP1:
		 11: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 12: oInstruction = {`BLE , `LOOP1,`R2, `R5};
		 13: oInstruction = {`SHL , `R1, `R1, `R4};
		 14: oInstruction = {`LCD , 4'b0, `R1, 8'b0}; 
		 15: oInstruction = {`STO , `R2, 16'd0};
		 //LOOP2:
		 16: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 17: oInstruction = {`BLE , `LOOP2,`R2, `R6};
		 
		 
		 18: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 19: oInstruction = {`SUB , `R8, `R8, `R3};
		 20: oInstruction = {`BLE , `JMP_L,`R8, `R7};
		 21: oInstruction = {`SUB , `R8, `R8, `R3};
		 22: oInstruction = {`BLE , `JMP_A,`R8, `R7};
		 23: oInstruction = {`SUB , `R8, `R8, `R3};
		 24: oInstruction = {`BLE , `JMP_SPC,`R8, `R7};
		 25: oInstruction = {`SUB , `R8, `R8, `R3};
		 26: oInstruction = {`BLE , `JMP_M,`R8, `R7};
		 27: oInstruction = {`SUB , `R8, `R8, `R3};
		 28: oInstruction = {`BLE , `JMP_U,`R8, `R7};
		 29: oInstruction = {`SUB , `R8, `R8, `R3};
		 30: oInstruction = {`BLE , `JMP_N,`R8, `R7};
		 31: oInstruction = {`SUB , `R8, `R8, `R3};
		 32: oInstruction = {`BLE , `JMP_D,`R8, `R7};
		 33: oInstruction = {`SUB , `R8, `R8, `R3};
		 34: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 
		 
		 //JMP_O:
		 35: oInstruction = {`STO , `R1, `O};
		 36: oInstruction = {`STO , `R8, 16'd10};
		 37: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_L:
		 38: oInstruction = {`STO , `R1, `L};
		 39: oInstruction = {`STO , `R8, 16'd10};
		 40: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_A:
		 41: oInstruction = {`STO , `R1, `A};
		 42: oInstruction = {`STO , `R8, 16'd10};
		 43: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_SPC:
		 44: oInstruction = {`STO , `R1, `SPC};
		 45: oInstruction = {`STO , `R8, 16'd10};
		 46: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_M:
		 47: oInstruction = {`STO , `R1, `M};
		 48: oInstruction = {`STO , `R8, 16'd10};
		 49: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_U:
		 50: oInstruction = {`STO , `R1, `U};
		 51: oInstruction = {`STO , `R8, 16'd10};
		 52: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_N:
		 53: oInstruction = {`STO , `R1, `N};
		 54: oInstruction = {`STO , `R8, 16'd10};
		 55: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_D:
		 56: oInstruction = {`STO , `R1, `D};
		 57: oInstruction = {`STO , `R8, 16'd10};
		 58: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 //JMP_O:
		 59: oInstruction = {`STO , `R1, `O};
		 60: oInstruction = {`STO , `R8, 16'd10};
		 61: oInstruction = {`JMP , 8'd10, 16'b0};
		 
	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule