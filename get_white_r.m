function [white_ratio] = get_white_r(imagen, centro, radio)
% se analiza un cuadrado centrado en centro y de lado 2*radio
centro_x = centro(2);  %% centro(2) porque columna es como eje x
centro_y = centro(1);  %% centro(1) porque filas es como eje y
X_length = length(imagen(1,:));
Y_length = length(imagen(:,1));

y1 = posicion_limite(floor(centro_y-radio),Y_length);
y2 = posicion_limite(floor(centro_y+radio),Y_length);
x1 = posicion_limite(floor(centro_x-radio),X_length);
x2 = posicion_limite(floor(centro_x+radio),X_length);
subimage = imagen(x1:x2,y1:y2);

pixels_in_circle = 0;
white_pixels = 0;

for i=1:(2*radio)
    for j=1:(2*radio)
        try
            pixel = subimage(i,j);
            distance = sqrt((i-radio)^2 + (j-radio)^2);
        catch
            distance = radio*2;
        end
        if distance <= radio            
            pixels_in_circle = pixels_in_circle + 1;
            if pixel == 1
                white_pixels = white_pixels + 1;
            end
        end
    end
end
white_ratio = white_pixels/pixels_in_circle;
end
        
            
        
