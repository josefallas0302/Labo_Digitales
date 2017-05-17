`timescale 1ns / 1ps
`ifndef DEFINTIONS_V
 `define DEFINTIONS_V
 `default_nettype none	
 `define NOP    4'd0
 `define LED    4'd2
 `define BLE    4'd3
 `define STO    4'd4
 `define ADD    4'd5
 `define JMP    4'd6
 `define SUB    4'd7
 `define SMUL   4'd8
 `define LCD_CHAR 4'd9
 `define LCD_CMD 4'd10
 `define LCD_ENB 4'd11
 `define SHL 4'd12
 `define CALL 4'd13
 `define RET 4'd14
   
 `define H 8'h48
 `define O 8'h4F
 `define L 8'h4C
 `define A 8'h41
 `define SPC 8'hA0
 `define M 8'h4D
 `define U 8'h55
 `define N 8'h4E
 `define D 8'h44


   //RAM registers
 `define R0 8'd0
 `define R1 8'd1
 `define R2 8'd2
 `define R3 8'd3
 `define R4 8'd4
 `define R5 8'd5
 `define R6 8'd6
 `define R7 8'd7
 `define R8 8'd8
 `define R9 8'd9

   //Multiplication registers
 `define RL 8'd10
 `define RH 8'd11

`endif

