module gameover (input [9:0] BallX, BallY, Ball_size, ghostX, ghostY, ghostS, OghostX, OghostY, OghostS,
                 output logic over
                );

        always_comb
        begin
            if ((BallX + Ball_size >= ghostX) && (ghostX+ ghostS >= BallX +Ball_size)&& (((BallY+Ball_size >= ghostY) && 
				(BallY+Ball_size <= ghostY+ghostS)) || ((BallY >= ghostY) && (BallY < ghostY+ghostS))))    // collision on left side
            begin
                over = 1'b1;
            end
			   else if ((BallX + Ball_size >= ghostX+ghostS) && (ghostX+ ghostS >= BallX) && (((BallY+Ball_size >= ghostY) && 
				(BallY+Ball_size <= ghostY+ghostS)) || ((BallY >= ghostY) && (BallY < ghostY+ghostS))))    // collision on right side
            begin
                over = 1'b1;
            end
				else if ((BallY+Ball_size >= ghostY) && (ghostY+ghostS >= BallY+Ball_size) && ((BallX+Ball_size >= ghostX && BallX+Ball_size <= ghostX+ghostS) 
				|| (BallX >= ghostX && BallX <= ghostX+ghostS)))   // collision on top side of ghost
				begin
                over = 1'b1;
            end
				else if ((BallY <= ghostY+ghostS) && (ghostY+ghostS <= BallY+Ball_size) && ((BallX+Ball_size >= ghostX && BallX+Ball_size <= ghostX+ghostS) 
				|| (BallX >= ghostX && BallX <= ghostX+ghostS)))   // collision on bot side of ghost
			   begin
                over = 1'b1;
            end
				//ORANGE GHOST===============================================================================================
				else if ((BallX + Ball_size >= OghostX) && (OghostX+ OghostS >= BallX +Ball_size)&& (((BallY+Ball_size >= OghostY) && 
				(BallY+Ball_size <= OghostY+OghostS)) || ((BallY >= OghostY) && (BallY < OghostY+OghostS))))    // collision on left side
            begin
                over = 1'b1;
            end
			   else if ((BallX + Ball_size >= OghostX+OghostS) && (OghostX+ OghostS >= BallX) && (((BallY+Ball_size >= OghostY) && 
				(BallY+Ball_size <= OghostY+OghostS)) || ((BallY >= OghostY) && (BallY < OghostY+OghostS))))    // collision on right side
            begin
                over = 1'b1;
            end
				else if ((BallY+Ball_size >= OghostY) && (OghostY+OghostS >= BallY+Ball_size) && ((BallX+Ball_size >= OghostX && BallX+Ball_size <= OghostX+OghostS) 
				|| (BallX >= OghostX && BallX <= OghostX+OghostS)))   // collision on top side of ghost
				begin
                over = 1'b1;
            end
				else if ((BallY <= OghostY+OghostS) && (OghostY+OghostS <= BallY+Ball_size) && ((BallX+Ball_size >= OghostX && BallX+Ball_size <= OghostX+OghostS) 
				|| (BallX >= OghostX && BallX <= OghostX+OghostS)))   // collision on bot side of ghost
			   begin
                over = 1'b1;
            end
				else
				begin
					over = 1'b0;
			   end
        end
endmodule

