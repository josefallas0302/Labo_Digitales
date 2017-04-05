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


module IMUL_Sum # (parameter SIZE = 4)
(
	input wire [SIZE-1:0] a,
	input wire [SIZE-1:0] b,

	output wire [((SIZE*2)-1:0] oResult,
);
	wire [SIZE-1:0] Sum0 [SIZE-1:0];
	wire [SIZE-1:0] Sum1 [SIZE-1:0];

	wire [SIZE-2:0] ResultA [2:0];
	wire Carryout [2:0]


	assign Sum0[0] = { 1'b0 ,  a[3]&b[0], a[2]&b[0], a[0]&b[1]};
	assign Sum1[0] = { a[3]&b[1],  a[2]&b[1], a[1]&b[1], a[1]&b[0]};

	assign Sum0[1] = { Carryout [0] ,  ResultA[0][3], ResultA[0][2], ResultA[0][1]};
	assign Sum1[1] = { a[3]&b[2],  a[2]&b[2], a[1]&b[2], a[0]&b[2]};

	assign Sum0[2] = { Carryout [1] ,  ResultA[1][3], ResultA[1][2], ResultA[1][1]};
	assign Sum1[2] = { a[3]&b[3],  a[2]&b[3], a[1]&b[3], a[0]&b[3]};


	ADDER # (4) SUM1 (.A(Sum0[0]), .B(Sum1[0]), .Result(ResultA[0]), .CarryO(Carryout[0]))
	ADDER # (4) SUM2 (.A(Sum0[1]), .B(Sum1[1]), .Result(ResultA[1]), .CarryO(Carryout[1]))
	ADDER # (4) SUM3 (.A(Sum0[2]), .B(Sum1[2]), .Result(ResultA[2]), .CarryO(Carryout[2]))




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


