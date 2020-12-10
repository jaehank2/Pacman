module dot(input [9:0] DrawX, DrawY,
           output logic dot_en
           );
// dot size 4x6
           always_comb
           begin
            if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd61 && DrawY < 10'd68) // starting from top left
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd61 && DrawY < 10'd68)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd61 && DrawY < 10'd68)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd61 && DrawY < 10'd68)    // first row done
            begin
                dot_en = 1'b1;
            end


            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd93 && DrawY < 10'd100)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd93 && DrawY < 10'd100)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd93 && DrawY < 10'd100)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd93 && DrawY < 10'd100)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd93 && DrawY < 10'd100)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd93 && DrawY < 10'd100)   // second row done
            begin
                dot_en = 1'b1;
            end


            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd125 && DrawY < 10'd132)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd125 && DrawY < 10'd132)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd125 && DrawY < 10'd132)    // third row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd157 && DrawY < 10'd164)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd157 && DrawY < 10'd164)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd157 && DrawY < 10'd164)    // fourth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd189 && DrawY < 10'd196)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd189 && DrawY < 10'd196)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd189 && DrawY < 10'd196)    // fifth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd221 && DrawY < 10'd228)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd221 && DrawY < 10'd228)    // sixth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd253 && DrawY < 10'd260)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd253 && DrawY < 10'd260)    // seventh row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd285 && DrawY < 10'd292)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd285 && DrawY < 10'd292)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd285 && DrawY < 10'd292)    // eigth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd317 && DrawY < 10'd324)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd317 && DrawY < 10'd324)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd317 && DrawY < 10'd324)    // nineth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd349 && DrawY < 10'd356)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd349 && DrawY < 10'd356)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd349 && DrawY < 10'd356)    // tenth row done
            begin
                dot_en = 1'b1;
            end

            else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd381 && DrawY < 10'd388)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd381 && DrawY < 10'd388)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd381 && DrawY < 10'd388)    // eleventh row done
            begin
                dot_en = 1'b1;
            end

             else if (DrawX > 10'd174 && DrawX < 10'd179 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd206 && DrawX < 10'd211 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd238 && DrawX < 10'd243 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd270 && DrawX < 10'd275 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd302 && DrawX < 10'd307 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd332 && DrawX < 10'd337 && DrawY > 10'd413 && DrawY < 10'd420)    // 30 jump
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd364 && DrawX < 10'd369 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd396 && DrawX < 10'd401 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd428 && DrawX < 10'd433 && DrawY > 10'd413 && DrawY < 10'd420)
            begin
                dot_en = 1'b1;
            end
            else if (DrawX > 10'd464 && DrawX < 10'd469 && DrawY > 10'd413 && DrawY < 10'd420)    // last row done
            begin
                dot_en = 1'b1;
            end
        end
endmodule