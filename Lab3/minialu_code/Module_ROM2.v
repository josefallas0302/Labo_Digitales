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
0: oInstruction = {`STO , `R1, 16'd0};
1: oInstruction = {`STO , `R2, 16'd1};
2: oInstruction = {`STO , `R3, 16'd24};
3: oInstruction = {`STO , `R4, 16'd31250};
4: oInstruction = {`STO , `R5, 16'd0};

		 //LOOP1
5: oInstruction = {`ADD , `R1, `R1, `R2}; 
6: oInstruction = {`BLE , 8'd5,`R1, `R4};
		 //LOOP1
7: oInstruction = {`ADD , `R5, `R5, `R2}; 
8: oInstruction = {`STO , `R1, 16'd0};
9: oInstruction = {`BLE , 8'd5,`R5, `R3};
		 //POWER ON
		////////////////////////////////////////////////////////////////////////////////////////////////
		//ESCRIBIR 0x3
		
10: oInstruction = {`STO , `R5, 16'd0};
11: oInstruction = {`STO , `R6, 16'h0030};
12: oInstruction = {`STO , `R3, 16'd12};
13: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
14: oInstruction = {`NOP , 24'd4000 };
15: oInstruction = {`NOP , 24'd4000 };
		 //ENABLE
16: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };
		 //LOOP 
17: oInstruction = {`ADD , `R5, `R5, `R2}; 
18: oInstruction = {`BLE , 8'd17,`R5, `R3};
		 
19: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
20: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////  
		 // LOOP 205000
21: oInstruction = {`STO , `R1, 16'd0};
22: oInstruction = {`STO , `R3, 16'd8};
23: oInstruction = {`STO , `R4, 16'd25625};
24: oInstruction = {`STO , `R5, 16'd0};
		 

		 //LOOP1
25: oInstruction = {`ADD , `R1, `R1, `R2}; 
26: oInstruction = {`BLE , 8'd25,`R1, `R4};
		 //LOOP1
27: oInstruction = {`ADD , `R5, `R5, `R2}; 
28: oInstruction = {`STO , `R1, 16'd0};
29: oInstruction = {`BLE , 8'd25,`R5, `R3};
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////  
		 // ESCRIBIR 0x3
30: oInstruction = {`STO , `R5, 16'd0};
31: oInstruction = {`STO , `R6, 16'h0030};
32: oInstruction = {`STO , `R3, 16'd12};
33: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
34: oInstruction = {`NOP , 24'd4000 };
35: oInstruction = {`NOP , 24'd4000 };
		 
36: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

37: oInstruction = {`ADD , `R5, `R5, `R2}; 
38: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
39: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
40: oInstruction = {`NOP , 24'd4000 };
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 5000
41: oInstruction = {`STO , `R1, 16'd0};
42: oInstruction = {`STO , `R4, 16'd5000};
		 

		 //LOOP1
43: oInstruction = {`ADD , `R1, `R1, `R2}; 
44: oInstruction = {`BLE , `LOOP1,`R1, `R4};

		 ///////////////////////////////////////////////////////////////////////////////////////////////////////
		 //ESCRIBIR 0x3
		 
45: oInstruction = {`STO , `R5, 16'd0};
46: oInstruction = {`STO , `R6, 16'h0030};
47: oInstruction = {`STO , `R3, 16'd12};
48: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
49: oInstruction = {`NOP , 24'd4000 };
50: oInstruction = {`NOP , 24'd4000 };
		 
51: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

52: oInstruction = {`ADD , `R5, `R5, `R2}; 
53: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
54: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
55: oInstruction = {`NOP , 24'd4000 };
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
56: oInstruction = {`STO , `R1, 16'd0};
57: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
58: oInstruction = {`ADD , `R1, `R1, `R2}; 
59: oInstruction = {`BLE , `LOOP1,`R1, `R4};
		 

		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //ESCRIBIR 0x2
		 
60: oInstruction = {`STO , `R5, 16'd0};
61: oInstruction = {`STO , `R6, 16'h0020};
62: oInstruction = {`STO , `R3, 16'd12};
63: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
64: oInstruction = {`NOP , 24'd4000 };
65: oInstruction = {`NOP , 24'd4000 };
		 
66: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

67: oInstruction = {`ADD , `R5, `R5, `R2}; 
68: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
69: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
70: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
71: oInstruction = {`STO , `R1, 16'd0};
72: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
73: oInstruction = {`ADD , `R1, `R1, `R2}; 
74: oInstruction = {`BLE , `LOOP1,`R1, `R4};


		 
 
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////CONFIGURACION//////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
		 

  	
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //FUNCTION SET- FIRST NIBBLE 
		 
75: oInstruction = {`STO , `R5, 16'd0};
76: oInstruction = {`STO , `R6, 16'h0028};
77: oInstruction = {`STO , `R3, 16'd12};

78: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
79: oInstruction = {`NOP , 24'd4000 };
80: oInstruction = {`NOP , 24'd4000 };
		 
81: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

82: oInstruction = {`ADD , `R5, `R5, `R2}; 
83: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
84: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
85: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
86: oInstruction = {`STO , `R1, 16'd0};
87: oInstruction = {`STO , `R4, 16'd50};

		 //LOOP1
88: oInstruction = {`ADD , `R1, `R1, `R2}; 
89: oInstruction = {`BLE , `LOOP1,`R1, `R4};
 

		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
90: oInstruction = {`STO , `R5, 16'd0};
91: oInstruction = {`STO , `R3, 16'd12};
92: oInstruction = {`SHL ,8'd0 ,`R6, 8'd4 };
93: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
94: oInstruction = {`NOP , 24'd4000 };
95: oInstruction = {`NOP , 24'd4000 };
		 
96: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

97: oInstruction = {`ADD , `R5, `R5, `R2}; 
98: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
99: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	
100: oInstruction = {`NOP , 24'd4000 };
	
	
	
	
	     //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
101: oInstruction = {`STO , `R1, 16'd0};
102: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
103: oInstruction = {`ADD , `R1, `R1, `R2}; 
104: oInstruction = {`BLE , `LOOP1,`R1, `R4};

	
	
		//////////////////////////////////////////////////////////////////////////////////////////////////
		 //ENTRY MODE- FIRST NIBBLE 
		 
105: oInstruction = {`STO , `R5, 16'd0};
106: oInstruction = {`STO , `R6, 16'h0006}; //ENTRY MODE BYTE
107: oInstruction = {`STO , `R3, 16'd12};

108: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
109: oInstruction = {`NOP , 24'd4000 };
110: oInstruction = {`NOP , 24'd4000 };
		 
111: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

112: oInstruction = {`ADD , `R5, `R5, `R2}; 
113: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
114: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
115: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
116: oInstruction = {`STO , `R1, 16'd0};
117: oInstruction = {`STO , `R4, 16'd50};

		 //LOOP1
118: oInstruction = {`ADD , `R1, `R1, `R2}; 
119: oInstruction = {`BLE , `LOOP1,`R1, `R4};
 

		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
120: oInstruction = {`STO , `R5, 16'd0};
121: oInstruction = {`STO , `R3, 16'd12};
122: oInstruction = {`SHL ,8'd0 ,`R6, 8'd4 };
123: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
124: oInstruction = {`NOP , 24'd4000 };
125: oInstruction = {`NOP , 24'd4000 };
		 
126: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

127: oInstruction = {`ADD , `R5, `R5, `R2}; 
128: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
129: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	
130: oInstruction = {`NOP , 24'd4000 };
	
	
	
	
	     //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
131: oInstruction = {`STO , `R1, 16'd0};
132: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
133: oInstruction = {`ADD , `R1, `R1, `R2}; 
134: oInstruction = {`BLE , `LOOP1,`R1, `R4};
	
	
			//////////////////////////////////////////////////////////////////////////////////////////////////
		 //DISPLAY ON-OFF / FIRST NIBBLE 
		 
135: oInstruction = {`STO , `R5, 16'd0};
136: oInstruction = {`STO , `R6, 16'h000C}; //ENTRY MODE BYTE
137: oInstruction = {`STO , `R3, 16'd12};

138: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
139: oInstruction = {`NOP , 24'd4000 };
140: oInstruction = {`NOP , 24'd4000 };
		 
141: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

142: oInstruction = {`ADD , `R5, `R5, `R2}; 
143: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
144: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
145: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
146: oInstruction = {`STO , `R1, 16'd0};
147: oInstruction = {`STO , `R4, 16'd50};

		 //LOOP1
148: oInstruction = {`ADD , `R1, `R1, `R2}; 
149: oInstruction = {`BLE , `LOOP1,`R1, `R4};
 

		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
150: oInstruction = {`STO , `R5, 16'd0};
151: oInstruction = {`STO , `R3, 16'd12};
152: oInstruction = {`SHL ,8'd0 ,`R6, 8'd4 };
153: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
154: oInstruction = {`NOP , 24'd4000 };
155: oInstruction = {`NOP , 24'd4000 };
		 
156: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

157: oInstruction = {`ADD , `R5, `R5, `R2}; 
158: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
159: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	
160: oInstruction = {`NOP , 24'd4000 };
	
	
	
	
	     //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
161: oInstruction = {`STO , `R1, 16'd0};
162: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
163: oInstruction = {`ADD , `R1, `R1, `R2}; 
164: oInstruction = {`BLE , `LOOP1,`R1, `R4};


		 /////////////////////////////////////////////////////////////////////////////////////////////////
		 //CLEAR DISPLAY - FIRST NIBBLE 
		 
165: oInstruction = {`STO , `R5, 16'd0};
166: oInstruction = {`STO , `R6, 16'h0001}; //ENTRY MODE BYTE
167: oInstruction = {`STO , `R3, 16'd12};

168: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
169: oInstruction = {`NOP , 24'd4000 };
170: oInstruction = {`NOP , 24'd4000 };
		 
171: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

172: oInstruction = {`ADD , `R5, `R5, `R2}; 
173: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
174: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
		 
175: oInstruction = {`NOP , 24'd4000 };
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
176: oInstruction = {`STO , `R1, 16'd0};
177: oInstruction = {`STO , `R4, 16'd50};

		 //LOOP1
178: oInstruction = {`ADD , `R1, `R1, `R2}; 
179: oInstruction = {`BLE , `LOOP1,`R1, `R4};
 

		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
180: oInstruction = {`STO , `R5, 16'd0};
181: oInstruction = {`STO , `R3, 16'd12};
182: oInstruction = {`SHL ,8'd0 ,`R6, 8'd4 };
183: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
184: oInstruction = {`NOP , 24'd4000 };
185: oInstruction = {`NOP , 24'd4000 };
		 
186: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

187: oInstruction = {`ADD , `R5, `R5, `R2}; 
188: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
189: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	
190: oInstruction = {`NOP , 24'd4000 };
	
	
	
	
	     //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 82000
191: oInstruction = {`STO , `R1, 16'd0};
192: oInstruction = {`STO , `R3, 16'd8};
193: oInstruction = {`STO , `R4, 16'd10250};
194: oInstruction = {`STO , `R5, 16'd0};

		 //LOOP1
195: oInstruction = {`ADD , `R1, `R1, `R2}; 
196: oInstruction = {`BLE , `LOOP1,`R1, `R4};
		 //LOOP1
197: oInstruction = {`ADD , `R5, `R5, `R2}; 
198: oInstruction = {`STO , `R1, 16'd0};
199: oInstruction = {`BLE , `LOOP1,`R5, `R3};



		//////////////////////////////////////////////////////////////////////////////////////////////////
		 //LETTER ROUTINE / FIRST NIBBLE 
		 
200: oInstruction = {`STO , `R5, 16'd0};
201: oInstruction = {`STO , `R6, 16'h0048}; //ENTRY MODE BYTE
202: oInstruction = {`STO , `R3, 16'd12};

203: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
204: oInstruction = {`NOP , 24'd4000 }; // SETUP TIME
205: oInstruction = {`NOP , 24'd4000 };
		 
206: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB ON

207: oInstruction = {`ADD , `R5, `R5, `R2}; 
208: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
209: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; // ENB OFF //REVISAR BAJAR EL DATO 
		 
210: oInstruction = {`NOP , 24'd4000 }; // HOLD TIME 
		 
		 
		 //////////////////////////////////////////////////////////////////////////////////////////////////
		 //NIBBLE WAIT
211: oInstruction = {`STO , `R1, 16'd0};
212: oInstruction = {`STO , `R4, 16'd50};

		 //LOOP1
213: oInstruction = {`ADD , `R1, `R1, `R2}; 
214: oInstruction = {`BLE , `LOOP1,`R1, `R4};
 

		//////////////////////////////////////////////////////////////////////////
		//SECOND NIBBLE
	
215: oInstruction = {`STO , `R5, 16'd0};
216: oInstruction = {`STO , `R3, 16'd12};
217: oInstruction = {`SHL ,8'd0 ,`R6, 8'd4 };
218: oInstruction = {`LCD_CMD ,8'd0 ,`R6, 8'd0 };
219: oInstruction = {`NOP , 24'd4000 };
220: oInstruction = {`NOP , 24'd4000 };
		 
221: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 };

222: oInstruction = {`ADD , `R5, `R5, `R2}; 
223: oInstruction = {`BLE , 8'd20,`R5, `R3};
		 
224: oInstruction = {`LCD_ENB ,8'd0 ,8'b0, 8'd0 }; //REVISAR BAJAR EL DATO 
	
225: oInstruction = {`NOP , 24'd4000 };
	
	
	
	
	     //////////////////////////////////////////////////////////////////////////////////////////////////
		 //LOOP 2000
226: oInstruction = {`STO , `R1, 16'd0};
227: oInstruction = {`STO , `R4, 16'd2000};


		 //LOOP1
228: oInstruction = {`ADD , `R1, `R1, `R2}; 
229: oInstruction = {`BLE , `LOOP1,`R1, `R4};




	

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
