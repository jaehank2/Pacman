module character_sprites( input [7:0]	addr,
						output [31:0]	data
					 );

	parameter ADDR_WIDTH = 8;
   parameter DATA_WIDTH =  32;

	// ROM definition
	parameter [0:159][31:0] ROM = {
	
		//Pacman facing right
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000001111111000000000000,
		32'b 00000000000111111111111000000000,
		32'b 00000000011111111111111110000000,
		32'b 00000000111111111111111111000000,
		32'b 00000011111111111111111111100000,
		32'b 00000111111111111111111110000000,
		32'b 00001111111111111111111000000000,
		32'b 00001111111111111111110000000000,
		32'b 00001111111111111111000000000000,
		32'b 00011111111111111000000000000000,
		32'b 00011111111111110000000000000000,
		32'b 00011111111111111000000000000000,
		32'b 00001111111111111111000000000000,
		32'b 00001111111111111111110000000000,
		32'b 00001111111111111111111000000000,
		32'b 00000111111111111111111110000000,
		32'b 00000011111111111111111111100000,
		32'b 00000000111111111111111111000000,
		32'b 00000000011111111111111110000000,
		32'b 00000000000111111111111000000000,
		32'b 00000000000001111111000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		
		//Pacman facing left
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000011111110000000000000,
		32'b 00000000011111111111100000000000,
		32'b 00000001111111111111111000000000,
		32'b 00000011111111111111111100000000,
		32'b 00000111111111111111111111000000,
		32'b 00000001111111111111111111100000,
		32'b 00000000011111111111111111110000,
		32'b 00000000001111111111111111110000,
		32'b 00000000000011111111111111110000,
		32'b 00000000000000011111111111111000,
		32'b 00000000000000001111111111111000,
		32'b 00000000000000011111111111111000,
		32'b 00000000000011111111111111110000,
		32'b 00000000001111111111111111110000,
		32'b 00000000011111111111111111110000,
		32'b 00000001111111111111111111100000,
		32'b 00000111111111111111111111000000,
		32'b 00000011111111111111111100000000,
		32'b 00000001111111111111111000000000,
		32'b 00000000011111111111100000000000,
		32'b 00000000000011111110000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		
		
						//Pacman facing down
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000001111111000000000000,
		32'b 00000000000111111111111000000000,
		32'b 00000000011111111111111110000000,
		32'b 00000000111111111111111111000000,
		32'b 00000011111111111111111111100000,
		32'b 00000111111111111111111111100000,
		32'b 00001111111111111111111111110000,
		32'b 00001111111111111111111111110000,
		32'b 00001111111111111111111111110000,
		32'b 00011111111111111011111111111000,
		32'b 00011111111111110001111111111000,
		32'b 00011111111111100001111111111000,
		32'b 00001111111111000000111111110000,
		32'b 00001111111111000000111111110000,
		32'b 00001111111110000000011111110000,
		32'b 00000111111110000000011111100000,
		32'b 00000011111100000000001111100000,
		32'b 00000000111100000000001111000000,
		32'b 00000000011100000000001110000000,
		32'b 00000000000100000000001000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		
				//Pacman facing up
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000100000000001000000000,
		32'b 00000000011100000000001110000000,
		32'b 00000000111100000000001111000000,
		32'b 00000011111100000000001111100000,
		32'b 00000111111110000000011111100000,
		32'b 00001111111110000000011111110000,
		32'b 00001111111111000000111111110000,
		32'b 00001111111111000000111111110000,
		32'b 00011111111111100001111111110000,
		32'b 00011111111111100011111111110000,
		32'b 00011111111111110111111111111000,
		32'b 00001111111111111111111111110000,
		32'b 00001111111111111111111111110000,
		32'b 00001111111111111111111111110000,
		32'b 00000111111111111111111111100000,
		32'b 00000011111111111111111111100000,
		32'b 00000000111111111111111111000000,
		32'b 00000000011111111111111110000000,
		32'b 00000000000111111111111000000000,
		32'b 00000000000001111111000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		


		//Ghost sprite
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000111111111110000000000,
		32'b 00000000011111111111111000000000,
		32'b 00000000111111111111111100000000,
		32'b 00000001111111111111111110000000,
		32'b 00000011111111111111111111000000,
		32'b 00000111111111111111111111100000,
		32'b 00000111110011111111100111100000,
		32'b 00001111100001111111000011110000,
		32'b 00001111100001111111000011110000,
		32'b 00001111100001111111000011110000,
		32'b 00011111110011111111100111111000,
		32'b 00011111111111111111111111111000,
		32'b 00011111111111111111111111111000,
		32'b 00011111111111111111111111111000,
		32'b 00011111111111111111111111111000,
		32'b 00011111111111111111111111111000,
		32'b 00011110111111110111111110111000,
		32'b 00011100011111100011111100011000,
		32'b 00011100001111100001111000011000,
		32'b 00011000000111000000111000011000,
		32'b 00010000000010000000010000001000,
		32'b 00010000000010000000010000001000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000,
		32'b 00000000000000000000000000000000

	};

	assign data = ROM[addr];

endmodule