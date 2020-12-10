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


module  Color_mapper ( input [9:0] BallX, BallY, DrawX, DrawY, Ball_size,	//X,Y = center, size = radius
		       input [9:0] ghostX, ghostY, ghostS, OghostX, OghostY, OghostS,
		       input [1:0] flag,	//indicates direction
		       input [1:0] level,
                       input logic Reset, Clk,  // added for always ff block
                       output logic [7:0]  Red, Green, Blue,
							  output logic [95:0] array);
    
	logic ball_on, map_on, ghost_on, oghost_on, end_on, win_on;
    	// create names for each dot
    	logic d1, d2, d3, d4, d5, d6, d7, d8, d9, d10, d11, d12, d13, d14, d15, d16, d17, d18, d19, d20, d21, d22, d23, d24,
	  d25, d26, d27, d28, d29, d30, d31, d32, d33, d34, d35, d36, d37, d38, d39, d40, d41, d42, d43, d44, d45, d46, d47, d48, 
          d49, d50, d51, d52, d53, d54, d55, d56, d57, d58, d59, d60, d61, d62, d63, d64, d65, d66, d67, d68, d69, d70, d71, d72, 
          d73, d74, d75, d76, d77, d78, d79, d80, d81, d82, d83, d84, d85, d86, d87, d88, d89, d90, d91, d92, d93, d94, d95, d96;
	//	logic array [95:0];    // create array for 96 dots - should be initialized to 0 by default

	  
	logic [31:0]pac_data, ghost_data, oghost_data;
	logic [7:0]pac_addr, ghost_addr, oghost_addr;
	logic [9:0]map_addr, end_addr, win_addr;
	logic [639:0]map_data, end_data, win_data;
	logic [2:0] dot_addr;
	logic [1:0] dot_data;
	
//	assign score =2'd00;
	 
	character_sprites pacman(.addr(pac_addr), .data(pac_data));
	ghost_sprite ghost(.addr(ghost_addr), .data(ghost_data));
	ghost_sprite Oghost(.addr(oghost_addr), .data(oghost_data));
	map_sprite map(.addr(map_addr), .data(map_data));
	dot_sprite dots(.addr(dot_addr), .data(dot_data));
	endscreen_sprite endscreen(.addr(end_addr), .data(end_data));
	winscreen_sprite winscreen(.addr(win_addr), .data(win_data));
	
	always_comb
	begin:Ball_on_proc
		//PACMAN
		if((DrawX >= BallX - Ball_size) && (DrawX <= BallX + Ball_size) && (DrawY >= BallY - Ball_size) && (DrawY <= BallY + Ball_size) && level == 2'b01)
		begin
			pac_addr = (DrawY-BallY+Ball_size + 32*flag);
			ball_on = 1'b1;
		end 
			  
		else 
		begin
			ball_on = 1'b0;
			pac_addr = 7'b0000000;
		end
		
		//ghost
		if ((DrawX >= ghostX - Ball_size) && (DrawX <= ghostX + Ball_size) && (DrawY >= ghostY - Ball_size) && (DrawY <= ghostY + Ball_size) && level == 2'b01)
		begin
			ghost_addr = (DrawY - ghostY + ghostS + 32*flag);
			ghost_on = 1'b1;
		end
		else 
		begin 
			ghost_on = 1'b0;
			ghost_addr = 7'b0000000;
		end
		//ORANGE GHOST 
		if ((DrawX >= OghostX - Ball_size) && (DrawX <= OghostX + Ball_size) && (DrawY >= OghostY - Ball_size) && (DrawY <= OghostY + Ball_size) && level == 2'b01)
		begin
			//ghost_addr = (DrawY - OghostY + Ball_size + 224);
			oghost_addr = (DrawY - OghostY + ghostS + 32*flag);
			oghost_on = 1'b1;
		end
		else 
		begin 
			oghost_on = 1'b0;
			oghost_addr = 7'b0000000;
		end
		
		
		//maze 
		if(DrawX < 640 && DrawY <= 480 && level == 2'b01)
		begin
			map_addr = DrawY;
			map_on = 1'b1;
		end 
		else 
		begin
			map_addr = 10'b0000000000;
			map_on = 1'b0;
		end
		
		//endscreen
		if (DrawX < 640 && DrawY <= 480 && level == 2'b10)
		begin
			end_addr = DrawY;
			end_on = 1'b1;
		end
		else
		begin
			end_addr = 10'b0000000000;
			end_on = 1'b0;
		end
		if (DrawX < 640 && DrawY <= 480 && level == 2'b11)
		begin
			win_addr = DrawY;
			win_on = 1'b1;
		end
		else
		begin
			win_addr = 10'b0000000000;
			win_on = 1'b0;
		end
	end
	
	// mark position for all dots
	always_comb
	begin
		d1 = 1'b0;
                d2 = 1'b0;
                d3 = 1'b0;
                d4 = 1'b0;
                d5 = 1'b0;
                d6 = 1'b0;
                d7 = 1'b0;
                d8 = 1'b0;
                d9 = 1'b0;
                d10 = 1'b0;
		d11 = 1'b0;
		d12 = 1'b0;
		d13 = 1'b0;
		d14 = 1'b0;
		d15 = 1'b0;
		d16 = 1'b0;
		d17 = 1'b0;
		d18 = 1'b0;
		d19 = 1'b0;
		d20 = 1'b0;
		d21 = 1'b0;
		d22 = 1'b0;
		d23 = 1'b0;
		d24 = 1'b0;
		d25 = 1'b0;
		d26 = 1'b0;
		d27 = 1'b0;
		d28 = 1'b0;
		d29 = 1'b0;
		d30 = 1'b0;
		d31 = 1'b0;
		d32 = 1'b0;
		d33 = 1'b0;
		d34 = 1'b0;
		d35 = 1'b0;
		d36 = 1'b0;
		d37 = 1'b0;
		d38 = 1'b0;
		d39 = 1'b0;
		d40 = 1'b0;
		d41 = 1'b0;
		d42 = 1'b0;
		d43 = 1'b0;
		d44 = 1'b0;
		d45 = 1'b0;
		d46 = 1'b0;
		d47 = 1'b0;
		d48 = 1'b0;
		d49 = 1'b0;
		d50 = 1'b0;
		d51 = 1'b0;
		d52 = 1'b0;
		d53 = 1'b0;
		d54 = 1'b0;
		d55 = 1'b0;
		d56 = 1'b0;
		d57 = 1'b0;
		d58 = 1'b0;
		d59 = 1'b0;
		d60 = 1'b0;
		d61 = 1'b0;
		d62 = 1'b0;
		d63 = 1'b0;
		d64 = 1'b0;
		d65 = 1'b0;
		d66 = 1'b0;
		d67 = 1'b0;
		d68 = 1'b0;
		d69 = 1'b0;
		d70 = 1'b0;
		d71 = 1'b0;
		d72 = 1'b0;
		d73 = 1'b0;
		d74 = 1'b0;
		d75 = 1'b0;
		d76 = 1'b0;
		d77 = 1'b0;
		d78 = 1'b0;
		d79 = 1'b0;
		d80 = 1'b0;
		d81 = 1'b0;
		d82 = 1'b0;
		d83 = 1'b0;
		d84 = 1'b0;
		d85 = 1'b0;
		d86 = 1'b0;
		d87 = 1'b0;
		d88 = 1'b0;
		d89 = 1'b0;
		d90 = 1'b0;
		d91 = 1'b0;
		d92 = 1'b0;
		d93 = 1'b0;
		d94 = 1'b0;
		d95 = 1'b0;
		d96 = 1'b0;
		dot_addr = 10'b0000000000; 
	    	if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01) // starting from top left
            	begin
                	d1 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
                	d2 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d3 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d4 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d5 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)    // 30 jump
            	begin
            	    	d6 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d7 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d8 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)
            	begin
            	    	d9 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd61 && DrawY < 10'd68 && level == 2'b01)    // first row done
            	begin
            	    	d10 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)	// second row start
            	begin
            	    	d11 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)
            	begin
            	    	d12 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)
            	begin
            	    	d13 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)
            	begin
            	    	d14 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)
            	begin
            	    	d15 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd93 && DrawY < 10'd100 && level == 2'b01)   // second row done
            	begin
            	    	d16 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)	// third row start
            	begin
            	    	d17 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)
            	begin
            	    	d18 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd125 && DrawY < 10'd132&& level == 2'b01)
            	begin
            	    	d19 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd125 && DrawY < 10'd132&& level == 2'b01)
            	begin
            	    	d20 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd125 && DrawY < 10'd132&& level == 2'b01 )
            	begin
            	    	d21 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)    // 30 jump
            	begin
            	    	d22 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)
            	begin
            	    	d23 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)
            	begin
            	    	d24 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)
            	begin
            	    	d25 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd125 && DrawY < 10'd132 && level == 2'b01)    // third row done
            	begin
            	    	d26 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd157 && DrawY < 10'd164 && level == 2'b01)	// fourth row start
            	begin
            	    	d27 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd157 && DrawY < 10'd164 && level == 2'b01)
            	begin
            	    	d28 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd156 && DrawY < 10'd163 && level == 2'b01)
            	begin
            	    	d29 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd156 && DrawY < 10'd163 && level == 2'b01)
            	begin
            	    	d30 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd156 && DrawY < 10'd163 && level == 2'b01)    // 30 jump
            	begin
            	    	d31 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd156 && DrawY < 10'd163 && level == 2'b01)
            	begin
            	    	d32 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd157 && DrawY < 10'd164 && level == 2'b01)
            	begin
            	    	d33 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd157 && DrawY < 10'd164 && level == 2'b01)    // fourth row done
            	begin
            	    	d34 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)	// fifth row start
            	begin
            	    	d35 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd205 && DrawX < 10'd210 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)
            	begin
            	    	d36 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)
            	begin
            	    	d37 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)
            	begin
            	    	d38 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd429 && DrawX < 10'd434 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)
            	begin
            	    	d39 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd189 && DrawY < 10'd196 && level == 2'b01)    // fifth row done
            	begin
            	    	d40 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)	// sixth row start
            	begin
            	    	d41 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd205 && DrawX < 10'd210 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)
            	begin
            	    	d42 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)
            	begin
            	    	d43 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)
            	begin
            	    	d44 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd429 && DrawX < 10'd434 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)
            	begin
            	    	d45 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd221 && DrawY < 10'd228 && level == 2'b01)    // sixth row done
            	begin
            	    	d46 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)	// seventh row start
            	begin
            	    	d47 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)
            	begin
            	    	d48 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)
            	begin
            	    	d49 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)
            	begin
            	    	d50 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)
            	begin
            	    	d51 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd253 && DrawY < 10'd260 && level == 2'b01)    // seventh row done
            	begin
            	    	d52 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd285 && DrawY < 10'd292 && level == 2'b01)	// eigth row start
            	begin
            	    	d53 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd285 && DrawY < 10'd292 && level == 2'b01)
            	begin
            	    	d54 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd285 && DrawY < 10'd292 && level == 2'b01)
            	begin
            	    	d55 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd285 && DrawY < 10'd292 && level == 2'b01)    // eigth row done
            	begin
            	    	d56 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)	// nineth row start
            	begin
            	    	d57 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d58 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d59 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d60 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d61 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)    // 30 jump
            	begin
            	    	d62 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd365 && DrawX < 10'd370 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d63 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d64 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)
            	begin
            	    	d65 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd317 && DrawY < 10'd324 && level == 2'b01)    // nineth row done
            	begin
            	    	d66 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)	// tenth row start
            	begin
            	    	d67 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd205 && DrawX < 10'd210 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d68 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d69 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d70 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d71 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd334 && DrawX < 10'd339 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)    // 30 jump
            	begin
            	    	d72 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d73 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d74 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd429 && DrawX < 10'd434 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)
            	begin
            	    	d75 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd349 && DrawY < 10'd356 && level == 2'b01)    // tenth row done
            	begin
            	    	d76 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)	// eleventh row start
            	begin
            	    	d77 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd205 && DrawX < 10'd210 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d78 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d79 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d80 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd301 && DrawX < 10'd306 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d81 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd335 && DrawX < 10'd340 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)    // 30 jump
            	begin
            	    	d82 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d83 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d84 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd429 && DrawX < 10'd434 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)
            	begin
            	    	d85 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd381 && DrawY < 10'd388 && level == 2'b01)    // eleventh row done
            	begin
            	    	d86 = 1'b1;
			dot_addr = DrawY;
            	end
		
		else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)	// last row start
            	begin
            	    	d87 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d88 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d89 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d90 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd301 && DrawX < 10'd306 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d91 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd335 && DrawX < 10'd340 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)    // 30 jump
            	begin
            	    	d92 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d93 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d94 = 1'b1;
			dot_addr = DrawY;
            	end
            	else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)
            	begin
            	    	d95 = 1'b1;
			dot_addr = DrawY;
            	end
		else if (DrawX > 10'd462 && DrawX < 10'd467 && DrawY > 10'd413 && DrawY < 10'd420 && level == 2'b01)    // last row done
            	begin
            	    	d96 = 1'b1;
			dot_addr = DrawY;
            	end
		
	    	else
	    	begin
			d1 = 1'b0;
            	    	d2 = 1'b0;
            	    	d3 = 1'b0;
            	    	d4 = 1'b0;
            	    	d5 = 1'b0;
            	    	d6 = 1'b0;
            	    	d7 = 1'b0;
            	    	d8 = 1'b0;
            	    	d9 = 1'b0;
            	    	d10 = 1'b0;
			d11 = 1'b0;
			d12 = 1'b0;
			d13 = 1'b0;
			d14 = 1'b0;
			d15 = 1'b0;
			d16 = 1'b0;
			d17 = 1'b0;
			d18 = 1'b0;
			d19 = 1'b0;
			d20 = 1'b0;
			d21 = 1'b0;
			d22 = 1'b0;
			d23 = 1'b0;
			d24 = 1'b0;
			d25 = 1'b0;
			d26 = 1'b0;
			d27 = 1'b0;
			d28 = 1'b0;
			d29 = 1'b0;
			d30 = 1'b0;
			d31 = 1'b0;
			d32 = 1'b0;
			d33 = 1'b0;
			d34 = 1'b0;
			d35 = 1'b0;
			d36 = 1'b0;
			d37 = 1'b0;
			d38 = 1'b0;
			d39 = 1'b0;
			d40 = 1'b0;
			d41 = 1'b0;
			d42 = 1'b0;
			d43 = 1'b0;
			d44 = 1'b0;
			d45 = 1'b0;
			d46 = 1'b0;
			d47 = 1'b0;
			d48 = 1'b0;
			d49 = 1'b0;
			d50 = 1'b0;
			d51 = 1'b0;
			d52 = 1'b0;
			d53 = 1'b0;
			d54 = 1'b0;
			d55 = 1'b0;
			d56 = 1'b0;
			d57 = 1'b0;
			d58 = 1'b0;
			d59 = 1'b0;
			d60 = 1'b0;
			d61 = 1'b0;
			d62 = 1'b0;
			d63 = 1'b0;
			d64 = 1'b0;
			d65 = 1'b0;
			d66 = 1'b0;
			d67 = 1'b0;
			d68 = 1'b0;
			d69 = 1'b0;
			d70 = 1'b0;
			d71 = 1'b0;
			d72 = 1'b0;
			d73 = 1'b0;
			d74 = 1'b0;
			d75 = 1'b0;
			d76 = 1'b0;
			d77 = 1'b0;
			d78 = 1'b0;
			d79 = 1'b0;
			d80 = 1'b0;
			d81 = 1'b0;
			d82 = 1'b0;
			d83 = 1'b0;
			d84 = 1'b0;
			d85 = 1'b0;
			d86 = 1'b0;
			d87 = 1'b0;
			d88 = 1'b0;
			d89 = 1'b0;
			d90 = 1'b0;
			d91 = 1'b0;
			d92 = 1'b0;
			d93 = 1'b0;
			d94 = 1'b0;
			d95 = 1'b0;
			d96 = 1'b0;
			dot_addr = 10'b0000000000;
	    	end
	end


	// check if dot consumed or not
	// if consumed, corresponding array is set to 1
	always_ff @ (posedge Clk)
	begin
    		if (Reset)
    		begin
			array[0] <= 1'b0;
			array[1] <= 1'b0;
			array[2] <= 1'b0;
			array[3] <= 1'b0;
			array[4] <= 1'b0;
			array[5] <= 1'b0;
			array[6] <= 1'b0;
			array[7] <= 1'b0;
			array[8] <= 1'b0;
			array[9] <= 1'b0;
			array[10] <= 1'b0;
			array[11] <= 1'b0;
			array[12] <= 1'b0;
			array[13] <= 1'b0;
			array[14] <= 1'b0;
			array[15] <= 1'b0;
			array[16] <= 1'b0;
			array[17] <= 1'b0;
			array[18] <= 1'b0;
			array[19] <= 1'b0;
			array[20] <= 1'b0;
			array[21] <= 1'b0;
			array[22] <= 1'b0;
			array[23] <= 1'b0;
			array[24] <= 1'b0;
			array[25] <= 1'b0;
			array[26] <= 1'b0;
			array[27] <= 1'b0;
			array[28] <= 1'b0;
			array[29] <= 1'b0;
			array[30] <= 1'b0;
			array[31] <= 1'b0;
			array[32] <= 1'b0;
			array[33] <= 1'b0;
			array[34] <= 1'b0;
			array[35] <= 1'b0;
			array[36] <= 1'b0;
			array[37] <= 1'b0;
			array[38] <= 1'b0;
			array[39] <= 1'b0;
			array[40] <= 1'b0;
			array[41] <= 1'b0;
			array[42] <= 1'b0;
			array[43] <= 1'b0;
			array[44] <= 1'b0;
			array[45] <= 1'b0;
			array[46] <= 1'b0;
			array[47] <= 1'b0;
			array[48] <= 1'b0;
			array[49] <= 1'b0;
			array[50] <= 1'b0;
			array[51] <= 1'b0;
			array[52] <= 1'b0;
			array[53] <= 1'b0;
			array[54] <= 1'b0;
			array[55] <= 1'b0;
			array[56] <= 1'b0;
			array[57] <= 1'b0;
			array[58] <= 1'b0;
			array[59] <= 1'b0;
			array[60] <= 1'b0;
			array[61] <= 1'b0;
			array[62] <= 1'b0;
			array[63] <= 1'b0;
			array[64] <= 1'b0;
			array[65] <= 1'b0;
			array[66] <= 1'b0;
			array[67] <= 1'b0;
			array[68] <= 1'b0;
			array[69] <= 1'b0;
			array[70] <= 1'b0;
			array[71] <= 1'b0;
			array[72] <= 1'b0;
			array[73] <= 1'b0;
			array[74] <= 1'b0;
			array[75] <= 1'b0;
			array[76] <= 1'b0;
			array[77] <= 1'b0;
			array[78] <= 1'b0;
			array[79] <= 1'b0;
			array[80] <= 1'b0;
			array[81] <= 1'b0;
			array[82] <= 1'b0;
			array[83] <= 1'b0;
			array[84] <= 1'b0;
			array[85] <= 1'b0;
			array[86] <= 1'b0;
			array[87] <= 1'b0;
			array[88] <= 1'b0;
			array[89] <= 1'b0;
			array[90] <= 1'b0;
			array[91] <= 1'b0;
			array[92] <= 1'b0;
			array[93] <= 1'b0;
			array[94] <= 1'b0;
			array[95] <= 1'b0;
    		end
    		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd61 && BallY < 10'd68)
    		begin
			array[0] <= 1'b1;
    		end
    		else if (BallX > 10'd206 && BallX < 10'd211 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[1] <= 1'b1;
    		end
    		else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[2] <= 1'b1;
    		end
    		else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[3] <= 1'b1;
    		end
    		else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[4] <= 1'b1;
    		end
    		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd61 && BallY < 10'd68)    // 30 jump
    		begin
    		    	array[5] <= 1'b1;
    		end
    		else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[6] <= 1'b1;
    		end
    		else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    			array[7] <= 1'b1;
    		end
    		else if (BallX > 10'd428 && BallX < 10'd433 && BallY > 10'd61 && BallY < 10'd68)
    		begin
    		    	array[8] <= 1'b1;
    		end
    		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd61 && BallY < 10'd68)    // first row done
    		begin
    		    	array[9] <= 1'b1;
    		end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd93 && BallY < 10'd100)	// second row start
            	begin
			array[10] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd93 && BallY < 10'd100)
            	begin
			array[11] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd93 && BallY < 10'd100)
            	begin
			array[12] <= 1'b1;
            	end
		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd93 && BallY < 10'd100)
            	begin
			array[13] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd93 && BallY < 10'd100)
            	begin
			array[14] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd93 && BallY < 10'd100)   // second row done
            	begin
			array[15] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd125 && BallY < 10'd132)	// third row start
            	begin
			array[16] <= 1'b1;
            	end
            	else if (BallX > 10'd206 && BallX < 10'd211 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[17] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[18] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[19] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[20] <= 1'b1;
            	end
		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd125 && BallY < 10'd132)    // 30 jump
            	begin
			array[21] <= 1'b1;
            	end
            	else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[22] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[23] <= 1'b1;
            	end
            	else if (BallX > 10'd428 && BallX < 10'd433 && BallY > 10'd125 && BallY < 10'd132)
            	begin
			array[24] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd125 && BallY < 10'd132)    // third row done
            	begin
			array[25] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd157 && BallY < 10'd164)	// fourth row start
            	begin
			array[26] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd157 && BallY < 10'd164)
            	begin
			array[27] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd156 && BallY < 10'd163)
            	begin
			array[28] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd156 && BallY < 10'd163)
            	begin
			array[29] <= 1'b1;
            	end
		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd156 && BallY < 10'd163)    // 30 jump
            	begin
			array[30] <= 1'b1;
            	end
            	else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd156 && BallY < 10'd163)
            	begin
			array[31] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd157 && BallY < 10'd164)
            	begin
			array[32] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd157 && BallY < 10'd164)    // fourth row done
            	begin
			array[33] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd189 && BallY < 10'd196)	// fifth row start
            	begin
			array[34] <= 1'b1;
            	end
            	else if (BallX > 10'd205 && BallX < 10'd210 && BallY > 10'd189 && BallY < 10'd196)
            	begin
			array[35] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd189 && BallY < 10'd196)
            	begin
			array[36] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd189 && BallY < 10'd196)
            	begin
			array[37] <= 1'b1;
            	end
            	else if (BallX > 10'd429 && BallX < 10'd434 && BallY > 10'd189 && BallY < 10'd196)
            	begin
			array[38] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd189 && BallY < 10'd196)    // fifth row done
            	begin
			array[39] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd221 && BallY < 10'd228)	// sixth row start
            	begin
			array[40] <= 1'b1;
            	end
            	else if (BallX > 10'd206 && BallX < 10'd211 && BallY > 10'd221 && BallY < 10'd228)
            	begin
			array[41] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd221 && BallY < 10'd228)
            	begin
			array[42] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd221 && BallY < 10'd228)
            	begin
			array[43] <= 1'b1;
            	end
            	else if (BallX > 10'd429 && BallX < 10'd434 && BallY > 10'd221 && BallY < 10'd228)
            	begin
			array[44] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd221 && BallY < 10'd228)    // sixth row done
            	begin
			array[45] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd253 && BallY < 10'd260)	// seventh row start
            	begin
			array[46] <= 1'b1;
            	end
            	else if (BallX > 10'd205 && BallX < 10'd210 && BallY > 10'd253 && BallY < 10'd260)
            	begin
			array[47] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd253 && BallY < 10'd260)
            	begin
			array[48] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd253 && BallY < 10'd260)
            	begin
			array[49] <= 1'b1;
            	end
            	else if (BallX > 10'd428 && BallX < 10'd433 && BallY > 10'd253 && BallY < 10'd260)
            	begin
			array[50] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd253 && BallY < 10'd260)    // seventh row done
            	begin
			array[51] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd285 && BallY < 10'd292)	// eigth row start
            	begin
			array[52] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd285 && BallY < 10'd292)
            	begin
			array[53] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd285 && BallY < 10'd292)
            	begin
			array[54] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd285 && BallY < 10'd292)    // eigth row done
            	begin
			array[55] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd317 && BallY < 10'd324)	// nineth row start
            	begin
			array[56] <= 1'b1;
            	end
            	else if (BallX > 10'd206 && BallX < 10'd211 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[57] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[58] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[59] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[60] <= 1'b1;
            	end
		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd317 && BallY < 10'd324)    // 30 jump
            	begin
			array[61] <= 1'b1;
            	end
            	else if (BallX > 10'd365 && BallX < 10'd370 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[62] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[63] <= 1'b1;
            	end
            	else if (BallX > 10'd428 && BallX < 10'd433 && BallY > 10'd317 && BallY < 10'd324)
            	begin
			array[64] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd317 && BallY < 10'd324)    // nineth row done
            	begin
			array[65] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd349 && BallY < 10'd356)	// tenth row start
            	begin
			array[66] <= 1'b1;
            	end
            	else if (BallX > 10'd205 && BallX < 10'd210 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[67] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[68] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[69] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[70] <= 1'b1;
            	end
		else if (BallX > 10'd334 && BallX < 10'd339 && BallY > 10'd349 && BallY < 10'd356)    // 30 jump
            	begin
			array[71] <= 1'b1;
            	end
            	else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[72] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[73] <= 1'b1;
            	end
            	else if (BallX > 10'd429 && BallX < 10'd434 && BallY > 10'd349 && BallY < 10'd356)
            	begin
			array[74] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd349 && BallY < 10'd356)    // tenth row done
            	begin
			array[75] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd381 && BallY < 10'd388)	// eleventh row start
            	begin
			array[76] <= 1'b1;
            	end
            	else if (BallX > 10'd205 && BallX < 10'd210 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[77] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[78] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[79] <= 1'b1;
            	end
            	else if (BallX > 10'd301 && BallX < 10'd306 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[80] <= 1'b1;
            	end
		else if (BallX > 10'd335 && BallX < 10'd340 && BallY > 10'd381 && BallY < 10'd388)    // 30 jump
            	begin
			array[81] <= 1'b1;
            	end
            	else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[82] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[83] <= 1'b1;
            	end
            	else if (BallX > 10'd429 && BallX < 10'd434 && BallY > 10'd381 && BallY < 10'd388)
            	begin
			array[84] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd381 && BallY < 10'd388)    // eleventh row done
            	begin
			array[85] <= 1'b1;
            	end
		
		else if (BallX > 10'd174 && BallX < 10'd179 && BallY > 10'd413 && BallY < 10'd420)	// last row start
            	begin
			array[86] <= 1'b1;
            	end
            	else if (BallX > 10'd206 && BallX < 10'd211 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[87] <= 1'b1;
            	end
            	else if (BallX > 10'd238 && BallX < 10'd243 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[88] <= 1'b1;
            	end
            	else if (BallX > 10'd270 && BallX < 10'd275 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[89] <= 1'b1;
            	end
            	else if (BallX > 10'd302 && BallX < 10'd307 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[90] <= 1'b1;
            	end
		else if (BallX > 10'd335 && BallX < 10'd340 && BallY > 10'd413 && BallY < 10'd420)    // 30 jump
            	begin
			array[91] <= 1'b1;
            	end
            	else if (BallX > 10'd364 && BallX < 10'd369 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[92] <= 1'b1;
            	end
            	else if (BallX > 10'd396 && BallX < 10'd401 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[93] <= 1'b1;
            	end
            	else if (BallX > 10'd428 && BallX < 10'd433 && BallY > 10'd413 && BallY < 10'd420)
            	begin
			array[94] <= 1'b1;
            	end
		else if (BallX > 10'd462 && BallX < 10'd467 && BallY > 10'd413 && BallY < 10'd420)    // last row done
            	begin
			array[95] <= 1'b1;
            	end
	end
		
     //===================================================================================
	  //===================================================================================
	  //NON DOT PART 
	  //===================================================================================
	  //===================================================================================
	
    	always_comb
    	begin:RGB_Display
    	    	if ((ball_on == 1'b1) && pac_data[DrawX - BallX + Ball_size] == 1'b1)
    	    	// yellow for pacman
    	    	begin
    	    	    	Red = 8'hff;
    	    	    	Green = 8'hff;
    	    	    	Blue = 8'h00;
    	    	end
		else if (ghost_on == 1'b1 && ghost_data[DrawX - ghostX + ghostS] == 1'b1)
		// light blue for ghost1
		begin
			Red = 8'h01;
			Green = 8'hff;
			Blue = 8'hff;
		end
		
		else if (oghost_on == 1'b1 && oghost_data[DrawX - OghostX +OghostS] == 1'b1)
		// orange for ghost2
		begin
			Red = 8'hff;
			Green = 8'hb8;
			Blue = 8'h52;
		end
		
    	 	else if (map_on == 1'b1 && map_data[DrawX] == 1'b1 && (DrawX > 10'd305 && DrawX <10'd334 && DrawY == 10'd208))
    	    	// skin color for middle box
		begin
			    Red = 8'hDE;
			    Green = 8'hA1;
			    Blue = 8'h85;
		end 
		else if(map_on == 1'b1 && map_data[DrawX] == 1'b1)
    	    	// blue for wall bounds
		begin
			    Red = 8'h21;
			    Green = 8'h21;
			    Blue = 8'hDE;
		end 

		
		//DOTS==========================================================================================================
    	    	// if not consumed, color it green
		else if(d1 == 1'b1 && dot_data[DrawX] == 1'b1 && array[0] == 1'b0 && level == 2'b01)
    	    	// green for dots
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d2 == 1'b1 && dot_data[DrawX] == 1'b1 && array[1] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d3 == 1'b1 && dot_data[DrawX] == 1'b1 && array[2] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d4 == 1'b1 && dot_data[DrawX] == 1'b1 && array[3] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d5 == 1'b1 && dot_data[DrawX] == 1'b1 && array[4] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d6 == 1'b1 && dot_data[DrawX] == 1'b1 && array[5] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d7 == 1'b1 && dot_data[DrawX] == 1'b1 && array[6] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d8 == 1'b1 && dot_data[DrawX] == 1'b1 && array[7] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d9 == 1'b1 && dot_data[DrawX] == 1'b1 && array[8] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
    	    	else if(d10 == 1'b1 && dot_data[DrawX] == 1'b1 && array[9] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d11 == 1'b1 && dot_data[DrawX] == 1'b1 && array[10] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d12 == 1'b1 && dot_data[DrawX] == 1'b1 && array[11] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d13 == 1'b1 && dot_data[DrawX] == 1'b1 && array[12] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d14 == 1'b1 && dot_data[DrawX] == 1'b1 && array[13] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d15 == 1'b1 && dot_data[DrawX] == 1'b1 && array[14] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d16 == 1'b1 && dot_data[DrawX] == 1'b1 && array[15] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d17 == 1'b1 && dot_data[DrawX] == 1'b1 && array[16] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d18 == 1'b1 && dot_data[DrawX] == 1'b1 && array[17] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d19 == 1'b1 && dot_data[DrawX] == 1'b1 && array[18] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d20 == 1'b1 && dot_data[DrawX] == 1'b1 && array[19] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d21 == 1'b1 && dot_data[DrawX] == 1'b1 && array[20] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d22 == 1'b1 && dot_data[DrawX] == 1'b1 && array[21] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d23 == 1'b1 && dot_data[DrawX] == 1'b1 && array[22] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d24 == 1'b1 && dot_data[DrawX] == 1'b1 && array[23] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d25 == 1'b1 && dot_data[DrawX] == 1'b1 && array[24] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d26 == 1'b1 && dot_data[DrawX] == 1'b1 && array[25] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d27 == 1'b1 && dot_data[DrawX] == 1'b1 && array[26] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d28 == 1'b1 && dot_data[DrawX] == 1'b1 && array[27] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d29 == 1'b1 && dot_data[DrawX] == 1'b1 && array[28] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d30 == 1'b1 && dot_data[DrawX] == 1'b1 && array[29] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d31 == 1'b1 && dot_data[DrawX] == 1'b1 && array[30] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d32 == 1'b1 && dot_data[DrawX] == 1'b1 && array[31] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d33 == 1'b1 && dot_data[DrawX] == 1'b1 && array[32] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d34 == 1'b1 && dot_data[DrawX] == 1'b1 && array[33] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d35 == 1'b1 && dot_data[DrawX] == 1'b1 && array[34] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d36 == 1'b1 && dot_data[DrawX] == 1'b1 && array[35] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d37 == 1'b1 && dot_data[DrawX] == 1'b1 && array[36] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d38 == 1'b1 && dot_data[DrawX] == 1'b1 && array[37] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d39 == 1'b1 && dot_data[DrawX] == 1'b1 && array[38] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d40 == 1'b1 && dot_data[DrawX] == 1'b1 && array[39] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d41 == 1'b1 && dot_data[DrawX] == 1'b1 && array[40] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d42 == 1'b1 && dot_data[DrawX] == 1'b1 && array[41] == 1'b0 && level == 2'b01)
		begin 
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d43 == 1'b1 && dot_data[DrawX] == 1'b1 && array[42] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d44 == 1'b1 && dot_data[DrawX] == 1'b1 && array[43] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d45 == 1'b1 && dot_data[DrawX] == 1'b1 && array[44] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d46 == 1'b1 && dot_data[DrawX] == 1'b1 && array[45] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d47 == 1'b1 && dot_data[DrawX] == 1'b1 && array[46] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d48 == 1'b1 && dot_data[DrawX] == 1'b1 && array[47] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d49 == 1'b1 && dot_data[DrawX] == 1'b1 && array[48] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d50 == 1'b1 && dot_data[DrawX] == 1'b1 && array[49] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d51 == 1'b1 && dot_data[DrawX] == 1'b1 && array[50] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d52 == 1'b1 && dot_data[DrawX] == 1'b1 && array[51] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d53 == 1'b1 && dot_data[DrawX] == 1'b1 && array[52] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d54 == 1'b1 && dot_data[DrawX] == 1'b1 && array[53] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d55 == 1'b1 && dot_data[DrawX] == 1'b1 && array[54] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d56 == 1'b1 && dot_data[DrawX] == 1'b1 && array[55] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d57 == 1'b1 && dot_data[DrawX] == 1'b1 && array[56] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d58 == 1'b1 && dot_data[DrawX] == 1'b1 && array[57] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d59 == 1'b1 && dot_data[DrawX] == 1'b1 && array[58] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d60 == 1'b1 && dot_data[DrawX] == 1'b1 && array[59] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d61 == 1'b1 && dot_data[DrawX] == 1'b1 && array[60] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d62 == 1'b1 && dot_data[DrawX] == 1'b1 && array[61] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d63 == 1'b1 && dot_data[DrawX] == 1'b1 && array[62] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d64 == 1'b1 && dot_data[DrawX] == 1'b1 && array[63] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d65 == 1'b1 && dot_data[DrawX] == 1'b1 && array[64] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d66 == 1'b1 && dot_data[DrawX] == 1'b1 && array[65] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d67 == 1'b1 && dot_data[DrawX] == 1'b1 && array[66] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d68 == 1'b1 && dot_data[DrawX] == 1'b1 && array[67] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d69 == 1'b1 && dot_data[DrawX] == 1'b1 && array[68] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d70 == 1'b1 && dot_data[DrawX] == 1'b1 && array[69] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d71 == 1'b1 && dot_data[DrawX] == 1'b1 && array[70] == 1'b0  && level == 2'b01)
		begin 
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d72 == 1'b1 && dot_data[DrawX] == 1'b1 && array[71] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d73 == 1'b1 && dot_data[DrawX] == 1'b1 && array[72] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d74 == 1'b1 && dot_data[DrawX] == 1'b1 && array[73] == 1'b0 && level == 2'b01)
		begin 
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d75 == 1'b1 && dot_data[DrawX] == 1'b1 && array[74] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d76 == 1'b1 && dot_data[DrawX] == 1'b1 && array[75] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d77 == 1'b1 && dot_data[DrawX] == 1'b1 && array[76] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d78 == 1'b1 && dot_data[DrawX] == 1'b1 && array[77] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d79 == 1'b1 && dot_data[DrawX] == 1'b1 && array[78] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d80 == 1'b1 && dot_data[DrawX] == 1'b1 && array[79] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d81 == 1'b1 && dot_data[DrawX] == 1'b1 && array[80] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d82 == 1'b1 && dot_data[DrawX] == 1'b1 && array[81] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d83 == 1'b1 && dot_data[DrawX] == 1'b1 && array[82] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d84 == 1'b1 && dot_data[DrawX] == 1'b1 && array[83] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d85 == 1'b1 && dot_data[DrawX] == 1'b1 && array[84] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d86 == 1'b1 && dot_data[DrawX] == 1'b1 && array[85] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d87 == 1'b1 && dot_data[DrawX] == 1'b1 && array[86] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d88 == 1'b1 && dot_data[DrawX] == 1'b1 && array[87] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d89 == 1'b1 && dot_data[DrawX] == 1'b1 && array[88] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d90 == 1'b1 && dot_data[DrawX] == 1'b1 && array[89] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d91 == 1'b1 && dot_data[DrawX] == 1'b1 && array[90] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d92 == 1'b1 && dot_data[DrawX] == 1'b1 && array[91] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d93 == 1'b1 && dot_data[DrawX] == 1'b1 && array[92] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d94 == 1'b1 && dot_data[DrawX] == 1'b1 && array[93] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d95 == 1'b1 && dot_data[DrawX] == 1'b1 && array[94] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end
		else if(d96 == 1'b1 && dot_data[DrawX] == 1'b1 && array[95] == 1'b0 && level == 2'b01)
		begin
			    Red = 8'h00;
			    Green = 8'hff;
			    Blue = 8'h00;
		end

	
		// if consumed, color it black (background color)
        	else if(d1 == 1'b1 && dot_data[DrawX] == 1'b1 && array[0] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d2 == 1'b1 && dot_data[DrawX] == 1'b1 && array[1] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d3 == 1'b1 && dot_data[DrawX] == 1'b1 && array[2] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d4 == 1'b1 && dot_data[DrawX] == 1'b1 && array[3] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d5 == 1'b1 && dot_data[DrawX] == 1'b1 && array[4] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d6 == 1'b1 && dot_data[DrawX] == 1'b1 && array[5] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d7 == 1'b1 && dot_data[DrawX] == 1'b1 && array[6] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d8 == 1'b1 && dot_data[DrawX] == 1'b1 && array[7] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d9 == 1'b1 && dot_data[DrawX] == 1'b1 && array[8] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
        	else if(d10 == 1'b1 && dot_data[DrawX] == 1'b1 && array[9] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d11 == 1'b1 && dot_data[DrawX] == 1'b1 && array[10] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d12 == 1'b1 && dot_data[DrawX] == 1'b1 && array[11] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d13 == 1'b1 && dot_data[DrawX] == 1'b1 && array[12] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d14 == 1'b1 && dot_data[DrawX] == 1'b1 && array[13] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d15 == 1'b1 && dot_data[DrawX] == 1'b1 && array[14] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d16 == 1'b1 && dot_data[DrawX] == 1'b1 && array[15] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d17 == 1'b1 && dot_data[DrawX] == 1'b1 && array[16] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d18 == 1'b1 && dot_data[DrawX] == 1'b1 && array[17] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d19 == 1'b1 && dot_data[DrawX] == 1'b1 && array[18] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d20 == 1'b1 && dot_data[DrawX] == 1'b1 && array[19] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d21 == 1'b1 && dot_data[DrawX] == 1'b1 && array[20] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end 
		else if(d22 == 1'b1 && dot_data[DrawX] == 1'b1 && array[21] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d23 == 1'b1 && dot_data[DrawX] == 1'b1 && array[22] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d24 == 1'b1 && dot_data[DrawX] == 1'b1 && array[23] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d25 == 1'b1 && dot_data[DrawX] == 1'b1 && array[24] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d26 == 1'b1 && dot_data[DrawX] == 1'b1 && array[25] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end 
		else if(d27 == 1'b1 && dot_data[DrawX] == 1'b1 && array[26] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d28 == 1'b1 && dot_data[DrawX] == 1'b1 && array[27] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d29 == 1'b1 && dot_data[DrawX] == 1'b1 && array[28] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d30 == 1'b1 && dot_data[DrawX] == 1'b1 && array[29] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d31 == 1'b1 && dot_data[DrawX] == 1'b1 && array[30] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d32 == 1'b1 && dot_data[DrawX] == 1'b1 && array[31] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d33 == 1'b1 && dot_data[DrawX] == 1'b1 && array[32] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d34 == 1'b1 && dot_data[DrawX] == 1'b1 && array[33] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d35 == 1'b1 && dot_data[DrawX] == 1'b1 && array[34] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d36 == 1'b1 && dot_data[DrawX] == 1'b1 && array[35] == 1'b1&& end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d37 == 1'b1 && dot_data[DrawX] == 1'b1 && array[36] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d38 == 1'b1 && dot_data[DrawX] == 1'b1 && array[37] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d39 == 1'b1 && dot_data[DrawX] == 1'b1 && array[38] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d40 == 1'b1 && dot_data[DrawX] == 1'b1 && array[39] == 1'b1 && end_on == 1'b0 )
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d41 == 1'b1 && dot_data[DrawX] == 1'b1 && array[40] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d42 == 1'b1 && dot_data[DrawX] == 1'b1 && array[41] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d43 == 1'b1 && dot_data[DrawX] == 1'b1 && array[42] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d44 == 1'b1 && dot_data[DrawX] == 1'b1 && array[43] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d45 == 1'b1 && dot_data[DrawX] == 1'b1 && array[44] == 1'b1&& end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d46 == 1'b1 && dot_data[DrawX] == 1'b1 && array[45] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d47 == 1'b1 && dot_data[DrawX] == 1'b1 && array[46] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d48 == 1'b1 && dot_data[DrawX] == 1'b1 && array[47] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d49 == 1'b1 && dot_data[DrawX] == 1'b1 && array[48] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d50 == 1'b1 && dot_data[DrawX] == 1'b1 && array[49] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d51 == 1'b1 && dot_data[DrawX] == 1'b1 && array[50] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d52 == 1'b1 && dot_data[DrawX] == 1'b1 && array[51] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d53 == 1'b1 && dot_data[DrawX] == 1'b1 && array[52] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d54 == 1'b1 && dot_data[DrawX] == 1'b1 && array[53] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d55 == 1'b1 && dot_data[DrawX] == 1'b1 && array[54] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d56 == 1'b1 && dot_data[DrawX] == 1'b1 && array[55] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d57 == 1'b1 && dot_data[DrawX] == 1'b1 && array[56] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d58 == 1'b1 && dot_data[DrawX] == 1'b1 && array[57] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d59 == 1'b1 && dot_data[DrawX] == 1'b1 && array[58] == 1'b1 && end_on == 1'b0)
		begin 
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d60 == 1'b1 && dot_data[DrawX] == 1'b1 && array[59] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d61 == 1'b1 && dot_data[DrawX] == 1'b1 && array[60] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d62 == 1'b1 && dot_data[DrawX] == 1'b1 && array[61] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d63 == 1'b1 && dot_data[DrawX] == 1'b1 && array[62] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d64 == 1'b1 && dot_data[DrawX] == 1'b1 && array[63] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d65 == 1'b1 && dot_data[DrawX] == 1'b1 && array[64] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d66 == 1'b1 && dot_data[DrawX] == 1'b1 && array[65] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d67 == 1'b1 && dot_data[DrawX] == 1'b1 && array[66] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d68 == 1'b1 && dot_data[DrawX] == 1'b1 && array[67] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d69 == 1'b1 && dot_data[DrawX] == 1'b1 && array[68] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end 
		else if(d70 == 1'b1 && dot_data[DrawX] == 1'b1 && array[69] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d71 == 1'b1 && dot_data[DrawX] == 1'b1 && array[70] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d72 == 1'b1 && dot_data[DrawX] == 1'b1 && array[71] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d73 == 1'b1 && dot_data[DrawX] == 1'b1 && array[72] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d74 == 1'b1 && dot_data[DrawX] == 1'b1 && array[73] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d75 == 1'b1 && dot_data[DrawX] == 1'b1 && array[74] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d76 == 1'b1 && dot_data[DrawX] == 1'b1 && array[75] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d77 == 1'b1 && dot_data[DrawX] == 1'b1 && array[76] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d78 == 1'b1 && dot_data[DrawX] == 1'b1 && array[77] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d79 == 1'b1 && dot_data[DrawX] == 1'b1 && array[78] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d80 == 1'b1 && dot_data[DrawX] == 1'b1 && array[79] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d81 == 1'b1 && dot_data[DrawX] == 1'b1 && array[80] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d82 == 1'b1 && dot_data[DrawX] == 1'b1 && array[81] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d83 == 1'b1 && dot_data[DrawX] == 1'b1 && array[82] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d84 == 1'b1 && dot_data[DrawX] == 1'b1 && array[83] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d85 == 1'b1 && dot_data[DrawX] == 1'b1 && array[84] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d86 == 1'b1 && dot_data[DrawX] == 1'b1 && array[85] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d87 == 1'b1 && dot_data[DrawX] == 1'b1 && array[86] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d88 == 1'b1 && dot_data[DrawX] == 1'b1 && array[87] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d89 == 1'b1 && dot_data[DrawX] == 1'b1 && array[88] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d90 == 1'b1 && dot_data[DrawX] == 1'b1 && array[89] == 1'b1 && end_on == 1'b0)
		begin 
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d91 == 1'b1 && dot_data[DrawX] == 1'b1 && array[90] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d92 == 1'b1 && dot_data[DrawX] == 1'b1 && array[91] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d93 == 1'b1 && dot_data[DrawX] == 1'b1 && array[92] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d94 == 1'b1 && dot_data[DrawX] == 1'b1 && array[93] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d95 == 1'b1 && dot_data[DrawX] == 1'b1 && array[94] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if(d96 == 1'b1 && dot_data[DrawX] == 1'b1 && array[95] == 1'b1 && end_on == 1'b0)
		begin
		    	Red = 8'h00;
		    	Green = 8'h00;
		    	Blue = 8'h00;
		end
		else if (end_on == 1'b1 && end_data[DrawX] == 1'b1)
		// colors YOU LOSE blue
		begin
			Red = 8'hFF;
			Green = 8'h00;
			Blue = 8'h00;
		end
      		else if (win_data[DrawX] ==1'b1 && win_on ==1'b1)
		// colors YOU WIN green
		begin
			Red = 8'h00;
			Green = 8'hFF;
			Blue = 8'h11;
		end
		else
		// black
        	begin 
        	    	Red = 8'h00; 
        	    	Green = 8'h00;
		    	Blue = 8'h00;
        	end      
    	end 
    
endmodule

