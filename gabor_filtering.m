function [gaberino] = gabor_filtering(iris_square, wavelength)

gray = rgb2gray(iris_square);
fil=length(gray(:,1));
col=length(gray(1,:));

orientation = 0;
%Resultado en magnitud y fase
[mag,phase] = imgaborfilt(gray,wavelength,orientation);
%Ajuste de resultados para que se puedan visualizar
mag=ajustar(mag);
phase=ajustar(phase);
%Aplicación de umbral sobre resultados obtenidos por Gabor
modo=1;
inicio=0;
fin=200;   
%Nuevo display de resultados: lista1 para magnitud y lista 2 para fase   
lista1=comparar(mag,inicio,fin,modo);
lista2=comparar(phase,inicio,fin,modo);
%Compara imagen original y otras 8 a las cuales se les aplicò un umbral.
%figure
%splot(3,3,lista1) %se puede elegir entre lista 1 y 2

gaberino = lista1{3};
%figure, imshow(gaberino)

end