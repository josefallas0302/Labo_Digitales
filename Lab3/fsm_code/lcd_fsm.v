
`timescale 1ns / 1ps

`define STATE_RESET 0 
`define STATE_POWERON_INIT_WAIT 1
`define STATE_POWERON_INIT_WRITE 2
`define STATE_CONFIG_INIT_WAIT 3
`define STATE_CONFIG_INIT_WRITE 4
`define STATE_PRINT_WAIT 5
`define STATE_PRINT_WRITE 6

module Module_LCD_Control ( 
			    input wire 	     Clock, 
			    input wire 	     Reset, 
			    output wire      oLCD_Enabled, 
			    output reg 	     oLCD_RegisterSelect, //0=Command, 1=Data 
			    output wire      oLCD_StrataFlashControl, 
			    output wire      oLCD_ReadWrite, 
			    output reg [3:0] oLCD_Data 
			    ); 

   reg 					     rWrite_Enabled; 
   reg [7:0] 				     rCurrentState,rNextState; 
   reg [31:0] 				     rTimeCount; 
   reg 					     rTimeCountReset;
   reg [3:0] 				     rPowerOnInitCount, rNextPowerOnInitCount;
   reg 					     rFinishedPowerOnWait;
   reg [31:0] 				     rConfigCommands;
   wire 				     wWriteDone; 

   assign oLCD_ReadWrite = 0;  //I only Write to the LCD display, never Read from it 
   assign oLCD_StrataFlashControl = 1; //StrataFlash disabled. Full read/write access to LCD 

   assign rConfigCommands = {8'h01, 8'h0C, 8'h06, 0x28};
   
   //---------------------------------------------- 
   //Next State and delay logic 
   
   always @ ( posedge Clock ) 
      begin 
	 if (Reset) 
	    begin 
	       rCurrentState <= `STATE_RESET;
	       rTimeCount    <= 32'b0;
	       rPowerOnInitCount <= 32'b0;
	    end 
	 else 
	    begin 
	       if (rTimeCountReset) 
		  rTimeCount <= 32'b0; 
	       else rTimeCount <= rTimeCount + 32'b1; 

	       rPowerOnInitCount <= rNextPowerOnInitCount;
	       rCurrentState 	 <= rNextState;
	    end 
      end 

   //---------------------------------------------- 
   //Current state and output logic 
   always @ ( * ) 
      begin
	 //Defaults
	 rNextPowerOnInitCount = rPowerOnInitCount; 
	 
	 case (rCurrentState) 
	    //------------------------------------------ 
	    `STATE_RESET: 
	       begin 
		  rWrite_Enabled 	 = 1'b0;
		  oLCD_Data 		 = 4'h0; 
		  oLCD_RegisterSelect 	 = 1'b0; 
		  rTimeCountReset 	 = 1'b0; 
		  rNextPowerOnInitCount  = 4'b0;
		  rNextState 		 = `STATE_POWERON_INIT_WAIT; 
	       end 
	    //------------------------------------------ 
	    /* Wait 15 ms or longer. 
	     The 15 ms interval is 750,000 clock cycles at 50 MHz. 
	     */ 
	    `STATE_POWERON_INIT_WAIT:
	       begin 
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; //Command
		  rTimeCountReset      = 1'b0; 
				       		  
		  case (rPowerOnInitCount)
		     0: rFinishedPowerOnWait 	= rTimeCount > 32'd750000;
		     1: rFinishedPowerOnWait 	= rTimeCount > 32'd205000;
		     2: rFinishedPowerOnWait 	= rTimeCount > 32'd5000;
		     3,4: rFinishedPowerOnWait 	= rTimeCount > 32'd2000;
		  endcase 
		  
		  if (rFinishedPowerOnWait) 
		     begin
			rTimeCountReset  = 1'b1;
			if (rPowerOnInitCount < 4)
			   rNextState  = `STATE_POWERON_INIT_WRITE;
			else
			   rNextState = `STATE_CONFIG_INIT_WRITE;
		     end
		  else 
		     rNextState = `STATE_POWERON_INIT_WAIT; 
	       end
            //------------------------------------------ 
	    `STATE_POWERON_INIT_WRITE:
	       begin
		  oLCD_RegisterSelect 	= 1'b0; //Command
		  rFinishedPowerOnWait 	= 1'b0;
		  
		  case (rPowerOnInitCount)
		     0,1,2,3: oLCD_Data  = 4'h3;
		     4:	oLCD_Data 	 = 4'h2;
		  endcase 

		  if (rTimeCount <= 32'b14) //(2 Setup + 12 Enable) cycles
		     begin
			rTimeCountReset        = 1'b0;
			//Setup: rWrite_Enabled = 0 for 2 cycles
			rWrite_Enabled 	       = (rTimeCount <= 32'b2) ? 1'b0 : 1'b1;
			rNextState 	       = `STATE_POWERON_INIT_WRITE;
		     end
		  else
		     begin
			rTimeCountReset        = 1'b1;
			rNextPowerOnInitCount  = rPowerOnInitCount + 4'b1;
			rNextState 	       = `STATE_POWERON_INIT_WAIT;
		     end
	       end
	    
	    //------------------------------------------ 
	    default: 
	       begin 
		  rWrite_Enabled = 1'b0; 
		  oLCD_Data = 4'h0; 
		  oLCD_RegisterSelect = 1'b0; 
		  rTimeCountReset = 1'b0; 
		  rNextPowerOnInitCount = 1'b0;
		  rNextState = `STATE_RESET; 
	       end 
	    //------------------------------------------ 
	 endcase // case (rCurrentState)

      end // always @ ( * )

endmodule // Module_LCD_Control
