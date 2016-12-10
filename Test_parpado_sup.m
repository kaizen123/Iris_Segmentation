%Script de testeo para algoritmo que permita detectar p�rpado superior (basado en m�todo de Minkowski/tesis de Daniel Contreras)
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
%Obtenci�n de datos sobre posici�n y radio del iris detectado
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
%C�lculo de dimensiones para rect�ngulos de detecci�n
W = floor(0.15*radio2);
H = floor(0.1*radio2);
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Iteraci�n sobre �ngulos desde -30 a 45 grados-> total de 75 grados.
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
    %Definici�n de la posici�n de rect�ngulos de detecci�n    
    x_esc = floor(cx + d1*cos(rad)); 
    y_esc = floor(cy - d1*sin(rad));
    x_par = floor(cx + d2*cos(rad)); 
    y_par = floor(cy - d2*sin(rad));
    %C�lculo de promedios de intensidad en cada canal, para S_esc y S_par.
    %ROJO
    R_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,1)));
    R_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,1)));
    %VERDE
    G_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,2)));
    G_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,2)));
    %AZUL
    B_esc = mean(mean(I(y_esc:y_esc+(H-1),x_esc:x_esc+W-1,3)));
    B_par = mean(mean(I(y_par:y_par+(H-1),x_par:x_par+W-1,3)));
    %C�lculo de factores de medida.
    g1 = 1 + (R_esc+G_esc+B_esc)/3;
    g2 = 1/(1 + (G_par+B_par)/2);
    deltagb = (G_esc-G_par + B_esc-B_par)/2;
    if deltagb > 0
        g3 = 1 + deltagb;
    else
        g3 = 1;
    end
    %Multiplicaci�n de factores y almacenamiento en vector
    if k <= length(angulosder)
        factores_der(k) = g1*g2*g3;
    else
        factores_izq(k-length(angulosder)) = g1*g2*g3;
    end       
    %factores(k)=g1*g2*g3;
    %Visualizaci�n de rect�ngulos utilizados para ajuste de par�metros
    I2=I;
    I2=rectangulos(I2,x_esc,y_esc,x_par,y_par,W,H);
    I3=rectangulos(I3,x_esc,y_esc,x_par,y_par,W,H);    
    %imshow(I2)    
end
figure
imshow(I3)
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%B�squeda de m�ximo de g y posiciones de los puntos c_izq y c_der.

[maximo1 ind1] = max(factores_der);
[maximo2 ind2] = max(factores_izq);
rad1 = angulosder(ind1)*pi/180;
rad2 = angulosizq(ind2)*pi/180;
%Definici�n de la posici�n de rect�ngulos de detecci�n
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
u=3;
% viscircles(centro2, 5, 'EdgeColor','b');
%-------------------------------------------------------------------------------------------------------------------------------------------------------
%C�lculo de pendientes y trazado de rectas
m1 = -(cy_der-cy_izq)/(cx_der-cy_izq);
m2 = -1/m1;
angulo = atan(m2);
coefs = 0:0.01:1.2;
%I4=I;
white = [255,255,255];
RGB2 = insertShape(RGB,'FilledCircle',[cx cy 5],'LineWidth',2,'Color','yellow');
imshow(RGB2)
x_v = zeros(1,length(coefs));
y_v = zeros(1,length(coefs));
for i = 1:length(coefs)
    xp = floor(cx+radio2*coefs(i)*cos(angulo));
    yp = floor(cy-radio2*coefs(i)*sin(angulo));
    x_v(i)=xp;
    y_v(i)=yp;
end   
RGB3 = insertShape(RGB2,'Line',[x_v(1) y_v(1) x_v(length(coefs)) y_v(length(coefs)) ],'LineWidth',2,'Color','yellow');
imshow(RGB3)
RGB4 = insertShape(RGB3,'Line',[cx_izq cy_izq cx_der cy_der],'LineWidth',2,'Color','yellow');
imshow(RGB4)
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%B�squeda del tercer punto
recta = zeros(1,length(coefs));
gray=rgb2gray(I);
for i=1:length(coefs)
    recta(1,i) = I(y_v(i),x_v(i));    
end
[maximo3 ind3] = min(recta);
cx_cen = x_v(ind3);
cy_cen = y_v(ind3);
RGB5 = insertShape(RGB4,'FilledCircle',[cx_cen cy_cen 5],'LineWidth',2,'Color','yellow');
imshow(RGB5)
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%C�lculo de coeficientes de par�bola resultante que ajusta los 3 puntos
M = [cx_izq^2 cx_izq 1 ; cx_cen^2 cx_cen 1 ; cx_der^2 cx_der 1];
B = [cy_izq ; cy_cen ; cy_der];
A = M^(-1)*B;
if A(1)<0 || A(2)<-5 || A(2)>0
    disp('Par�bola no v�lida')
else
    disp('k')
end
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%C�lculo de puntos pertenecientes a la par�bola descrita
x_aju = cx_izq:1:cx_der;
y_aju = zeros(1,length(x_aju));
blue = [0,0,255];

for i=1:length(x_aju)
    y_aju(i) = floor(A(1)*x_aju(i)^2+A(2)*x_aju(i)+A(3));
    RGB5(y_aju(i),x_aju(i),:) = blue;       
end 
figure
imshow(RGB5)
    





