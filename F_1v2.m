main_folder = 'RGB Images';

%Iteraci�n sobre algunas im�genes de la base de datos.
%Notar que si se descomenta pause al final del c�digo este puede quedarse
%pegado, por lo que lo recomendable es dejarlo comentado e iterar sobre un
%n�mero peque�o de imagenes (para no tener muchas figuras)
%for i=47:50
%    for j=1:2
    %Aqu� se puede elegir la imagen en caso de no querer iterar. Claramente se deben comentar adem�s los 2 for (i,j)    
    i=74;
    j=2;
    %Identificar imagen actual en consola
    %i
    %j
    
    %Lectura de la imagen    
    carpeta = int2str(i);  %% A�ADIR 1 ---> 01, 79 --->79
    Nimagen = int2str(j);
    direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_R_',Nimagen,'.JPG');

    I_original = imread(direccion);
    resize_constant = 0.2;
    I = imresize(I_original,resize_constant);
    
    %Nuevas imagenes a partir de la original
    gray = rgb2gray(I);
    fil=length(gray(:,1));
    col=length(gray(1,:));
    %equalizada = histeq(gray);
    %binaria = imbinarize(equalizada);

    %Testeo con distintos tipos de edge, aun falta ordenar esto si se quiere presentar alg�n resultado. 
    % J=edge(binaria);
    %Tresholds a utilizar + sigma si se ocupa log.
    % t1=0.001;
    % t2=0.1;
    % t3=0.04;
    % sigma=0.6;

    % A1=edge(gray,'Prewitt',t1);
    % A1=edge(gray,'zerocross',t1);
    % B1=edge(gray,'Canny',t2);
    % C1=edge(gray,'Sobel');
    % C1=edge(gray,'log',t3,sigma);

    % A2=edge(equalizada,'Prewitt',t1);
    % A2=edge(equalizada,'zerocross',t1);
    % B2=edge(equalizada,'Canny',t2);
    % C2=edge(equalizada,'Sobel');
    % C2=edge(equalizada,'log',t3,sigma);

    % A3=edge(binaria,'Prewitt',t1);
    % A3=edge(binaria,'zerocross',t1);
    % B3=edge(binaria,'canny',t2);
    % C3=edge(binaria,'Sobel');
    % C3=edge(binaria,'log',t3,sigma);

    % figure
    % subplot(3,3,1)
    % imshow(A1)
    % subplot(3,3,2)
    % imshow(B1)
    % subplot(3,3,3);
    % imshow(C1)
    % subplot(3,3,4);
    % imshow(A2)
    % subplot(3,3,5);
    % imshow(B2)
    % subplot(3,3,6);
    % imshow(C2)
    % subplot(3,3,7);
    % imshow(A3)
    % subplot(3,3,8);
    % imshow(B3)
    % subplot(3,3,9);
    % imshow(C3)

    %C�lculo del gradiente de la im�gen
    [Gx, Gy] = imgradientxy(gray);
    [Gmag, Gdir] = imgradient(Gx, Gy);
    %Ajuste de resultados para que se puedan visualizar
    Gmag=ajustar(Gmag);
    %Gdir=ajustar(Gdir);
    %// Display images
    figure, imshow(gray);    
    %figure, imshow(I);
    %figure, imshow(Gmag);
    %figure, imshow(Gdir);


    %Aplicaci�n de filtros Gabor

    %Par�metros del filtro
    wavelength = 3.4;
    orientation = 0;
    %Resultado en magnitud y fase
    [mag,phase] = imgaborfilt(gray,wavelength,orientation);
    %Ajuste de resultados para que se puedan visualizar
    mag=ajustar(mag);
    phase=ajustar(phase);
    %Aplicaci�n de umbral sobre resultados obtenidos por Gabor
    modo=2;
    inicio=0;
    fin=175;
    delta=(fin-inicio)/7; %7 saltos y 8 valores distintos
    umbrales=inicio:delta:fin;
    mag2=umbral(mag,umbrales(1),modo);
    phase2=umbral(phase,umbrales(1),modo);
    mag3=umbral(mag,umbrales(2),modo);
    phase3=umbral(phase,umbrales(2),modo);
    mag4=umbral(mag,umbrales(3),modo);
    phase4=umbral(phase,umbrales(3),modo);
    mag5=umbral(mag,umbrales(4),modo);
    phase5=umbral(phase,umbrales(4),modo);
    mag6=umbral(mag,umbrales(5),modo);
    phase6=umbral(phase,umbrales(5),modo);
    mag7=umbral(mag,umbrales(6),modo);
    phase7=umbral(phase,umbrales(6),modo);
    mag8=umbral(mag,umbrales(7),modo);
    phase8=umbral(phase,umbrales(7),modo);
    mag9=umbral(mag,umbrales(8),modo);
    phase9=umbral(phase,umbrales(8),modo);

    %Nuevo display de resultados
    lista1=lista(mag,mag2,mag3,mag4,mag5,mag6,mag7,mag8,mag9);
    lista2=lista(phase,phase2,phase3,phase4,phase5,phase6,phase7,phase8,phase9);
    %Compara imagen original y otras 8 a las cuales se les aplic� un umbral.
    figure
    splot(3,3,lista1)
    %pause
%    end
%end




    



