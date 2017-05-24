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
   assign memoryROM[7] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[8] =  {`BLE , 8'd7,`R1, `R4};
   //LOOP1
   assign memoryROM[9] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[10] =  {`STO , `R1, 16'd0};
   assign memoryROM[11] =  {`BLE , 8'd7,`R5, `R3};


   //POWER ON
   ////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x3
   
   assign memoryROM[12] =  {`STO , `R5, 16'd0};
   assign memoryROM[13] =  {`STO , `R6, 16'h0030};
   assign memoryROM[14] =  {`STO , `R3, 16'd12};
   assign memoryROM[15] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[16] =  {`NOP , 24'd4000 };
   assign memoryROM[17] =  {`NOP , 24'd4000 };
   //ENABLE
   assign memoryROM[18] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   //LOOP 
   assign memoryROM[19] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[20] =  {`BLE , 8'd19,`R5, `R3};
   
   assign memoryROM[21] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[22] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////  
   // LOOP 205000
   assign memoryROM[23] =  {`STO , `R1, 16'd0};
   assign memoryROM[24] =  {`STO , `R3, 16'd8};
   assign memoryROM[25] =  {`STO , `R4, 16'd25625};
   assign memoryROM[26] =  {`STO , `R5, 16'd0};
   

   //LOOP1
   assign memoryROM[27] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[28] =  {`BLE , 8'd27,`R1, `R4};
   //LOOP1
   assign memoryROM[29] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[30] =  {`STO , `R1, 16'd0};
   assign memoryROM[31] =  {`BLE , 8'd27,`R5, `R3};
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////  
   // ESCRIBIR 0x3
   assign memoryROM[32] =  {`STO , `R5, 16'd0};
   assign memoryROM[33] =  {`STO , `R6, 16'h0030};
   assign memoryROM[34] =  {`STO , `R3, 16'd12};
   assign memoryROM[35] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[36] =  {`NOP , 24'd4000 };
   assign memoryROM[37] =  {`NOP , 24'd4000 };
   
   assign memoryROM[38] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[39] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[40] =  {`BLE , 8'd39,`R5, `R3}; //20?
   
   assign memoryROM[41] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[42] =  {`NOP , 24'd4000 };
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 5000
   assign memoryROM[43] =  {`STO , `R1, 16'd0};
   assign memoryROM[44] =  {`STO , `R4, 16'd5000};
   

   //LOOP1
   assign memoryROM[45] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[46] =  {`BLE , 8'd45,`R1, `R4};

   ///////////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x3
   
   assign memoryROM[47] =  {`STO , `R5, 16'd0};
   assign memoryROM[48] =  {`STO , `R6, 16'h0030};
   assign memoryROM[49] =  {`STO , `R3, 16'd12};
   assign memoryROM[50] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[51] =  {`NOP , 24'd4000 };
   assign memoryROM[52] =  {`NOP , 24'd4000 };
   
   assign memoryROM[53] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[54] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[55] =  {`BLE , 8'd54,`R5, `R3};
   
   assign memoryROM[56] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[57] =  {`NOP , 24'd4000 };
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[58] =  {`STO , `R1, 16'd0};
   assign memoryROM[59] =  {`STO , `R4, 16'd2000};


   //LOOP1
   assign memoryROM[60] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[61] =  {`BLE , 8'd60,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //ESCRIBIR 0x2
   
   assign memoryROM[62] =  {`STO , `R5, 16'd0};
   assign memoryROM[63] =  {`STO , `R6, 16'h0020};
   assign memoryROM[64] =  {`STO , `R3, 16'd12};
   assign memoryROM[65] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[66] =  {`NOP , 24'd4000 };
   assign memoryROM[67] =  {`NOP , 24'd4000 };
   
   assign memoryROM[68] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[69] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[70] =  {`BLE , 8'd69,`R5, `R3};
   
   assign memoryROM[71] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[72] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[73] =  {`STO , `R1, 16'd0};
   assign memoryROM[74] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[75] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[76] =  {`BLE , 8'd75,`R1, `R4};


   
   
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ///////////////////////////////////////CONFIGURACION//////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   

   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //FUNCTION SET- FIRST NIBBLE 
   
   assign memoryROM[77] =  {`STO , `R5, 16'd0};
   assign memoryROM[78] =  {`STO , `R6, 16'h0028};
   assign memoryROM[79] =  {`STO , `R3, 16'd12};

   assign memoryROM[80] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[81] =  {`NOP , 24'd4000 };
   assign memoryROM[82] =  {`NOP , 24'd4000 };
   
   assign memoryROM[83] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[84] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[85] =  {`BLE , 8'd84,`R5, `R3};
   
   assign memoryROM[86] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[87] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[88] =  {`STO , `R1, 16'd0};
   assign memoryROM[89] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[90] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[91] =  {`BLE , 8'd90,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[92] =  {`STO , `R5, 16'd0};
   assign memoryROM[93] =  {`STO , `R3, 16'd12};
   assign memoryROM[94] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[95] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[96] =  {`NOP , 24'd4000 };
   assign memoryROM[97] =  {`NOP , 24'd4000 };
   
   assign memoryROM[98] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[99] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[100] =  {`BLE , 8'd99,`R5, `R3};
   
   assign memoryROM[101] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[102] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[103] =  {`STO , `R1, 16'd0};
   assign memoryROM[104] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[105] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[106] =  {`BLE , 8'd105,`R1, `R4};

   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //ENTRY MODE- FIRST NIBBLE 
   
   assign memoryROM[107] =  {`STO , `R5, 16'd0};
   assign memoryROM[108] =  {`STO , `R6, 16'h0006}; //ENTRY MODE BYTE
   assign memoryROM[109] =  {`STO , `R3, 16'd12};

   assign memoryROM[110] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[111] =  {`NOP , 24'd4000 };
   assign memoryROM[112] =  {`NOP , 24'd4000 };
   
   assign memoryROM[113] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[114] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[115] =  {`BLE , 8'd114,`R5, `R3};
   
   assign memoryROM[116] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[117] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[118] =  {`STO , `R1, 16'd0};
   assign memoryROM[119] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[120] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[121] =  {`BLE , 8'd120,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[122] =  {`STO , `R5, 16'd0};
   assign memoryROM[123] =  {`STO , `R3, 16'd12};
   assign memoryROM[124] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[125] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[126] =  {`NOP , 24'd4000 };
   assign memoryROM[127] =  {`NOP , 24'd4000 };
   
   assign memoryROM[128] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[129] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[130] =  {`BLE , 8'd129,`R5, `R3};
   
   assign memoryROM[131] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[132] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[133] =  {`STO , `R1, 16'd0};
   assign memoryROM[134] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[135] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[136] =  {`BLE , 8'd135,`R1, `R4};
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //DISPLAY ON-OFF / FIRST NIBBLE 
   
   assign memoryROM[137] =  {`STO , `R5, 16'd0};
   assign memoryROM[138] =  {`STO , `R6, 16'h000C}; //ENTRY MODE BYTE
   assign memoryROM[139] =  {`STO , `R3, 16'd12};

   assign memoryROM[140] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[141] =  {`NOP , 24'd4000 };
   assign memoryROM[142] =  {`NOP , 24'd4000 };
   
   assign memoryROM[143] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[144] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[145] =  {`BLE , 8'd144,`R5, `R3};
   
   assign memoryROM[146] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[147] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[148] =  {`STO , `R1, 16'd0};
   assign memoryROM[149] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[150] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[151] =  {`BLE , 8'd150,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[152] =  {`STO , `R5, 16'd0};
   assign memoryROM[153] =  {`STO , `R3, 16'd12};
   assign memoryROM[154] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[155] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[156] =  {`NOP , 24'd4000 };
   assign memoryROM[157] =  {`NOP , 24'd4000 };
   
   assign memoryROM[158] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[159] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[160] =  {`BLE , 8'd159,`R5, `R3};
   
   assign memoryROM[161] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[162] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[163] =  {`STO , `R1, 16'd0};
   assign memoryROM[164] =  {`STO , `R4, 16'd2000};

   //LOOP1
   assign memoryROM[165] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[166] =  {`BLE , 8'd165,`R1, `R4};


   /////////////////////////////////////////////////////////////////////////////////////////////////
   //CLEAR DISPLAY - FIRST NIBBLE 
   
   assign memoryROM[167] =  {`STO , `R5, 16'd0};
   assign memoryROM[168] =  {`STO , `R6, 16'h0001}; //ENTRY MODE BYTE
   assign memoryROM[169] =  {`STO , `R3, 16'd12};

   assign memoryROM[170] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[171] =  {`NOP , 24'd4000 };
   assign memoryROM[172] =  {`NOP , 24'd4000 };
   
   assign memoryROM[173] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[174] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[175] =  {`BLE , 8'd174,`R5, `R3};
   
   assign memoryROM[176] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[177] =  {`NOP , 24'd4000 };
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[178] =  {`STO , `R1, 16'd0};
   assign memoryROM[179] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[180] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[181] =  {`BLE , 8'd180,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[182] =  {`STO , `R5, 16'd0};
   assign memoryROM[183] =  {`STO , `R3, 16'd12};
   assign memoryROM[184] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[185] =  {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[186] =  {`NOP , 24'd4000 };
   assign memoryROM[187] =  {`NOP , 24'd4000 };
   
   assign memoryROM[188] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

   assign memoryROM[189] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[190] =  {`BLE , 8'd189,`R5, `R3};
   
   assign memoryROM[191] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
   
   assign memoryROM[192] =  {`NOP , 24'd4000 };
   
   
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 82000
   assign memoryROM[193] =  {`STO , `R1, 16'd0};
   assign memoryROM[194] =  {`STO , `R3, 16'd8};
   assign memoryROM[195] =  {`STO , `R4, 16'd10250};
   assign memoryROM[196] =  {`STO , `R5, 16'd0};

   //LOOP1
   assign memoryROM[197] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[198] =  {`BLE , 8'd197,`R1, `R4};
   //LOOP1
   assign memoryROM[199] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[200] =  {`STO , `R1, 16'd0};
   assign memoryROM[201] =  {`BLE , 8'd197,`R5, `R3};



   //////////////////////////////////////////////////////////////////////////////////////////////////
   //PRINT ROUTINE 
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //H 
   //FIRST NIBBLE 
   assign memoryROM[202] =  {`STO , `R5, 16'd0};
   assign memoryROM[203] =  {`STO , `R6, 8'h00,`H}; //ENTRY MODE BYTE
   assign memoryROM[204] =  {`STO , `R3, 16'd12};

   assign memoryROM[205] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[206] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[207] =  {`NOP , 24'd4000 };
   
   assign memoryROM[208] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[209] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[210] =  {`BLE , 8'd209,`R5, `R3};
   
   assign memoryROM[211] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[212] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[213] =  {`STO , `R1, 16'd0};
   assign memoryROM[214] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[215] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[216] =  {`BLE , 8'd214,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[217] =  {`STO , `R5, 16'd0};
   assign memoryROM[218] =  {`STO , `R3, 16'd12};
   assign memoryROM[219] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[220] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[221] =  {`NOP , 24'd4000 };
   assign memoryROM[222] =  {`NOP , 24'd4000 };
   assign memoryROM[223] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[224] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[225] =  {`BLE , 8'd224,`R5, `R3};
   assign memoryROM[226] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[227] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[228] =  {`STO , `R1, 16'd0};
   assign memoryROM[229] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[230] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[231] =  {`BLE , 8'd230,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //O 
   //FIRST NIBBLE 
   assign memoryROM[232] =  {`STO , `R5, 16'd0};
   assign memoryROM[233] =  {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
   assign memoryROM[234] =  {`STO , `R3, 16'd12};

   assign memoryROM[235] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[236] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[237] =  {`NOP , 24'd4000 };
   
   assign memoryROM[238] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[239] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[240] =  {`BLE , 8'd239,`R5, `R3};
   
   assign memoryROM[241] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[242] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[243] =  {`STO , `R1, 16'd0};
   assign memoryROM[244] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[245] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[246] =  {`BLE , 8'd245,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[247] =  {`STO , `R5, 16'd0};
   assign memoryROM[248] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[249] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[250] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[251] =  {`NOP , 24'd4000 };
   assign memoryROM[252] =  {`NOP , 24'd4000 };
   
   assign memoryROM[253] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[254] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[255] =  {`BLE , 8'd254,`R5, `R3};
   
   assign memoryROM[256] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[257] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[258] =  {`STO , `R1, 16'd0};
   assign memoryROM[259] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[260] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[261] =  {`BLE , 8'd260,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //L 
   //FIRST NIBBLE 
   assign memoryROM[262] =  {`STO , `R5, 16'd0};
   assign memoryROM[263] =  {`STO , `R6, 8'h00,`L}; //ENTRY MODE BYTE
   assign memoryROM[264] =  {`STO , `R3, 16'd12};

   assign memoryROM[265] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[266] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[267] =  {`NOP , 24'd4000 };
   
   assign memoryROM[268] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[269] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[270] =  {`BLE , 8'd269,`R5, `R3};
   
   assign memoryROM[271] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[272] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[273] =  {`STO , `R1, 16'd0};
   assign memoryROM[274] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[275] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[276] =  {`BLE , 8'd275,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[277] =  {`STO , `R5, 16'd0};
   assign memoryROM[278] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[279] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[280] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[281] =  {`NOP , 24'd4000 };
   assign memoryROM[282] =  {`NOP , 24'd4000 };
   assign memoryROM[283] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[284] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[285] =  {`BLE , 8'd284,`R5, `R3};
   
   assign memoryROM[286] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[287] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[288] =  {`STO , `R1, 16'd0};
   assign memoryROM[289] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[290] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[291] =  {`BLE , 8'd290,`R1, `R4};


   //////////////////////////////////////////////////////////////////////////////////////////////////
   //A 
   //FIRST NIBBLE 
   assign memoryROM[292] =  {`STO , `R5, 16'd0};
   assign memoryROM[293] =  {`STO , `R6, 8'h00,`A}; //ENTRY MODE BYTE
   assign memoryROM[294] =  {`STO , `R3, 16'd12};

   assign memoryROM[295] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[296] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[297] =  {`NOP , 24'd4000 };
   
   assign memoryROM[298] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[299] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[300] =  {`BLE , 8'd299,`R5, `R3};
   
   assign memoryROM[301] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[302] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[303] =  {`STO , `R1, 16'd0};
   assign memoryROM[304] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[305] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[306] =  {`BLE , 8'd305,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[307] =  {`STO , `R5, 16'd0};
   assign memoryROM[308] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[309] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[310] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[311] =  {`NOP , 24'd4000 };
   assign memoryROM[312] =  {`NOP , 24'd4000 };
   assign memoryROM[313] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[314] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[315] =  {`BLE , 8'd314,`R5, `R3};
   
   assign memoryROM[316] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[317] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[318] =  {`STO , `R1, 16'd0};
   assign memoryROM[319] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[320] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[321] =  {`BLE , 8'd320,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //SPC 
   //FIRST NIBBLE 
   assign memoryROM[322] =  {`STO , `R5, 16'd0};
   assign memoryROM[323] =  {`STO , `R6, 8'h00,`SPC}; //ENTRY MODE BYTE
   assign memoryROM[324] =  {`STO , `R3, 16'd12};

   assign memoryROM[325] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[326] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[327] =  {`NOP , 24'd4000 };
   
   assign memoryROM[328] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[329] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[330] =  {`BLE , 8'd239,`R5, `R3};
   
   assign memoryROM[331] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[332] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[333] =  {`STO , `R1, 16'd0};
   assign memoryROM[334] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[335] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[336] =  {`BLE , 8'd214,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[337] =  {`STO , `R5, 16'd0};
   assign memoryROM[338] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[339] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[340] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[341] =  {`NOP , 24'd4000 };
   assign memoryROM[342] =  {`NOP , 24'd4000 };
   assign memoryROM[343] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[344] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[345] =  {`BLE , 8'd344,`R5, `R3};
   
   assign memoryROM[346] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[347] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[348] =  {`STO , `R1, 16'd0};
   assign memoryROM[349] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[350] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[351] =  {`BLE , 8'd350,`R1, `R4};
   
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //M 
   //FIRST NIBBLE 
   assign memoryROM[352] =  {`STO , `R5, 16'd0};
   assign memoryROM[353] =  {`STO , `R6, 8'h00,`M}; //ENTRY MODE BYTE
   assign memoryROM[354] =  {`STO , `R3, 16'd12};

   assign memoryROM[355] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[356] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[357] =  {`NOP , 24'd4000 };
   
   assign memoryROM[358] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[359] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[360] =  {`BLE , 8'd359,`R5, `R3};
   
   assign memoryROM[361] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[362] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[363] =  {`STO , `R1, 16'd0};
   assign memoryROM[364] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[365] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[366] =  {`BLE , 8'd365,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[367] =  {`STO , `R5, 16'd0};
   assign memoryROM[368] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[369] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[370] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[371] =  {`NOP , 24'd4000 };
   assign memoryROM[372] =  {`NOP , 24'd4000 };
   assign memoryROM[373] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[374] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[375] =  {`BLE , 8'd374,`R5, `R3};
   
   assign memoryROM[376] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[377] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[378] =  {`STO , `R1, 16'd0};
   assign memoryROM[379] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[380] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[381] =  {`BLE , 8'd380,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //U 
   //FIRST NIBBLE 
   assign memoryROM[382] =  {`STO , `R5, 16'd0};
   assign memoryROM[383] =  {`STO , `R6, 8'h00,`U}; //ENTRY MODE BYTE
   assign memoryROM[384] =  {`STO , `R3, 16'd12};

   assign memoryROM[385] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[386] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[387] =  {`NOP , 24'd4000 };
   
   assign memoryROM[388] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[389] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[390] =  {`BLE , 8'd389,`R5, `R3};
   
   assign memoryROM[391] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[392] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[393] =  {`STO , `R1, 16'd0};
   assign memoryROM[394] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[395] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[396] =  {`BLE , 8'd395,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[397] =  {`STO , `R5, 16'd0};
   assign memoryROM[398] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[399] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[400] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[401] =  {`NOP , 24'd4000 };
   assign memoryROM[402] =  {`NOP , 24'd4000 };
   assign memoryROM[403] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[404] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[405] =  {`BLE , 8'd404,`R5, `R3};
   
   assign memoryROM[406] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[407] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[408] =  {`STO , `R1, 16'd0};
   assign memoryROM[409] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[410] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[411] =  {`BLE , 8'd410,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //N 
   //FIRST NIBBLE 
   assign memoryROM[412] =  {`STO , `R5, 16'd0};
   assign memoryROM[413] =  {`STO , `R6, 8'h00,`N}; //ENTRY MODE BYTE
   assign memoryROM[414] =  {`STO , `R3, 16'd12};

   assign memoryROM[415] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[416] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[417] =  {`NOP , 24'd4000 };
   
   assign memoryROM[418] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[419] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[420] =  {`BLE , 8'd419,`R5, `R3};
   
   assign memoryROM[421] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[422] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[423] =  {`STO , `R1, 16'd0};
   assign memoryROM[424] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[425] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[426] =  {`BLE , 8'd425,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[427] =  {`STO , `R5, 16'd0};
   assign memoryROM[428] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[429] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[430] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[431] =  {`NOP , 24'd4000 };
   assign memoryROM[432] =  {`NOP , 24'd4000 };
   assign memoryROM[433] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[434] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[435] =  {`BLE , 8'd434,`R5, `R3};
   
   assign memoryROM[436] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[437] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[438] =  {`STO , `R1, 16'd0};
   assign memoryROM[439] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[440] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[441] =  {`BLE , 8'd440,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //D 
   //FIRST NIBBLE 
   assign memoryROM[442] =  {`STO , `R5, 16'd0};
   assign memoryROM[443] =  {`STO , `R6, 8'h00,`D}; //ENTRY MODE BYTE
   assign memoryROM[444] =  {`STO , `R3, 16'd12};

   assign memoryROM[445] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[446] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[447] =  {`NOP , 24'd4000 };
   
   assign memoryROM[448] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[449] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[450] =  {`BLE , 8'd449,`R5, `R3};
   
   assign memoryROM[451] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[452] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[453] =  {`STO , `R1, 16'd0};
   assign memoryROM[454] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[455] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[456] =  {`BLE , 8'd455,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[457] =  {`STO , `R5, 16'd0};
   assign memoryROM[458] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[459] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[460] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[461] =  {`NOP , 24'd4000 };
   assign memoryROM[462] =  {`NOP , 24'd4000 };
   assign memoryROM[463] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[464] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[465] =  {`BLE , 8'd464,`R5, `R3};
   
   assign memoryROM[466] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[467] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[468] =  {`STO , `R1, 16'd0};
   assign memoryROM[469] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[470] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[471] =  {`BLE , 8'd470,`R1, `R4};
   

   //////////////////////////////////////////////////////////////////////////////////////////////////
   //O 
   //FIRST NIBBLE 
   assign memoryROM[472] =  {`STO , `R5, 16'd0};
   assign memoryROM[473] =  {`STO , `R6, 8'h00,`O}; //ENTRY MODE BYTE
   assign memoryROM[474] =  {`STO , `R3, 16'd12};

   assign memoryROM[475] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[476] =  {`NOP , 24'd4000 }; // SETUP TIME
   assign memoryROM[477] =  {`NOP , 24'd4000 };
   
   assign memoryROM[478] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

   assign memoryROM[479] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[480] =  {`BLE , 8'd479,`R5, `R3};
   
   assign memoryROM[481] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
   
   assign memoryROM[482] =  {`NOP , 24'd4000 }; // HOLD TIME 
   
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //NIBBLE WAIT
   assign memoryROM[483] =  {`STO , `R1, 16'd0};
   assign memoryROM[484] =  {`STO , `R4, 16'd50};

   //LOOP1
   assign memoryROM[485] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[486] =  {`BLE , 8'd485,`R1, `R4};
   
   //////////////////////////////////////////////////////////////////////////
   //SECOND NIBBLE
   
   assign memoryROM[487] =  {`STO , `R5, 16'd0};
   assign memoryROM[488] =  {`STO , `R3, 16'd12};
   
   assign memoryROM[489] =  {`SHL , `R6 ,`R6, `R7 };
   assign memoryROM[490] =  {`LCD_CHAR ,8'd0 ,`R6, 8'd0 };
   assign memoryROM[491] =  {`NOP , 24'd4000 };
   assign memoryROM[492] =  {`NOP , 24'd4000 };
   assign memoryROM[493] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   
   assign memoryROM[494] =  {`ADD , `R5, `R5, `R2}; 
   assign memoryROM[495] =  {`BLE , 8'd494,`R5, `R3};
   
   assign memoryROM[496] =  {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
   assign memoryROM[497] =  {`NOP , 24'd4000 };  
   
   //////////////////////////////////////////////////////////////////////////////////////////////////
   //LOOP 2000
   assign memoryROM[498] =  {`STO , `R1, 16'd0};
   assign memoryROM[499] =  {`STO , `R4, 16'd2000};
   //LOOP1
   assign memoryROM[500] =  {`ADD , `R1, `R1, `R2}; 
   assign memoryROM[501] =  {`BLE , 8'd500,`R1, `R4};
      

   
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
