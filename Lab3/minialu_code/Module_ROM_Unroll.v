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

   wire [27:0] memoryROM [0:511];
   
   
   /////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 750000
   assign memoryROM[0] =  {`NOP , 24'd4000 };
   assign memoryROM[1] =  {`STO , `R1, 16'd0};
   assign memoryROM[2] =  {`STO , `R2, 16'd1};
   assign memoryROM[3] =  {`STO , `R3, 16'd24};
   assign memoryROM[4] =  {`STO , `R4, 16'd31250};
   assign memoryROM[5] =  {`STO , `R5, 16'd0};
   assign memoryROM[6] =  {`STO , `R7, 16'd4};
   
   //LOOP1
   assign memoryROM[7] =  {`STO , `R9, 16'd8};
   assign memoryROM[8] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[9] =  {`BLE , `R9,`R1, `R4};
   //LOOP1
   assign memoryROM[10] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[11] =  {`STO , `R1, 16'd0};
   assign memoryROM[12] =  {`BLE , `R9,`R5, `R3};


   //POWER ON
   ////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x3
   
   assign memoryROM[13] =  {`STO , `R5, 16'd0};
   assign memoryROM[14] =  {`STO , `R6, 16'h0030};
   assign memoryROM[15] =  {`STO , `R3, 16'd12};
   assign memoryROM[16] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[17] =  {`NOP , 24'd4000 };
   assign memoryROM[18] =  {`NOP , 24'd4000 };
   //ENABLE
   assign memoryROM[19] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   //LOOP 
   assign memoryROM[20] =  {`STO , `R9, 16'd21};
   assign memoryROM[21] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[22] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[23] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[24] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////  
   // LOOP 205000
   assign memoryROM[25] =  {`STO , `R1, 16'd0};
   assign memoryROM[26] =  {`STO , `R3, 16'd8};
   assign memoryROM[27] =  {`STO , `R4, 16'd25625};
   assign memoryROM[28] =  {`STO , `R5, 16'd0};
  

   //LOOP1
   assign memoryROM[29] =  {`STO , `R9, 16'd30};
   assign memoryROM[30] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[31] =  {`BLE , `R9,`R1, `R4};
   //LOOP1
   assign memoryROM[32] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[33] =  {`STO , `R1, 16'd0};
   assign memoryROM[34] =  {`BLE , `R9,`R5, `R3};
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////  
   // ESCRIBIR 0x3
   assign memoryROM[35] =  {`STO , `R5, 16'd0};
   assign memoryROM[36] =  {`STO , `R6, 16'h0030};
   assign memoryROM[37] =  {`STO , `R3, 16'd12};
   assign memoryROM[38] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[39] =  {`NOP , 24'd4000 };
   assign memoryROM[40] =  {`NOP , 24'd4000 };
   
   assign memoryROM[41] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[42] =  {`STO , `R9, 16'd43};
   assign memoryROM[43] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[44] =  {`BLE , `R9,`R5, `R3}; //20?
   
   assign memoryROM[45] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[46] =  {`NOP , 24'd4000 };
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 5000
   assign memoryROM[47] =  {`STO , `R1, 16'd0};
   assign memoryROM[48] =  {`STO , `R4, 16'd5000};
   

   //LOOP1
   assign memoryROM[49] =  {`STO , `R9, 16'd50};
   assign memoryROM[50] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[51] =  {`BLE , `R9,`R1, `R4};

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x3
   
   assign memoryROM[52] =  {`STO , `R5, 16'd0};
   assign memoryROM[53] =  {`STO , `R6, 16'h0030};
   assign memoryROM[54] =  {`STO , `R3, 16'd12};
   assign memoryROM[55] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[56] =  {`NOP , 24'd4000 };
   assign memoryROM[57] =  {`NOP , 24'd4000 };
   
   assign memoryROM[58] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[59] =  {`STO , `R9, 16'd60};
   assign memoryROM[60] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[61] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[62] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[63] =  {`NOP , 24'd4000 };
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[64] =  {`STO , `R1, 16'd0};
   assign memoryROM[65] =  {`STO , `R4, 16'd2000};


   //LOOP1
   assign memoryROM[66] =  {`STO , `R9, 16'd67};
   assign memoryROM[67] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[68] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x2
   
   assign memoryROM[69] =  {`STO , `R5, 16'd0};
   assign memoryROM[70] =  {`STO , `R6, 16'h0020};
   assign memoryROM[71] =  {`STO , `R3, 16'd12};
   assign memoryROM[72] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[73] =  {`NOP , 24'd4000 };
   assign memoryROM[74] =  {`NOP , 24'd4000 };
   
   assign memoryROM[75] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[76] =  {`STO , `R9, 16'd77};
   assign memoryROM[77] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[78] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[79] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[80] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[81] =  {`STO , `R1, 16'd0};
   assign memoryROM[82] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[83] =  {`STO , `R9, 16'd84};
   assign memoryROM[84] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[85] =  {`BLE , `R9,`R1, `R4};


   
   
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ///////////////////////////////////////CONFIGURACION//////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   

   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //FUNCTION SET- FIRST NIBBLE 
   
   assign memoryROM[86] =  {`STO , `R5, 16'd0};
   assign memoryROM[87] =  {`STO , `R6, 16'h0028};
   assign memoryROM[88] =  {`STO , `R3, 16'd12};

   assign memoryROM[89] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[90] =  {`NOP , 24'd4000 };
   assign memoryROM[91] =  {`NOP , 24'd4000 };
   
   assign memoryROM[92] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[93] =  {`STO , `R9, 16'd94};
   assign memoryROM[94] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[95] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[96] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[97] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[98] =  {`STO , `R1, 16'd0};
   assign memoryROM[99] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[100] =  {`STO , `R9, 16'd101};
   assign memoryROM[101] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[102] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[103] =  {`STO , `R5, 16'd0};
   assign memoryROM[104] =  {`STO , `R3, 16'd12};
   assign memoryROM[105] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[106] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[107] =  {`NOP , 24'd4000 };
   assign memoryROM[108] =  {`NOP , 24'd4000 };
   
   assign memoryROM[109] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[110] =  {`STO , `R9, 16'd111};
   assign memoryROM[111] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[112] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[113] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[114] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[115] =  {`STO , `R1, 16'd0};
   assign memoryROM[116] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[117] =  {`STO , `R9, 16'd118};
   assign memoryROM[118] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[119] =  {`BLE , `R9,`R1, `R4};

   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //ENTRY MODE- FIRST NIBBLE 
   
   assign memoryROM[120] =  {`STO , `R5, 16'd0};
   assign memoryROM[121] =  {`STO , `R6, 16'h0006}; //ENTRY MODE BYTE
   assign memoryROM[122] =  {`STO , `R3, 16'd12};

   assign memoryROM[123] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[124] =  {`NOP , 24'd4000 };
   assign memoryROM[125] =  {`NOP , 24'd4000 };
   
   assign memoryROM[126] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[127] =  {`STO , `R9, 16'd128};
   assign memoryROM[128] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[129] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[130] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[131] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[132] =  {`STO , `R1, 16'd0};
   assign memoryROM[133] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[134] =  {`STO , `R9, 16'd135};
   assign memoryROM[135] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[136] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[137] =  {`STO , `R5, 16'd0};
   assign memoryROM[138] =  {`STO , `R3, 16'd12};
   assign memoryROM[139] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[140] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[141] =  {`NOP , 24'd4000 };
   assign memoryROM[142] =  {`NOP , 24'd4000 };
   
   assign memoryROM[143] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[144] =  {`STO , `R9, 16'd145};
   assign memoryROM[145] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[146] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[147] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[148] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[149] =  {`STO , `R1, 16'd0};
   assign memoryROM[150] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[151] =  {`STO , `R9, 16'd152};
   assign memoryROM[152] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[153] =  {`BLE , `R9,`R1, `R4};
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //DISPLAY ON-OFF / FIRST NIBBLE 
   
   assign memoryROM[154] =  {`STO , `R5, 16'd0};
   assign memoryROM[155] =  {`STO , `R6, 16'h000C}; //ENTRY MODE BYTE
   assign memoryROM[156] =  {`STO , `R3, 16'd12};

   assign memoryROM[157] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[158] =  {`NOP , 24'd4000 };
   assign memoryROM[159] =  {`NOP , 24'd4000 };
   
   assign memoryROM[160] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[161] =  {`STO , `R9, 16'd162};
   assign memoryROM[162] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[163] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[164] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[165] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[166] =  {`STO , `R1, 16'd0};
   assign memoryROM[167] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[168] =  {`STO , `R9, 16'd169};
   assign memoryROM[169] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[170] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[171] =  {`STO , `R5, 16'd0};
   assign memoryROM[172] =  {`STO , `R3, 16'd12};
   assign memoryROM[173] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[174] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[175] =  {`NOP , 24'd4000 };
   assign memoryROM[176] =  {`NOP , 24'd4000 };
   
   assign memoryROM[177] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[178] =  {`STO , `R9, 16'd179};
   assign memoryROM[179] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[180] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[181] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[182] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[183] =  {`STO , `R1, 16'd0};
   assign memoryROM[184] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[185] =  {`STO , `R9, 16'd186};
   assign memoryROM[186] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[187] =  {`BLE , `R9,`R1, `R4};


   /////////////////////////////////////////////////////////////////////////////////////////////////
   //CLEAR DISPLAY - FIRST NIBBLE 
   
   assign memoryROM[188] =  {`STO , `R5, 16'd0};
   assign memoryROM[189] =  {`STO , `R6, 16'h0001}; //ENTRY MODE BYTE
   assign memoryROM[190] =  {`STO , `R3, 16'd12};

   assign memoryROM[191] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[192] =  {`NOP , 24'd4000 };
   assign memoryROM[193] =  {`NOP , 24'd4000 };
   
   assign memoryROM[194] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[195] =  {`STO , `R9, 16'd196};
   assign memoryROM[196] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[197] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[198] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[199] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[200] =  {`STO , `R1, 16'd0};
   assign memoryROM[201] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[202] =  {`STO , `R9, 16'd203};
   assign memoryROM[203] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[204] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[205] =  {`STO , `R5, 16'd0};
   assign memoryROM[206] =  {`STO , `R3, 16'd12};
   assign memoryROM[207] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[208] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[209] =  {`NOP , 24'd4000 };
   assign memoryROM[210] =  {`NOP , 24'd4000 };
   
   assign memoryROM[211] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[212] =  {`STO , `R9, 16'd213};
   assign memoryROM[213] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[214] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[215] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[216] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 82000
   assign memoryROM[217] =  {`STO , `R1, 16'd0};
   assign memoryROM[218] =  {`STO , `R3, 16'd8};
   assign memoryROM[219] =  {`STO , `R4, 16'd10250};
   assign memoryROM[220] =  {`STO , `R5, 16'd0};

   //LOOP1
   assign memoryROM[221] =  {`STO , `R9, 16'd222};
   assign memoryROM[222] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[223] =  {`BLE , `R9,`R1, `R4};
   //LOOP1
   assign memoryROM[224] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[225] =  {`STO , `R1, 16'd0};
   assign memoryROM[225] =  {`BLE , `R9,`R5, `R3};



   //////////////////////////////////////////////////////////////////////////////////////////////////
   //PRINT ROUTINE 
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //H 
   //FIRST NIBBLE 
   assign memoryROM[226] =  {`STO , `R5, 16'd0};
   assign memoryROM[227] =  {`STO , `R6, 8'h00,`H}; //ENTRY MODE BYTE
   assign memoryROM[228] =  {`STO , `R3, 16'd12};

   assign memoryROM[229] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[230] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[231] =  {`NOP , 24'd4000 };
   
   assign memoryROM[232] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[233] =  {`STO , `R9, 16'd234};
   assign memoryROM[234] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[235] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[236] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[237] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[238] =  {`STO , `R1, 16'd0};
   assign memoryROM[239] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[240] =  {`STO , `R9, 16'd241};
   assign memoryROM[241] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[242] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[243] =  {`STO , `R5, 16'd0};
   assign memoryROM[244] =  {`STO , `R3, 16'd12};
   assign memoryROM[245] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[246] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[247] =  {`NOP , 24'd4000 };
   assign memoryROM[248] =  {`NOP , 24'd4000 };
   assign memoryROM[249] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[250] =  {`STO , `R9, 16'd251};
   assign memoryROM[251] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[252] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[253] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[254] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[255] =  {`STO , `R1, 16'd0};
   assign memoryROM[256] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[257] =  {`STO , `R9, 16'd258};
   assign memoryROM[258] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[259] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //O 
   //FIRST NIBBLE 
   assign memoryROM[260] =  {`STO , `R5, 16'd0};
   assign memoryROM[261] =  {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
   assign memoryROM[262] =  {`STO , `R3, 16'd12};

   assign memoryROM[263] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[264] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[265] =  {`NOP , 24'd4000 };
   
   assign memoryROM[266] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[267] =  {`STO , `R9, 16'd268};
   assign memoryROM[268] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[269] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[270] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[271] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[272] =  {`STO , `R1, 16'd0};
   assign memoryROM[273] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[274] =  {`STO , `R9, 16'd275};
   assign memoryROM[276] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[277] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[278] =  {`STO , `R5, 16'd0};
   assign memoryROM[279] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[280] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[281] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[282] =  {`NOP , 24'd4000 };
   assign memoryROM[283] =  {`NOP , 24'd4000 };
   
   assign memoryROM[284] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[285] =  {`STO , `R9, 16'd286};
   assign memoryROM[286] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[287] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[288] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[289] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[290] =  {`STO , `R1, 16'd0};
   assign memoryROM[291] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[292] =  {`STO , `R9, 16'd293};
   assign memoryROM[293] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[294] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //L 
   //FIRST NIBBLE 
   assign memoryROM[295] =  {`STO , `R5, 16'd0};
   assign memoryROM[296] =  {`STO , `R6, 8'h00,`L}; //ENTRY MODE BYTE
   assign memoryROM[297] =  {`STO , `R3, 16'd12};

   assign memoryROM[298] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[299] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[300] =  {`NOP , 24'd4000 };
   
   assign memoryROM[301] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[302] =  {`STO , `R9, 16'd303};
   assign memoryROM[303] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[304] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[305] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[306] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[307] =  {`STO , `R1, 16'd0};
   assign memoryROM[308] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[309] =  {`STO , `R9, 16'd1};
   assign memoryROM[310] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[311] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[312] =  {`STO , `R5, 16'd0};
   assign memoryROM[313] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[314] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[315] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[316] =  {`NOP , 24'd4000 };
   assign memoryROM[317] =  {`NOP , 24'd4000 };
   assign memoryROM[318] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[319] =  {`STO , `R9, 16'd320};
   assign memoryROM[320] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[321] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[322] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[323] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[324] =  {`STO , `R1, 16'd0};
   assign memoryROM[325] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[326] =  {`STO , `R9, 16'd327};
   assign memoryROM[327] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[328] =  {`BLE , `R9,`R1, `R4};


   //////////////////////////////////////////////////////////////////////////////////////////////////
   //A 
   //FIRST NIBBLE 
   assign memoryROM[329] =  {`STO , `R5, 16'd0};
   assign memoryROM[330] =  {`STO , `R6, 8'h00,`A}; //ENTRY MODE BYTE
   assign memoryROM[331] =  {`STO , `R3, 16'd12};

   assign memoryROM[332] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[333] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[334] =  {`NOP , 24'd4000 };
   
   assign memoryROM[335] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[336] =  {`STO , `R9, 16'd337};
   assign memoryROM[338] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[339] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[340] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[341] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[342] =  {`STO , `R1, 16'd0};
   assign memoryROM[343] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[344] =  {`STO , `R9, 16'd345};
   assign memoryROM[345] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[346] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[347] =  {`STO , `R5, 16'd0};
   assign memoryROM[348] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[349] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[350] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[351] =  {`NOP , 24'd4000 };
   assign memoryROM[352] =  {`NOP , 24'd4000 };
   assign memoryROM[353] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[354] =  {`STO , `R9, 16'd355};
   assign memoryROM[355] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[356] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[357] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[358] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[359] =  {`STO , `R1, 16'd0};
   assign memoryROM[360] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[361] =  {`STO , `R9, 16'd362};
   assign memoryROM[362] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[363] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //SPC 
   //FIRST NIBBLE 
   assign memoryROM[364] =  {`STO , `R5, 16'd0};
   assign memoryROM[365] =  {`STO , `R6, 8'h00,`SPC}; //ENTRY MODE BYTE
   assign memoryROM[366] =  {`STO , `R3, 16'd12};

   assign memoryROM[367] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[368] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[369] =  {`NOP , 24'd4000 };
   
   assign memoryROM[370] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[371] =  {`STO , `R9, 16'd371};
   assign memoryROM[372] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[373] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[374] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[375] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[376] =  {`STO , `R1, 16'd0};
   assign memoryROM[377] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[378] =  {`STO , `R9, 16'd379};
   assign memoryROM[379] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[380] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[381] =  {`STO , `R5, 16'd0};
   assign memoryROM[382] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[383] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[384] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[385] =  {`NOP , 24'd4000 };
   assign memoryROM[386] =  {`NOP , 24'd4000 };
   assign memoryROM[387] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[388] =  {`STO , `R9, 16'd389};
   assign memoryROM[389] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[390] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[391] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[392] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[393] =  {`STO , `R1, 16'd0};
   assign memoryROM[394] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[395] =  {`STO , `R9, 16'd396};
   assign memoryROM[396] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[397] =  {`BLE , `R9,`R1, `R4};
   
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //M 
   //FIRST NIBBLE 
   assign memoryROM[398] =  {`STO , `R5, 16'd0};
   assign memoryROM[399] =  {`STO , `R6, 8'h00,`M}; //ENTRY MODE BYTE
   assign memoryROM[400] =  {`STO , `R3, 16'd12};

   assign memoryROM[401] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[402] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[403] =  {`NOP , 24'd4000 };
   
   assign memoryROM[404] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[405] =  {`STO , `R9, 16'd406};
   assign memoryROM[406] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[407] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[408] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[409] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[410] =  {`STO , `R1, 16'd0};
   assign memoryROM[411] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[412] =  {`STO , `R9, 16'd413};
   assign memoryROM[413] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[414] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[415] =  {`STO , `R5, 16'd0};
   assign memoryROM[416] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[417] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[418] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[419] =  {`NOP , 24'd4000 };
   assign memoryROM[420] =  {`NOP , 24'd4000 };
   assign memoryROM[421] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[422] =  {`STO , `R9, 16'd423};
   assign memoryROM[423] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[424] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[425] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[426] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[427] =  {`STO , `R1, 16'd0};
   assign memoryROM[428] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[429] =  {`STO , `R9, 16'd430};
   assign memoryROM[430] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[431] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //U 
   //FIRST NIBBLE 
   assign memoryROM[432] =  {`STO , `R5, 16'd0};
   assign memoryROM[433] =  {`STO , `R6, 8'h00,`U}; //ENTRY MODE BYTE
   assign memoryROM[434] =  {`STO , `R3, 16'd12};

   assign memoryROM[435] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[436] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[437] =  {`NOP , 24'd4000 };
   
   assign memoryROM[438] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[439] =  {`STO , `R9, 16'd440};
   assign memoryROM[440] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[441] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[442] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[443] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[444] =  {`STO , `R1, 16'd0};
   assign memoryROM[445] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[446] =  {`STO , `R9, 16'd447};
   assign memoryROM[447] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[448] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[449] =  {`STO , `R5, 16'd0};
   assign memoryROM[450] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[451] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[452] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[453] =  {`NOP , 24'd4000 };
   assign memoryROM[454] =  {`NOP , 24'd4000 };
   assign memoryROM[455] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[456] =  {`STO , `R9, 16'd457};
   assign memoryROM[457] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[458] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[459] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[460] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[461] =  {`STO , `R1, 16'd0};
   assign memoryROM[462] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[463] =  {`STO , `R9, 16'd464};
   assign memoryROM[464] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[465] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //N 
   //FIRST NIBBLE 
   assign memoryROM[466] =  {`STO , `R5, 16'd0};
   assign memoryROM[467] =  {`STO , `R6, 8'h00,`N}; //ENTRY MODE BYTE
   assign memoryROM[468] =  {`STO , `R3, 16'd12};

   assign memoryROM[469] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[470] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[471] =  {`NOP , 24'd4000 };
   
   assign memoryROM[472] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[473] =  {`STO , `R9, 16'd474};
   assign memoryROM[474] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[475] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[476] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[477] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[478] =  {`STO , `R1, 16'd0};
   assign memoryROM[479] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[480] =  {`STO , `R9, 16'd481};
   assign memoryROM[481] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[482] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[483] =  {`STO , `R5, 16'd0};
   assign memoryROM[484] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[485] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[486] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[487] =  {`NOP , 24'd4000 };
   assign memoryROM[488] =  {`NOP , 24'd4000 };
   assign memoryROM[489] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[490] =  {`STO , `R9, 16'd491};
   assign memoryROM[491] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[492] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[493] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[494] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[495] =  {`STO , `R1, 16'd0};
   assign memoryROM[496] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[497] =  {`STO , `R9, 16'd498};
   assign memoryROM[498] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[499] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //D 
   //FIRST NIBBLE 
   assign memoryROM[500] =  {`STO , `R5, 16'd0};
   assign memoryROM[501] =  {`STO , `R6, 8'h00,`D}; //ENTRY MODE BYTE
   assign memoryROM[502] =  {`STO , `R3, 16'd12};

   assign memoryROM[503] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[504] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[505] =  {`NOP , 24'd4000 };
   
   assign memoryROM[506] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[507] =  {`STO , `R9, 16'd508};
   assign memoryROM[508] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[509] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[510] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[511] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[512] =  {`STO , `R1, 16'd0};
   assign memoryROM[513] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[514] =  {`STO , `R9, 16'd515};
   assign memoryROM[515] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[516] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[517] =  {`STO , `R5, 16'd0};
   assign memoryROM[518] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[519] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[520] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[521] =  {`NOP , 24'd4000 };
   assign memoryROM[522] =  {`NOP , 24'd4000 };
   assign memoryROM[523] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[524] =  {`STO , `R9, 16'd525};
   assign memoryROM[525] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[526] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[527] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[528] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[529] =  {`STO , `R1, 16'd0};
   assign memoryROM[530] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[531] =  {`STO , `R9, 16'd532};
   assign memoryROM[532] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[533] =  {`BLE , `R9,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //O 
   //FIRST NIBBLE 
   assign memoryROM[534] =  {`STO , `R5, 16'd0};
   assign memoryROM[535] =  {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
   assign memoryROM[536] =  {`STO , `R3, 16'd12};

   assign memoryROM[537] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[538] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[539] =  {`NOP , 24'd4000 };
   
   assign memoryROM[540] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[541] =  {`STO , `R9, 16'd542};
   assign memoryROM[542] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[543] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[544] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[545] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[546] =  {`STO , `R1, 16'd0};
   assign memoryROM[547] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[548] =  {`STO , `R9, 16'd549};
   assign memoryROM[549] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[550] =  {`BLE , `R9,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[551] =  {`STO , `R5, 16'd0};
   assign memoryROM[552] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[553] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[554] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[555] =  {`NOP , 24'd4000 };
   assign memoryROM[556] =  {`NOP , 24'd4000 };
   assign memoryROM[557] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[558] =  {`STO , `R9, 16'd559};
   assign memoryROM[559] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[560] =  {`BLE , `R9,`R5, `R3};
   
   assign memoryROM[561] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[562] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[563] =  {`STO , `R1, 16'd0};
   assign memoryROM[564] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[565] =  {`STO , `R9, 16'd566};
   assign memoryROM[566] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[567] =  {`BLE , `R9,`R1, `R4};
      

   
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
    default:
    oInstruction = { `LED ,  24'b10101010 };
    */	    


   always @ ( iAddress ) 
      oInstruction = memoryROM[iAddress];
   
endmodule
