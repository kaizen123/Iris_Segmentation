function [centro_out , radio_out] = compare_white_r (imagen_binaria, centros, radios)
%%%%%%%%%%%% Para el arreglo de centros y radios entregado por find_circles
%%%%%%%%%%%% entrega el centro y radio que cumple con el criterio de tener
%%%%%%%%%%%% una menor proporción de pixeles blancos.

%%% ¡¡¡Esta función no debería ser llamada en casos en los cuales no exista 
%%% deteccion y N sea 0 !!!

%%% Armar arreglo de white_ratios
N_datos = length(centros(:,1));  
white_ratios = ones(N_datos,1);
limite = 0.06; %% limite para analizar white_ratios pequeños
special_case = 0;  %% Caso especial, detección de varios circulos dentro del iris
for i=1:N_datos
    center = centros(i,:);
    radio = radios(i);
    white_ratio = get_white_r(imagen_binaria, center, radio);
    if white_ratio <= limite
        special_radios(i) = radio;
        special_centers(i,1:2) = center;
        special_case = 1;
    end
    white_ratios(i) = white_ratio;
end

if special_case == 1
    [~,index] = sort(special_radios);
    mayor = length(special_radios); %% Se elige el con mayor radio
    centro_out = special_centers(index(mayor),:); 
    radio_out = special_radios(index(mayor));
    
    
else
    %%% Se ordenan los white_ratios de menor a mayor
    [~, indices] = sort(white_ratios);   %%% " ~ " significa que no se necesita
    centro_out = centros(indices(1),:);  %% Se elige el que tenga menor ratio
    radio_out = radios(indices(1));
end

end





    
    