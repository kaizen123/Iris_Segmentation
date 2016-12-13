function [out] = sin_reflejos(image, resize, morfo)

reflex = imresize(image,resize);        %% Se achica la imagen
gary = rgb2gray(reflex);                %% Transformacion a escala e grises
reflejos_mask = umbral_adaptivo(gary);  %% Generacion de mascara con los reflejos

SE = strel('disk',morfo);                   %% Operador para dilatar y cerrar blobs
BW2 = imdilate(reflejos_mask,SE);       %% Dilatacion de blobs
closeBW = imclose(BW2,SE);              %% Mezcla de blobs cercanos

out = fill_in(closeBW, reflex);

%%%% IMAGENES REAL, DILATACION, MEZCLA
% figure()
% subplot(1,3,1)        
% imshow(reflejos_mask)
% subplot(1,3,2)
% imshow(BW2)
% subplot(1,3,3)
% imshow(closeBW)
% 
% %%%% IMAGEN REAL, IMAGEN SALIDA
% figure()
% subplot(1,2,1)
% imshow(reflex)
% subplot(1,2,2)
% imshow(out)

end
