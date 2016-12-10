function [imagen] = lectura_2(direcciones, numero_imagen, resize_constant) 
a = strjoin(direcciones(numero_imagen));
I_original = imread(a);
imagen = imresize(I_original,resize_constant);
end