
module  Oghost (input Reset, frame_clk,
              output [9:0]  OghostX, OghostY, OghostS,
	      output [9:0] Ox_motion, Oy_motion,
	      output [1:0] oflag);
    
    logic [9:0] Oghost_X_Pos, Oghost_X_Motion, Oghost_Y_Pos, Oghost_Y_Motion, Oghost_Size,
	 Cur_X_Motion, Cur_Y_Motion, Cur_X_Pos, Cur_Y_Pos;
	 logic col0,col1,col2,col3, up, down, left, right;
	 logic[7:0]prev_key;
	 logic[7:0]keycode; 
	 
	 //x1A = up, x16 = down, x04 = left, x07 = right 
	 
    parameter [9:0] Oghost_X_Center=176;  // Center position on the X axis
    parameter [9:0] Oghost_Y_Center=64;  // Center position on the Y axis
    parameter [9:0] Oghost_X_Min=0;       // Leftmost point on the X axis
    parameter [9:0] Oghost_X_Max=639;     // Rightmost point on the X axis
    parameter [9:0] Oghost_Y_Min=0;       // Topmost point on the Y axis
    parameter [9:0] Oghost_Y_Max=479;     // Bottommost point on the Y axis
    parameter [9:0] Oghost_X_Step=1;      // Step size on the X axis
    parameter [9:0] Oghost_Y_Step=1;      // Step size on the Y axis
	 assign Oghost_Size = 16;  // assigns the value 4 as a 10-digit binary number, ie "0000000100"
	 assign OghostX = Oghost_X_Pos;
	 assign OghostY = Oghost_Y_Pos;
	 assign OghostS = Oghost_Size;
	 assign x_motion = Oghost_X_Motion;
	 assign y_motion = Oghost_Y_Motion;
//	 assign keycode = 8'h00;
	
	
//		 always_ff @ (posedge frame_clk or posedge Reset)
//    begin
//		  if (Reset)
//        begin
//            prev_key<=8'h00;
//        end
//        else 
//        begin
//            if((keycode==8'h1A)||(keycode==8'h16)||(keycode==8'h04)||(keycode==8'h07)) begin  prev_key<=keycode;  end  
//        end
//    end
   
    always_ff @ (posedge Reset or posedge frame_clk )
    begin: Move_Oghost
        if (Reset)  // Asynchronous Reset
        begin 
            Oghost_Y_Motion <= 10'd0; //Oghost_Y_Step;
				Oghost_X_Motion <= 10'd0; //Oghost_X_Step;
				Oghost_Y_Pos <= Oghost_Y_Center;
				Oghost_X_Pos <= Oghost_X_Center;
				prev_key <= 8'h00;
        end
			else 
				  begin
						prev_key <= keycode;
						Oghost_X_Motion <= Oghost_X_Motion;
						Oghost_Y_Motion <= Oghost_Y_Motion;
						Oghost_X_Pos <= Cur_X_Pos;
						Oghost_Y_Pos <= Cur_Y_Pos;
						case (keycode)
							8'h04 : begin

										Oghost_X_Motion <= -1;//A
										Oghost_Y_Motion<= 0;
										oflag <= 2'b00;
									  end
									  
							8'h07 : begin
										
									  Oghost_X_Motion <= 1;//D
									  Oghost_Y_Motion <= 0;
									  oflag <= 2'b01;
									  end

									  
							8'h16 : begin

									  Oghost_Y_Motion <= 1;//S
									  Oghost_X_Motion <= 0;
									  oflag <= 2'b10;
									 end
									  
							8'h1A : begin
									  Oghost_Y_Motion <= -1;//W
									  Oghost_X_Motion <= 0;
									  oflag <= 2'b11;
									 end	  
							default: ;
						endcase 
						end
					end	
				
	always_ff @ (posedge frame_clk ) //mmovement of ghost, 16 = down, 07 = right, 04 = left, 1A = up.
	begin
		  if(Oghost_X_Pos >10'd174 && Oghost_X_Pos<10'd179 && Oghost_Y_Pos>10'd61 && Oghost_Y_Pos<10'd68) //top left
		  begin 
				keycode <= 8'h16; //down
		  end 
		  else if(OghostX >10'd174 && OghostX<10'd179 && OghostY>10'd189 && OghostY<10'd196) //5th 1st dot
		  begin 
				keycode <= 8'h07; //right
        end 
		  else if(Oghost_X_Pos >10'd205 && Oghost_X_Pos<10'd210 && Oghost_Y_Pos>10'd189 && Oghost_Y_Pos<10'd196) //5th 2nd dot
		  begin 
				keycode <= 8'h16; //down
        end  
		  else if(Oghost_X_Pos >10'd205 && Oghost_X_Pos<10'd210 && Oghost_Y_Pos>10'd221 && Oghost_Y_Pos<10'd228) //6th 2nd dot
		  begin 
				keycode <= 8'h04; //left
        end  
		  else if(Oghost_X_Pos >10'd174 && Oghost_X_Pos<10'd179 && Oghost_Y_Pos>10'd221 && Oghost_Y_Pos<10'd228) //6th 1st dot
		  begin 
				keycode <= 8'h16; //down
        end  
		  else if(Oghost_X_Pos >10'd174 && Oghost_X_Pos<10'd179 && Oghost_Y_Pos>10'd253 && Oghost_Y_Pos<10'd260) //7th 1st dot
		  begin 
				keycode <= 8'h07; //right
        end  
		  else if(Oghost_X_Pos >10'd238 && Oghost_X_Pos<10'd243 && Oghost_Y_Pos>10'd253 && Oghost_Y_Pos<10'd260) //7th 3rd dot
		  begin 
				keycode <= 8'h1A; //up
        end  
		  else if(Oghost_X_Pos >10'd238 && Oghost_X_Pos<10'd243 && Oghost_Y_Pos>10'd61 && Oghost_Y_Pos<10'd68) //1st 3rd dot
		  begin 
				keycode <= 8'h07; //right
        end  
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd61 && Oghost_Y_Pos<10'd68) //1st 5th dot
		  begin 
				keycode <= 8'h16; 
        end  
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd125 && Oghost_Y_Pos<10'd132) //3rd 5th dot
		  begin 
				keycode <= 8'h04; 
        end  
		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd125 && Oghost_Y_Pos<10'd132) //3rd 4th dot
		  begin 
				keycode <= 8'h16;  //down
        end  
		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd156 && Oghost_Y_Pos<10'd163) //4th 4th dot
		  begin 
				keycode <= 8'h07;  //right
        end 
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd156 && Oghost_Y_Pos<10'd163) //4th 5th dot
		  begin 
				keycode <= 8'h16; 
        end  
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd189 && Oghost_Y_Pos<10'd196) //5th 5th dot
		  begin 
				keycode <= 8'h04; 
        end  
		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd189 && Oghost_Y_Pos<10'd196) //5th 4th dot
		  begin 
				keycode <= 8'h16; 
        end  
		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd317 && Oghost_Y_Pos<10'd324) //9th 4th dot
		  begin 
				keycode <= 8'h07; 
        end 
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd317 && Oghost_Y_Pos<10'd324) //9th 5th dot
		  begin 
				keycode <= 8'h16; 
        end   
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd349 && Oghost_Y_Pos<10'd356) //10th 5th dot
		  begin 
				keycode <= 8'h04; 
        end 
		  else if(Oghost_X_Pos >10'd238 && Oghost_X_Pos<10'd243 && Oghost_Y_Pos>10'd349 && Oghost_Y_Pos<10'd356) //10th 3rd dot
		  begin 
				keycode <= 8'h16; 
        end   
		  else if(Oghost_X_Pos >10'd238 && Oghost_X_Pos<10'd243 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 3rd dot
		  begin 
				keycode <= 8'h04; 
        end 
		  else if(Oghost_X_Pos >10'd175 && Oghost_X_Pos<10'd179 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 1st dot
		  begin 
				keycode <= 8'h16; 
        end 
		  else if(Oghost_X_Pos >10'd175 && Oghost_X_Pos<10'd179 && Oghost_Y_Pos>10'd413 && Oghost_Y_Pos<10'd420) //12th 1st dot
		  begin 
				keycode <= 8'h07; 
        end
//		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd413 && Oghost_Y_Pos<10'd420) //12th 5th dot
//		  begin 
//				keycode <= 8'h1A; 
//        end 
//		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 5th dot
//		  begin 
//				keycode <= 8'h04; 
//        end 
//		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 4th dot
//		  begin 
//				keycode <= 8'h1A; 
//        end 
//		  else if(Oghost_X_Pos >10'd270 && Oghost_X_Pos<10'd275 && Oghost_Y_Pos>10'd349 && Oghost_Y_Pos<10'd356) //10th 4th dot
//		  begin 
//				keycode <= 8'h07; 
//        end     
//		  else if(Oghost_X_Pos >10'd364 && Oghost_X_Pos<10'd369 && Oghost_Y_Pos>10'd349 && Oghost_Y_Pos<10'd356) //10th 7th dot
//		  begin 
//				keycode <= 8'h16; 
//        end     
//		  else if(Oghost_X_Pos >10'd364 && Oghost_X_Pos<10'd369 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 7th dot
//		  begin 
//				keycode <= 8'h04; 
//        end  
//		  else if(Oghost_X_Pos >10'd335 && Oghost_X_Pos<10'd340 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 6th dot
//		  begin 
//				keycode <= 8'h16; 
//        end 
//		  else if(Oghost_X_Pos >10'd335 && Oghost_X_Pos<10'd340 && Oghost_Y_Pos>10'd413 && Oghost_Y_Pos<10'd420) //11th 6th dot
//		  begin 
//				keycode <= 8'h07; 
//        end 	
		  else if(Oghost_X_Pos >10'd462 && Oghost_X_Pos<10'd467 && Oghost_Y_Pos>10'd413 && Oghost_Y_Pos<10'd420) //12th last dot
		  begin 
				keycode <= 8'h1A; 
        end 	
		  else if(Oghost_X_Pos >10'd462 && Oghost_X_Pos<10'd467 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th last dot
		  begin 
				keycode <= 8'h04; 
        end   
		  else if(Oghost_X_Pos >10'd396 && Oghost_X_Pos<10'd401 && Oghost_Y_Pos>10'd381 && Oghost_Y_Pos<10'd388) //11th 8th dot
		  begin 
				keycode <= 8'h1A; 
        end   
		  else if(Oghost_X_Pos >10'd396 && Oghost_X_Pos<10'd401 && Oghost_Y_Pos>10'd125 && Oghost_Y_Pos<10'd132) //3rd 8th dot
		  begin 
				keycode <= 8'h04; 
        end   
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd125 && Oghost_Y_Pos<10'd132) //3rd 5th dot
		  begin 
				keycode <= 8'h1A; 
        end   
		  else if(Oghost_X_Pos >10'd302 && Oghost_X_Pos<10'd307 && Oghost_Y_Pos>10'd61 && Oghost_Y_Pos<10'd68) //1st 5th dot
		  begin 
				keycode <= 8'h04; 
        end   
		  else 
		  begin 
				keycode <= 8'h00;
		  end 
	end
		
		
				always_comb
				begin
					Cur_X_Motion = Oghost_X_Motion;
					Cur_Y_Motion = Oghost_Y_Motion;
							
				unique case(oflag)
//				//down
				2'b10: begin 
						if((Oghost_X_Motion == 1'b1 && col0 == 1'b1)||(Oghost_X_Motion>10'd10 && col1 ==1'b1)||(Oghost_Y_Motion==1'b1 && col2 == 1'b1)||(Oghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(down == 1'b1 || (((Oghost_X_Pos+1'b1)/4)%2) == 1'b0 || ((Oghost_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Oghost_X_Motion;
								Cur_Y_Motion = Oghost_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Oghost_Y_Step;
								end
							if ( (Oghost_Y_Pos + Oghost_Size) >= Oghost_Y_Max)  // Oghost is at the bottom edge, BOUNCE!
								begin
								Cur_Y_Pos <= Oghost_Y_Max - Oghost_Size;
								Cur_X_Pos <= (Oghost_X_Pos + Oghost_X_Motion);
								end 
						  end					
//				//up
				2'b11: begin
							if((Oghost_X_Motion == 1'b1 && col0 == 1'b1)||(Oghost_X_Motion>10'd10 && col1 ==1'b1)||(Oghost_Y_Motion==1'b1 && col2 == 1'b1)||(Oghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(up == 1'b1 || (((Oghost_X_Pos+1'b1)/4)%2) == 1'b0 || ((Oghost_X_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Oghost_X_Motion;
								Cur_Y_Motion = Oghost_Y_Motion;
								end
							 else
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Oghost_Y_Step)+1'b1);
								end
							 if ( (Oghost_Y_Pos - Oghost_Size) <= Oghost_Y_Min )  // Oghost is at the top edge, BOUNCE!
								begin
								Cur_Y_Pos <= Oghost_Y_Min + Oghost_Size;
								Cur_X_Pos <= (Oghost_X_Pos + Oghost_X_Motion);
			//					  Oghost_Y_Motion <= Oghost_Y_Step;
								end 
						  end
//				//right
				2'b01: begin 
							if((Oghost_X_Motion == 1'b1 && col0 == 1'b1)||(Oghost_X_Motion>10'd10 && col1 ==1'b1)||(Oghost_Y_Motion==1'b1 && col2 == 1'b1)||(Oghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(right == 1'b1 || (((Oghost_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Oghost_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Oghost_X_Motion;
								Cur_Y_Motion = Oghost_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Oghost_X_Step;
								end
							 if ( (Oghost_X_Pos + Oghost_Size) >= Oghost_X_Max && oflag == 2'b01)  // Oghost is at the Right edge, BOUNCE!
								begin
								Cur_X_Pos <= Oghost_X_Max - Oghost_Size;
								Cur_Y_Pos <= (Oghost_Y_Pos + Oghost_Y_Motion);
								end 
						  end
				//left
				2'b00: begin 
							if((Oghost_X_Motion == 1'b1 && col0 == 1'b1)||(Oghost_X_Motion>10'd10 && col1 ==1'b1)||(Oghost_Y_Motion==1'b1 && col2 == 1'b1)||(Oghost_Y_Motion>10'd10 && col3 == 1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							 else if(left == 1'b1 || (((Oghost_Y_Pos+1'b1)/4)%2) == 1'b0 || ((Oghost_Y_Pos+1'b1)%4)!=1'b0) 
								begin
								Cur_X_Motion = Oghost_X_Motion;
								Cur_Y_Motion = Oghost_Y_Motion;
								end
							 else
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Oghost_X_Step)+1'b1);
								end
							 if ( (Oghost_X_Pos - Oghost_Size) <= Oghost_X_Min && oflag == 2'b00)  // Oghost is at the Left edge, BOUNCE!
								begin 
								Cur_X_Pos <= Oghost_X_Min + Oghost_Size;
								Cur_Y_Pos <= (Oghost_Y_Pos + Oghost_Y_Motion);
								end
						  end
				default: begin
							if((Oghost_X_Motion==1'b1 && col0 ==1'b1)||(Oghost_X_Motion >10'd10 && col1 == 1'b1)||(Oghost_Y_Motion ==1'b1 && col2==1'b1)||(Oghost_Y_Motion>10'd10 && col3==1'b1))
								begin
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = 10'd0;
								end
							else if(prev_key==8'h1A && up == 1'b0 && (((Oghost_X_Pos+1'b1)/4)%2)==1'b1 && ((Oghost_X_Pos+1'b1)%4)==1'b0) 
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = (~(Oghost_Y_Step)+1'b1);
								end
							else if(prev_key==8'h16 && down == 1'b0 && (((Oghost_X_Pos+1'b1)/4)%2) == 1'b1 && ((Oghost_X_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_X_Motion = 10'd0;
								Cur_Y_Motion = Oghost_Y_Step;
								end
							else if(prev_key==8'h04 && left == 1'b0 && (((Oghost_Y_Pos+1'b1)/4)%2)==1'b1 && ((Oghost_Y_Pos+1'b1)%4)==1'b0)
								begin 
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = (~(Oghost_X_Step)+1'b1);
								end
							else if(prev_key==8'h07 && right == 1'b0 && (((Oghost_Y_Pos+1'b1)/4)%2)==1'b1 && ((Oghost_Y_Pos+1'b1)%4)==1'b0)
								begin
								Cur_Y_Motion = 10'd0;
								Cur_X_Motion = Oghost_X_Step;
								end
							else
								begin 
								Cur_X_Motion = Oghost_X_Motion;
								Cur_Y_Motion = Oghost_Y_Motion;
								end
							end
					endcase
						Cur_X_Pos <= (Oghost_X_Pos + Cur_X_Motion);
						Cur_Y_Pos <= (Oghost_Y_Pos + Cur_Y_Motion);
					end

//					end
//					end
//				//down
//				 if ( (Oghost_Y_Pos + Oghost_Size) >= Oghost_Y_Max && oflag == 2'b10 )  // Oghost is at the bottom edge, BOUNCE!
//					begin
//					Oghost_Y_Pos <= Oghost_Y_Max - Oghost_Size;
//					Oghost_X_Pos <= (Oghost_X_Pos + Oghost_X_Motion);
//					end 
////					  Oghost_Y_Motion <= (~ (Oghost_Y_Step) + 1'b1);  // 2's complement.
//					//up
//				 else if ( (Oghost_Y_Pos - Oghost_Size) <= Oghost_Y_Min && oflag == 2'b11 )  // Oghost is at the top edge, BOUNCE!
//					begin
//					Oghost_Y_Pos <= Oghost_Y_Min + Oghost_Size;
//					Oghost_X_Pos <= (Oghost_X_Pos + Oghost_X_Motion);
////					  Oghost_Y_Motion <= Oghost_Y_Step;
//					end 
//					//right
//				  else if ( (Oghost_X_Pos + Oghost_Size) >= Oghost_X_Max && oflag == 2'b01)  // Oghost is at the Right edge, BOUNCE!
//					begin
//					Oghost_X_Pos <= Oghost_X_Max - Oghost_Size;
//					Oghost_Y_Pos <= (Oghost_Y_Pos + Oghost_Y_Motion);
//					end 
////					  Oghost_X_Motion <= (~ (Oghost_X_Step) + 1'b1);  // 2's complement.
//					  //left
//				 else if ( (Oghost_X_Pos - Oghost_Size) <= Oghost_X_Min && oflag == 2'b00)  // Oghost is at the Left edge, BOUNCE!
//					begin 
//					Oghost_X_Pos <= Oghost_X_Min + Oghost_Size;
//					Oghost_Y_Pos <= (Oghost_Y_Pos + Oghost_Y_Motion);
//					end
////					  Oghost_X_Motion <= Oghost_X_Step;
////				 else 
////					begin
////					  Oghost_Y_Motion <= Oghost_Y_Motion;  // Oghost is somewhere in the middle, don't bounce, just keep moving
////					end 
//				 else 
//					begin
//					 Oghost_Y_Pos <= (Oghost_Y_Pos + Oghost_Y_Motion);  // Update Oghost position
//					 Oghost_X_Pos <= (Oghost_X_Pos + Oghost_X_Motion);
//					end 
				
			
	  /**************************************************************************************
	    ATTENTION! Please answer the following quesiton in your lab report! Points will be allocated for the answers!
		 Hidden Question #2/2:
          Note that Oghost_Y_Motion in the above statement may have been changed at the same clock edge
          that is causing the assignment of Oghost_Y_pos.  Will the new value of Oghost_Y_Motion be used,
          or the old?  How will this impact behavior of the Oghost during a bounce, and how might that 
          interact with a response to a keypress?  Can you fix it?  Give an answer in your Post-Lab.
      **************************************************************************************/
      
//			
//       
//    assign OghostX = Oghost_X_Pos;
//   
//    assign OghostY = Oghost_Y_Pos;
//   
//    assign OghostS = Oghost_Size;

		
		wall_bounds decider0(.DrawX(Oghost_X_Pos+Oghost_Size+Oghost_X_Motion),.DrawY(Oghost_Y_Pos),.wall_en(col0));
		wall_bounds decider1(.DrawX(Oghost_X_Pos-Oghost_Size),.DrawY(Oghost_Y_Pos),.wall_en(col1));
		wall_bounds decider2(.DrawX(Oghost_X_Pos),.DrawY(Oghost_Y_Pos+Oghost_Size+Oghost_Y_Motion),.wall_en(col2));
		wall_bounds decider3(.DrawX(Oghost_X_Pos),.DrawY(Oghost_Y_Pos-Oghost_Size),.wall_en(col3));
		wall_bounds decider4(.DrawX(Oghost_X_Pos),.DrawY(Oghost_Y_Pos-Oghost_Size),.wall_en(up));
		wall_bounds decider5(.DrawX(Oghost_X_Pos),.DrawY(Oghost_Y_Pos+1'b1+OghostS),.wall_en(down));
		wall_bounds decider6(.DrawX(Oghost_X_Pos-Oghost_Size),.DrawY(Oghost_Y_Pos),.wall_en(left));
		wall_bounds decider7(.DrawX(Oghost_X_Pos+1'b1+Oghost_Size),.DrawY(Oghost_Y_Pos),.wall_en(right));
		 

endmodule
