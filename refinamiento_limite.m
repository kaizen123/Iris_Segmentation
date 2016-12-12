function [subimage] = refinamiento_limite(imagen, centro, radio)
% se analiza un cuadrado centrado en centro y de lado 2*radio
centro_x = centro(2);  %% centro(2) porque columna es como eje x
centro_y = centro(1);  %% centro(1) porque filas es como eje y
X_length = length(imagen(:,1));
Y_length = length(imagen(1,:));

radio_2 = radio*1.2; % nuevo radio que posee 
y1 = posicion_limite(floor(centro_y-radio_2),Y_length);
y2 = posicion_limite(floor(centro_y+radio_2),Y_length);
x1 = posicion_limite(floor(centro_x-radio_2),X_length);
x2 = posicion_limite(floor(centro_x+radio_2),X_length);

subimage = imagen(x1:x2,y1:y2);
final_image = subimage;

filas_sub = length(subimage(:,1));
columnas_sub = length(subimage(1,:));
disco_interior = nan*ones(filas_sub, columnas_sub);
disco_exterior = nan*ones(filas_sub, columnas_sub);


figure(), imshow(subimage);

for i=1:(2*radio_2)
    for j=1:(2*radio_2)
        try
            distance = sqrt((i-radio_2)^2 + (j-radio_2)^2);
            if (distance > radio) && (distance < radio_2)
                disco_exterior(i,j) = subimage(i,j);
            end
            if (distance < radio) && (distance > radio*0.8)
                disco_interior(i,j) = subimage(i,j);
            end
        catch
            distance = radio_2*2;            
        end            
    end
end

%figure(), imshow(uint8(disco_exterior))
%figure(), imshow(uint8(disco_interior))

I_ext = gpuArray(uint8(disco_exterior));
I_int = gpuArray(uint8(disco_interior));

[counts_ext,x_ext] = imhist(I_ext);
[counts_int,x_int] = imhist(I_int);

N=length(x_ext);

figure()
stem(x_ext(2:N-1), counts_ext(2:N-1));
hold on
stem(x_int(2:N-1), counts_int(2:N-1));

inter = primera_insterseccion(counts_int(2:N-1), counts_ext(2:N-1), x_int(2:N-1));

for i=1:(2*radio-2)
    for j=1:(2*radio_2)
        try
            distance = sqrt((i-radio_2)^2 + (j-radio_2)^2);
            if (distance > radio*0.8) && (distance < radio_2) && (subimage(i,j) > inter)
                final_image(i,j) = nan;
            end

        catch
            distance = radio_2*2;            
        end            
    end
end

figure, imshow(uint8(final_image))

%hold on
%imhist(disco_interior)

end


        
            
        
