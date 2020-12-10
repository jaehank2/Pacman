//-------------------------------------------------------------------------
//    Ball.sv                                                            --
//    Viral Mehta                                                        --
//    Spring 2005                                                        --
//                                                                       --
//    Modified by Stephen Kempf 03-01-2006                               --
//                              03-12-2007                               --
//    Translated by Joe Meng    07-07-2013                               --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 298 Lab 7                                         --
//    UIUC ECE Department                                                --
//-------------------------------------------------------------------------


module  ball (input Reset, frame_clk,
	      input [7:0] keycode,
              output [9:0]  BallX, BallY, BallS,
	      output [9:0] x_motion, y_motion,
	      output [1:0] flag);
    
    logic [9:0] Ball_X_Pos, Ball_X_Motion, Ball_Y_Pos, Ball_Y_Motion, Ball_Size,
	 Cur_X_Motion, Cur_Y_Motion, Cur_X_Pos, Cur_Y_Pos;
	 logic col0,col1,col2,col3, up, down, left, right;
	 logic[7:0]prev_key;
	 
	 //x1A = up, x16 = down, x04 = left, x07 = right 
	 
    parameter [9:0] Ball_X_Center=320;  // Center position on the X axis
    parameter [9:0] Ball_Y_Center=350;  // Center position on the Y axis
    parameter [9:0] Ball_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Ball_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Ball_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Ball_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Ball_X_Step=1;      // Step size on the X axis
    parameter [9:0] Ball_Y_Step=1;      // Step size on the Y axis
	 assign Ball_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign BallX = Ball_X_Pos;
	 assign BallY = Ball_Y_Pos;
	 assign BallS = Ball_Size;
	 assign x_motion = Ball_X_Motion;
	 assign y_motion = Ball_Y_Motion;
	
	
		 always_ff @ (posedge frame_clk or posedge Reset)
    begin
		  if (Reset)
        begin
            prev_key<=8'h00;
        end
        else 
        begin
            if((keycode==8'h1A)||(keycode==8'h16)||(keycode==8'h04)||(keycode==8'h07)) begin  prev_key<=keycode;  end  
        end
    end
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Ball
        if (Reset)  // Asynchronous Reset
        begin 
            Ball_Y_Motion <= 10'd0; //Ball_Y_Step;
				Ball_X_Motion <= 10'd0; //Ball_X_Step;
				Ball_Y_Pos <= Ball_Y_Center;
				Ball_X_Pos <= Ball_X_Center;
				prev_key <= 8'h00;
        end
           
        else 
        begin
				prev_key <= keycode;
				Ball_X_Motion <= Ball_X_Motion;
				Ball_Y_Motion <= Ball_Y_Motion;
				Ball_X_Pos <= Cur_X_Pos;
				Ball_Y_Pos <= Cur_Y_Pos;
		 		case (keycode)
					8'h04 : begin

								Ball_X_Motion <= -1;//A
								Ball_Y_Motion<= 0;
								flag <= 2'b00;
							  end
					        
					8'h07 : begin
								
					        Ball_X_Motion <= 1;//D
							  Ball_Y_Motion <= 0;
							  flag <= 2'b01;
							  end

							  
					8'h16 : begin

					        Ball_Y_Motion <= 1;//S
							  Ball_X_Motion <= 0;
							  flag <= 2'b10;
							 end
							  
					8'h1A : begin
					        Ball_Y_Motion <= -1;//W
							  Ball_X_Motion <= 0;
							  flag <= 2'b11;
							 end	  
					default: ;
 			   endcase 
				end
			end	
				
				always_comb
				begin
					Cur_X_Motion = Ball_X_Motion;
					Cur_Y_Motion = Ball_Y_Motion;
							
				unique case(flag)
//				//down
				2'b10: begin 
						if((Ball_X_Motion == 1'b1 && col0 == 1'b1)||(Ball_X_Motion>10'd10 && col1 ==1'b1)||(Ball_Y_Motion==1'b1 && col2 == 1'b1)||(Ball_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(down == 1'b1 || (((Ball_X_Pos+1'b1)/4)%2) == 1'b0 || ((Ball_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ball_X_Motion;
								Cur_Y_Motion = Ball_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Ball_Y_Step;
								end
							if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max)  // Ball is at the bottom edge, BOUNCE!
								begin
								Cur_Y_Pos <= Ball_Y_Max - Ball_Size;
								Cur_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
								end 
						  end					
//				//up
				2'b11: begin
							if((Ball_X_Motion == 1'b1 && col0 == 1'b1)||(Ball_X_Motion>10'd10 && col1 ==1'b1)||(Ball_Y_Motion==1'b1 && col2 == 1'b1)||(Ball_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(up == 1'b1 || (((Ball_X_Pos+1'b1)/4)%2) == 1'b0 || ((Ball_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ball_X_Motion;
								Cur_Y_Motion = Ball_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Ball_Y_Step)+1'b1);
								end
							 if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min )  // Ball is at the top edge, BOUNCE!
								begin
								Cur_Y_Pos <= Ball_Y_Min + Ball_Size;
								Cur_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
			//					  Ball_Y_Motion <= Ball_Y_Step;
								end 
						  end
//				//right
				2'b01: begin 
							if((Ball_X_Motion == 1'b1 && col0 == 1'b1)||(Ball_X_Motion>10'd10 && col1 ==1'b1)||(Ball_Y_Motion==1'b1 && col2 == 1'b1)||(Ball_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(right == 1'b1 || (((Ball_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Ball_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ball_X_Motion;
								Cur_Y_Motion = Ball_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Ball_X_Step;
								end
							 if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max && flag == 2'b01)  // Ball is at the Right edge, BOUNCE!
								begin
								Cur_X_Pos <= Ball_X_Max - Ball_Size;
								Cur_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
								end 
						  end
				//left
				2'b00: begin 
							if((Ball_X_Motion == 1'b1 && col0 == 1'b1)||(Ball_X_Motion>10'd10 && col1 ==1'b1)||(Ball_Y_Motion==1'b1 && col2 == 1'b1)||(Ball_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(left == 1'b1 || (((Ball_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Ball_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Ball_X_Motion;
								Cur_Y_Motion = Ball_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Ball_X_Step)+1'b1);
								end
							 if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min && flag == 2'b00)  // Ball is at the Left edge, BOUNCE!
								begin 
								Cur_X_Pos <= Ball_X_Min + Ball_Size;
								Cur_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
								end
						  end
				default: begin
							if((Ball_X_Motion==1'b1 && col0 ==1'b1)||(Ball_X_Motion >10'd10 && col1 == 1'b1)||(Ball_Y_Motion ==1'b1 && col2==1'b1)||(Ball_Y_Motion>10'd10 && col3==1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							else if(prev_key==8'h1A && up == 1'b0 && (((Ball_X_Pos+1'b1)/4)%2)==1'b1 && ((Ball_X_Pos+1'b1)%4)==1'b0) 
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Ball_Y_Step)+1'b1);
								end
							else if(prev_key==8'h16 && down == 1'b0 && (((Ball_X_Pos+1'b1)/4)%2) == 1'b1 && ((Ball_X_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Ball_Y_Step;
								end
							else if(prev_key==8'h04 && left == 1'b0 && (((Ball_Y_Pos+1'b1)/4)%2)==1'b1 && ((Ball_Y_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Ball_X_Step)+1'b1);
								end
							else if(prev_key==8'h07 && right == 1'b0 && (((Ball_Y_Pos+1'b1)/4)%2)==1'b1 && ((Ball_Y_Pos+1'b1)%4)==1'b0)
								begin
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Ball_X_Step;
								end
							else
								begin 
								Cur_X_Motion = Ball_X_Motion;
								Cur_Y_Motion = Ball_Y_Motion;
								end
							end
					endcase
						Cur_X_Pos <= (Ball_X_Pos + Cur_X_Motion);
						Cur_Y_Pos <= (Ball_Y_Pos + Cur_Y_Motion);
					end

//					end
//					end
//				//down
//				 if ( (Ball_Y_Pos + Ball_Size) >= Ball_Y_Max && flag == 2'b10 )  // Ball is at the bottom edge, BOUNCE!
//					begin
//					Ball_Y_Pos <= Ball_Y_Max - Ball_Size;
//					Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
//					end 
////					  Ball_Y_Motion <= (~ (Ball_Y_Step) + 1'b1);  // 2's complement.
//					//up
//				 else if ( (Ball_Y_Pos - Ball_Size) <= Ball_Y_Min && flag == 2'b11 )  // Ball is at the top edge, BOUNCE!
//					begin
//					Ball_Y_Pos <= Ball_Y_Min + Ball_Size;
//					Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
////					  Ball_Y_Motion <= Ball_Y_Step;
//					end 
//					//right
//				  else if ( (Ball_X_Pos + Ball_Size) >= Ball_X_Max && flag == 2'b01)  // Ball is at the Right edge, BOUNCE!
//					begin
//					Ball_X_Pos <= Ball_X_Max - Ball_Size;
//					Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
//					end 
////					  Ball_X_Motion <= (~ (Ball_X_Step) + 1'b1);  // 2's complement.
//					  //left
//				 else if ( (Ball_X_Pos - Ball_Size) <= Ball_X_Min && flag == 2'b00)  // Ball is at the Left edge, BOUNCE!
//					begin 
//					Ball_X_Pos <= Ball_X_Min + Ball_Size;
//					Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);
//					end
////					  Ball_X_Motion <= Ball_X_Step;
////				 else 
////					begin
////					  Ball_Y_Motion <= Ball_Y_Motion;  // Ball is somewhere in the middle, don't bounce, just keep moving
////					end 
//				 else 
//					begin
//					 Ball_Y_Pos <= (Ball_Y_Pos + Ball_Y_Motion);  // Update ball position
//					 Ball_X_Pos <= (Ball_X_Pos + Ball_X_Motion);
//					end 
				
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Ball_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Ball_Y_pos.  Will the new value of Ball_Y_Motion be used,
          or the old?  How will this impact behavior of the ball during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
//			
//       
//    assign BallX = Ball_X_Pos;
//   
//    assign BallY = Ball_Y_Pos;
//   
//    assign BallS = Ball_Size;

		
		wall_bounds decider0(.DrawX(Ball_X_Pos+Ball_Size+Ball_X_Motion),.DrawY(Ball_Y_Pos),.wall_en(col0));
		wall_bounds decider1(.DrawX(Ball_X_Pos-Ball_Size),.DrawY(Ball_Y_Pos),.wall_en(col1));
		wall_bounds decider2(.DrawX(Ball_X_Pos),.DrawY(Ball_Y_Pos+Ball_Size+Ball_Y_Motion),.wall_en(col2));
		wall_bounds decider3(.DrawX(Ball_X_Pos),.DrawY(Ball_Y_Pos-Ball_Size),.wall_en(col3));
		wall_bounds decider4(.DrawX(Ball_X_Pos),.DrawY(Ball_Y_Pos-Ball_Size),.wall_en(up));
		wall_bounds decider5(.DrawX(Ball_X_Pos),.DrawY(Ball_Y_Pos+1'b1+BallS),.wall_en(down));
		wall_bounds decider6(.DrawX(Ball_X_Pos-Ball_Size),.DrawY(Ball_Y_Pos),.wall_en(left));
		wall_bounds decider7(.DrawX(Ball_X_Pos+1'b1+Ball_Size),.DrawY(Ball_Y_Pos),.wall_en(right));
		 

endmodule

