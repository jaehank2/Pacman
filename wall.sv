module wall_bounds(input [9:0]  DrawX, DrawY,	
				   output logic wall_en
				   );
	        always_comb
            begin
                if (DrawX < 10'd163 || DrawX > 10'd478 || DrawY < 10'd51 || DrawY > 10'd430)    // outer bound
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd190 && DrawX < 10'd227 && DrawY > 10'd78 && DrawY < 10'd115)   // square1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd254 && DrawX < 10'd291 && DrawY > 10'd78 && DrawY < 10'd115)   // square2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd318 && DrawX < 10'd323 && DrawY < 10'd111) // stick1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd350 && DrawX < 10'd387 && DrawY > 10'd78 && DrawY < 10'd115)  // square3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd451 && DrawY > 10'd78 && DrawY < 10'd115)   // square4
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd190 && DrawX < 10'd227 && DrawY > 10'd142 && DrawY < 10'd179)  // square5
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd254 && DrawX < 10'd259 && DrawY > 10'd146 && DrawY < 10'd207)  // ver stick of tetris1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd254 && DrawX < 10'd289 && DrawY > 10'd174 && DrawY < 10'd179)  // hor stick of tetris1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd288 && DrawX < 10'd353 && DrawY > 10'd142 && DrawY < 10'd147)  // hor stick of T1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd318 && DrawX < 10'd323 && DrawY > 10'd142 && DrawY < 10'd175)   // ver stick of T1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd382 && DrawX < 10'd387 && DrawY > 10'd146 && DrawY < 10'd207)   // ver stick of tetris2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd352 && DrawX < 10'd387 && DrawY > 10'd174 && DrawY < 10'd179)   // hor stick of tetris2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd451 && DrawY > 10'd142 && DrawY < 10'd179)   // square6
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX < 10'd193 && DrawY > 10'd206 && DrawY < 10'd211) // block1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd222 && DrawX < 10'd227 && DrawY > 10'd210 && DrawY < 10'd243)  // ver stick of chair1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd192 && DrawX < 10'd227 && DrawY > 10'd238 && DrawY < 10'd243)  // hor stick of chair1
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd286 && DrawX < 10'd355 && DrawY > 10'd206 && DrawY < 10'd275)  // window
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd419 && DrawY > 10'd206 && DrawY < 10'd243)  // ver stick of chair2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd449 && DrawY > 10'd238 && DrawY < 10'd243)  // hor stick of chair2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd448 && DrawY > 10'd206 && DrawY < 10'd211) // block2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd254 && DrawX < 10'd259 && DrawY > 10'd242 && DrawY < 10'd303)  // stick2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd382 && DrawX < 10'd387 && DrawY > 10'd242 && DrawY < 10'd303)  // stick3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd190 && DrawX < 10'd227 && DrawY > 10'd270 && DrawY < 10'd307)  // square7
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd451 && DrawY > 10'd270 && DrawY < 10'd307)  //sqaure8
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd288 && DrawX < 10'd353 && DrawY > 10'd302 && DrawY < 10'd307)  // hor stick of T2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd318 && DrawX < 10'd323 && DrawY > 10'd302 && DrawY < 10'd335)  // ver stick of T2
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd192 && DrawX < 10'd227 && DrawY > 10'd334 && DrawY < 10'd339)  // hor stick of chair3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd222 && DrawX < 10'd227 && DrawY > 10'd334 && DrawY < 10'd367)  // ver stick of chair3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd256 && DrawX < 10'd289 && DrawY > 10'd334 && DrawY < 10'd339)  // block3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd352 && DrawX < 10'd385 && DrawY > 10'd334 && DrawY < 10'd339)  //block4
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd449 && DrawY > 10'd334 && DrawY < 10'd339)  // hor stick of chair4
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd414 && DrawX < 10'd419 && DrawY > 10'd334 && DrawY < 10'd367)  // ver stick of chair4
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX < 10'd193 && DrawY > 10'd366 && DrawY < 10'd371) // block5
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd288 && DrawX < 10'd353 && DrawY > 10'd366 && DrawY < 10'd371)  //hor stick of T3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd318 && DrawX < 10'd323 && DrawY > 10'd366 && DrawY < 10'd399)  // ver stick of T3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd448 && DrawY > 10'd366 && DrawY < 10'd371) // block6
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd254 && DrawX < 10'd259 && DrawY > 10'd370 && DrawY < 10'd403)  // ver stick of tetris3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd192 && DrawX < 10'd289 && DrawY > 10'd398 && DrawY < 10'd403)  // hor stick of tetris3
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd382 && DrawX < 10'd387 && DrawY > 10'd370 && DrawY < 10'd403)  // ver stick of tetris4
                begin
                    wall_en = 1'b1;
                end
                else if (DrawX > 10'd352 && DrawX < 10'd449 && DrawY > 10'd398 && DrawY < 10'd403)  // hor stick of tetris4
                begin
                    wall_en = 1'b1;
                end
                else
                begin
                    wall_en = 1'b0;
                end
            end
endmodule