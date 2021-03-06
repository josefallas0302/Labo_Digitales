// Module Name:   D:/Proyecto/RTL/Dev/MiniALU/TestBench.v
// Project Name:  MiniALU
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: MiniAlu
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module TestBench(
	output 		reg Reset,
	output 		reg Clock,
	output 	   reg [10:0] PS2_DATA,
	input    		wire [7:0]  oData
);

   // Inputs
	
   // Outputs
	//reg PS2_DATA;	
	//reg Clock;
	//reg Reset;
   
   // Instantiate the Unit Under Test (UUT)
   keyboard uut (
		.Clock(Clock), 
		.Reset(Reset), 
		.PS2_DATA(PS2_DATA),
		.oData(wData)
		);
   
   always
      begin
	 #25  Clock =  ! Clock;

      end

always
      begin
	 #17  PS2_DATA =  ! PS2_DATA;

      end

   initial begin
      // Initialize Inputs
      Clock = 0;
      Reset = 0;
		PS2_DATA = 0;

      // Wait 100 ns for global reset to finish
      #100;
      Reset = 1;
      #50
	   Reset = 0;
      
      // Add stimulus here

   end
   
endmodule

