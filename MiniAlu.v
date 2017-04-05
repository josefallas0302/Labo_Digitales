
`timescale 1ns / 1ps
`include "Defintions.v"


module MiniAlu
(
 input wire Clock,
 input wire Reset,
 output wire [7:0] oLed

 
);

wire [15:0]  wIP,wIP_temp;
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
	.oDataOut0(     wSourceDataRAM0 ),
	.oDataOut1(     wSourceDataRAM1 )
);

assign wIPInitialValue = (Reset) ? 8'b0 : wDestination;
UPCOUNTER_POSEDGE IP
(
.Clock(   Clock                ), 
.Reset(   Reset | rBranchTaken ),
.Initial( wIPInitialValue + 16'b1 ), // +1
.Enable(  1'b1                 ),
.Q(       wIP_temp             )
);
assign wIP = (rBranchTaken) ? wIPInitialValue : wIP_temp;

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

wire [15:0] wRL;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRL
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(wOperation == `SMUL /*|| 'IMUL16)*/ ),
	.D(rResult[15:0]),
	.Q(wRL)
);

wire [15:0] wRH;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 16 ) FFRH
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable(wOperation == `SMUL /*|| 'IMUL16)*/ ), //IMUL de 16?
	.D(rResult[31:16]),
	.Q(wRH)
);


reg rFFLedEN;
FFD_POSEDGE_SYNCRONOUS_RESET # ( 8 ) FF_LEDS
(
	.Clock(Clock),
	.Reset(Reset),
	.Enable( rFFLedEN ),
	.D( wSourceData1[7:0]),
	.Q( oLed    )
);

wire [7:0] wResult4_IMUL1;
IMUL1_LOGIC4 imul1_4
(
	.A(wSourceData0[3:0]),
	.B(wSourceData1[3:0]),
	.Result(wResult4_IMUL1)
);

/*wire [31:0] wResult16_IMUL1;
IMUL1_LOGIC # ( 16 ) imul1_16
(	
	.A(wSourceData0[15:0]),
	.B(wSourceData1[15:0]),
	.Result(wResult16_IMUL1)
);

wire [7:0] wResult4_IMUL2;
IMUL2_LOGIC4 imul2_4
(
	.A(wSourceData0[3:0]),
	.B(wSourceData1[3:0]),
	.Result(wResult4_IMUL2)
);

*/


assign wImmediateValue = {wSourceAddr1,wSourceAddr0};
assign wSourceData0 = (wSourceAddr0 == `RL) ? wRL : (( wSourceAddr0 == `RH) ? wRH : wSourceDataRAM0);
assign wSourceData1 = (wSourceAddr1 == `RL) ? wRL : (( wSourceAddr1 == `RH) ? wRH : wSourceDataRAM1);

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
	   $display("%d ns SMUL r: %d * %d = %d, RL = %d, RH = %d , oLED = %b", $time, wSourceData1, wSourceData0, rResult, wRL, wRH, oLed);
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= wSourceData1 * wSourceData0;
	end
	//-------------------------------------
	`IMUL1_4:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wResult4_IMUL1;
	end

	/*//-------------------------------------
	`IMUL1_16:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b0;
		rResult      <= wResult16_IMUL1;
	end

	//-------------------------------------
	`IMUL2_4:
	begin
		rFFLedEN     <= 1'b0;
		rBranchTaken <= 1'b0;
		rWriteEnable <= 1'b1;
		rResult      <= wResult4_IMUL2;
	end
	//-------------------------------------*/
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
	`JMP:
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
