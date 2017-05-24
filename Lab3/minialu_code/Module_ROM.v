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

	    32: oInstruction   = {`STO , `R6, 16'h0006};
	    33: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    34: oInstruction   = {`STO , `R4, 16'd50}; 
	    35: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    36: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    37: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    38: oInstruction  = {`STO , `R4, 16'd2000};
	    39: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


	    // DISPLAY ON/OFF

	    40: oInstruction   = {`STO , `R6, 16'h000C};
	    41: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    42: oInstruction   = {`STO , `R4, 16'd50}; 
	    43: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    44: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    45: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    46: oInstruction  = {`STO , `R4, 16'd2000};
	    47: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



	    // CLEAR DISPLAY

	    48: oInstruction   = {`STO , `R6, 16'h0001};
	    49: oInstruction  = {`CALL, `CMD, 16'b0}; /// 

	    50: oInstruction   = {`STO , `R4, 16'd50}; 
	    51: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    52: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    53: oInstruction  = {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    54: oInstruction  = {`STO , `R3, 16'd8};
	    55: oInstruction  = {`STO , `R4, 16'd10250};
	    56: oInstruction  = {`CALL, `LONG_WAIT, 16'b0}; // LOOP 82000
	    // PRINT ROUTINE
	    
	    //H
	    57: oInstruction   = {`STO , `R6, `H};
	    58: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    59: oInstruction  = {`STO , `R4, 16'd50}; 
	    60: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    61: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    62: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    63: oInstruction  = {`STO , `R4, 16'd2000};
	    64: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

	    //O
	    65: oInstruction   = {`STO , `R6, `O};
	    66: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    67: oInstruction  = {`STO , `R4, 16'd50}; 
	    68: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    69: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    70: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    71: oInstruction  = {`STO , `R4, 16'd2000};
	    72: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000 

	    //L
	    73: oInstruction   = {`STO , `R6, `L};
	    74: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    75: oInstruction  = {`STO , `R4, 16'd50}; 
	    76: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    77: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    78: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    79: oInstruction  = {`STO , `R4, 16'd2000};
	    80: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

	    //A
	    81: oInstruction   = {`STO , `R6, `A};
	    82: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    83: oInstruction  = {`STO , `R4, 16'd50}; 
	    84: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    85: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    86: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    87: oInstruction  = {`STO , `R4, 16'd2000};
	    88: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

	    //SPC
	    89: oInstruction   = {`STO , `R6, `SPC};
	    90: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    91: oInstruction  = {`STO , `R4, 16'd50}; 
	    92: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    93: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    94: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    95: oInstruction  = {`STO , `R4, 16'd2000};
	    96: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


	    //M
	    97: oInstruction   = {`STO , `R6, `M};
	    98: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    99: oInstruction  = {`STO , `R4, 16'd50}; 
	    100: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    101: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    102: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    103: oInstruction  = {`STO , `R4, 16'd2000};
	    104: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

	    
	    //U
	    105: oInstruction   = {`STO , `R6, `U};
	    106: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    107: oInstruction  = {`STO , `R4, 16'd50}; 
	    108: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    109: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    110: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    111: oInstruction  = {`STO , `R4, 16'd2000};
	    112: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



	    //N
	    113: oInstruction   = {`STO , `R6, `N};
	    114: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    115: oInstruction  = {`STO , `R4, 16'd50}; 
	    116: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    117: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    118: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    119: oInstruction  = {`STO , `R4, 16'd2000};
	    120: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



	    //D
	    121: oInstruction   = {`STO , `R6, `D};
	    122: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    123: oInstruction  = {`STO , `R4, 16'd50}; 
	    124: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    125: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    126: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    127: oInstruction  = {`STO , `R4, 16'd2000};
	    128: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



	    //O
	    129: oInstruction   = {`STO , `R6, `O};
	    130: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

	    131: oInstruction  = {`STO , `R4, 16'd50}; 
	    132: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

	    133: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    134: oInstruction  = {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

	    135: oInstruction  = {`STO , `R4, 16'd2000};
	    136: oInstruction  = {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

	    

	    137: oInstruction = {`NOP , 24'd4000 };
	    138: oInstruction = {`NOP , 24'd4000 };
	    139: oInstruction = {`JMP , `EXIT , 16'b0};




	    //LONG_WAIT: //R4 LOOP INTERNO  // R3 LOOP EXTERNO
	    140: oInstruction    = {`STO , `R1, 16'd0};	 
	    141: oInstruction    = {`STO , `R5, 16'd0};	 
	    //LOOP INTERNO
	    142: oInstruction    = {`ADD , `R1, `R1, `R2}; 
	    143: oInstruction    = {`BLE , 8'd142,`R1, `R4};
	    //LOOP EXTERNO
	    144: oInstruction    = {`ADD , `R5, `R5, `R2}; 
	    145: oInstruction    = {`STO , `R1, 16'd0};
	    146: oInstruction   = {`BLE , 8'd142,`R5, `R3};
	    147: oInstruction  = {`RET, 24'd4000 };

	    

	    //SHORT_WAIT
	    148: oInstruction    = {`STO , `R1, 16'd0};	 

	    149: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    150: oInstruction  = {`BLE , 8'd149,`R1, `R4};
	    151: oInstruction  = {`RET, 24'd4000 };



	    //CMD:
	    152: oInstruction   = {`STO , `R5, 16'd0};
	    153: oInstruction   = {`STO , `R3, 16'd12};

	    154: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    155: oInstruction   = {`NOP , 24'd4000 };
	    156: oInstruction   = {`NOP , 24'd4000 };
	    //ENABLE
	    157: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    //LOOP 
	    158: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    159: oInstruction   = {`BLE , 8'd158,`R5, `R3};
	    
	    160: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    161: oInstruction   = {`NOP , 24'd4000 };
	    162: oInstruction  = {`RET, 24'd4000 };



	    //CHAR:
	    163: oInstruction   = {`STO , `R5, 16'd0};
	    164: oInstruction   = {`STO , `R3, 16'd12};

	    165: oInstruction   = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    166: oInstruction   = {`NOP , 24'd4000 };
	    167: oInstruction   = {`NOP , 24'd4000 };
	    //ENABLE
	    168: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    //LOOP 
	    169: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    170: oInstruction   = {`BLE , 8'd169,`R5, `R3};
	    
	    171: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    172: oInstruction   = {`NOP , 24'd4000 };
	    173: oInstruction  = {`RET, 24'd4000 };


	    
	    //EXIT:
	    174: oInstruction = {`NOP , 24'd4000 };
	    
	    

	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
