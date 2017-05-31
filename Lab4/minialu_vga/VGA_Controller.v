`timescale 1ns / 1ps
`include "Defintions.v"

`define STATE_RESET 0
`define STATE_DISPLAY 1 
`define STATE_PULSE 2
`define STATE_FRONT_PORCH 3
`define STATE_BACK_PORCH 4


module VGA_CONTROLLER # (parameter X_WIDTH=8, 
			 parameter Y_WIDTH=8,
			 parameter X_SIZE=256, 
			 parameter Y_SIZE=256
			 )
   (
    input wire 		      Clock,
    input wire 		      Reset,
    output wire [X_WIDTH-1:0] oVideoMemCol,
    output wire [Y_WIDTH-1:0] oVideoMemRow,
    output wire 	      oVGAHorizontalSync,
    output wire 	      oVGAVerticalSync,
    output wire 	      oDisplay
    );

   

   VGA_CONTROL_HS_FSM #(X_WIDTH,
			Y_WIDTH, 
			X_SIZE, 
			Y_SIZE) vga_hs_fsm
      (
       .Clock(Clock),
       .Reset(Reset),
       .oVideoMemCol(oVideoMemCol),
       .oVideoMemRow(oVideoMemRow),
       .oVGAHorizontalSync(oVGAHorizontalSync),
       .oDisplay(oDisplay)
       );
   
   VGA_CONTROL_VS_FSM vga_vs_fsm
      (
       .Clock(Clock),
       .Reset(Reset),
       .oVGAVerticalSync(oVGAVerticalSync)
       );

endmodule



module VGA_CONTROL_HS_FSM # (parameter X_WIDTH=8, 
			     parameter Y_WIDTH=8,
			     parameter X_SIZE=256, 
			     parameter Y_SIZE=256
			     )
   (
    input wire 		     Clock,
    input wire 		     Reset,
    output reg [X_WIDTH-1:0] oVideoMemCol,
    output reg [Y_WIDTH-1:0] oVideoMemRow,
    output reg 		     oVGAHorizontalSync,
    output reg 		     oDisplay
    );

   reg [3:0] 		     rCurrentState, rNextState;
   
   reg [15:0] 		     rHSyncCount;
   reg 			     rHSyncCountReset;
   
   reg [X_WIDTH-1:0] 	     rNextVideoMemCol;
   reg [Y_WIDTH-1:0] 	     rNextVideoMemRow;

   reg 			     rCountEnable;
   
   always @(posedge Clock)
      begin
	 if (Reset)
	    begin
	       rCurrentState <= `STATE_RESET;
	       rHSyncCount   <= 16'b0;
	       rCountEnable  <= 1'b1;
	    end
	 else
	    begin
	       if (rHSyncCountReset)
		  rHSyncCount <= 16'b0;
	       else
		  begin
		     if (rCountEnable) 
			rHSyncCount <= rHSyncCount + 16'b1;
		  end
		     
	       rCountEnable  <= ~rCountEnable;
	       rCurrentState <= rNextState;
	       oVideoMemCol  <= rNextVideoMemCol;
	       oVideoMemRow  <= rNextVideoMemRow;
	    end
      end


   always @(*)
      begin
	 //Default values
	 oVGAHorizontalSync  = 1'b1;
	 rHSyncCountReset    = 1'b0;
	 oDisplay 	     = 1'b0;
	 
	 //Keep row and col value by default
	 rNextVideoMemCol    = oVideoMemCol; 
	 rNextVideoMemRow    = oVideoMemRow;

	 
	 case (rCurrentState)
	    //-----------------------------------
	    `STATE_RESET:
	       begin
		  rNextVideoMemCol  = 0;		  
		  rNextVideoMemRow  = 0;
		  rNextState 	    = `STATE_PULSE;
	       end
	    //-----------------------------------
	    `STATE_PULSE:
	       begin
		  oVGAHorizontalSync  = 1'b0;

		  if (rHSyncCount < 16'd95 || rCountEnable == 1'b0)
		     rNextState  = `STATE_PULSE;
		  else
		     begin
			rNextState 	  = `STATE_BACK_PORCH;
			rHSyncCountReset  = 1'b1;
		     end
	       end
	    //-----------------------------------
	    `STATE_BACK_PORCH:
	       begin
		  if (rHSyncCount < 16'd47 || rCountEnable == 1'b0)
		     rNextState  = `STATE_BACK_PORCH;
		  else
		     begin
			rHSyncCountReset  = 1'b1;
			rNextState 	  = `STATE_DISPLAY;
		     end
	       end
	    //-----------------------------------
	    `STATE_DISPLAY:
	       begin
		  oDisplay  = 1'b1;
		  if(rCountEnable) rNextVideoMemCol = oVideoMemCol + 1;
		  
		  if (rHSyncCount < X_SIZE-1 || rCountEnable == 1'b0)
		     rNextState  = `STATE_DISPLAY;
		  else
		     begin
			if (rCountEnable)
			   begin
			      if (oVideoMemRow < Y_SIZE-1)
				 rNextVideoMemRow  = oVideoMemRow + 1;
			      else
				 rNextVideoMemRow  = 0;
			   end

			rNextVideoMemCol  = 0;
			rHSyncCountReset  = 1'b1;
			rNextState 	  = `STATE_FRONT_PORCH;
		     end
	       end
	    //-----------------------------------
	    `STATE_FRONT_PORCH:
	       begin
		  if (rHSyncCount < 16'd47 || rCountEnable == 1'b0)
		     rNextState  = `STATE_FRONT_PORCH;
		  else
		     begin
			rHSyncCountReset  = 1'b1;
			rNextState 	  = `STATE_PULSE;
		     end
	       end
	 endcase
	 
      end

endmodule


module VGA_CONTROL_VS_FSM
   (
    input wire 		     Clock,
    input wire 		     Reset,
    output reg 		     oVGAVerticalSync
    );

   reg [3:0] 		     rCurrentState, rNextState;

   reg [31:0] 		     rVSyncCount;
   reg 			     rVSyncCountReset;

   reg 			     rCountEnable;
   
   always @(posedge Clock)
      begin
	 if (Reset)
	    begin
	       rCurrentState <= `STATE_RESET;
	       rVSyncCount   <= 32'b0;
	       rCountEnable  <= 1'b1;
	    end
	 else
	    begin
	       if (rVSyncCountReset)
		  rVSyncCount <= 32'b0;
	       else
		  begin
		     if (rCountEnable) rVSyncCount <= rVSyncCount + 16'b1;
		  end

	       rCountEnable  <= ~rCountEnable;
	       rCurrentState <= rNextState;
	    end
      end
   
   always @(*) 
     begin
      //Default values
	oVGAVerticalSync  = 1'b1;
	rVSyncCountReset  = 1'b0;
        
	
	case (rCurrentState)
	   //-----------------------------------
	   `STATE_RESET:
	      begin
		 rNextState  = `STATE_DISPLAY; //`STATE_PULSE;
	      end
	   //-----------------------------------
	   `STATE_PULSE:
	      begin
		 oVGAVerticalSync  = 1'b0;

		 if (rVSyncCount < 32'd1600 || rCountEnable == 1'b0)
		    rNextState  = `STATE_PULSE;
		 else
		    begin
		       rVSyncCountReset = 1'b1;
		       rNextState  = `STATE_BACK_PORCH;
		    end
	      end
	   //-----------------------------------
	   `STATE_BACK_PORCH:
	      begin
		 if (rVSyncCount < 32'd24800 || rCountEnable == 1'b0)
		    rNextState  = `STATE_BACK_PORCH;
		 else
		    begin
		       rVSyncCountReset = 1'b1;
		       rNextState  = `STATE_DISPLAY;
		    end
	      end
	   //-----------------------------------
	   `STATE_DISPLAY:
	      begin
		 if (rVSyncCount < `VSYNC_DISP_T || rCountEnable == 1'b0)
		    rNextState  = `STATE_DISPLAY;
		 else
		    begin
		       rVSyncCountReset  = 1'b1;
		       rNextState 	 = `STATE_FRONT_PORCH;
		    end
	      end
	   //-----------------------------------
	   `STATE_FRONT_PORCH:
	      begin
		 if (rVSyncCount < 32'd8800 || rCountEnable == 1'b0)
		    rNextState  = `STATE_FRONT_PORCH;
		 else
		    begin
		       rVSyncCountReset = 1'b1;
		       rNextState  = `STATE_PULSE;
		    end
	      end
	endcase
	
     end
   

endmodule
