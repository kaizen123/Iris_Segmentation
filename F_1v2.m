main_folder = 'RGB Images';
directions = direcciones('Nico', 'Iris_Segmentation');
%Iteración sobre algunas imágenes de la base de datos.
%Notar que si se descomenta pause al final del código este puede quedarse
%pegado, por lo que lo recomendable es dejarlo comentado e iterar sobre un
%número pequeño de imagenes (para no tener muchas figuras)


for j=10:10
%Reescalamiento de imagen
%I_original = imread(direccion);
I_original = lectura_2(directions, j, 1);
resize_constant = 1;
I = imresize(I_original,resize_constant);

% 2)Nuevas imagenes a partir de la original + dimensiones
gray = rgb2gray(I);
fil=length(gray(:,1));
col=length(gray(1,:));
equalizada = histeq(gray);
binaria = imbinarize(equalizada);

% 3)Testeo con distintos tipos de edge: Sobel,Prewitt,Canny,zerocross o log.
% Se pretende visualizar la aplicación de 3 tipos de edge sobre 3 imagenes distintas, por ejemplo, gray,equalizada y binaria.

%Tipos de edge:
tipo1='Prewitt';
tipo2='Canny';
tipo3='log';

%Tresholds a utilizar + sigma si se ocupa log. El valor automático de
%treshold se obtiene ingresando como argumento un paréntesis vacío ->[]
% t1=0.001;
% t2=0.1;
% t3=0.04;
% sigma=0.6;

% A1=edge(gray,tipo1,t1);   
% B1=edge(gray,tipo2,t2);    
% C1=edge(gray,'log',t3,sigma);

% A2=edge(equalizada,tipo1,t1);   
% B2=edge(equalizada,tipo2,t2);    
% C2=edge(equalizada,tipo3,t3,sigma);

% A3=edge(binaria,tipo1,t1);    
% B3=edge(binaria,tipo2,t2);   
% C3=edge(binaria,tipo3,t3,sigma);

% edges=lista(A1,B1,C1,A2,B2,C2,A3,B3,C3);
% figure
% imshow(I)
% splot(3,3,edges)

% 4) Cálculo del gradiente de la imàgen
[Gx, Gy] = imgradientxy(gray);
[Gmag, Gdir] = imgradient(Gx, Gy);
%Ajuste de resultados para que se puedan visualizar
%     Gx=ajustar(Gx);
%     Gy=ajustar(Gy);
Gmag=ajustar(Gmag);
Gdir=ajustar(Gdir);
%// Display images
figure, imshow(gray);    
%figure, imshow(I);
%figure, imshow(Gmag);
%figure, imshow(Gdir);


%5)Aplicación de filtros Gabor

%Parámetros del filtro
wavelength = 3.2;
orientation = 0;
%Resultado en magnitud y fase
[mag,phase] = imgaborfilt(gray,wavelength,orientation);
%Ajuste de resultados para que se puedan visualizar
mag=ajustar(mag);
phase=ajustar(phase);
%Aplicación de umbral sobre resultados obtenidos por Gabor
modo=2;
inicio=0;
fin=200;   
%Nuevo display de resultados: lista1 para magnitud y lista 2 para fase   
lista1=comparar(mag,inicio,fin,modo);
lista2=comparar(phase,inicio,fin,modo);
%Compara imagen original y otras 8 a las cuales se les aplicò un umbral.
figure
splot(3,3,lista1) %se puede elegir entre lista 1 y 2

%6)Aplicación de umbrales de intensidad para reflejos->modo 4(y conjuntos de pestañas?->modo 5)
%     inicio1=0;
%     fin1=50;
%     modo1=5;
%     lista3=comparar(gray,inicio1,fin1,modo1);
%     convertir(I,lista3{8})        
%     figure
%     splot(3,3,lista3)

%7)Detección de párpados
%     figure
%     imshow(Gy)
%     figure
%     imshow(Gx)
%     figure
%     imshow(Gmag)
%     figure
%     imshow(Gdir)
%     figure
%     imshow(gray)
%     e1=edge(gray,'zerocross');
%     figure
%     imshow(e1)
%     [Gx2, Gy2] = imgradientxy(Gmag);
%     [Gmag2, Gdir2] = imgradient(Gx2, Gy2);
%     %Ajuste de resultados para que se puedan visualizar    
%     Gmag2=ajustar(Gmag2);
%     Gdir2=ajustar(Gdir2);
inicio2=0;
fin2=50;
modo2=5;
lista4=comparar(Gdir,inicio2,fin2,modo2);
%     figure
%     splot(3,3,lista4)
% Pasa altos a gray
filterx=[1 1 1]; 
filtery=[-5;0;-5];
filter=filtery*filterx;
resultado=filter2(filter,Gdir,'same');
resultado=ajustar(resultado);
resultado2=filter2(filter,resultado,'same');
resultado2=ajustar(resultado2);    
%     figure
%     imshow(resultado)
rbin=comparar(resultado,100,200,5);
%     figure
%     splot(3,3,rbin)
b1=imbinarize(rbin{5});
%     figure
%     imshow(b1)
%     figure
%     imshow(binaria)
%     e2=edge(b1,'canny');
%     figure
%     imshow(e2)    
%     figure
%     imshow(Gy)
%     b2=imbinarize(Gy);
%     figure
%     imshow(b2)
%     neg=negativo(b1);
%     figure
%     imshow(neg)
%     test=entornoblanco(b1);
%     figure
%     imshow(test)
%Pasa bajos no es util
%     filterb=[1 1 1;1 1 1;1 1 1];
%     resultado3=filter2(filterb,Gx,'same');
%     resultado3=ajustar(resultado3);
%     figure
%     imshow(resultado3)
%     pause
%   
end




    



