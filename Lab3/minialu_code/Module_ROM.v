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

`define ADD_FN 8'd10
`define EXIT 8'd100

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
	    0: oInstruction    = {`NOP , 24'd4000 };
	    1: oInstruction    = {`STO , `R1, 16'd0};
	    2: oInstruction    = {`STO , `R2, 16'd1};
	    3: oInstruction    = {`STO , `R3, 16'd24};
	    4: oInstruction    = {`STO , `R4, 16'd31250};
	    5: oInstruction    = {`STO , `R5, 16'd0};
	    6: oInstruction    = {`STO , `R7, 16'd4};
	    
	    //LOOP1
	    7: oInstruction    = {`ADD , `R1, `R1, `R2}; 
	    8: oInstruction    = {`BLE , 8'd7,`R1, `R4};
	    //LOOP1
	    9: oInstruction    = {`ADD , `R5, `R5, `R2}; 
	    10: oInstruction    = {`STO , `R1, 16'd0};
	    11: oInstruction   = {`BLE , 8'd7,`R5, `R3};


	    //POWER ON
	    ////////////////////////////////////////////////////////////////////////////////////////////////
	    //ESCRIBIR 0x3
	    
	    12: oInstruction   = {`STO , `R5, 16'd0};
	    13: oInstruction   = {`STO , `R6, 16'h0030};
	    14: oInstruction   = {`STO , `R3, 16'd12};
	    15: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    16: oInstruction   = {`NOP , 24'd4000 };
	    17: oInstruction   = {`NOP , 24'd4000 };
	    //ENABLE
	    18: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    //LOOP 
	    19: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    20: oInstruction   = {`BLE , 8'd19,`R5, `R3};
	    
	    21: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    22: oInstruction   = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////  
	    // LOOP 205000
	    23: oInstruction   = {`STO , `R1, 16'd0};
	    24: oInstruction   = {`STO , `R3, 16'd8};
	    25: oInstruction   = {`STO , `R4, 16'd25625};
	    26: oInstruction   = {`STO , `R5, 16'd0};
	    

	    //LOOP1
	    27: oInstruction   = {`ADD , `R1, `R1, `R2}; 
	    28: oInstruction   = {`BLE , 8'd27,`R1, `R4};
	    //LOOP1
	    29: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    30: oInstruction   = {`STO , `R1, 16'd0};
	    31: oInstruction   = {`BLE , 8'd27,`R5, `R3};
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////  
	    // ESCRIBIR 0x3
	    32: oInstruction   = {`STO , `R5, 16'd0};
	    33: oInstruction   = {`STO , `R6, 16'h0030};
	    34: oInstruction   = {`STO , `R3, 16'd12};
	    35: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    36: oInstruction   = {`NOP , 24'd4000 };
	    37: oInstruction   = {`NOP , 24'd4000 };
	    
	    38: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    39: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    40: oInstruction   = {`BLE , 8'd39,`R5, `R3}; //20?
	    
	    41: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    42: oInstruction   = {`NOP , 24'd4000 };
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 5000
	    43: oInstruction   = {`STO , `R1, 16'd0};
	    44: oInstruction   = {`STO , `R4, 16'd5000};
	    

	    //LOOP1
	    45: oInstruction   = {`ADD , `R1, `R1, `R2}; 
	    46: oInstruction   = {`BLE , 8'd45,`R1, `R4};

	    ///////////////////////////////////////////////////////////////////////////////////////////////////////
	    //ESCRIBIR 0x3
	    
	    47: oInstruction   = {`STO , `R5, 16'd0};
	    48: oInstruction   = {`STO , `R6, 16'h0030};
	    49: oInstruction   = {`STO , `R3, 16'd12};
	    50: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    51: oInstruction   = {`NOP , 24'd4000 };
	    52: oInstruction   = {`NOP , 24'd4000 };
	    
	    53: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    54: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    55: oInstruction   = {`BLE , 8'd54,`R5, `R3};
	    
	    56: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    57: oInstruction   = {`NOP , 24'd4000 };
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    58: oInstruction   = {`STO , `R1, 16'd0};
	    59: oInstruction   = {`STO , `R4, 16'd2000};


	    //LOOP1
	    60: oInstruction   = {`ADD , `R1, `R1, `R2}; 
	    61: oInstruction   = {`BLE , 8'd60,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //ESCRIBIR 0x2
	    
	    62: oInstruction   = {`STO , `R5, 16'd0};
	    63: oInstruction   = {`STO , `R6, 16'h0020};
	    64: oInstruction   = {`STO , `R3, 16'd12};
	    65: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    66: oInstruction   = {`NOP , 24'd4000 };
	    67: oInstruction   = {`NOP , 24'd4000 };
	    
	    68: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    69: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    70: oInstruction   = {`BLE , 8'd69,`R5, `R3};
	    
	    71: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    72: oInstruction   = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    73: oInstruction   = {`STO , `R1, 16'd0};
	    74: oInstruction   = {`STO , `R4, 16'd2000};

	    //LOOP1
	    75: oInstruction   = {`ADD , `R1, `R1, `R2}; 
	    76: oInstruction   = {`BLE , 8'd75,`R1, `R4};


	    
	    
	    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    ///////////////////////////////////////CONFIGURACION//////////////////////////////////////////////
	    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	    

  	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //FUNCTION SET- FIRST NIBBLE 
	    
	    77: oInstruction   = {`STO , `R5, 16'd0};
	    78: oInstruction   = {`STO , `R6, 16'h0028};
	    79: oInstruction   = {`STO , `R3, 16'd12};

	    80: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    81: oInstruction   = {`NOP , 24'd4000 };
	    82: oInstruction   = {`NOP , 24'd4000 };
	    
	    83: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    84: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    85: oInstruction   = {`BLE , 8'd84,`R5, `R3};
	    
	    86: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    87: oInstruction   = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    88: oInstruction   = {`STO , `R1, 16'd0};
	    89: oInstruction   = {`STO , `R4, 16'd50};

	    //LOOP1
	    90: oInstruction   = {`ADD , `R1, `R1, `R2}; 
	    91: oInstruction   = {`BLE , 8'd90,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    92: oInstruction   = {`STO , `R5, 16'd0};
	    93: oInstruction   = {`STO , `R3, 16'd12};
	    94: oInstruction   = {`SHL , `R6 ,`R6, `R7 };
	    95: oInstruction   = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    96: oInstruction   = {`NOP , 24'd4000 };
	    97: oInstruction   = {`NOP , 24'd4000 };
	    
	    98: oInstruction   = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    99: oInstruction   = {`ADD , `R5, `R5, `R2}; 
	    100: oInstruction   = {`BLE , 8'd99,`R5, `R3};
	    
	    101: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    102: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    103: oInstruction  = {`STO , `R1, 16'd0};
	    104: oInstruction  = {`STO , `R4, 16'd2000};

	    //LOOP1
	    105: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    106: oInstruction  = {`BLE , 8'd105,`R1, `R4};

	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //ENTRY MODE- FIRST NIBBLE 
	    
	    107: oInstruction  = {`STO , `R5, 16'd0};
	    108: oInstruction  = {`STO , `R6, 16'h0006}; //ENTRY MODE BYTE
	    109: oInstruction  = {`STO , `R3, 16'd12};

	    110: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    111: oInstruction  = {`NOP , 24'd4000 };
	    112: oInstruction  = {`NOP , 24'd4000 };
	    
	    113: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    114: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    115: oInstruction  = {`BLE , 8'd114,`R5, `R3};
	    
	    116: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    117: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    118: oInstruction  = {`STO , `R1, 16'd0};
	    119: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    120: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    121: oInstruction  = {`BLE , 8'd120,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    122: oInstruction  = {`STO , `R5, 16'd0};
	    123: oInstruction  = {`STO , `R3, 16'd12};
	    124: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    125: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    126: oInstruction  = {`NOP , 24'd4000 };
	    127: oInstruction  = {`NOP , 24'd4000 };
	    
	    128: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    129: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    130: oInstruction  = {`BLE , 8'd129,`R5, `R3};
	    
	    131: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    132: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    133: oInstruction  = {`STO , `R1, 16'd0};
	    134: oInstruction  = {`STO , `R4, 16'd2000};

	    //LOOP1
	    135: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    136: oInstruction  = {`BLE , 8'd135,`R1, `R4};
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //DISPLAY ON-OFF / FIRST NIBBLE 
	    
	    137: oInstruction  = {`STO , `R5, 16'd0};
	    138: oInstruction  = {`STO , `R6, 16'h000C}; //ENTRY MODE BYTE
	    139: oInstruction  = {`STO , `R3, 16'd12};

	    140: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    141: oInstruction  = {`NOP , 24'd4000 };
	    142: oInstruction  = {`NOP , 24'd4000 };
	    
	    143: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    144: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    145: oInstruction  = {`BLE , 8'd144,`R5, `R3};
	    
	    146: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    147: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    148: oInstruction  = {`STO , `R1, 16'd0};
	    149: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    150: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    151: oInstruction  = {`BLE , 8'd150,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    152: oInstruction  = {`STO , `R5, 16'd0};
	    153: oInstruction  = {`STO , `R3, 16'd12};
	    154: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    155: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    156: oInstruction  = {`NOP , 24'd4000 };
	    157: oInstruction  = {`NOP , 24'd4000 };
	    
	    158: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    159: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    160: oInstruction  = {`BLE , 8'd159,`R5, `R3};
	    
	    161: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    162: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    163: oInstruction  = {`STO , `R1, 16'd0};
	    164: oInstruction  = {`STO , `R4, 16'd2000};

	    //LOOP1
	    165: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    166: oInstruction  = {`BLE , 8'd165,`R1, `R4};


	    /////////////////////////////////////////////////////////////////////////////////////////////////
	    //CLEAR DISPLAY - FIRST NIBBLE 
	    
	    167: oInstruction  = {`STO , `R5, 16'd0};
	    168: oInstruction  = {`STO , `R6, 16'h0001}; //ENTRY MODE BYTE
	    169: oInstruction  = {`STO , `R3, 16'd12};

	    170: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    171: oInstruction  = {`NOP , 24'd4000 };
	    172: oInstruction  = {`NOP , 24'd4000 };
	    
	    173: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    174: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    175: oInstruction  = {`BLE , 8'd174,`R5, `R3};
	    
	    176: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    177: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    178: oInstruction  = {`STO , `R1, 16'd0};
	    179: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    180: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    181: oInstruction  = {`BLE , 8'd180,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    182: oInstruction  = {`STO , `R5, 16'd0};
	    183: oInstruction  = {`STO , `R3, 16'd12};
	    184: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    185: oInstruction  = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
	    186: oInstruction  = {`NOP , 24'd4000 };
	    187: oInstruction  = {`NOP , 24'd4000 };
	    
	    188: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

	    189: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    190: oInstruction  = {`BLE , 8'd189,`R5, `R3};
	    
	    191: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	    
	    192: oInstruction  = {`NOP , 24'd4000 };
	    
	    
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 82000
	    193: oInstruction  = {`STO , `R1, 16'd0};
	    194: oInstruction  = {`STO , `R3, 16'd8};
	    195: oInstruction  = {`STO , `R4, 16'd10250};
	    196: oInstruction  = {`STO , `R5, 16'd0};

	    //LOOP1
	    197: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    198: oInstruction  = {`BLE , 8'd197,`R1, `R4};
	    //LOOP1
	    199: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    200: oInstruction  = {`STO , `R1, 16'd0};
	    201: oInstruction  = {`BLE , 8'd197,`R5, `R3};



	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //PRINT ROUTINE 
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //H 
	    //FIRST NIBBLE 
	    202: oInstruction  = {`STO , `R5, 16'd0};
	    203: oInstruction  = {`STO , `R6, 8'h00,`H}; //ENTRY MODE BYTE
	    204: oInstruction  = {`STO , `R3, 16'd12};

	    205: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    206: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    207: oInstruction  = {`NOP , 24'd4000 };
	    
	    208: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    209: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    210: oInstruction  = {`BLE , 8'd209,`R5, `R3};
	    
	    211: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    212: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    213: oInstruction  = {`STO , `R1, 16'd0};
	    214: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    215: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    216: oInstruction  = {`BLE , 8'd215,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    217: oInstruction  = {`STO , `R5, 16'd0};
	    218: oInstruction  = {`STO , `R3, 16'd12};
	    
	    219: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    220: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    221: oInstruction  = {`NOP , 24'd4000 };
	    222: oInstruction  = {`NOP , 24'd4000 };
	    223: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    224: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    225: oInstruction  = {`BLE , 8'd224,`R5, `R3};
	    
	    226: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    227: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    228: oInstruction  = {`STO , `R1, 16'd0};
	    229: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    230: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    231: oInstruction  = {`BLE , 8'd230,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //O 
	    //FIRST NIBBLE 
	    232: oInstruction  = {`STO , `R5, 16'd0};
	    233: oInstruction  = {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
	    234: oInstruction  = {`STO , `R3, 16'd12};

	    235: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    236: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    237: oInstruction  = {`NOP , 24'd4000 };
	    
	    238: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    239: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    240: oInstruction  = {`BLE , 8'd239,`R5, `R3};
	    
	    241: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    242: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    243: oInstruction  = {`STO , `R1, 16'd0};
	    244: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    245: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    246: oInstruction  = {`BLE , 8'd245,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    247: oInstruction  = {`STO , `R5, 16'd0};
	    248: oInstruction  = {`STO , `R3, 16'd12};
	    
	    249: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    250: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    251: oInstruction  = {`NOP , 24'd4000 };
	    252: oInstruction  = {`NOP , 24'd4000 };
	    
	    253: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    254: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    255: oInstruction  = {`BLE , 8'd254,`R5, `R3};
	    
	    256: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    257: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    258: oInstruction  = {`STO , `R1, 16'd0};
	    259: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    260: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    261: oInstruction  = {`BLE , 8'd260,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //L 
	    //FIRST NIBBLE 
	    262: oInstruction  = {`STO , `R5, 16'd0};
	    263: oInstruction  = {`STO , `R6, 8'h00,`L}; //ENTRY MODE BYTE
	    264: oInstruction  = {`STO , `R3, 16'd12};

	    265: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    266: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    267: oInstruction  = {`NOP , 24'd4000 };
	    
	    268: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    269: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    270: oInstruction  = {`BLE , 8'd269,`R5, `R3};
	    
	    271: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    272: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    273: oInstruction  = {`STO , `R1, 16'd0};
	    274: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    275: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    276: oInstruction  = {`BLE , 8'd275,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    277: oInstruction  = {`STO , `R5, 16'd0};
	    278: oInstruction  = {`STO , `R3, 16'd12};
	    
	    279: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    280: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    281: oInstruction  = {`NOP , 24'd4000 };
	    282: oInstruction  = {`NOP , 24'd4000 };
	    283: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    284: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    285: oInstruction  = {`BLE , 8'd284,`R5, `R3};
	    
	    286: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    287: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    288: oInstruction  = {`STO , `R1, 16'd0};
	    289: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    290: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    291: oInstruction  = {`BLE , 8'd290,`R1, `R4};


	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //A 
	    //FIRST NIBBLE 
	    292: oInstruction  = {`STO , `R5, 16'd0};
	    293: oInstruction  = {`STO , `R6, 8'h00,`A}; //ENTRY MODE BYTE
	    294: oInstruction  = {`STO , `R3, 16'd12};

	    295: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    296: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    297: oInstruction  = {`NOP , 24'd4000 };
	    
	    298: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    299: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    300: oInstruction  = {`BLE , 8'd299,`R5, `R3};
	    
	    301: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    302: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    303: oInstruction  = {`STO , `R1, 16'd0};
	    304: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    305: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    306: oInstruction  = {`BLE , 8'd305,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    307: oInstruction  = {`STO , `R5, 16'd0};
	    308: oInstruction  = {`STO , `R3, 16'd12};
	    
	    309: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    310: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    311: oInstruction  = {`NOP , 24'd4000 };
	    312: oInstruction  = {`NOP , 24'd4000 };
	    313: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    314: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    315: oInstruction  = {`BLE , 8'd314,`R5, `R3};
	    
	    316: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    317: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    318: oInstruction  = {`STO , `R1, 16'd0};
	    319: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    320: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    321: oInstruction  = {`BLE , 8'd320,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //SPC 
	    //FIRST NIBBLE 
	    322: oInstruction  = {`STO , `R5, 16'd0};
	    323: oInstruction  = {`STO , `R6, 8'h00,`SPC}; //ENTRY MODE BYTE
	    324: oInstruction  = {`STO , `R3, 16'd12};

	    325: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    326: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    327: oInstruction  = {`NOP , 24'd4000 };
	    
	    328: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    329: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    330: oInstruction  = {`BLE , 8'd329,`R5, `R3};
	    
	    331: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    332: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    333: oInstruction  = {`STO , `R1, 16'd0};
	    334: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    335: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    336: oInstruction  = {`BLE , 8'd335,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    337: oInstruction  = {`STO , `R5, 16'd0};
	    338: oInstruction  = {`STO , `R3, 16'd12};
	    
	    339: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    340: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    341: oInstruction  = {`NOP , 24'd4000 };
	    342: oInstruction  = {`NOP , 24'd4000 };
	    343: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    344: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    345: oInstruction  = {`BLE , 8'd344,`R5, `R3};
	    
	    346: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    347: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    348: oInstruction  = {`STO , `R1, 16'd0};
	    349: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    350: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    351: oInstruction  = {`BLE , 8'd350,`R1, `R4};
	    
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //M 
	    //FIRST NIBBLE 
	    352: oInstruction  = {`STO , `R5, 16'd0};
	    353: oInstruction  = {`STO , `R6, 8'h00,`M}; //ENTRY MODE BYTE
	    354: oInstruction  = {`STO , `R3, 16'd12};

	    355: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    356: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    357: oInstruction  = {`NOP , 24'd4000 };
	    
	    358: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    359: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    360: oInstruction  = {`BLE , 8'd359,`R5, `R3};
	    
	    361: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    362: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    363: oInstruction  = {`STO , `R1, 16'd0};
	    364: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    365: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    366: oInstruction  = {`BLE , 8'd365,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    367: oInstruction  = {`STO , `R5, 16'd0};
	    368: oInstruction  = {`STO , `R3, 16'd12};
	    
	    369: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    370: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    371: oInstruction  = {`NOP , 24'd4000 };
	    372: oInstruction  = {`NOP , 24'd4000 };
	    373: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    374: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    375: oInstruction  = {`BLE , 8'd374,`R5, `R3};
	    
	    376: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    377: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    378: oInstruction  = {`STO , `R1, 16'd0};
	    379: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    380: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    381: oInstruction  = {`BLE , 8'd380,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //U 
	    //FIRST NIBBLE 
	    382: oInstruction  = {`STO , `R5, 16'd0};
	    383: oInstruction  = {`STO , `R6, 8'h00,`U}; //ENTRY MODE BYTE
	    384: oInstruction  = {`STO , `R3, 16'd12};

	    385: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    386: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    387: oInstruction  = {`NOP , 24'd4000 };
	    
	    388: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    389: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    390: oInstruction  = {`BLE , 8'd389,`R5, `R3};
	    
	    391: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    392: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    393: oInstruction  = {`STO , `R1, 16'd0};
	    394: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    395: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    396: oInstruction  = {`BLE , 8'd395,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    397: oInstruction  = {`STO , `R5, 16'd0};
	    398: oInstruction  = {`STO , `R3, 16'd12};
	    
	    399: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    400: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    401: oInstruction  = {`NOP , 24'd4000 };
	    402: oInstruction  = {`NOP , 24'd4000 };
	    403: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    404: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    405: oInstruction  = {`BLE , 8'd404,`R5, `R3};
	    
	    406: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    407: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    408: oInstruction  = {`STO , `R1, 16'd0};
	    409: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    410: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    411: oInstruction  = {`BLE , 8'd410,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //N 
	    //FIRST NIBBLE 
	    412: oInstruction  = {`STO , `R5, 16'd0};
	    413: oInstruction  = {`STO , `R6, 8'h00,`N}; //ENTRY MODE BYTE
	    414: oInstruction  = {`STO , `R3, 16'd12};

	    415: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    416: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    417: oInstruction  = {`NOP , 24'd4000 };
	    
	    418: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    419: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    420: oInstruction  = {`BLE , 8'd419,`R5, `R3};
	    
	    421: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    422: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    423: oInstruction  = {`STO , `R1, 16'd0};
	    424: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    425: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    426: oInstruction  = {`BLE , 8'd425,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    427: oInstruction  = {`STO , `R5, 16'd0};
	    428: oInstruction  = {`STO , `R3, 16'd12};
	    
	    429: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    430: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    431: oInstruction  = {`NOP , 24'd4000 };
	    432: oInstruction  = {`NOP , 24'd4000 };
	    433: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    434: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    435: oInstruction  = {`BLE , 8'd434,`R5, `R3};
	    
	    436: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    437: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    438: oInstruction  = {`STO , `R1, 16'd0};
	    439: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    440: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    441: oInstruction  = {`BLE , 8'd440,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //D 
	    //FIRST NIBBLE 
	    442: oInstruction  = {`STO , `R5, 16'd0};
	    443: oInstruction  = {`STO , `R6, 8'h00,`D}; //ENTRY MODE BYTE
	    444: oInstruction  = {`STO , `R3, 16'd12};

	    445: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    446: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    447: oInstruction  = {`NOP , 24'd4000 };
	    
	    448: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    449: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    450: oInstruction  = {`BLE , 8'd449,`R5, `R3};
	    
	    451: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    452: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    453: oInstruction  = {`STO , `R1, 16'd0};
	    454: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    455: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    456: oInstruction  = {`BLE , 8'd455,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    457: oInstruction  = {`STO , `R5, 16'd0};
	    458: oInstruction  = {`STO , `R3, 16'd12};
	    
	    459: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    460: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    461: oInstruction  = {`NOP , 24'd4000 };
	    462: oInstruction  = {`NOP , 24'd4000 };
	    463: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    464: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    465: oInstruction  = {`BLE , 8'd464,`R5, `R3};
	    
	    466: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    467: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    468: oInstruction  = {`STO , `R1, 16'd0};
	    469: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    470: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    471: oInstruction  = {`BLE , 8'd470,`R1, `R4};
	    

	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //O 
	    //FIRST NIBBLE 
	    472: oInstruction  = {`STO , `R5, 16'd0};
	    473: oInstruction  = {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
	    474: oInstruction  = {`STO , `R3, 16'd12};

	    475: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    476: oInstruction  = {`NOP , 24'd4000 }; // SETUP TIME
	    477: oInstruction  = {`NOP , 24'd4000 };
	    
	    478: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

	    479: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    480: oInstruction  = {`BLE , 8'd479,`R5, `R3};
	    
	    481: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
	    
	    482: oInstruction  = {`NOP , 24'd4000 }; // HOLD TIME 
	    
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //NIBBLE WAIT
	    483: oInstruction  = {`STO , `R1, 16'd0};
	    484: oInstruction  = {`STO , `R4, 16'd50};

	    //LOOP1
	    485: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    486: oInstruction  = {`BLE , 8'd485,`R1, `R4};
	    
	    //////////////////////////////////////////////////////////////////////////
	    //SECOND NIBBLE
	    
	    487: oInstruction  = {`STO , `R5, 16'd0};
	    488: oInstruction  = {`STO , `R3, 16'd12};
	    
	    489: oInstruction  = {`SHL , `R6 ,`R6, `R7 };
	    490: oInstruction  = {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
	    491: oInstruction  = {`NOP , 24'd4000 };
	    492: oInstruction  = {`NOP , 24'd4000 };
	    493: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    
	    494: oInstruction  = {`ADD , `R5, `R5, `R2}; 
	    495: oInstruction  = {`BLE , 8'd494,`R5, `R3};
	    
	    496: oInstruction  = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
	    497: oInstruction  = {`NOP , 24'd4000 };  
	    
	    //////////////////////////////////////////////////////////////////////////////////////////////////
	    //LOOP 2000
	    498: oInstruction  = {`STO , `R1, 16'd0};
	    499: oInstruction  = {`STO , `R4, 16'd2000};
	    //LOOP1
	    500: oInstruction  = {`ADD , `R1, `R1, `R2}; 
	    501: oInstruction  = {`BLE , 8'd500,`R1, `R4};
	    

	    
	    /* Test CALL/RET
	     0: oInstruction  = {`NOP , 24'd4000 };
	     1: oInstruction  = {`STO , `R1, 16'd1};
	     2: oInstruction  = {`STO , `R2, 16'd2};
	     3: oInstruction  = {`STO , `R3, 16'd7};
	     4: oInstruction  = {`CALL, `ADD_FN, 16'b0}; //R1 = R1 + R2
	     5: oInstruction  = {`SUB, `R4, `R3, `R1};
	     6: oInstruction  = {`NOP , 24'd4000 };
	     7: oInstruction = {`NOP , 24'd4000 };
	     8: oInstruction = {`NOP , 24'd4000 };
	     9: oInstruction = {`JMP , 8'd100 , 16'b0};
	     //ADD_FN:
	     10: oInstruction  = {`ADD, `R1, `R1, `R2};
	     11: oInstruction  = {`RET, 24'd4000 };
	     
	     //EXIT:
	     100: oInstruction = {`NOP , 24'd4000 };
	     */
	    

	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
