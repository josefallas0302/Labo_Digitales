`timescale 1ns / 1ps
`include "Defintions.v"


module MiniAlu
   (
    input wire 	      Clock,
    input wire 	      Reset,
    output wire [7:0] oLed,
    output wire [7:0] oLCD,
    output wire [4:0] oVGA
    );

   wire [15:0] 	      wIP,wIP_temp, wIP_noRET;
   reg 		      rWriteEnable,rBranchTaken;
   wire [27:0] 	      wInstruction;
   wire [3:0] 	      wOperation;
   reg signed [31:0]  rResult;
   wire [7:0] 	      wSourceAddr0,wSourceAddr1,wDestination;
   wire signed [15:0] wSourceDataRAM0,wSourceDataRAM1;
   wire signed [15:0] wSourceData0,wSourceData1;
   wire [15:0] 	      wIPInitialValue,wImmediateValue;


   wire 	      Clk_25mhz;
   wire 	      DCM_Clk0;
   DCM_SP #(
	    .CLKDV_DIVIDE(2.0), // Divide by: 1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5
	    .CLKIN_PERIOD(20.0),  // Specify period of input clock
	    .CLKOUT_PHASE_SHIFT("NONE"), // Specify phase shift of NONE, FIXED or VARIABLE
	    .CLK_FEEDBACK("1X"),  // Specify clock feedback of NONE, 1X or 2X
	    .DUTY_CYCLE_CORRECTION("TRUE"), // Duty cycle correction, TRUE or FALSE
	    .STARTUP_WAIT("FALSE")   // Delay configuration DONE until DCM LOCK, TRUE/FALSE
	    ) DCM_SP_inst (
			   .CLK0(DCM_Clk0),     // 0 degree DCM CLK output
			   .CLKDV(Clk_25mhz),   // Divided DCM CLK out (CLKDV_DIVIDE)
			   .CLKFB(DCM_Clk0),   // DCM clock feedback
			   .CLKIN(Clock),   // Clock input (from IBUFG, BUFG or DCM)
			   .RST(Reset)        // DCM asynchronous reset input
			   );   
   

   ROM InstructionRom 
      (
       .iAddress(wIP),
       .oInstruction(wInstruction)
       );
   
   RAM_DUAL_READ_PORT DataRam
      (
       .Clock(Clk_25mhz),
       .iWriteEnable(rWriteEnable),
       .iReadAddress0(wInstruction[7:0]),
       .iReadAddress1(wInstruction[15:8]),
       .iWriteAddress(wDestination),
       .iDataIn(rResult[15:0]),
       .oDataOut1(wSourceDataRAM1),
       .oDataOut0(wSourceDataRAM0)
       );

   //--------------------------------------------------------------------
   // VGA Display Logic
   //--------------------------------------------------------------------
   
   wire 	      oVGA_R, oVGA_G, oVGA_B, oVGA_HS, oVGA_VS;
   wire [`VMEM_X_WIDTH-1:0] wCurrentCol;
   wire [`VMEM_Y_WIDTH-1:0] wCurrentRow;

   wire [23:0] 		    wCurrentVideoReadAddr;
   wire [23:0] 		    wVideoWriteAddr;
   wire [2:0] 		    wWriteColor, wReadColor;
   
   assign wCurrentVideoReadAddr  = (`VMEM_X_SIZE)*wCurrentRow + wCurrentCol;
   assign wVideoWriteAddr  = (`VMEM_X_SIZE)*wSourceData1 + wSourceData0;

      
   RAM_SINGLE_READ_PORT #(`VMEM_DATA_WIDTH, 
			  `VMEM_X_WIDTH+`VMEM_Y_WIDTH,
			  `VMEM_X_SIZE*`VMEM_Y_SIZE,
			  `COLOR_BLACK) VideoMemory
      (
       .Clock(Clk_25mhz),
       .iWriteEnable(wOperation == `VGA),
       .iReadAddress(wCurrentVideoReadAddr),
       .iWriteAddress(wVideoWriteAddr),
       .iDataIn(wWriteColor),
       .oDataOut(wReadColor) 
       );

   
   VGA_CONTROLLER #(`VMEM_X_WIDTH,
		    `VMEM_Y_WIDTH,
		    640, 
		    480) VGA_Control
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .oVideoMemCol(wCurrentCol),
       .oVideoMemRow(wCurrentRow),
       .oVGAHorizontalSync(oVGA_HS),
       .oVGAVerticalSync(oVGA_VS)
       );

   assign {oVGA_R,oVGA_G,oVGA_B} = ( wCurrentCol < 120 || wCurrentCol > 520 || wCurrentRow < 120 || wCurrentRow > 360 ) ? {0,0,0} : wReadColor;

   

   assign oVGA 	= {oVGA_R, oVGA_G, oVGA_B, oVGA_HS, oVGA_VS};
   //assign oVGA 	= {1'b1, oVGA_G, oVGA_B, oVGA_HS, oVGA_VS};
   


   //--------------------------------------------------------------------
   // Instruction Pointer (IP) Logic  
   //--------------------------------------------------------------------

   wire [15:0] 	      wRetIP;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_RET_IP
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );

   assign wImmediateValue = {wSourceAddr1,wSourceAddr0};   
   assign wIPInitialValue = (Reset) ? 16'b0 : (wOperation == `RET) ? wRetIP : wDestination;

   UPCOUNTER_POSEDGE IP
      (
       .Clock(Clk_25mhz), 
       .Reset(Reset | rBranchTaken),
       .Initial(wIPInitialValue + 16'b1),
       .Enable(1'b1),
       .Q(wIP_temp)
       );

   assign wIP_noRET = (rBranchTaken) ? wIPInitialValue : wIP_temp;
   assign wIP = (wOperation == `RET) ? wRetIP : wIP_noRET;   


   

   //--------------------------------------------------------------------
   // Pipeline registers (Fetch/Execute)
   //--------------------------------------------------------------------   
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FFD1
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wInstruction[27:24]),
       .Q(wOperation)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD2
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wInstruction[7:0]),
       .Q(wSourceAddr0)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD3
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wInstruction[15:8]),
       .Q(wSourceAddr1)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD4
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wInstruction[23:16]),
       .Q(wDestination)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FFD5
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wInstruction[18:16]),
       .Q(wWriteColor)
       );

   
   
   //--------------------------------------------------------------------
   // Read after Write registers
   //--------------------------------------------------------------------
   
   wire [15:0] 	      wLastResult;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_Result
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(rResult),
       .Q(wLastResult)
       );
   wire [7:0] 	      wLastDestination;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_Destination
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(wDestination),
       .Q(wLastDestination)
       );

   wire 	      wLastWriteEnable;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 ) FF_WriteEnable
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(1'b1),
       .D(rWriteEnable),
       .Q(wLastWriteEnable)
       );

   
   //--------------------------------------------------------------------
   //SMUL result registers
   //--------------------------------------------------------------------
   wire [15:0] 	      wRL;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRL
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable((wOperation == `SMUL)),
       .D(rResult[15:0]),
       .Q(wRL)
       );

   wire [15:0] 	      wRH;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRH
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable((wOperation == `SMUL)),
       .D(rResult[31:16]),
       .Q(wRH)
       );

   reg 		      rFFLedEN;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(rFFLedEN),
       .D(wSourceData1[7:0]),
       .Q(oLed)
       );



   //--------------------------------------------------------------------
   //LCD Display Logic
   //--------------------------------------------------------------------
   wire [5:0] 	      wLCD_Info;
   wire 	      wRS, wRW;
   assign wRS = wOperation == `LCD_CHAR;
   assign wRW = 1'b0;
   
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 6 ) FF_LCD_DATA
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(wOperation == `LCD_CHAR || wOperation == `LCD_CMD),
       .D({wRW,wRS,wSourceData1[7:4]}),
       .Q(wLCD_Info)
       );		 

   wire 	      wLCD_ENB;
   
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 ) FF_LCD_ENB
      (
       .Clock(Clk_25mhz),
       .Reset(Reset),
       .Enable(wOperation == `LCD_ENB),
       .D(~wLCD_ENB), //iLED_RS, iLED_E
       .Q(wLCD_ENB) //oLED_RS, oLED_E
       );
   
   // oLCD DATA ARRAY
   assign oLCD = {1'b1,wLCD_Info[5],wLCD_Info[4],wLCD_ENB,wLCD_Info[3:0]};
   



   //--------------------------------------------------------------------
   // Source Data selection multiplexers
   //--------------------------------------------------------------------

   wire [15:0] 	      wSourceDataMul0, wSourceDataMul1;
   //Muxes selección registros RL, RH
   assign wSourceDataMul0 = (wSourceAddr0 == `RL) ? wRL : (( wSourceAddr0 == `RH) ? wRH : wSourceDataRAM0);
   assign wSourceDataMul1 = (wSourceAddr1 == `RL) ? wRL : (( wSourceAddr1 == `RH) ? wRH : wSourceDataRAM1);

   //Muxes Read after Write
   assign wSourceData0 = ((wSourceAddr0 == wLastDestination) && (wLastWriteEnable == 1'b1)) ? wLastResult : wSourceDataMul0;
   assign wSourceData1 = ((wSourceAddr1 == wLastDestination) && (wLastWriteEnable == 1'b1)) ? wLastResult : wSourceDataMul1;
   

   
   //--------------------------------------------------------------------
   // ALU Operation Logic
   //--------------------------------------------------------------------   
   
   always @ ( * )
      begin
	 case (wOperation)
	    
	    //-------------------------------------
	    `NOP:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
	       end
	    //-------------------------------------
	    `ADD:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b1;
		  rResult      <= wSourceData1 + wSourceData0;
	       end
	    //-------------------------------------
	    `SUB:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b1;
		  rResult      <= wSourceData1 - wSourceData0;
	       end
	    //-------------------------------------
	    `SMUL:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= wSourceData1 * wSourceData0;
	       end
	    //-------------------------------------
	    `STO:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b1;
		  rBranchTaken <= 1'b0;
		  rResult      <= wImmediateValue;
	       end
	    //-------------------------------------
	    `BLE:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  if (wSourceData1 <= wSourceData0 )
		     rBranchTaken <= 1'b1;
		  else
		     rBranchTaken <= 1'b0;
		  
	       end
	    //-------------------------------------	
	    `JMP, `CALL, `RET:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b1;
	       end
	    //-------------------------------------	
	    `LED:
	       begin
		  rFFLedEN     <= 1'b1;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b0;
	       end
	    //-------------------------------------
	    `LCD_CHAR:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b0;
	       end	
	    //-------------------------------------
	    `LCD_CMD:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b0;
	       end	
	    //-------------------------------------
	    `LCD_ENB:
	       begin
		  rFFLedEN     <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b0;
	       end	
	    
	    //-------------------------------------
	    `SHL:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b1;
		  rResult <= wSourceData1 << wSourceData0;
	       end
	    //-------------------------------------
	    `VGA:
	       begin
		  rFFLedEN     <= 1'b0;
		  rBranchTaken <= 1'b0;
		  rWriteEnable <= 1'b0;
		  rResult      <= 1'b0;
	       end
	    
	    //-------------------------------------
	    default:
	       begin
		  rFFLedEN     <= 1'b1;
		  rWriteEnable <= 1'b0;
		  rResult      <= 0;
		  rBranchTaken <= 1'b0;
	       end	
	    //-------------------------------------	
	 endcase	
      end


endmodule
