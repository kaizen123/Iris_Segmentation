main_folder = 'RGB Images';

%Iteración sobre algunas imágenes de la base de datos.
%Notar que si se descomenta pause al final del código este puede quedarse
%pegado, por lo que lo recomendable es dejarlo comentado e iterar sobre un
%número pequeño de imagenes (para no tener muchas figuras)

%for i=47:50
%    for j=1:2
    %Aquí se puede elegir la imagen en caso de no querer iterar. Claramente se deben comentar además los 2 for (i,j)    
    i=74;
    j=2;
    %Identificar imagen actual en consola
    %i
    %j
    
    % 1)Lectura de la imagen    
    carpeta = int2str(i);  %% AÑADIR 1 ---> 01, 79 --->79
    Nimagen = int2str(j);
    direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_R_',Nimagen,'.JPG');
    %Reescalamiento de imagen
    I_original = imread(direccion);
    resize_constant = 0.2;
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
    Gmag=ajustar(Gmag);
    %Gdir=ajustar(Gdir);
    %// Display images
    figure, imshow(gray);    
    %figure, imshow(I);
    %figure, imshow(Gmag);
    %figure, imshow(Gdir);


    %Aplicación de filtros Gabor

    %Parámetros del filtro
    wavelength = 3.4;
    orientation = 0;
    %Resultado en magnitud y fase
    [mag,phase] = imgaborfilt(gray,wavelength,orientation);
    %Ajuste de resultados para que se puedan visualizar
    mag=ajustar(mag);
    phase=ajustar(phase);
    %Aplicación de umbral sobre resultados obtenidos por Gabor
    modo=2;
    inicio=0;
    fin=255;   
    %Nuevo display de resultados: lista1 para magnitud y lista 2 para fase   
    lista1=comparar(mag,inicio,fin,modo);
    lista2=comparar(phase,inicio,fin,modo);
    %Compara imagen original y otras 8 a las cuales se les aplicò un umbral.
    figure
    splot(3,3,lista1) %se puede elegir entre lista 1 y 2
%     pause
%    end
%end




    



