
`timescale 1ns / 1ps
`include "Defintions.v"


module MiniAlu
(
 input wire Clock,
 input wire Reset,
 output wire [7:0] oLed,
 output wire [7:0] oLCD 

);

wire [15:0]  wIP,wIP_temp, wIP_noRET;
reg         rWriteEnable,rBranchTaken;
wire [27:0] wInstruction;
wire [3:0]  wOperation;
reg signed [31:0]   rResult;
wire [7:0]  wSourceAddr0,wSourceAddr1,wDestination;
wire signed [15:0] wSourceDataRAM0,wSourceDataRAM1;
wire signed [15:0] wSourceData0,wSourceData1;
wire [15:0] wIPInitialValue,wImmediateValue;

ROM InstructionRom 
(
	.iAddress(     wIP          ),
	.oInstruction( wInstruction )
);


   
RAM_DUAL_READ_PORT DataRam
(
	.Clock(         Clock        ),
	.iWriteEnable(  rWriteEnable ),
	.iReadAddress0( wInstruction[7:0] ),
	.iReadAddress1( wInstruction[15:8] ),
	.iWriteAddress( wDestination ),
	.iDataIn(       rResult[15:0]      ),
	.oDataOut1(     wSourceDataRAM1 ),
	.oDataOut0(     wSourceDataRAM0 )
);


wire [15:0] wRetIP;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_RET_IP
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   
assign wIPInitialValue = (Reset) ? 8'b0 : (wOperation == `RET) ? wRetIP : wDestination;
UPCOUNTER_POSEDGE IP
(
.Clock(   Clock                ), 
.Reset(   Reset | rBranchTaken ),
.Initial( wIPInitialValue + 16'b1 ),
.Enable(  1'b1                 ),
.Q(       wIP_temp             )
);
assign wIP_noRET = (rBranchTaken) ? wIPInitialValue : wIP_temp;
assign wIP = (wOperation == `RET) ? wRetIP : wIP_noRET;   

   
FFD_POSEDGE_SYNCRONOUS_RESET # ( 4 ) FFD1 // 8
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[27:24]),
	.Q(wOperation)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD2
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[7:0]),
	.Q(wSourceAddr0)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD3
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[15:8]),
	.Q(wSourceAddr1)
);

FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FFD4
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wInstruction[23:16]),
	.Q(wDestination)
);

wire [15:0] wLastResult;

FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FF_Result
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(rResult),
	.Q(wLastResult)
);
wire [7:0] wLastDestination;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_Destination
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(1'b1),
	.D(wDestination),
	.Q(wLastDestination)
);


wire [15:0] wRL;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRL
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable((wOperation == `SMUL)),
	.D(rResult[15:0]),
	.Q(wRL)
);

wire [15:0] wRH;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRH
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable((wOperation == `SMUL)),
	.D(rResult[31:16]),
	.Q(wRH)
);


wire [5:0] wLCD_Info;
wire wRS, wRW;
assign wRS = wOperation == `LCD_CHAR;
assign wRW = 1'b0;
   FFD_POSEDGE_SYNCRONOUS_RESET # ( 6 ) FF_LCD_DATA
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `LCD_CHAR || wOperation == `LCD_CMD),
       .D({wRW,wRS,wSourceData1[7:4]}),
       .Q(wLCD_Info)
       );
		 


wire  wLCD_ENB;

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 1 ) FF_LCD_ENB
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `LCD_ENB),
       .D(~wLCD_ENB), //iLED_RS, iLED_E
       .Q(wLCD_ENB) //oLED_RS, oLED_E
       );
		 
// oLCD DATA ARRAY
assign oLCD = {1'b1,wLCD_Info[5],wLCD_Info[4],wLCD_ENB,wLCD_Info[3:0]};

reg rFFLedEN;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( rFFLedEN ),
	.D( wSourceData1[7:0]),
	.Q( oLed    )
);





//Mux selección registros RL, RH
assign wImmediateValue = {wSourceAddr1,wSourceAddr0};
wire [15:0] wSourceDataMul0, wSourceDataMul1;

assign wSourceDataMul0 = (wSourceAddr0 == `RL) ? wRL : (( wSourceAddr0 == `RH) ? wRH : wSourceDataRAM0);
assign wSourceDataMul1 = (wSourceAddr1 == `RL) ? wRL : (( wSourceAddr1 == `RH) ? wRH : wSourceDataRAM1);

assign wSourceData0 = ( wSourceAddr0 == wLastDestination) ? wLastResult : wSourceDataMul0;
assign wSourceData1 = ( wSourceAddr1 == wLastDestination) ? wLastResult : wSourceDataMul1;



//assign wSourceData0 = (wSourceAddr0 == `RL) ? wRL : (( wSourceAddr0 == `RH) ? wRH : (( wSourceAddr0 == wLastDestination) ? wLastResult : wSourceDataRAM0));
//assign wSourceData1 = (wSourceAddr1 == `RL) ? wRL : (( wSourceAddr1 == `RH) ? wRH : (( wSourceAddr1 == wLastDestination) ? wLastResult : wSourceDataRAM1));


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
//	   $display("%d ns SMUL r: %d * %d = %d, RL = %d, RH = %d , oLED = %b", $time, wSourceData1, wSourceData0, rResult, wRL, wRH, oLed);
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
	end
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
