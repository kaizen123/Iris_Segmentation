function [distance] = center_distance (rows, cols, centros)
N_centros = length(centros(:,1)); % Cantidad de circulos detectados 
distance = ones(N_centros, 1);
centro_rows_imag = rows/2;
centro_cols_imag = cols/2;

for i=1:N_centros
    centro_rows = centros(i,2) ;       %% Coordenada fila del centro
    centro_cols = centros(i,1);        %% Coordenada columna del centro
    distance(i) = sqrt((centro_rows_imag-centro_rows)^2+(centro_cols_imag-centro_cols)^2);
end

end