module wingame(input logic [95:0] array, 
	       output logic win);	// win = 1 if all dots consumed
	
	
	// array[i] = 1 for i in [0, 95] if dot_i consumed				
	always_comb
	begin
		if(array ==  96'b111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111)
		begin
			win = 1'b1;
		end
		else
		begin
			win = 1'b0;
		end
	end
				
endmodule
