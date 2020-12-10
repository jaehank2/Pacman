module FSM(input logic Reset, Clk,
           input [7:0] keycode,
           input over, win,	// over = game lost, win = game win
	   output reseton,	// reset after game ends
           output [1:0] level
          );
        

	enum logic [2:0] {RES, START, OVER, WIN} curr_state, next_state;
        logic [7:0] Enter;
        assign Enter = 8'h28;	// keycode for ENTER
	logic next_reseton;

        always_ff @ (posedge Clk)
        begin
            if (Reset)
            begin
                curr_state <= RES;
		reseton <= 1'b1;
            end
            else
            begin
                curr_state <= next_state;
		reseton <= next_reseton;
            end
        end

        always_comb
        begin
            next_state = curr_state;
	    next_reseton = reseton;
		
            case (curr_state)
	    RES : begin
		next_reseton = 1'b0;
		level = 2'b01;
		next_state = START;
	    end
		 
	    //START
            START : begin
		next_reseton = 1'b0;
                level = 2'b01;
                if (over)
		begin
                    next_state = OVER;
		end
		else if(win)
		begin 
		    next_state= WIN;
		end
                else
		begin 
                    next_state = START;
		end 
	    end
		
	    //WIN
	    WIN: begin
		 level = 2'b11;
		 if(keycode==Enter)
		 begin
			next_state= RES;
			next_reseton = 1'b1;	// when game ends and ENTER pressed, reset
		end
		else
		begin
			next_state = WIN;
			next_reseton = 1'b0;
		end
	    end
	
	    //OVER
            OVER : begin
                level = 2'b10;
                if (keycode == Enter)
		begin
                    next_state = RES;
		    next_reseton = 1'b1;	// when game ends and ENTER pressed, reset
                end
		else 
		begin
                    next_state = OVER;
		    next_reseton = 1'b0;
		end
	    end
            endcase
        end
endmodule


