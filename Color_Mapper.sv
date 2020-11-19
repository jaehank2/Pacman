//-------------------------------------------------------------------------
//    Color_Mapper.sv                                                    --
//    Stephen Kempf                                                      --
//    3-1-06                                                             --
//                                                                       --
//    Modified by David Kesler  07-16-2008                               --
//    Translated by Joe Meng    07-07-2013                               --
//                                                                       --
//    Fall 2014 Distribution                                             --
//                                                                       --
//    For use with ECE 385 Lab 7                                         --
//    University of Illinois ECE Department                              --
//-------------------------------------------------------------------------


module  color_mapper ( input        [9:0] BallX, BallY, DrawX, DrawY, Ball_size, 
							  input        [1:0] flag,
                       output logic [7:0]  Red, Green, Blue );
    
    logic ball_on, map_on; 
	 
 /* Old Ball: Generated square box by checking if the current pixel is within a square of length
    2*Ball_Size, centered at (BallX, BallY).  Note that this requires unsigned comparisons.
	 
    if ((DrawX >= BallX - Ball_size) &&
       (DrawX <= BallX + Ball_size) &&
       (DrawY >= BallY - Ball_size) &&
       (DrawY <= BallY + Ball_size))

     New Ball: Generates (pixelated) circle by using the standard circle formula.  Note that while 
     this single line is quite powerful descriptively, it causes the synthesis tool to use up three
     of the 12 available multipliers on the chip!  Since the multiplicants are required to be signed,
	  we have to first cast them from logic to int (signed by default) before they are multiplied). */
	  
//    int DistX, DistY, Size;
//	 assign DistX = DrawX - BallX;
//    assign DistY = DrawY - BallY;
//    assign Size = Ball_size;

	  
	 logic [31:0]pac_data;
	 logic [7:0]pac_addr;
	 logic [9:0]map_addr;
	 logic [639:0]map_data;
	 
	 character_sprites pacman(.addr(pac_addr), .data(pac_data));
	 map_sprite map(.addr(map_addr), .data(map_data));
	 
	 
	 
    always_comb
    begin:Ball_on_proc
			//PACMAN
		  if((DrawX >= BallX - Ball_size) && (DrawX <= BallX + Ball_size) && (DrawY >= BallY - Ball_size) && (DrawY <= BallY + Ball_size))
			  begin 
					pac_addr = (DrawY-BallY+Ball_size + 32*flag);
					ball_on = 1'b1;
			  end 
			  
			  else 
			  begin
					ball_on = 1'b0;
					pac_addr = 7'b0000000;
			  end 
		  
		  //maze 
		  if(DrawX < 640 && DrawY <= 480)
				begin
					map_addr = DrawY;
					map_on = 1'b1;
				end 
		  else 
				begin
					map_addr = 10'b0000000000;
					map_on = 1'b0;
				end 
		end
     
    always_comb
    begin:RGB_Display
        if ((ball_on == 1'b1) && pac_data[DrawX - BallX + Ball_size] == 1'b1) 
        begin 
            Red = 8'hff;
            Green = 8'hff;
            Blue = 8'h00;
        end       
        else if 
		  (map_on == 1'b1 && map_data[DrawX] == 1'b1)
		  begin
				Red = 8'h00;
				Green = 8'h00;
				Blue = 8'hff;
		  end 
		  else
        begin 
            Red = 8'h00; 
            Green = 8'h00;
//            Blue = 8'h7f - DrawX[9:3];
				Blue = 8'h00;
        end      
    end 
    
endmodule
