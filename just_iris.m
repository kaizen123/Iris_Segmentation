function [iris] = just_iris(image, center, radio)
%%% Recibe una imagen, más el centro y el radio del iris detectado para
%%% eliminar (dejar en negro) toda parte de la imagen que no corresponde al
%%% iris
iris = image;

centro_rows = center(2);        %% Coordenada fila del centro
centro_cols = center(1);        %% Coordenada columna del centro 
rows = length(image(:,1,1));      %% Cantidad de filas
cols = length(image(1,:,1));      %% Cantidad de columnas

% Se obtienen los puntos del cuadrado circunscrito al iris
row_1 = posicion_limite(floor(centro_rows - radio), rows);
row_2 = posicion_limite(floor(centro_rows + radio), rows);
col_1 = posicion_limite(floor(centro_cols - radio), cols);
col_2 = posicion_limite(floor(centro_cols + radio), cols);

% Sectores fuera del cuadrado circunscrito
for channel=1:3
    iris(1:rows, 1:col_1, channel) = 0;
    iris(1:rows, col_2:cols, channel) = 0;
    iris(1:row_1, col_1:col_2, channel) = 0;
    iris(row_2:rows, col_1:col_2, channel) =0;
end
 
 for r=row_1:row_2
     for c=col_1:col_2
         distance = sqrt((r-centro_rows)^2 + (c-centro_cols)^2);
         if distance >= radio
             iris(r,c,1) = 0;
             iris(r,c,2) = 0;
             iris(r,c,3) = 0;
         end
     end
 end

end