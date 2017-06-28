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


	
	always @(*) begin

	if ( (P00 = 0) || (P11 = 0) || (P22 = 0))begin
		//No HAGO NADA GANADO

	end

	else begin

		if( (P00 == X)   && (P01 == X ) && (P02 == X) ) begin
			// VERDE	

		end

			
		if else( (P10 == X ) && (P11 == X) && (P12 == X)  ) begin
			//VERDE
		end		
	

		if else( (P20 == X ) &&  (P21 == X)  && (P22 == X)) begin
			//VERDE
		end		
	
		if else( (P00 == X) && (P10 == X)  &&  (P20 == X) ) begin
		// VERDE
		end


		if else( (P01 == X) && (P11 == X)  && (P21 == X) ) begin
		// VERDE
		end
	

		if else( (P02 ==X) && (P12 ==X)  && (P22 == X ) ) begin
		// VERDE
			if
		end


		if else( (P00 == X) && (P11 == X)  && (P22 == X) ) begin
		// VERDE
		end

		if else( (P20 == X) && (P11 == X) &&  (P21 == X)000 ) begin
		// VERDE
		end
	end	
end
