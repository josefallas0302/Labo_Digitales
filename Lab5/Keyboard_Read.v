module KEYBOARD_READ (
		      input wire Clock,
		      input wire Reset,
		      input wire iKbClock,
		      input wire iKbData,
		      output reg [7:0] oReadValue,
		      output wire oKbFlag
		      );
   
   reg [3:0] 	    rCounter;
   reg [7:0] 	    rCurrData;
   reg [7:0] 	    rDataPre;
   reg 		    rSeqFlag;

   reg [7:0] 	    rClockFilter;
   reg 		    rKbFilteredClock;
   

   assign oKbFlag = rSeqFlag && (rCurrData == 8'hf0);
   
   initial begin
      rCounter    = 4'h1;
      rCurrData   = 8'hf0;
      rDataPre    = 8'hf0;
      rSeqFlag    = 1'b0;
      oReadValue  = 8'hf0;
   end


   always @(posedge Clock)
      begin
	 rClockFilter <= {iKbClock, rClockFilter[7:1]};
	 if (rClockFilter == 8'b11111111)
	    rKbFilteredClock <= 1;
	 else if (rClockFilter == 8'b00000000) 
	    rKbFilteredClock <= 0;
      end

   
   always @(negedge rKbFilteredClock or posedge Reset) begin
      if (Reset) begin
	 rCounter <= 4'h1;
      end
      else begin
	 case (rCounter)
	    1:;
	    2: 	rCurrData[0] <= iKbData;
	    3: 	rCurrData[1] <= iKbData;	
	    4: 	rCurrData[2] <= iKbData;
	    5: 	rCurrData[3] <= iKbData;	
	    6: 	rCurrData[4] <= iKbData;
	    7: 	rCurrData[5] <= iKbData;	
	    8: 	rCurrData[6] <= iKbData;
	    9: 	rCurrData[7] <= iKbData;
	    10:	rSeqFlag     <= 1'b1;
	    11: rSeqFlag     <= 1'b0;
	 endcase

	 if (rCounter <= 10)
	    rCounter <= rCounter + 4'h1;
	 else 
	    rCounter <= 4'h1;
      end
   end
   
   always @(posedge rSeqFlag) begin
      if (rCurrData == 8'hf0) 
	 oReadValue <= rDataPre;
      else
	 rDataPre <= rCurrData;
   end
   
endmodule 
