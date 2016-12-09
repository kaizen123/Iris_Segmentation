%Script de testeo para algoritmo que permita detectar párpado superior (basado en método de Minkowski/tesis de Daniel Contreras)
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%LECTURA IMAGEN
i = 16;
j = 2;
lado = 'L';
Ioriginal=lectura(i,j,lado,1);
resize = 0.2;
I = lectura(i,j,lado,resize);
row=length(I(:,1,1));
col=length(I(1,:,1));
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Obtención de datos sobre posición y radio del iris detectado
[centro radio] = datos_iris(I,resize);
centro2=centro*resize;
cx=centro2(1);
cy=centro2(2);
radio2=radio*resize;
figure
imshow(Ioriginal)
viscircles(centro, radio, 'EdgeColor','b');
imshow(I)
viscircles(centro2, radio2, 'EdgeColor','b');

%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Cálculo de dimensiones para rectángulos de detección
W = floor(0.15*radio2);
H = floor(0.1*radio2);
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Iteración sobre ángulos desde -30 a 45 grados-> total de 75 grados.
pause(5)
delta = 1;
angulos = -40:delta:50;
factores=zeros(1,length(angulos));
for k = 1:length(angulos)
    rad = angulos(k)*pi/180;
    %Definición de la posición de rectángulos de detección
    d1 = radio2*(1.1);
    d2 = radio2*(1.3);
    x_esc = floor(cx + d1*cos(rad)); 
    y_esc = floor(cy - d1*sin(rad));
    x_par = floor(cx + d2*cos(rad)); 
    y_par = floor(cy - d2*sin(rad));
    %Cálculo de promedios de intensidad en cada canal, para S_esc y S_par.
    %ROJO
    R_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,1)));
    R_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,1)));
    %VERDE
    G_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,2)));
    G_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,2)));
    %AZUL
    B_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,3)));
    B_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,3)));
    %Cálculo de factores de medida.
    g1 = 1 + (R_esc+G_esc+B_esc)/3;
    g2 = 1/(1 + (G_par+B_par)/2);
    deltagb = (G_esc-G_par + B_esc-B_par)/2;
    if deltagb > 0
        g3 = 1 + deltagb;
    else
        g3 = 1;
    end
    %Multiplicación de factores y almacenamiento en vector
    factores(k)=g1*g2*g3;
    %Visualización de rectángulos utilizados para ajuste de parámetros
    I2 = I;
    verde = [0,255,0];
    verdeW = zeros(1,W,3);
    verdeH = zeros(H,1,3);
    rojo = [255,0,0];
    rojoW = zeros(1,W,3);
    rojoH = zeros(H,1,3);
    for i=1:H
        verdeH(i,1,:)=verde;
        rojoH(i,1,:)=rojo;
    end 
    for j=1:W
        verdeW(1,j,:) = verde;
        rojoW(1,j,:) = rojo;
    end    
    I2(y_esc:y_esc+(H-1),x_esc,1:3) = verdeH;
    I2(y_esc:y_esc+(H-1),x_esc+W-1,1:3) = verdeH;
    I2(y_esc,x_esc:x_esc+W-1,1:3) = verdeW;
    I2(y_esc+(H-1),x_esc:x_esc+W-1,1:3) = verdeW;
    I2(y_par:y_par+(H-1),x_par,1:3) = rojoH;
    I2(y_par:y_par+(H-1),x_par+W-1,1:3) = rojoH;
    I2(y_par,x_par:x_par+W-1,1:3) = rojoW;
    I2(y_par+(H-1),x_par:x_par+W-1,1:3) = rojoW;
    imshow(I2)    
end
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Búsqueda del máximo en vector de factores y cálculo de la posición de



