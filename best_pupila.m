function [centro_out , radio_out] = best_pupila(rows, cols, centros, radios)
% Se calcula la distancia al centro de cada círculo detectado:
[distance] = center_distance (rows, cols, centros);

% Se ordenan de menor a mayor y se elige el menor
[~,index] = sort(distance);
centro_out = centros(index(1),:); 
radio_out = radios(index(1));
end