%Script de testeo para algoritmo que permita detectar párpado superior (basado en método de Minkowski/tesis de Daniel Contreras)
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%LECTURA IMAGEN
tic
i = 40; %Imagen 1 = 16,2. %Imagen 2 = 40,2 , %Angulos de -30 a 50 y 130 a 220. Factores de radios = 1.1 y 1.4
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
angulosder = -40:delta:50;
angulosizq = 130:delta:220;
angulos = horzcat(angulosder,angulosizq);
% angulos = -40:delta:50;
%angulos = 130:delta:220;
%factores=zeros(1,length(angulos));
factores_der = zeros(1,length(angulosder));
factores_izq = zeros(1,length(angulosizq));
d1 = radio2*(1.1);
d2 = radio2*(1.4);
I2 = I;
I3 = I;
%figure
for k = 1:length(angulos)
    rad = angulos(k)*pi/180;
    %Definición de la posición de rectángulos de detección    
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
    if k <= length(angulosder)
        factores_der(k) = g1*g2*g3;
    else
        factores_izq(k-length(angulosder)) = g1*g2*g3;
    end       
    %factores(k)=g1*g2*g3;
    %Visualización de rectángulos utilizados para ajuste de parámetros
    I2=I;
    I2=rectangulos(I2,x_esc,y_esc,x_par,y_par,W,H);
    I3=rectangulos(I3,x_esc,y_esc,x_par,y_par,W,H);    
    %imshow(I2)    
end
figure
imshow(I3)
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Búsqueda de máximo de g y posiciones de los puntos c_izq y c_der.

[maximo1 ind1] = max(factores_der);
[maximo2 ind2] = max(factores_izq);
rad1 = angulosder(ind1)*pi/180;
rad2 = angulosizq(ind2)*pi/180;
%Definición de la posición de rectángulos de detección
xd_esc = floor(cx + d1*cos(rad1));
yd_esc = floor(cy - d1*sin(rad1));
xd_par = floor(cx + d2*cos(rad1));
yd_par = floor(cy - d2*sin(rad1));
cx_der = (xd_esc + xd_par)/2;
cy_der = (yd_esc + yd_par)/2;
c_der(1) = cx_der;
c_der(2) = cy_der;
xi_esc = floor(cx + d1*cos(rad2));
yi_esc = floor(cy - d1*sin(rad2));
xi_par = floor(cx + d2*cos(rad2));
yi_par = floor(cy - d2*sin(rad2));
cx_izq = (xi_esc + xi_par)/2;
cy_izq = (yi_esc + yi_par)/2;
c_izq(1) = cx_izq;
c_izq(2) = cy_izq;
RGB = insertShape(I,'FilledCircle',[cx_der cy_der 5],'LineWidth',2,'Color','yellow');
RGB = insertShape(RGB,'FilledCircle',[cx_izq cy_izq 5],'LineWidth',2,'Color','yellow');
figure
imshow(RGB)
toc
u=2;
% viscircles(centro2, 5, 'EdgeColor','b');





