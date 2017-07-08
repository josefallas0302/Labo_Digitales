`timescale 1ns / 1ps
`include "Defintions.v"


module MiniAlu
   (
    input wire 	      Clock,
    input wire 	      Reset,
    input wire 	      PS2_DATA,
    input wire 	      PS2_CLK,
    //output wire [7:0] oLed,
    //output wire [7:0] oLCD,
    output wire [4:0] oVGA
    );
   

   //--------------------------------------------------------------------
   // Keyboard
   //--------------------------------------------------------------------
   wire [7:0]	      wKeyboardData;
   wire 	      wKeyboardFlag;
   wire [0:17] 	      wSymVector;

   wire 	      wWinFlag;
   wire [14:0] 	      wWinSeqPos;

   wire [3:0] 	      wMarkedBlockPosX, wMarkedBlockPosY;


   
   keyboard kb
      (
       .reset(Reset),
       .clock(Clock),
       .clk_kb(PS2_CLK),
       .data_kb(PS2_DATA),
       .out_reg(wKeyboardData),
       .out_flag(wKeyboardFlag)
       );

   Detector dtr
      (
       .Clock(Clock),
       .Reset(Reset),
       .iData(wKeyboardData),
       .iKeyboardFlag(wKeyboardFlag),
       .iWinFlag(wWinFlag),
       .oCurrentPosX(wMarkedBlockPosX),
       .oCurrentPosY(wMarkedBlockPosY),
       .oSymVector(wSymVector)
       );
   
   
   //--------------------------------------------------------------------
   // TicTacToe Win Logic
   //--------------------------------------------------------------------
   
   WIN_LOGIC Win_Logic (
			.iSymVector(wSymVector),
			.oWinFlag(wWinFlag),
			.oWinSeqPos(wWinSeqPos)
			);

   

   //--------------------------------------------------------------------
   // VGA Display Logic
   //--------------------------------------------------------------------
   
   wire 	      oVGA_HS, oVGA_VS;
   wire [2:0] 	      wColor;
   
   
   VGA_CHECKBOARD_PIXEL_GEN #(`VMEM_X_WIDTH,
   			      `VMEM_Y_WIDTH,
   			      `VGA_X_RES,
   			      `VGA_Y_RES,
   			      150, 
   			      150) VGA_Control
      (
       .Clock(Clock),
       .Reset(Reset),
       .iMarkedBlockPosX(wMarkedBlockPosX),
       .iMarkedBlockPosY(wMarkedBlockPosY),
       .iSymVector(wSymVector),
       .iWinSeqPos(wWinSeqPos),
       .iWinFlag(wWinFlag),
       .oVGAColor(wColor),
       .oVGAHorizontalSync(oVGA_HS),
       .oVGAVerticalSync(oVGA_VS)
       );

   assign oVGA = {wColor, oVGA_HS, oVGA_VS};


   
endmodule
