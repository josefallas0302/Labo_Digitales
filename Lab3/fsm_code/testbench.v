`timescale 1ns / 1ps

module TestBench;

   // Inputs
   reg Clock;
   reg Reset;

   // Outputs
   wire       oLCD_Enabled;
   wire       oLCD_RegisterSelect;
   wire       oLCD_StrataFlashControl;
   wire       oLCD_ReadWrite;
   wire [3:0] oLCD_Data;


   Module_LCD_Control lcd_fsm (
			       .Clock(Clock), 
			       .Reset(Reset), 
			       .oLCD_Enabled(oLCD_Enabled), 
			       .oLCD_RegisterSelect(oLCD_RegisterSelect), //0=Command, 1=Data 
			       .oLCD_StrataFlashControl(oLCD_StrataFlashControl), 
			       .oLCD_ReadWrite(oLCD_ReadWrite), 
			       .oLCD_Data(oLCD_Data)
			       ); 

   
   always
      begin
	 #5  Clock = !Clock;
      end

   initial begin
      // Initialize Inputs
      Clock = 0;
      Reset = 0;

      // Wait 100 ns for global reset to finish
      #100;
      Reset = 1;
      #50
	 Reset = 0;
      
      // Add stimulus here

   end
   
endmodule

