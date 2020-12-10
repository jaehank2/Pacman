module dot_sprite(input [2:0] addr,
                  output [1:0] data
                  );
            
            parameter [0:5][3:0] ROM = {

                // dot
                4'b0000,
                4'b0000,
                4'b0110,
                4'b0110,
                4'b0000,
                4'b0000
            };

            assign data = ROM[addr];
endmodule