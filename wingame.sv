module wingame(input logic [95:0] array, 
					output logic win);
					
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
