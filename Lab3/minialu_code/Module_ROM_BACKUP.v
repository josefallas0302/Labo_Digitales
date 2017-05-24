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

   wire [27:0] 	      memoryROM [0:255];

   assign memoryROM[0] =  {`NOP , 24'd4000 };

   assign memoryROM[1] =  {`STO , `R2, 16'd1};    // UNO FIJO
   assign memoryROM[2] =  {`STO , `R7, 16'd4};	 // CUATRO FIJO
   assign memoryROM[3] =  {`STO , `R6, 16'h0030}; // DATA LCD	    	

   ///POWER ON 
   assign memoryROM[4] =  {`STO , `R3, 16'd24};	 // PRIMER LOOP LONG(EXTERNO) y SHORT
   assign memoryROM[5] =  {`STO , `R4, 16'd31250};// SEGUNDO LOOP LONG(INTERNO)
   assign memoryROM[6] =  {`CALL, `LONG_WAIT, 16'b0}; /// LOOP 750000

   assign memoryROM[7] =  {`STO , `R6, 16'h0030};
   assign memoryROM[8] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

   assign memoryROM[9] =  {`STO , `R3, 16'd8};
   assign memoryROM[10] =  {`STO , `R4, 16'd25625};
   assign memoryROM[11] =  {`CALL, `LONG_WAIT, 16'b0}; // LOOP 205000

   assign memoryROM[12] =  {`STO , `R6, 16'h0030};
   assign memoryROM[13] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

   assign memoryROM[14] =  {`STO , `R4, 16'd5000};
   assign memoryROM[15] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 5000

   assign memoryROM[16] =  {`STO , `R6, 16'h0030};
   assign memoryROM[17] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3
   
   assign memoryROM[18] =  {`STO , `R4, 16'd2000};
   assign memoryROM[19] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   assign memoryROM[20] =  {`STO , `R6, 16'h0020};
   assign memoryROM[21] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR 0x3

   assign memoryROM[22] =  {`STO , `R4, 16'd2000};
   assign memoryROM[23] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   //CONFIGURATION
   // FUCTION SET

   assign memoryROM[24] =  {`STO , `R6, 16'h0028};
   assign memoryROM[25] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[26] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[27] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[28] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[29] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[30] =  {`STO , `R4, 16'd2000};
   assign memoryROM[31] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


   // ENTRY MODE

   assign memoryROM[32] =  {`STO , `R6, 16'h0006};
   assign memoryROM[33] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[34] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[35] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[36] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[37] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[38] =  {`STO , `R4, 16'd2000};
   assign memoryROM[39] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


   // DISPLAY ON/OFF

   assign memoryROM[40] =  {`STO , `R6, 16'h000C};
   assign memoryROM[41] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[42] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[43] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[44] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[45] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[46] =  {`STO , `R4, 16'd2000};
   assign memoryROM[47] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



   // CLEAR DISPLAY

   assign memoryROM[48] =  {`STO , `R6, 16'h0001};
   assign memoryROM[49] =  {`CALL, `CMD, 16'b0}; /// 

   assign memoryROM[50] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[51] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[52] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[53] =  {`CALL, `CMD, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[54] =  {`STO , `R3, 16'd8};
   assign memoryROM[55] =  {`STO , `R4, 16'd10250};
   assign memoryROM[56] =  {`CALL, `LONG_WAIT, 16'b0}; // LOOP 82000
   // PRINT ROUTINE
   
   //H
   assign memoryROM[57] =  {`STO , `R6, `H};
   assign memoryROM[58] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[59] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[60] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[61] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[62] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[63] =  {`STO , `R4, 16'd2000};
   assign memoryROM[64] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   //O
   assign memoryROM[65] =  {`STO , `R6, `O};
   assign memoryROM[66] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[67] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[68] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[69] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[70] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[71] =  {`STO , `R4, 16'd2000};
   assign memoryROM[72] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000 

   //L
   assign memoryROM[73] =  {`STO , `R6, `L};
   assign memoryROM[74] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[75] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[76] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[77] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[78] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[79] =  {`STO , `R4, 16'd2000};
   assign memoryROM[80] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   //A
   assign memoryROM[81] =  {`STO , `R6, `A};
   assign memoryROM[82] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[83] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[84] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[85] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[86] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[87] =  {`STO , `R4, 16'd2000};
   assign memoryROM[88] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   //SPC
   assign memoryROM[89] =  {`STO , `R6, `SPC};
   assign memoryROM[90] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[91] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[92] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[93] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[94] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[95] =  {`STO , `R4, 16'd2000};
   assign memoryROM[96] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000


   //M
   assign memoryROM[97] =  {`STO , `R6, `M};
   assign memoryROM[98] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[99] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[100] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[101] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[102] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[103] =  {`STO , `R4, 16'd2000};
   assign memoryROM[104] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   
   //U
   assign memoryROM[105] =  {`STO , `R6, `U};
   assign memoryROM[106] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[107] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[108] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[109] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[110] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[111] =  {`STO , `R4, 16'd2000};
   assign memoryROM[112] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



   //N
   assign memoryROM[113] =  {`STO , `R6, `N};
   assign memoryROM[114] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[115] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[116] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[117] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[118] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[119] =  {`STO , `R4, 16'd2000};
   assign memoryROM[120] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



   //D
   assign memoryROM[121] =  {`STO , `R6, `D};
   assign memoryROM[122] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[123] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[124] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[125] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[126] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[127] =  {`STO , `R4, 16'd2000};
   assign memoryROM[128] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000



   //O
   assign memoryROM[129] =  {`STO , `R6, `O};
   assign memoryROM[130] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR FIRST NIBBLE

   assign memoryROM[131] =  {`STO , `R4, 16'd50}; 
   assign memoryROM[132] =  {`CALL, `SHORT_WAIT, 16'b0}; //NIBBLE WAIT

   assign memoryROM[133] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[134] =  {`CALL, `CHAR, 16'b0}; /// ESCRIBIR SECOND NIBBLE

   assign memoryROM[135] =  {`STO , `R4, 16'd2000};
   assign memoryROM[136] =  {`CALL, `SHORT_WAIT, 16'b0}; // LOOP 2000

   

   assign memoryROM[137] =  {`NOP , 24'd4000 };
   assign memoryROM[138] =  {`NOP , 24'd4000 };
   assign memoryROM[139] =  {`JMP , `EXIT , 16'b0};




   //LONG_WAIT: //R4 LOOP INTERNO  // R3 LOOP EXTERNO
   assign memoryROM[140] =  {`STO , `R1, 16'd0};	 
   assign memoryROM[141] =  {`STO , `R5, 16'd0};	 
   //LOOP INTERNO
   assign memoryROM[142] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[143] =  {`BLE , 8'd142,`R1, `R4};
   //LOOP EXTERNO
   assign memoryROM[144] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[145] =  {`STO , `R1, 16'd0};
   assign memoryROM[146] =  {`BLE , 8'd142,`R5, `R3};
   assign memoryROM[147] =  {`RET, 24'd4000 };

   

   //SHORT_WAIT
   assign memoryROM[148] =  {`STO , `R1, 16'd0};	 

   assign memoryROM[149] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[150] =  {`BLE , 8'd149,`R1, `R4};
   assign memoryROM[151] =  {`RET, 24'd4000 };



   //CMD:
   assign memoryROM[152] =  {`STO , `R5, 16'd0};
   assign memoryROM[153] =  {`STO , `R3, 16'd12};

   assign memoryROM[154] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[155] =  {`NOP , 24'd4000 };
   assign memoryROM[156] =  {`NOP , 24'd4000 };
   //ENABLE
   assign memoryROM[157] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   //LOOP 
   assign memoryROM[158] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[159] =  {`BLE , 8'd158,`R5, `R3};
   
   assign memoryROM[160] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[161] =  {`NOP , 24'd4000 };
   assign memoryROM[162] =  {`RET, 24'd4000 };



   //CHAR:
   assign memoryROM[163] =  {`STO , `R5, 16'd0};
   assign memoryROM[164] =  {`STO , `R3, 16'd12};

   assign memoryROM[165] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[166] =  {`NOP , 24'd4000 };
   assign memoryROM[167] =  {`NOP , 24'd4000 };
   //ENABLE
   assign memoryROM[168] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   //LOOP 
   assign memoryROM[169] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[170] =  {`BLE , 8'd169,`R5, `R3};
   
   assign memoryROM[171] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[172] =  {`NOP , 24'd4000 };
   assign memoryROM[173] =  {`RET, 24'd4000 };

   
   //EXIT:
   assign memoryROM[174] =  {`NOP , 24'd4000 };

	    
   always @ ( iAddress ) 
      oInstruction = memoryROM[iAddress];


endmodule
