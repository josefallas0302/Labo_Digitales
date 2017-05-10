`include "definitions.v"

`timescale 1ns / 1ps

`define STATE_RESET 0 
`define STATE_POWERON_INIT_WAIT 1
`define STATE_POWERON_INIT_WRITE 2

`define STATE_CONFIG_INIT_WAIT 3
`define STATE_CONFIG_INIT_WRITE 4
`define STATE_CONFIG_INIT_HALF_WAIT 5

`define STATE_PRINT_WAIT 6
`define STATE_PRINT_WRITE 7
`define STATE_PRINT_HALF_WAIT 8

`define STATE_IDLE 9

module Module_LCD_Control ( 
			    input wire 	     Clock, 
			    input wire 	     Reset, 
			    output wire      oLCD_Enabled, 
			    output reg 	     oLCD_RegisterSelect, //0=Command, 1=Data 
			    output wire      oLCD_StrataFlashControl, 
			    output wire      oLCD_ReadWrite, 
			    output reg [3:0] oLCD_Data 
			    ); 

   parameter TEXT_LENGTH  = 10;

   reg 					     rWrite_Enabled; 
   reg [7:0] 				     rCurrentState,rNextState; 
   reg [31:0] 				     rTimeCount; 
   reg 					     rTimeCountReset;
   reg [3:0] 				     rStepCount, rNextStepCount;
   reg 					     rNibbleSelect, rNextNibbleSelect; //Upper=0, Lower=1
   reg 					     rFinishedStepWait;
   
   wire [31:0] 				     rConfigCommands; //WARNING: Check if bit direction is right
   wire [(8*TEXT_LENGTH-1):0] 		     rTextChars; //WARNING: Check if bit direction is right

   assign oLCD_Enabled = rWrite_Enabled;
   assign oLCD_ReadWrite = 0;  //I only Write to the LCD display, never Read from it 
   assign oLCD_StrataFlashControl = 1; //StrataFlash disabled. Full read/write access to LCD 

   assign rConfigCommands  = {`FUNCTION_SET,
			      `ENTRY_MODE_SET,
			      `DISPLAY_ONOFF,
			      `CLEAR_DISPLAY
			      };
   
   assign rTextChars  = {`H,`O,`L,`A,`SPC,`M,`U,`N,`D,`O};
	
   //---------------------------------------------- 
   //Next State and delay logic 
   
   always @ ( posedge Clock ) 
      begin 
	 if (Reset) 
	    begin 
	       rCurrentState <= `STATE_RESET;
	       rTimeCount    <= 32'b0;
	       rStepCount    <= 32'b0;
	       rNibbleSelect <= 1'b0;
	    end 
	 else 
	    begin 
	       if (rTimeCountReset) 
		  rTimeCount <= 32'b0; 
	       else rTimeCount <= rTimeCount + 32'b1; 
	       
	       rNibbleSelect <= rNextNibbleSelect;
	       rStepCount    <= rNextStepCount;
	       rCurrentState <= rNextState;
	    end 
      end 

   //---------------------------------------------- 
   //Current state and output logic 
   always @ ( * ) 
      begin
	 //Defaults
	 oLCD_Data 	    = 4'h0; 
	 rNextStepCount     = rStepCount; 
	 rNextNibbleSelect  = rNibbleSelect;
	 rFinishedStepWait  = 1'b0;
	 
	 case (rCurrentState) 
	    //------------------------------------------ 
	    `STATE_RESET: 
	       begin 
		  rWrite_Enabled       = 1'b0;
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; 
		  rTimeCountReset      = 1'b0;
		  rNextNibbleSelect    = 1'b0;
		  rNextStepCount       = 4'b0;
		  rNextState 	       = `STATE_POWERON_INIT_WAIT; 
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
		  
		  case (rStepCount)
		     0: rFinishedStepWait    = rTimeCount > 32'd750000;
		     1: rFinishedStepWait    = rTimeCount > 32'd205000;
		     2: rFinishedStepWait    = rTimeCount > 32'd5000;
		     3,4: rFinishedStepWait  = rTimeCount > 32'd2000;
		  endcase 
		  
		  if (rFinishedStepWait) 
		     begin
			rTimeCountReset  = 1'b1;
			if (rStepCount < 4)
			   rNextState  = `STATE_POWERON_INIT_WRITE;
			else
			   begin
			      rNextState      = `STATE_CONFIG_INIT_WRITE;
			      rNextStepCount  = 1'b0;
			   end
		     end
		  else 
		     rNextState = `STATE_POWERON_INIT_WAIT; 
	       end
            //------------------------------------------ 
	    `STATE_POWERON_INIT_WRITE:
	       begin
		  oLCD_RegisterSelect  = 1'b0; //Command
		  
		  case (rStepCount)
		     0,1,2: oLCD_Data  = 4'h3;
		     3,4:	oLCD_Data 	 = 4'h2;
		  endcase 

		  if (rTimeCount <= 32'd14) //(2 Setup + 12 Enable) cycles
		     begin
			rTimeCountReset        = 1'b0;
			//Setup: rWrite_Enabled = 0 for 2 cycles
			rWrite_Enabled 	       = (rTimeCount <= 32'd2) ? 1'b0 : 1'b1;
			rNextState 	       = `STATE_POWERON_INIT_WRITE;
		     end
		  else
		     begin
			rTimeCountReset  = 1'b1;
			rNextStepCount 	 = rStepCount + 4'b1;
			rWrite_Enabled 	 = 1'b0;
			rNextState 	 = `STATE_POWERON_INIT_WAIT;
		     end
	       end
	    //------------------------------------------
	    `STATE_CONFIG_INIT_WRITE:
	       begin
		  oLCD_RegisterSelect  = 1'b0; //Command
		  
		  oLCD_Data = rConfigCommands[31-(8*rStepCount+4*rNibbleSelect) -: 4];
		  
		  if (rTimeCount <= 32'd14) //(2 Setup + 12 Enable) cycles
		     begin
			rTimeCountReset        = 1'b0;
			//Setup: rWrite_Enabled = 0 for 2 cycles
			rWrite_Enabled 	       = (rTimeCount <= 32'd2) ? 1'b0 : 1'b1;
			rNextState 	       = `STATE_CONFIG_INIT_WRITE;
		     end
		  else
		     begin
			rTimeCountReset  = 1'b1;
			rWrite_Enabled 	 = 1'b0;
			
			if (rNibbleSelect == 1'b0)
			   begin
			      rNextNibbleSelect  = 1'b1;
			      rNextState 	 = `STATE_CONFIG_INIT_HALF_WAIT;
			   end
			else // rNibbleSelect == 1
			   begin
			      rNextNibbleSelect  = 1'b0;
			      rNextState 	 = `STATE_CONFIG_INIT_WAIT;
			   end
		     end
	       end
	    //------------------------------------------
	    `STATE_CONFIG_INIT_HALF_WAIT:
	       begin
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; //Command
		  rTimeCountReset      = 1'b0; 
		  rFinishedStepWait    = rTimeCount > 32'd50; //1 us
		  
		  if (rFinishedStepWait) 
		     begin
			rTimeCountReset  = 1'b1;
			rNextState = `STATE_CONFIG_INIT_WRITE;
		     end
		  else 
		     rNextState = `STATE_CONFIG_INIT_HALF_WAIT;
	       end
	    //------------------------------------------
	    `STATE_CONFIG_INIT_WAIT:
	       begin
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; //Command
		  rTimeCountReset      = 1'b0; 

		  case (rStepCount)
		     0,1,2: rFinishedStepWait  = rTimeCount > 32'd2000;  //40 us
		     3: rFinishedStepWait      = rTimeCount > 32'd82000; //1.64 ms
		  endcase 

		  if (rFinishedStepWait) 
		     begin
			rTimeCountReset  = 1'b1;
			if (rStepCount < 3)
			   begin
			      rNextStepCount  = rStepCount + 4'b1;
			      rNextState      = `STATE_CONFIG_INIT_WRITE;
			   end
			else
			   begin
			      rNextStepCount  = 1'b0;
			      rNextState      = `STATE_PRINT_WRITE;
			   end
		     end
		  else 
		     rNextState = `STATE_CONFIG_INIT_WAIT; 		  
	       end
	    //------------------------------------------
	    `STATE_PRINT_WRITE:
	       begin
		  oLCD_RegisterSelect  = 1'b1; //Data
		  
		  oLCD_Data = rTextChars[((8*TEXT_LENGTH-1)-(8*rStepCount + 4*rNibbleSelect)) -: 4];
		  
		  if (rTimeCount <= 32'd14) //(2 Setup + 12 Enable) cycles
		     begin
			rTimeCountReset        = 1'b0;
			//Setup: rWrite_Enabled = 0 for 2 cycles
			rWrite_Enabled 	       = (rTimeCount <= 32'd2) ? 1'b0 : 1'b1;
			rNextState 	       = `STATE_PRINT_WRITE;
		     end
		  else
		     begin
			rTimeCountReset  = 1'b1;
			rWrite_Enabled 	 = 1'b0;
			
			if (rNibbleSelect == 1'b0)
			   begin
			      rNextNibbleSelect  = 1'b1;
			      rNextState 	 = `STATE_CONFIG_INIT_HALF_WAIT;
			   end
			else // rNibbleSelect == 1
			   begin
			      rNextNibbleSelect  = 1'b0;
			      rNextState 	 = `STATE_CONFIG_INIT_WAIT;
			   end
		     end

	       end
	    //------------------------------------------
	    `STATE_PRINT_HALF_WAIT:
	       begin
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; // WARNING: Check if 0 or 1
		  rTimeCountReset      = 1'b0; 
		  rFinishedStepWait    = rTimeCount > 32'd50; //1 us
		  
		  if (rFinishedStepWait) 
		     begin
			rTimeCountReset  = 1'b1;
			rNextState = `STATE_PRINT_WRITE;
		     end
		  else 
		     rNextState = `STATE_PRINT_HALF_WAIT;
	       end
	    //------------------------------------------
	    `STATE_PRINT_WAIT:
	       begin
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; //Command
		  rTimeCountReset      = 1'b0; 
		  rFinishedStepWait    = rTimeCount > 32'd2000; //40 us

		  if (rFinishedStepWait) 
		     begin
			rTimeCountReset  = 1'b1;
			
			if (rStepCount < TEXT_LENGTH)
			   begin
			      rNextStepCount  = rStepCount + 4'b1;
			      rNextState      = `STATE_PRINT_WRITE;
			   end
			else
			   begin
			      rNextStepCount  = 1'b0;
			      rNextState      = `STATE_IDLE;
			   end
		     end
		  else 
		     rNextState  = `STATE_PRINT_WAIT;
	       end
	    //------------------------------------------
	    `STATE_IDLE:
	       begin
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; //Command
		  rTimeCountReset      = 1'b0; 
		  rNextState 	       = `STATE_IDLE;
	       end
	    //------------------------------------------ 
	    default: 
	       begin 
		  rWrite_Enabled       = 1'b0; 
		  oLCD_Data 	       = 4'h0; 
		  oLCD_RegisterSelect  = 1'b0; 
		  rTimeCountReset      = 1'b0; 
		  rNextNibbleSelect    = 1'b0;
		  rNextStepCount       = 1'b0;
		  rNextState 	       = `STATE_RESET;
	       end 
	    //------------------------------------------ 
	 endcase // case (rCurrentState)

      end // always @ ( * )

endmodule // Module_LCD_Control
