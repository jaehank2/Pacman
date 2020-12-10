
module  Ghost (input Reset, frame_clk,
              output [9:0]  GhostX, GhostY, GhostS,
	      output [9:0] x_motion, y_motion,
	       output [1:0] gflag);	// module for blue ghost
    
    logic [9:0] Ghost_X_Pos, Ghost_X_Motion, Ghost_Y_Pos, Ghost_Y_Motion, Ghost_Size,
	 Cur_X_Motion, Cur_Y_Motion, Cur_X_Pos, Cur_Y_Pos;
    logic col0,col1,col2,col3, up, down, left, right;
    logic[7:0]prev_key;
    logic[7:0]keycode; 
	 
    //x1A = up, x16 = down, x04 = left, x07 = right 
	 
    parameter [9:0] Ghost_X_Center=465;  // Center position on X
    parameter [9:0] Ghost_Y_Center=64;  // Center position on Y
    parameter [9:0] Ghost_X_Min=0;       // Leftmost point on X
    parameter [9:0] Ghost_X_Max=639;     // Rightmost point on X
    parameter [9:0] Ghost_Y_Min=0;       // Topmost point on Y
    parameter [9:0] Ghost_Y_Max=479;     // Bottommost point on Y
    parameter [9:0] Ghost_X_Step=1;      // Step size on X
    parameter [9:0] Ghost_Y_Step=1;      // Step size on Y
    assign Ghost_Size = 16;
    assign GhostX = Ghost_X_Pos;
    assign GhostY = Ghost_Y_Pos;
    assign GhostS = Ghost_Size;
    assign x_motion = Ghost_X_Motion;
    assign y_motion = Ghost_Y_Motion;

   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ghost
        if (Reset)  // Asynchronous Reset
        begin 
            	Ghost_Y_Motion <= 10'd0; //Ghost_Y_Step;
		Ghost_X_Motion <= 10'd0; //Ghost_X_Step;
		Ghost_Y_Pos <= Ghost_Y_Center;
		Ghost_X_Pos <= Ghost_X_Center;
		prev_key <= 8'h00;
        end
	else 
	begin
		prev_key <= keycode;
		Ghost_X_Motion <= Ghost_X_Motion;
		Ghost_Y_Motion <= Ghost_Y_Motion;
		Ghost_X_Pos <= Cur_X_Pos;
		Ghost_Y_Pos <= Cur_Y_Pos;
		case (keycode)
		8'h04 : begin
			Ghost_X_Motion <= -1;
			Ghost_Y_Motion<= 0;
			gflag <= 2'b00;
		end
									  
		8'h07 : begin							
			Ghost_X_Motion <= 1;
			Ghost_Y_Motion <= 0;
			gflag <= 2'b01;
		end

									  
		8'h16 : begin
			Ghost_Y_Motion <= 1;
			Ghost_X_Motion <= 0;
			gflag <= 2'b10;
		end
									  
		8'h1A : begin
			Ghost_Y_Motion <= -1;
			Ghost_X_Motion <= 0;
			gflag <= 2'b11;
		end	  
		default: ;
		endcase 
	end
    end	
				
	always_ff @ (posedge frame_clk )
	begin
		  if(Ghost_X_Pos >10'd462 && Ghost_X_Pos<10'd467 && Ghost_Y_Pos>10'd61 && Ghost_Y_Pos<10'd68) //last dot first row
		  begin 
				keycode <= 8'h04;
		  end 
		  else if(GhostX >10'd334 && GhostX<10'd339 && GhostY>10'd61 && GhostY<10'd68) //6th dot first
		  begin 
				keycode <= 8'h16;
        	  end
		  else if(Ghost_X_Pos >10'd334 && Ghost_X_Pos<10'd339 && Ghost_Y_Pos>10'd125 && Ghost_Y_Pos<10'd132) //6th dot third
		  begin 
				keycode <= 8'h04;
        	  end  
		  else if(Ghost_X_Pos >10'd238 && Ghost_X_Pos<10'd243 && Ghost_Y_Pos>10'd125 && Ghost_Y_Pos<10'd132) //3rd dot third
		  begin 
				keycode <= 8'h16;
        	  end  
		  else if(Ghost_X_Pos >10'd238 && Ghost_X_Pos<10'd243 && Ghost_Y_Pos>10'd349 && Ghost_Y_Pos<10'd356) //3rd dot tenth
		  begin 
				keycode <= 8'h07;
        	  end  
		  else if(Ghost_X_Pos >10'd396 && Ghost_X_Pos<10'd401 && Ghost_Y_Pos>10'd349 && Ghost_Y_Pos<10'd356) //8th dot tenth
		  begin 
				keycode <= 8'h1A;
        	  end  
		  else if(Ghost_X_Pos >10'd396 && Ghost_X_Pos<10'd401 && Ghost_Y_Pos>10'd189 && Ghost_Y_Pos<10'd196) //8th dot fifth
		  begin 
				keycode <= 8'h07;
        	  end  
		  else if(Ghost_X_Pos >10'd462 && Ghost_X_Pos<10'd467 && Ghost_Y_Pos>10'd189 && Ghost_Y_Pos<10'd196) //last dot fifth
		  begin 
				keycode <= 8'h1A;
		  end
		  else 
		  begin 
				keycode <= 8'h00;
		  end 
	end
		
		
				always_comb
				begin
					Cur_X_Motion = Ghost_X_Motion;
					Cur_Y_Motion = Ghost_Y_Motion;
							
				unique case(gflag)
				//down
				2'b10: begin 
						if((Ghost_X_Motion == 1'b1 && col0 == 1'b1)||(Ghost_X_Motion>10'd10 && col1 ==1'b1)||(Ghost_Y_Motion==1'b1 && col2 == 1'b1)||(Ghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(down == 1'b1 || (((Ghost_X_Pos+1'b1)/4)%2) == 1'b0 || ((Ghost_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ghost_X_Motion;
								Cur_Y_Motion = Ghost_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Ghost_Y_Step;
								end
							if ( (Ghost_Y_Pos + Ghost_Size) >= Ghost_Y_Max)  // Ghost is at the bottom edge, BOUNCE!
								begin
								Cur_Y_Pos <= Ghost_Y_Max - Ghost_Size;
								Cur_X_Pos <= (Ghost_X_Pos + Ghost_X_Motion);
								end 
						  end					
//				//up
				2'b11: begin
							if((Ghost_X_Motion == 1'b1 && col0 == 1'b1)||(Ghost_X_Motion>10'd10 && col1 ==1'b1)||(Ghost_Y_Motion==1'b1 && col2 == 1'b1)||(Ghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(up == 1'b1 || (((Ghost_X_Pos+1'b1)/4)%2) == 1'b0 || ((Ghost_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ghost_X_Motion;
								Cur_Y_Motion = Ghost_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Ghost_Y_Step)+1'b1);
								end
							 if ( (Ghost_Y_Pos - Ghost_Size) <= Ghost_Y_Min )  // Ghost is at the top edge, BOUNCE!
								begin
								Cur_Y_Pos <= Ghost_Y_Min + Ghost_Size;
								Cur_X_Pos <= (Ghost_X_Pos + Ghost_X_Motion);
								// Ghost_Y_Motion <= Ghost_Y_Step;
								end 
						  end
				//right
				2'b01: begin 
							if((Ghost_X_Motion == 1'b1 && col0 == 1'b1)||(Ghost_X_Motion>10'd10 && col1 ==1'b1)||(Ghost_Y_Motion==1'b1 && col2 == 1'b1)||(Ghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(right == 1'b1 || (((Ghost_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Ghost_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ghost_X_Motion;
								Cur_Y_Motion = Ghost_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Ghost_X_Step;
								end
							 if ( (Ghost_X_Pos + Ghost_Size) >= Ghost_X_Max && gflag == 2'b01)  // Ghost is at the Right edge, BOUNCE!
								begin
								Cur_X_Pos <= Ghost_X_Max - Ghost_Size;
								Cur_Y_Pos <= (Ghost_Y_Pos + Ghost_Y_Motion);
								end 
						  end
				//left
				2'b00: begin 
							if((Ghost_X_Motion == 1'b1 && col0 == 1'b1)||(Ghost_X_Motion>10'd10 && col1 ==1'b1)||(Ghost_Y_Motion==1'b1 && col2 == 1'b1)||(Ghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(left == 1'b1 || (((Ghost_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Ghost_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ghost_X_Motion;
								Cur_Y_Motion = Ghost_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Ghost_X_Step)+1'b1);
								end
							 if ( (Ghost_X_Pos - Ghost_Size) <= Ghost_X_Min && gflag == 2'b00)  // Ghost is at the Left edge, BOUNCE!
								begin 
								Cur_X_Pos <= Ghost_X_Min + Ghost_Size;
								Cur_Y_Pos <= (Ghost_Y_Pos + Ghost_Y_Motion);
								end
						  end
				default: begin
							if((Ghost_X_Motion==1'b1 && col0 ==1'b1)||(Ghost_X_Motion >10'd10 && col1 == 1'b1)||(Ghost_Y_Motion ==1'b1 && col2==1'b1)||(Ghost_Y_Motion>10'd10 && col3==1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							else if(prev_key==8'h1A && up == 1'b0 && (((Ghost_X_Pos+1'b1)/4)%2)==1'b1 && ((Ghost_X_Pos+1'b1)%4)==1'b0) 
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Ghost_Y_Step)+1'b1);
								end
							else if(prev_key==8'h16 && down == 1'b0 && (((Ghost_X_Pos+1'b1)/4)%2) == 1'b1 && ((Ghost_X_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Ghost_Y_Step;
								end
							else if(prev_key==8'h04 && left == 1'b0 && (((Ghost_Y_Pos+1'b1)/4)%2)==1'b1 && ((Ghost_Y_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Ghost_X_Step)+1'b1);
								end
							else if(prev_key==8'h07 && right == 1'b0 && (((Ghost_Y_Pos+1'b1)/4)%2)==1'b1 && ((Ghost_Y_Pos+1'b1)%4)==1'b0)
								begin
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Ghost_X_Step;
								end
							else
								begin 
								Cur_X_Motion = Ghost_X_Motion;
								Cur_Y_Motion = Ghost_Y_Motion;
								end
							end
					endcase
						Cur_X_Pos <= (Ghost_X_Pos + Cur_X_Motion);
						Cur_Y_Pos <= (Ghost_Y_Pos + Cur_Y_Motion);
					end


		
		wall_bounds decider0(.DrawX(Ghost_X_Pos+Ghost_Size+Ghost_X_Motion),.DrawY(Ghost_Y_Pos),.wall_en(col0));
		wall_bounds decider1(.DrawX(Ghost_X_Pos-Ghost_Size),.DrawY(Ghost_Y_Pos),.wall_en(col1));
		wall_bounds decider2(.DrawX(Ghost_X_Pos),.DrawY(Ghost_Y_Pos+Ghost_Size+Ghost_Y_Motion),.wall_en(col2));
		wall_bounds decider3(.DrawX(Ghost_X_Pos),.DrawY(Ghost_Y_Pos-Ghost_Size),.wall_en(col3));
		wall_bounds decider4(.DrawX(Ghost_X_Pos),.DrawY(Ghost_Y_Pos-Ghost_Size),.wall_en(up));
		wall_bounds decider5(.DrawX(Ghost_X_Pos),.DrawY(Ghost_Y_Pos+1'b1+GhostS),.wall_en(down));
		wall_bounds decider6(.DrawX(Ghost_X_Pos-Ghost_Size),.DrawY(Ghost_Y_Pos),.wall_en(left));
		wall_bounds decider7(.DrawX(Ghost_X_Pos+1'b1+Ghost_Size),.DrawY(Ghost_Y_Pos),.wall_en(right));
		 

endmodule
