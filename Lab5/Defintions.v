`timescale 1ns / 1ps
`ifndef DEFINTIONS_V
 `define DEFINTIONS_V
 `default_nettype none	


//----------------------------------------------------------------
 //TicTacToe Symbols
 `define EMPTY 2'b00
 `define X 2'b01
 `define O 2'b10  

//----------------------------------------------------------------
  //VGA Colors
 `define COLOR_BLACK 8'd0
 `define COLOR_BLUE 8'd1 
 `define COLOR_GREEN 8'd2
 `define COLOR_CYAN 8'd3
 `define COLOR_RED 8'd4
 `define COLOR_MAGENTA 8'd5
 `define COLOR_YELLOW 8'd6
 `define COLOR_WHITE 8'd7

 //VGA Parameters
 `define VGA_COL_WIDTH 10
 `define VGA_ROW_WIDTH 10
 `define VGA_X_RES 640
 `define VGA_Y_RES 480
    
 `define HSYNC_FP_T 16
 `define HSYNC_BP_T 48
 `define HSYNC_PULSE_T 96
 `define HSYNC_START `VGA_X_RES+`HSYNC_FP_T
 `define HSYNC_END `HSYNC_START+`HSYNC_PULSE_T
 `define H_TOTAL_T `HSYNC_END+`HSYNC_BP_T

 `define VSYNC_FP_T 10
 `define VSYNC_BP_T 29
 `define VSYNC_PULSE_T 2
 `define VSYNC_START `VGA_Y_RES+`VSYNC_FP_T
 `define VSYNC_END `VSYNC_START+`VSYNC_PULSE_T
 `define V_TOTAL_T `VSYNC_END+`VSYNC_BP_T
    
 //TicTacToe Frame Parameters
 `define FRAME_TOTAL_DIM 450
 `define FRAME_BLOCK_DIM `FRAME_TOTAL_DIM/3
 
 `define FRAME_START_X (`VGA_X_RES-`FRAME_TOTAL_DIM)/2
 `define FRAME_END_X (`VGA_X_RES+`FRAME_TOTAL_DIM)/2
 `define FRAME_START_Y (`VGA_Y_RES-`FRAME_TOTAL_DIM)/2
 `define FRAME_END_Y (`VGA_Y_RES+`FRAME_TOTAL_DIM)/2

 `define STRIPE_WIDTH 6

 `define FRAME_MARKED_START `STRIPE_WIDTH/2
 `define FRAME_MARKED_END `FRAME_BLOCK_DIM-`STRIPE_WIDTH/2

 `define FRAME_STRIPE_START `FRAME_BLOCK_DIM-`STRIPE_WIDTH/2
 `define FRAME_STRIPE_END `FRAME_BLOCK_DIM+`STRIPE_WIDTH/2

 `define NUM_BLOCKS_DIM 3
    
  //Keyboard Chars
 `define A 8'h1C
 `define S 8'h1B
 `define W 8'h1D
 `define D 8'h23
 `define R 8'h2D
 `define ENTER 8'h5A
    
`endif
