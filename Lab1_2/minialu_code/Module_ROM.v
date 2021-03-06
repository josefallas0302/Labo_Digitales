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
	    1: oInstruction = {`STO , `R2, 16'd4};
	    2: oInstruction = {`STO , `R3, 16'd7};
	    3: oInstruction = {`STO , `R4, 16'd12};
	    4: oInstruction = {`STO , `R5, 16'd130};
	    5: oInstruction = {`STO , `R6, 16'd700};
	    6: oInstruction = {`IMUL1_4 , `R7, `R2, `R3};
	    7: oInstruction = {`IMUL2_4 , `R7, `R3, `R4};
	    8: oInstruction = {`IMUL1_16 , 8'b0, `R4, `R5};
	    9: oInstruction = {`IMUL2_16 , 8'b0, `R5, `R6};
	    10: oInstruction = {`LED, 8'b0,`R7, 8'b0};
	    11: oInstruction = {`JMP ,  8'd6, 16'b0  };
	    
	    /*	0: oInstruction = { `NOP ,24'd4000      };
	     1: oInstruction = { `STO , `R7,16'b0001 };
	     2: oInstruction = { `STO ,`R3,16'h1     }; 
	     3: oInstruction = { `STO, `R4,16'd1     };  //1000
	     4: oInstruction = { `STO, `R6,16'd2     };
	     5: oInstruction = { `STO, `R8,16'd0     };
	     6: oInstruction = { `STO, `R5,16'd0     };  //j
	     //LOOP2:
	     7: oInstruction = { `LED ,8'b0,`R7,8'b0 };
	     8: oInstruction = { `STO ,`R1,16'h0     }; 	
	     9: oInstruction = { `STO ,`R2,16'd10    };  //65000
	     //LOOP1:
	     10: oInstruction = { `ADD ,`R1,`R1,`R3    }; 
	     11: oInstruction = { `BLE ,`LOOP1,`R1,`R2 }; 
	     12: oInstruction = { `ADD ,`R5,`R5,`R3    };
	     13: oInstruction = { `BLE ,`LOOP2,`R5,`R4 };	
	     14: oInstruction = { `NOP ,24'd4000       };
	     15: oInstruction = { `SMUL , 8'b0,`R7,`R6 }; //LED Update
	     16: oInstruction = { `ADD ,`R7,`RL,`R8    };
	     17: oInstruction = { `JMP ,  8'd2,16'b0   };*/
	    default:
	       oInstruction = { `LED ,  24'b10101010 };
	 endcase
      end
endmodule
