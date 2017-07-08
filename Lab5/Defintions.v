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
 //LCD Chars
 // `define H 16'h0048
 // `define O 16'h004F
 // `define L 16'h004C
 // `define A 16'h0041
 // `define SPC 16'h00A0
 // `define M 16'h004D
 // `define U 16'h0055
 // `define N 16'h004E
 // `define D 16'h0044

  //VGA Colors
 `define COLOR_BLACK 8'd0
 `define COLOR_BLUE 8'd1 
 `define COLOR_GREEN 8'd2
 `define COLOR_CYAN 8'd3
 `define COLOR_RED 8'd4
 `define COLOR_MAGENTA 8'd5
 `define COLOR_YELLOW 8'd6
 `define COLOR_WHITE 8'd7

 //VGA parameters
 `define VGA_COL_WIDTH 10
 `define VGA_ROW_WIDTH 10
 `define VMEM_X_SIZE 400
 `define VMEM_Y_SIZE 240
 `define VGA_X_RES 640
 `define VGA_Y_RES 480
    
 `define HSYNC_BP_T 16'd47
 `define HSYNC_FP_T 16'd47
 `define HSYNC_DISP_T 16'd384000
 `define HSYNC_PULSE_T 16'd95

 `define VSYNC_BP_T 32'd23200
 `define VSYNC_FP_T 32'd8000
 `define VSYNC_DISP_T 32'd384000
 `define VSYNC_PULSE_T 32'd1600

    
  //Keyboard Chars
 `define A 8'h1C
 `define S 8'h1B
 `define W 8'h1D
 `define D 8'h23
 `define R 8'h2D
 `define ENTER 8'h5A
    
`endif
