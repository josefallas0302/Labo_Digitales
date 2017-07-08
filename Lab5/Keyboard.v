module KEYBOARD_READ (reset, clock, clk_kb, data_kb, out_reg, out_flag);

   // Assigning ports as in/out
   input reset;
   input clock;
   input clk_kb;
   input data_kb;
   output reg [7:0] out_reg;
   output wire 	    out_flag;
   
   // Instantaiting and Intializing Registers
   reg [3:0] 	    counter;
   reg [7:0] 	    data_curr;
   reg [7:0] 	    data_pre;
   reg 		    flag;

   reg [7:0] 	    filter;
   reg 		    clk_kb_filtered;
   

   assign out_flag = flag && (data_curr == 8'hf0);
   
   initial
      begin
	 counter = 4'h1;
	 data_curr = 8'hf0;
	 data_pre = 8'hf0;
	 flag = 1'b0;
	 out_reg = 8'hf0;
      end


   always @(posedge clock)
      begin
	 filter <= {clk_kb, filter[7:1]};
	 if (filter==8'b1111_1111) clk_kb_filtered <= 1;
	 else if (filter==8'b0000_0000) clk_kb_filtered <= 0;
      end

   
// FSM
   always @(negedge clk_kb_filtered or posedge reset)
      begin
	 if (reset)
	    begin
	       counter <= 4'h1;
	    end
	 else
	    begin
	       case (counter)
		  1:;
		  2: 	data_curr[0] <= data_kb;
		  3: 	data_curr[1] <= data_kb;	
		  4: 	data_curr[2] <= data_kb;
		  5: 	data_curr[3] <= data_kb;	
		  6: 	data_curr[4] <= data_kb;
		  7: 	data_curr[5] <= data_kb;	
		  8: 	data_curr[6] <= data_kb;
		  9: 	data_curr[7] <= data_kb;
		  10:	flag 	     <= 1'b1;
		  11:   flag 	     <= 1'b0;
	       endcase

	       if (counter <= 10)
		  counter <= counter + 4'h1;
	       else 
		  counter <= 4'h1;
	    end
      end
   
   always @(posedge flag)
      begin
	 if (data_curr == 8'hf0) 
	    out_reg <= data_pre;
	 else
	    data_pre <= data_curr;
      end
   
endmodule 
