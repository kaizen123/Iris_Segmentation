%Script de testeo para algoritmo que permita detectar párpado superior (basado en método de Minkowski/tesis de Daniel Contreras)
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%LECTURA IMAGEN

pc_folder = 'Koky';
carpeta = 'Iris_Segmentation';
directions = direcciones(pc_folder, carpeta);


for iteration=108:108
rect = 0;
tic
resize = 0.5;
cancer = iteration;
I = lectura_2(directions, cancer, resize);
I_original = lectura_2(directions, cancer, 1);

I_iris = lectura_2(directions, cancer, 0.15);
row=length(I(:,1,1));
col=length(I(1,:,1));

%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Obtención de datos sobre posición y radio del iris detectado
[centro, radio] = datos_iris(I_iris,0.15);
centro2=centro*resize;
cx=centro2(1);
cy=centro2(2);
radio2=radio*resize;
% figure()
% imshow(I_original)
% viscircles(centro, radio, 'EdgeColor','b');
% figure()
% imshow(I)
% viscircles(centro2, radio2, 'EdgeColor','b');

%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Cálculo de dimensiones para rectángulos de detección
W = floor(0.15*radio2);
H = floor(0.1*radio2);
%-----------------------------------------------------------------------------------------------------------------------------------------------------
%Iteración sobre ángulos desde -30 a 45 grados-> total de 75 grados.
pause(5)
delta = 1;
angulosder = -20:delta:45;
angulosizq = 135:delta:200;
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
    try
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
    catch        
        rect = 1;
    end
end

if rect==0
%figure
%imshow(I3)
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
cx_der = floor((xd_esc + xd_par)/2);
cy_der = floor((yd_esc + yd_par)/2);
c_der(1) = cx_der;
c_der(2) = cy_der;
xi_esc = floor(cx + d1*cos(rad2));
yi_esc = floor(cy - d1*sin(rad2));
xi_par = floor(cx + d2*cos(rad2));
yi_par = floor(cy - d2*sin(rad2));
cx_izq = floor((xi_esc + xi_par)/2);
cy_izq = floor((yi_esc + yi_par)/2);
c_izq(1) = cx_izq;
c_izq(2) = cy_izq;
RGB = insertShape(I,'FilledCircle',[cx_der cy_der 5],'LineWidth',2,'Color','yellow');
RGB = insertShape(RGB,'FilledCircle',[cx_izq cy_izq 5],'LineWidth',2,'Color','yellow');
% figure
% imshow(RGB)
%toc
u=3;
% viscircles(centro2, 5, 'EdgeColor','b');
%-------------------------------------------------------------------------------------------------------------------------------------------------------
%Cálculo de pendientes y trazado de rectas
m1 = -(cy_der-cy_izq)/(cx_der-cy_izq);
m2 = -1/m1;
if m2 >0
    angulo = atan(m2);
else
    angulo = atan(m2)+pi;
end    
coefs = 0:0.01:1.2;
%I4=I;
white = [255,255,255];
RGB2 = insertShape(RGB,'FilledCircle',[cx cy 5],'LineWidth',2,'Color','yellow');
% imshow(RGB2)
x_v = zeros(1,length(coefs));
y_v = zeros(1,length(coefs));
for i = 1:length(coefs)
    xp = floor(cx+radio2*coefs(i)*cos(angulo));
    yp = floor(cy-radio2*coefs(i)*sin(angulo));
    if yp<1 || xp<1
    i=i-1;
        break
    end
    x_v(i)=xp;
    y_v(i)=yp;
end
x_v2 = x_v(1:i);
y_v2 = y_v(1:i);
RGB3 = insertShape(RGB2,'Line',[x_v2(1) y_v2(1) x_v2(end) y_v2(end) ],'LineWidth',2,'Color','yellow');
% imshow(RGB3)
RGB4 = insertShape(RGB3,'Line',[cx_izq cy_izq cx_der cy_der],'LineWidth',2,'Color','yellow');
% imshow(RGB4)
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%Búsqueda del tercer punto
%Parte preliminar: intersectar pupila con recta anterior
[iris, iris_square] = just_iris( I_original, centro, radio);
%figure, imshow(iris_square),
[centro_pupila, radio_pupila] = finding_retina(iris_square, radio);
pupila_real_center = centro_real(centro, radio, centro_pupila);
cx_pup = pupila_real_center(1)*resize;
cy_pup = pupila_real_center(2)*resize;
r_pup = radio_pupila*resize;
RGB5 = insertShape(RGB4,'Circle',[cx_pup cy_pup r_pup],'LineWidth',5,'Color','blue');
% imshow(RGB5)
%Version original
recta = zeros(1,length(x_v2));
recta3d = zeros(length(x_v2),3);
gray=rgb2gray(I);
blue = [0,0,255];
for i=1:length(x_v2)
    recta(1,i) = gray(y_v2(i),x_v2(i)); 
    recta3d(i,:) = RGB5(y_v2(i),x_v2(i),:);
    if recta3d(i,:)==blue
        f_pup=i;
    end   
end
f_pup=f_pup+2;
RGB6 = insertShape(RGB5,'Line',[x_v2(f_pup) y_v2(f_pup) x_v2(end) y_v2(end) ],'LineWidth',2,'Color','red');
%imshow(RGB6)
coef_inicial = coefs(f_pup);
recta_cortada = recta(f_pup:end);
[maximo3 ind3] = min(recta_cortada);
cx_cen = x_v2(ind3+f_pup);
cy_cen = y_v2(ind3+f_pup);
RGB7 = insertShape(RGB6,'FilledCircle',[cx_cen cy_cen 5],'LineWidth',2,'Color','yellow');
% imshow(RGB7)
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%Cálculo de coeficientes de parábola resultante que ajusta los 3 puntos
M = [cx_izq^2 cx_izq 1 ; cx_cen^2 cx_cen 1 ; cx_der^2 cx_der 1];
B = [cy_izq ; cy_cen ; cy_der];
A = M^(-1)*B;
if A(1)<0 || A(2)<-5 || A(2)>0
    disp('Parábola no válida')
else
    disp('k')
end
%--------------------------------------------------------------------------------------------------------------------------------------------------------
%Cálculo de puntos pertenecientes a la parábola descrita + 
x_aju = cx_izq:1:cx_der;
y_aju = zeros(1,length(x_aju));
blue = [0,0,255];
mascara = I;
black = [0,0,0];

for i = 1:length(x_aju)
    y_aju(i) = floor(A(1)*x_aju(i)^2+A(2)*x_aju(i)+A(3));
    y_vector = 1:1:y_aju(i);
    for k = 1:length(y_vector)
        mascara(y_vector(k),x_aju(i),:) = black;
    end    
    RGB7(y_aju(i),x_aju(i),:) = blue;       
end 
figure()
imshow(RGB7)
titulo = strcat('Imagen Número',' ');
titulo = strcat(titulo,num2str(iteration));
title(titulo);
%figure()
%imshow(mascara)
else
    display('Rectangulos se salen de la imagen')
end
toc
end    





