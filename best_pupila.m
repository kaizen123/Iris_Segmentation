function [centro_out , radio_out] = best_pupila(rows, cols, centros, radios)

[distance] = center_distance (rows, cols, centros);

[~,index] = sort(distance);
centro_out = centros(index(1),:); 
radio_out = radios(index(1));
end