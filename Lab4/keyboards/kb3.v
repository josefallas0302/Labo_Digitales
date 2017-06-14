module keyboard(keyboard_clk, keyboard_data, clock50, reset, scan_code);
input keyboard_clk;
input keyboard_data;
input clock50; // 50 Mhz system clock
input reset;

output [7:0] scan_code;

reg ready_set;
reg [7:0] scan_code;
reg scan_ready;
reg read_char;
reg clock; // 25 Mhz internal clock

reg [3:0] incnt;
reg [8:0] shiftin;

reg [7:0] filter;
reg keyboard_clk_filtered;

// scan_ready is set to 1 when scan_code is available.
// user should set read to 1 and then to 0 to clear scan_ready


// divide-by-two 50MHz to 25MHz
always @(posedge clock50)
	clock <= ~clock;



// This process filters the raw clock signal coming from the keyboard 
// using an eight-bit shift register and two AND gates

always @(posedge clock)
begin
   filter <= {keyboard_clk, filter[7:1]};
   if (filter==8'b1111_1111) keyboard_clk_filtered <= 1;
   else if (filter==8'b0000_0000) keyboard_clk_filtered <= 0;
end


// This process reads in serial data coming from the terminal

always @(posedge keyboard_clk_filtered)
begin
   if (reset==1)
   begin
      incnt <= 4'b0000;
      read_char <= 0;
   end
   else if (keyboard_data==0 && read_char==0)
   begin
	read_char <= 1;
	ready_set <= 0;
   end
   else
   begin
	   // shift in next 8 data bits to assemble a scan code	
	   if (read_char == 1)
   		begin
      		if (incnt < 9) 
      		begin
				incnt <= incnt + 1'b1;
				shiftin = { keyboard_data, shiftin[8:1]};
				ready_set <= 0;
			end
		else
			begin
				incnt <= 0;
				scan_code <= shiftin[7:0];
				read_char <= 0;
				ready_set <= 1;
			end
		end
	end
end
reg pressed_key;
always @(*) begin
	if (ready_set) begin
		
		pressed_key = scan_code;
	end
	else begin
		pressed_key = pressed_key;
	end
end

endmodule