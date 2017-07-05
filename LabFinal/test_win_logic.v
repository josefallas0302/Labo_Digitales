

wire [7:0] win_line;

wire [1:0] win_symb;

wire [5:0] ldata [7:0];

wire [1:0] m [2:0][2:0];

function  isWin;
   input [5:0] data;  
   begin
      isWin = (data[1:0]==data[3:2]) && (data[3:2]==data[5:4]);
   end
endfunction


assign ldata[0] = {m[0][0], m[0][1], m[0][2]}; //h0
assign ldata[1] = {m[1][0], m[1][1], m[1][2]}; //h1
assign ldata[2] = {m[2][0], m[2][1], m[2][2]}; //h2
assign ldata[3] = {m[0][0], m[1][0], m[2][0]}; //v0
assign ldata[4] = {m[0][1], m[1][1], m[2][1]}; //v1
assign ldata[5] = {m[0][2], m[1][2], m[2][2]}; //v2
assign ldata[6] = {m[0][0], m[1][1], m[2][1]}; //d0
assign ldata[7] = {m[0][2], m[1][1], m[2][0]}; //d1


genvar i;
generate
   for (i = 0; i < 8; i = i + 1)
      begin: ISWIN
	 assign lwin[i]  = isWin(ldata[i]);
      end
endgenerate




always @(*) begin
   if (lwin[0])      win_seq = ldata[0];
   else if (lwin[1]) win_seq  = ldata[1];
   else if (lwin[2]) win_seq  = ldata[2];
   else if (lwin[3]) win_seq  = ldata[3];
   else if (lwin[4]) win_seq  = ldata[4];
   else if (lwin[5]) win_seq  = ldata[5];
   else if (lwin[6]) win_seq  = ldata[6];
   else if (lwin[7]) win_seq  = ldata[7];
   else win_seq = 6'b00;
end
