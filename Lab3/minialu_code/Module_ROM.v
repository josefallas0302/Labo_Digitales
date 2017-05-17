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

module ROM
   (
    input wire [15:0] iAddress,
    output reg [27:0] oInstruction
    );
   always @ ( iAddress )
      begin
	 case (iAddress)
		 /////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 750000 
		 1: oInstruction = {`STO , `R1, 16'd0};
		 2: oInstruction = {`STO , `R2, 16'd1};
		 3: oInstruction = {`STO , `R3, 16'd24};
		 4: oInstruction = {`STO , `R4, 16'd31250};
		 5: oInstruction = {`STO , `R5, 16'd0};

		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};
		 //LOOP1
		 10: oInstruction = {`ADD , `R5, `R5, `R2}; 
       11: oInstruction = {`STO , `R1, 16'd0};
		 12: oInstruction = {`BLE , `LOOP1,`R5, `R3};
		 //POWER ON
		////////////////////////////////////////////////////////////////////////////////////////////////
		//ESCRIBIR 0x3
		
	    13: oInstruction = {`STO , `R5, 16'd0};
		 14: oInstruction = {`STO , `R6, 16'h0030};
		 15: oInstruction = {`STO , `R3, 16'd12};
 		 16: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
		 17: oInstruction = {`NOP , 24'd4000 };
		 18: oInstruction = {`NOP , 24'd4000 };
		 //ENABLE
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		 //LOOP 
 		 20: oInstruction = {`ADD , `R5, `R5, `R2}; 
		 21: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
		 22: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
		 23: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////  
		 // LOOP 205000
		 24: oInstruction = {`STO , `R1, 16'd0};
		 25: oInstruction = {`STO , `R3, 16'd8};
		 26: oInstruction = {`STO , `R4, 16'd25625};
		 27: oInstruction = {`STO , `R5, 16'd0};
		 

		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};
		 //LOOP1
		 10: oInstruction = {`ADD , `R5, `R5, `R2}; 
       11: oInstruction = {`STO , `R1, 16'd0};
		 12: oInstruction = {`BLE , `LOOP1,`R5, `R3};
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////  
		 // ESCRIBIR 0x3
	    13: oInstruction = {`STO , `R5, 16'd0};
		 14: oInstruction = {`STO , `R6, 16'h0030};
		 15: oInstruction = {`STO , `R3, 16'd12};
 		 16: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
		 17: oInstruction = {`NOP , 24'd4000 };
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

 		 20: oInstruction = {`ADD , `R5, `R5, `R2}; 
		 21: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 5000
		 24: oInstruction = {`STO , `R1, 16'd0};
		 26: oInstruction = {`STO , `R4, 16'd5000};
		 

		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};

		 ///////////////////////////////////////////////////////////////////////////////////////////////////////
		 //ESCRIBIR 0x3
		 
	    13: oInstruction = {`STO , `R5, 16'd0};
		 14: oInstruction = {`STO , `R6, 16'h0030};
		 15: oInstruction = {`STO , `R3, 16'd12};
 		 16: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
		 17: oInstruction = {`NOP , 24'd4000 };
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

 		 20: oInstruction = {`ADD , `R5, `R5, `R2}; 
		 21: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
		 24: oInstruction = {`STO , `R1, 16'd0};
		 26: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};
		 

		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //ESCRIBIR 0x2
		 
	    13: oInstruction = {`STO , `R5, 16'd0};
		 14: oInstruction = {`STO , `R6, 16'h0020};
		 15: oInstruction = {`STO , `R3, 16'd12};
 		 16: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
		 17: oInstruction = {`NOP , 24'd4000 };
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

 		 20: oInstruction = {`ADD , `R5, `R5, `R2}; 
		 21: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
		 24: oInstruction = {`STO , `R1, 16'd0};
		 26: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};


		 
 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////CONFIGURACION//////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 

  	
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //FUNCTION SET- FIRST NIBBLE 
		 
	    13: oInstruction = {`STO , `R5, 16'd0};
		 14: oInstruction = {`STO , `R6, 16'h0028};
		 15: oInstruction = {`STO , `R3, 16'd12};
 		 16: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
		 17: oInstruction = {`NOP , 24'd4000 };
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

 		 20: oInstruction = {`ADD , `R5, `R5, `R2}; 
		 21: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
		 19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
		 18: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
		 24: oInstruction = {`STO , `R1, 16'd0};
		 26: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
		 8: oInstruction = {`ADD , `R1, `R1, `R2}; 
		 9: oInstruction = {`BLE , `LOOP1,`R1, `R4};
  
  
		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

		 // 0: oInstruction = {`NOP , 24'd4000 };
		 // 1: oInstruction = {`STO , `R2, 16'd0};
		 // 2: oInstruction = {`STO , `R3, 16'd1};
		 // 3: oInstruction = {`STO , `R4, 16'd4};
		 // 4: oInstruction = {`STO , `R5, 16'd50};
		 // 5: oInstruction = {`STO , `R6, 16'd2000};
		 // 6: oInstruction = {`STO , `R7, 16'd11}; 
		 // 7: oInstruction = {`STO , `R8, 16'd10}; 
		 
		 // //INICIO:
		 // 8: oInstruction = {`STO , `R1, `H};
		 // 9: oInstruction = {`SUB , `R7, `R7, `R3};
		 
		 // //MAIN:
		 // 10: oInstruction = {`LCD , 4'b0, `R1, 8'b0};
		 // //LOOP1:
		 // 11: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 // 12: oInstruction = {`BLE , `LOOP1,`R2, `R5};
		 // 13: oInstruction = {`SHL , `R1, `R1, `R4};
		 // 14: oInstruction = {`LCD , 4'b0, `R1, 8'b0}; 
		 // 15: oInstruction = {`STO , `R2, 16'd0};
		 // //LOOP2:
		 // 16: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 // 17: oInstruction = {`BLE , `LOOP2,`R2, `R6};
		 
		 
		 // 18: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 // 19: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 20: oInstruction = {`BLE , `JMP_L,`R8, `R7};
		 // 21: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 22: oInstruction = {`BLE , `JMP_A,`R8, `R7};
		 // 23: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 24: oInstruction = {`BLE , `JMP_SPC,`R8, `R7};
		 // 25: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 26: oInstruction = {`BLE , `JMP_M,`R8, `R7};
		 // 27: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 28: oInstruction = {`BLE , `JMP_U,`R8, `R7};
		 // 29: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 30: oInstruction = {`BLE , `JMP_N,`R8, `R7};
		 // 31: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 32: oInstruction = {`BLE , `JMP_D,`R8, `R7};
		 // 33: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 34: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 // 35: oInstruction = {`JMP , 8'd60 , 16'b0};
		 
		 
		 // //JMP_O:
		 // 36: oInstruction = {`STO , `R1, `O};
		 // 37: oInstruction = {`STO , `R8, 16'd10};
		 // 38: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 
		 // //JMP_L:
		 // 39: oInstruction = {`STO , `R1, `L};
		 // 40: oInstruction = {`STO , `R8, 16'd10};
		 // 41: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_A:
		 // 42: oInstruction = {`STO , `R1, `A};
		 // 43: oInstruction = {`STO , `R8, 16'd10};
		 // 44: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_SPC:
		 // 45: oInstruction = {`STO , `R1, `SPC};
		 // 46: oInstruction = {`STO , `R8, 16'd10};
		 // 47: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_M:
		 // 48: oInstruction = {`STO , `R1, `M};
		 // 49: oInstruction = {`STO , `R8, 16'd10};
		 // 50: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_U:
		 // 51: oInstruction = {`STO , `R1, `U};
		 // 52: oInstruction = {`STO , `R8, 16'd10};
		 // 53: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_N:
		 // 54: oInstruction = {`STO , `R1, `N};
		 // 55: oInstruction = {`STO , `R8, 16'd10};
		 // 56: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_D:
		 // 57: oInstruction = {`STO , `R1, `D};
		 // 58: oInstruction = {`STO , `R8, 16'd10};
		 // 59: oInstruction = {`JMP , 8'd10, 16'b0};

		 // 60: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 // 0: oInstruction = {`NOP , 24'd4000 };
		 // 1: oInstruction = {`STO , `R2, 16'd0};
		 // 2: oInstruction = {`STO , `R3, 16'd1};
		 // 3: oInstruction = {`STO , `R4, 16'd4};
		 // 4: oInstruction = {`STO , `R5, 16'd50};
		 // 5: oInstruction = {`STO , `R6, 16'd2000};
		 // 6: oInstruction = {`STO , `R7, 16'd11}; 
		 // 7: oInstruction = {`STO , `R8, 16'd10}; 
		 
		 // //INICIO:
		 // 8: oInstruction = {`STO , `R1, `H};
		 // 9: oInstruction = {`SUB , `R7, `R7, `R3};
		 
		 // //MAIN:
		 // 10: oInstruction = {`LCD , 4'b0, `R1, 8'b0};
		 // //LOOP1:
		 // 11: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 // 12: oInstruction = {`BLE , `LOOP1,`R2, `R5};
		 // 13: oInstruction = {`SHL , `R1, `R1, `R4};
		 // 14: oInstruction = {`LCD , 4'b0, `R1, 8'b0}; 
		 // 15: oInstruction = {`STO , `R2, 16'd0};
		 // //LOOP2:
		 // 16: oInstruction = {`ADD , `R2, `R2, `R3}; 
		 // 17: oInstruction = {`BLE , `LOOP2,`R2, `R6};
		 
		 
		 // 18: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 // 19: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 20: oInstruction = {`BLE , `JMP_L,`R8, `R7};
		 // 21: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 22: oInstruction = {`BLE , `JMP_A,`R8, `R7};
		 // 23: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 24: oInstruction = {`BLE , `JMP_SPC,`R8, `R7};
		 // 25: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 26: oInstruction = {`BLE , `JMP_M,`R8, `R7};
		 // 27: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 28: oInstruction = {`BLE , `JMP_U,`R8, `R7};
		 // 29: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 30: oInstruction = {`BLE , `JMP_N,`R8, `R7};
		 // 31: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 32: oInstruction = {`BLE , `JMP_D,`R8, `R7};
		 // 33: oInstruction = {`SUB , `R8, `R8, `R3};
		 // 34: oInstruction = {`BLE , `JMP_O,`R8, `R7};
		 // 35: oInstruction = {`JMP , 8'd60 , 16'b0};
		 
		 
		 // //JMP_O:
		 // 36: oInstruction = {`STO , `R1, `O};
		 // 37: oInstruction = {`STO , `R8, 16'd10};
		 // 38: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 
		 // //JMP_L:
		 // 39: oInstruction = {`STO , `R1, `L};
		 // 40: oInstruction = {`STO , `R8, 16'd10};
		 // 41: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_A:
		 // 42: oInstruction = {`STO , `R1, `A};
		 // 43: oInstruction = {`STO , `R8, 16'd10};
		 // 44: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_SPC:
		 // 45: oInstruction = {`STO , `R1, `SPC};
		 // 46: oInstruction = {`STO , `R8, 16'd10};
		 // 47: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_M:
		 // 48: oInstruction = {`STO , `R1, `M};
		 // 49: oInstruction = {`STO , `R8, 16'd10};
		 // 50: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_U:
		 // 51: oInstruction = {`STO , `R1, `U};
		 // 52: oInstruction = {`STO , `R8, 16'd10};
		 // 53: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_N:
		 // 54: oInstruction = {`STO , `R1, `N};
		 // 55: oInstruction = {`STO , `R8, 16'd10};
		 // 56: oInstruction = {`JMP , 8'd10, 16'b0};
		 
		 // //JMP_D:
		 // 57: oInstruction = {`STO , `R1, `D};
		 // 58: oInstruction = {`STO , `R8, 16'd10};
		 // 59: oInstruction = {`JMP , 8'd10, 16'b0};

		 // 60: oInstruction = {`NOP , 24'd4000 };
		 
		 
	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
