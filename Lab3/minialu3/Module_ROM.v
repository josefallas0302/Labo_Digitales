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

`define LONG_WAIT 8'd54
`define SHORT_WAIT 8'd62
`define NIBBLE_CHAR 8'd96
`define NIBBLE_CMD 8'd88
`define CMD 8'd66
`define CHAR 8'd77

`define EXIT 8'd112

module ROM
   (
    input wire [15:0] iAddress,
    output reg [27:0] oInstruction
    );
   always @ ( iAddress )
      begin
	 case (iAddress)

0: oInstruction  = {`NOP , 24'd4000 };

1: oInstruction    = {`STO , `R2, 16'd1};    // UNO FIJO
2: oInstruction    = {`STO , `R7, 16'd4};	 // CUATRO FIJO
3: oInstruction    = {`STO , `R6, 16'h0030}; // DATA LCD	    	

///POWER ON 
4: oInstruction    = {`STO , `R3, 16'd24};	 // PRIMER LOOP LONG(EXTERNO) y SHORT
5: oInstruction    = {`STO , `R4, 16'd31250};// SEGUNDO LOOP LONG(INTERNO)
8: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; /// LOOP 750000

9: oInstruction   = {`STO , `R6, 16'h0030};
10: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

11: oInstruction   = {`STO , `R3, 16'd8};
12: oInstruction   = {`STO , `R4, 16'd25625};
13: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; // LOOP 205000

14: oInstruction   = {`STO , `R6, 16'h0030};
15: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

16: oInstruction   = {`STO , `R4, 16'd5000};
17: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 5000

18: oInstruction   = {`STO , `R6, 16'h0030};
19: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3
		    
20: oInstruction   = {`STO , `R4, 16'd2000};
21: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

22: oInstruction   = {`STO , `R6, 16'h0020};
23: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

24: oInstruction   = {`STO , `R4, 16'd2000};
25: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

//CONFIGURATION
		// FUCTION SET

26: oInstruction   = {`STO , `R6, 16'h0028};
27: oInstruction  = {`CALL, `NIBBLE_CMD, 16'b0}; /// 

	     // ENTRY MODE

28: oInstruction   = {`STO , `R6, 16'h0006};
29: oInstruction  = {`CALL, `NIBBLE_CMD, 16'b0}; /// 

	     // DISPLAY ON/OFF

30: oInstruction   = {`STO , `R6, 16'h000C};
31: oInstruction  = {`CALL, `NIBBLE_CMD, 16'b0}; /// 


	     // CLEAR DISPLAY

32: oInstruction   = {`STO , `R6, 16'h0001};
33: oInstruction  = {`CALL, `CMD, 16'b0}; /// 

34: oInstruction   = {`STO , `R4, 16'd50}; 
35: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

36: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
37: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

38: oInstruction  = {`STO , `R3, 16'd8};
39: oInstruction  = {`STO , `R4, 16'd10250};
40: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; // LOOP 82000
// PRINT ROUTINE
	     
		//H

41: oInstruction   = {`STO , `R6, `H};
42: oInstruction  = {`CALL, `NIBBLE_CHAR, 16'b0}; /// 
		
		//O

43: oInstruction   = {`STO , `R6, `O};
44: oInstruction  = {`CALL, `NIBBLE_CHAR, 16'b0}; /// 

		//L

45: oInstruction   = {`STO , `R6, `L};
46: oInstruction  = {`CALL, `NIBBLE_CHAR, 16'b0}; /// 

		//A

47: oInstruction   = {`STO , `R6, `A};
48: oInstruction  = {`CALL, `NIBBLE_CHAR, 16'b0}; /// 

		//SPC

49: oInstruction   = {`STO , `R6, `SPC};
50: oInstruction  = {`CALL, `NIBBLE_CHAR, 16'b0}; /// 



51: oInstruction = {`NOP , 24'd4000 };
52: oInstruction = {`NOP , 24'd4000 };
53: oInstruction = {`JMP , 8'd100 , 16'b0};




//LONG_WAIT: //R4 LOOP INTERNO  // R3 LOOP EXTERNO

54: oInstruction    = {`STO , `R1, 16'd0};	 
55: oInstruction    = {`STO , `R5, 16'd0};	 
		    //LOOP INTERNO
56: oInstruction    = {`ADD , `R1, `R1, `R2}; 
57: oInstruction    = {`BLE , 8'd56,`R1, `R4};
		    //LOOP EXTERNO
58: oInstruction    = {`ADD , `R5, `R5, `R2}; 
59: oInstruction    = {`STO , `R1, 16'd0};
60: oInstruction   = {`BLE , 8'd56,`R5, `R3};
61: oInstruction  = {`RET, 24'd4000 };

		

//SHORT_WAIT
	
62: oInstruction    = {`STO , `R1, 16'd0};	 

63: oInstruction  = {`ADD , `R1, `R1, `R2}; 
64: oInstruction  = {`BLE , 8'd87,`R1, `R4};
65: oInstruction  = {`RET, 24'd4000 };



//CMD:
66: oInstruction   = {`STO , `R5, 16'd0};
67: oInstruction   = {`STO , `R3, 16'd12};

68: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
69: oInstruction   = {`NOP , 24'd4000 };
70: oInstruction   = {`NOP , 24'd4000 };
		    //ENABLE
71: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		    //LOOP 
72: oInstruction   = {`ADD , `R5, `R5, `R2}; 
73: oInstruction   = {`BLE , 8'd72,`R5, `R3};
		    
74: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		    
75: oInstruction   = {`NOP , 24'd4000 };
76: oInstruction  = {`RET, 24'd4000 };



//CHAR:
77: oInstruction   = {`STO , `R5, 16'd0};
78: oInstruction   = {`STO , `R3, 16'd12};

79: oInstruction   = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
80: oInstruction   = {`NOP , 24'd4000 };
81: oInstruction   = {`NOP , 24'd4000 };
		    //ENABLE
82: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		    //LOOP 
83: oInstruction   = {`ADD , `R5, `R5, `R2}; 
84: oInstruction   = {`BLE , 8'd83,`R5, `R3};
		    
85: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		    
86: oInstruction   = {`NOP , 24'd4000 };
87: oInstruction  = {`RET, 24'd4000 };

//NIBBLE_CMD:

88: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

89: oInstruction   = {`STO , `R4, 16'd50}; 
90: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

91: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
92: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

93: oInstruction   = {`STO , `R4, 16'd2000};
94: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000
95: oInstruction  = {`RET, 24'd4000 };

//NIBBLE_CHAR:

96: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

97: oInstruction   = {`STO , `R4, 16'd50}; 
98: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

99: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
100: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

101: oInstruction   = {`STO , `R4, 16'd2000};
102: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000
103: oInstruction  = {`RET, 24'd4000 };

	     
	     //EXIT:
104: oInstruction = {`NOP , 24'd4000 };
	     
	    

	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
