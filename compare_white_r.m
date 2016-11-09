function [centro_out , radio_out] = compare_white_r (imagen_binaria, centros, radios)
%%%%%%%%%%%% Para el arreglo de centros y radios entregado por find_circles
%%%%%%%%%%%% entrega el centro y radio que cumple con el criterio de tener
%%%%%%%%%%%% una menor proporción de pixeles blancos.

%%% ¡¡¡Esta función no debería ser llamada en casos en los cuales no exista 
%%% deteccion y N sea 0 !!!

%%% Armar arreglo de white_ratios
N_datos = length(centros(:,1));  
white_ratios = ones(N,1);
for i=1:N_datos
    center = centros(i);
    radio = radios(i);
    white_ratios(i) = get_white_r(imagen_binaria, center, radio);
end

%%% Se ordenan los white_ratios de menor a mayor
[~, indices] = sort(white_ratios);   %%% " ~ " significa que no se necesita
centro_out = centros(indices(1));  %% Se elige el que tenga menor ratio
radio_out = radios(indices(1));

%%$ A futuro mejorar el criterio de decisión, por ejemplo, normalizar por el radio.
end





    
    