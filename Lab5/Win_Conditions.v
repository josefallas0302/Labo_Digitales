module win_condition

   (
    input wire 	     P00,
    input wire 	     P01,
    input wire 	     P02,
    input wire 	     P10,
    input wire 	     P11,
    input wire 	     P12,
    input wire 	     P20,
    input wire 	     P21,
    input wire 	     P22,

	output	reg		oWinO,
	output	reg		oWinX
    );


	reg R0 = 1'b0;
	reg R1 = 1'b0;
	reg R2 = 1'b0;
	reg C0 = 1'b0;
	reg C1 = 1'b0;
	reg C2 = 1'b0;
	reg D0 = 1'b0;
	reg D1 = 1'b0;
	reg D2 = 1'b0;

	
	always @(*) begin

		if( (P00 = X ) && (P01 = X ) && (P02 = X ) ) begin
			// VERDE	

		end

		if( (P00 = O ) && (P01 = O ) && (P02 = O ) ) begin
			//VERDE

		end
			
		if( (P10 = X ) && (P11 = X ) && (P12 = X ) ) begin
			//VERDE
		end		
	

	end
