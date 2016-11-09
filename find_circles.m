function [centros, radios] = find_circles(Image, Rmin, Rmax, sensitivity)
[centros, radios] =imfindcircles(Image,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', sensitivity);
end


%% Funcion creada para evitar escribir siempre OBject Polarity = dark
%% y Sensitivity = sensibilidad que se desee