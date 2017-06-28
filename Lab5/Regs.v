module Registros

( 
	input reg [3:0] oCurrentPositionX,
	input reg [3:0] oCurrentPositionY

);

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P00
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P01
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P02
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P10
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );

   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P11
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P12
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P20
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P21
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );


   FFD_POSEDGE_SYNCRONOUS_RESET # ( 3 ) FF_P22
      (
       .Clock(Clock),
       .Reset(Reset),
       .Enable(wOperation == `CALL),
       .D(wIP_temp), 
       .Q(wRetIP)
       );

























	/*(
	input wire flagReset,
	input wire Clock,
	input wire [7:0] iData,
	input wire iKeyboardFlag,
	output reg oKeyboardReset,
	output reg [3:0] oCurrentPositionX,
	output reg [3:0] oCurrentPositionY,
	input reg flagReset,
	input reg flagSym	
	);

	reg [1:0] P00;
	reg [1:0] P01;
	reg [1:0] P02;
	reg [1:0] P10;
	reg [1:0] P11;
	reg [1:0] P12;
	reg [1:0] P20;
	reg [1:0] P21;
	reg [1:0] P22;



	*/
