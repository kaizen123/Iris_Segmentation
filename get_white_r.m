function [white_ratio] = get_white_r(imagen, centro, radio)
% se analiza un cuadrado centrado en centro y de lado 2*radio
centro_x = centro(1);
centro_y = centro(2);
y1 = floor(centro_x-radio);
y2 = floor(centro_x+radio);
x1 = floor(centro_y-radio);
x2 = floor(centro_y+radio);
subimage = imagen(x1:x2,y1:y2);

pixels_in_circle = 0;
white_pixels = 0;

for i=1:(2*radio)
    for j=1:(2*radio)
        distance = sqrt((i-radio)^2 + (j-radio)^2);
        if distance <= radio
            pixels_in_circle = pixels_in_circle + 1;
            if subimage(i,j) == 1
                white_pixels = white_pixels + 1;
            end
        end
    end
end
white_ratio = white_pixels/pixels_in_circle;
end
        
            
        
