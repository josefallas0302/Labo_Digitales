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

`define EXIT 8'd137

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
6: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; /// LOOP 750000

7: oInstruction   = {`STO , `R6, 16'h0030};
8: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

9: oInstruction   = {`STO , `R3, 16'd8};
10: oInstruction   = {`STO , `R4, 16'd25625};
11: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; // LOOP 205000

12: oInstruction   = {`STO , `R6, 16'h0030};
13: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

14: oInstruction   = {`STO , `R4, 16'd5000};
15: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 5000

16: oInstruction   = {`STO , `R6, 16'h0030};
17: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3
		    
18: oInstruction   = {`STO , `R4, 16'd2000};
19: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

20: oInstruction   = {`STO , `R6, 16'h0020};
21: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

22: oInstruction   = {`STO , `R4, 16'd2000};
23: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

//CONFIGURATION
		// FUCTION SET

24: oInstruction   = {`STO , `R6, 16'h0028};
25: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

26: oInstruction   = {`STO , `R4, 16'd50}; 
27: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

28: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
29: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

30: oInstruction  = {`STO , `R4, 16'd2000};
31: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


	     // ENTRY MODE

33: oInstruction   = {`STO , `R6, 16'h0006};
34: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

35: oInstruction   = {`STO , `R4, 16'd50}; 
36: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

37: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
38: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

39: oInstruction  = {`STO , `R4, 16'd2000};
40: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


	     // DISPLAY ON/OFF

42: oInstruction   = {`STO , `R6, 16'h000C};
43: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

44: oInstruction   = {`STO , `R4, 16'd50}; 
45: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

46: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
47: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

48: oInstruction  = {`STO , `R4, 16'd2000};
49: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



	     // CLEAR DISPLAY

51: oInstruction   = {`STO , `R6, 16'h0001};
52: oInstruction  = {`CALL, `CMD, 16'b0}; /// 

53: oInstruction   = {`STO , `R4, 16'd50}; 
54: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

55: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
56: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

57: oInstruction  = {`STO , `R3, 16'd8};
58: oInstruction  = {`STO , `R4, 16'd10250};
59: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; // LOOP 82000
// PRINT ROUTINE
	     
		//H

60: oInstruction   = {`STO , `R6, `H};
61: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

62: oInstruction  = {`STO , `R4, 16'd50}; 
63: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

64: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
65: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

66: oInstruction  = {`STO , `R4, 16'd2000};
67: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000
		
		//O

68: oInstruction   = {`STO , `R6, `O};
69: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

70: oInstruction  = {`STO , `R4, 16'd50}; 
71: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

72: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
73: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

74: oInstruction  = {`STO , `R4, 16'd2000};
75: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000 

		//L

76: oInstruction   = {`STO , `R6, `L};
77: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

78: oInstruction  = {`STO , `R4, 16'd50}; 
79: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

80: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
81: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

82: oInstruction  = {`STO , `R4, 16'd2000};
83: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

		//A

84: oInstruction   = {`STO , `R6, `A};
85: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

86: oInstruction  = {`STO , `R4, 16'd50}; 
87: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

88: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
89: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

90: oInstruction  = {`STO , `R4, 16'd2000};
91: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

		//SPC

92: oInstruction   = {`STO , `R6, `SPC};
93: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

94: oInstruction  = {`STO , `R4, 16'd50}; 
95: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

96: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
97: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

98: oInstruction  = {`STO , `R4, 16'd2000};
99: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



100: oInstruction = {`NOP , 24'd4000 };
101: oInstruction = {`NOP , 24'd4000 };
102: oInstruction = {`JMP , 8'd100 , 16'b0};




//LONG_WAIT: //R4 LOOP INTERNO  // R3 LOOP EXTERNO

103: oInstruction    = {`STO , `R1, 16'd0};	 
104: oInstruction    = {`STO , `R5, 16'd0};	 
		    //LOOP INTERNO
105: oInstruction    = {`ADD , `R1, `R1, `R2}; 
106: oInstruction    = {`BLE , 8'd105,`R1, `R4};
		    //LOOP EXTERNO
107: oInstruction    = {`ADD , `R5, `R5, `R2}; 
108: oInstruction    = {`STO , `R1, 16'd0};
109: oInstruction   = {`BLE , 8'd105,`R5, `R3};
110: oInstruction  = {`RET, 24'd4000 };

		

//SHORT_WAIT
	
111: oInstruction    = {`STO , `R1, 16'd0};	 

112: oInstruction  = {`ADD , `R1, `R1, `R2}; 
113: oInstruction  = {`BLE , 8'd112,`R1, `R4};
114: oInstruction  = {`RET, 24'd4000 };



//CMD:
115: oInstruction   = {`STO , `R5, 16'd0};
116: oInstruction   = {`STO , `R3, 16'd12};

117: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
118: oInstruction   = {`NOP , 24'd4000 };
119: oInstruction   = {`NOP , 24'd4000 };
		    //ENABLE
120: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		    //LOOP 
121: oInstruction   = {`ADD , `R5, `R5, `R2}; 
122: oInstruction   = {`BLE , 8'd121,`R5, `R3};
		    
123: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		    
124: oInstruction   = {`NOP , 24'd4000 };
125: oInstruction  = {`RET, 24'd4000 };



//CHAR:
126: oInstruction   = {`STO , `R5, 16'd0};
127: oInstruction   = {`STO , `R3, 16'd12};

128: oInstruction   = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
129: oInstruction   = {`NOP , 24'd4000 };
130: oInstruction   = {`NOP , 24'd4000 };
		    //ENABLE
131: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		    //LOOP 
132: oInstruction   = {`ADD , `R5, `R5, `R2}; 
133: oInstruction   = {`BLE , 8'd132,`R5, `R3};
		    
134: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		    
135: oInstruction   = {`NOP , 24'd4000 };
136: oInstruction  = {`RET, 24'd4000 };


	     
	     //EXIT:
137: oInstruction = {`NOP , 24'd4000 };
	     
	    

	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
