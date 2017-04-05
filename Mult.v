`timescale 1ns / 1ps
//------------------------------------------------
module ADDER # (parameter SIZE= 4)
(
	input wire [SIZE-1:0] A,
	input wire [SIZE-1:0] B,
	output wire [SIZE-1:0] Result,
	output wire CarryO
);

assign {CarryO, Result} = A + B;

endmodule
//------------------------------------------------
module MULT_MUX # (parameter ASIZE= 4) 
(
	input wire [ASIZE-1:0] A,
	input wire [1:0] B,
	output reg [ASIZE+1:0] Result
);

always @ (*)
begin
case (B)
	2'b00: Result = 0;
	2'b01: Result = A;
	2'b10: Result = {A, 1'b0};
	2'b11: Result = {A, 1'b0} + A;
endcase
end

endmodule
//----------------------------------------------------
module IMUL2_LOGIC4
(
	input wire [3:0] A,
	input wire [3:0] B,
	output wire [7:0] Result
);
	wire [5:0] wRMux0, wRMux1;
	wire [5:0] wSumA, wSumB, wRSum;
	wire wCarry;
	
	MULT_MUX #(4) mux0 (.A(A), .B(B[1:0]), .Result(wRMux0));
   
	MULT_MUX #(4) mux1 (.A(A), .B(B[3:2]), .Result(wRMux1));

	assign wSumA = {2'b0,wRMux0[5:2]};
	assign wSumB = wRMux1;
	assign Result = {wRSum,wRMux0[1:0]};
	
   ADDER #(6) add0 
	(
		.A(wSumA), 
		.B(wSumB), 
		.Result(wRSum), 
		.CarryO(wCarry)
	);

endmodule


/*

wire [15:0] wCarry [15:0];
wire [15:0] sum0 [15:0];

wire [15:0] wRes [15:0];


genvar C_Row, C_C;

generate
	
	for (C_Row = 0; C_Row < Size; C_Row = C_Row + 1)
	begin:Mul_Row
		assign wCarry [C_Row] [0] = 0 ;
		Sumador # (16) Sumadorbit(
			.isum0(sum0[]),
			.isum1(sum0[C_Row),

			.oResult(wRes[C_Row]),
			.oCarry(wCarry[C_Row])
		);	

		assign wCarry[C_Row][0] = 0;l
	
	end
endgenerate

*/


