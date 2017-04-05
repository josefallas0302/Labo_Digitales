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
	
	MULT_MUX #(4) mux0 
	(
		.A(A), 
		.B(B[1:0]), 
		.Result(wRMux0)
	);
   
	MULT_MUX #(4) mux1 
	(
		.A(A), 
		.B(B[3:2]), 
		.Result(wRMux1)
	);

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


module IMUL1_LOGIC4
(	
	input wire [3:0] A,
	input wire [3:0] B,
	output wire [7:0] Result
);

	wire [3:0] wSumOp0 [2:0];
	wire [3:0] wSumOp1 [2:0];

	wire [3:0] wAddResult [2:0];
	wire wCarryOut [2:0];


	assign wSumOp0[0] = { 1'b0 ,  A[3]&B[0], A[2]&B[0], A[1]&B[0]};
	assign wSumOp1[0] = { A[3]&B[1],  A[2]&B[1], A[1]&B[1], A[0]&B[1]};

	assign wSumOp0[1] = { wCarryOut[0] ,  wAddResult[0][3:1]};
	assign wSumOp1[1] = { A[3]&B[2],  A[2]&B[2], A[1]&B[2], A[0]&B[2]};

	assign wSumOp0[2] = { wCarryOut[1] ,  wAddResult[1][3:1]};
	assign wSumOp1[2] = { A[3]&B[3],  A[2]&B[3], A[1]&B[3], A[0]&B[3]};


	ADDER # (4) SUM1 (.A(wSumOp0[0]), .B(wSumOp1[0]), .Result(wAddResult[0]), .CarryO(wCarryOut[0]));
	ADDER # (4) SUM2 (.A(wSumOp0[1]), .B(wSumOp1[1]), .Result(wAddResult[1]), .CarryO(wCarryOut[1]));
	ADDER # (4) SUM3 (.A(wSumOp0[2]), .B(wSumOp1[2]), .Result(wAddResult[2]), .CarryO(wCarryOut[2]));

	assign Result = {wCarryOut[2], wAddResult[2], wAddResult[1][0], wAddResult[0][0], A[0]&B[0]};

endmodule



module IMUL1_LOGIC #(parameter SIZE = 16)
(	
	input wire [SIZE-1:0] A,
	input wire [SIZE-1:0] B,
	output wire [(2*SIZE)-1:0] Result
);

wire [SIZE-1:0] wSumOp0 [SIZE-2:0];
wire [SIZE-1:0] wSumOp1 [SIZE-2:0];

wire [SIZE-1:0] wAddResult [SIZE-2:0];
wire [SIZE-2:0] wCarryOut;


//-----------------------------------------------
genvar i,j;

generate //Entradas del 1er sumador
	for (i = 0; i < SIZE-1; i = i + 1)
	begin: ANDMAT
		assign wSumOp0[0][i] = A[i+1] & B[0];
		assign wSumOp1[0][i] = A[i] & B[1];
	end
endgenerate

assign wSumOp0[0][SIZE-1] = 0;
assign wSumOp1[0][SIZE-1] = A[SIZE-1] & B[SIZE-1];

//-----------------------------------------------
generate
   //Primer operando demás contadores
	for (i = 1; i < SIZE-1; i = i + 1) 
	begin: WSUMOP0
		assign wSumOp0[i] = {wCarryOut[i-1], wAddResult[i-1][(SIZE-1):1]};
	end
	
	//Segundo operando demás contadores
	for (i = 1; i < SIZE-1; i = i + 1)
	begin: WSUMOP1I
		for (j = 0; j < SIZE; j = j + 1)
		begin: WSUMOP1J
			assign wSumOp1[i][j] = A[j] & B[i+1];
		end
	end
	
	//Instancias de los sumadores
	for (i = 0; i < SIZE-1; i = i + 1) 
	begin: ADD
		 ADDER #(SIZE) add 
		 (
			.A(wSumOp0[i]), 
			.B(wSumOp1[i]), 
			.Result(wAddResult[i]), 
			.CarryO(wCarryOut[i])
		 );
	end
		
	//Construcción del resultado
	assign Result[0] = A[0] & B[0]; 
	assign Result[2*(SIZE-1):(SIZE-1)] = wAddResult[SIZE-1];
	assign Result[(2*SIZE)-1] = wCarryOut[SIZE-1];
	
	for (i = 1; i < SIZE-1; i = i + 1) 
	begin: RESULT
		assign Result[i] = wAddResult[i-1][0];
	end
	
endgenerate
//-----------------------------------------------

endmodule


