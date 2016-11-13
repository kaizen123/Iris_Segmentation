
main_folder = 'RGB Images';
for i=70:79
    for j=1:4
        carpeta = int2str(i);  %% AÑADIR 1 ---> 01, 79 --->79
        Nimagen = int2str(j);
        direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_L_',Nimagen,'.JPG');
        I_original = imread(direccion);  
        
        % Resizeando (vest verbo) para detección óptima
        resize_constant = 0.2; 
        I = imresize(I_original,resize_constant); 
        
        % Preprocesamiento de imagen
        gray = rgb2gray(I);
        equalizada = histeq(gray);
        binaria = imbinarize(equalizada);
        J=edge(binaria, 'Canny', 0.05);
        
        % Radios mínimos y maximos para buscar circulos, encontrados a mano
        Rmin = 60;
        Rmax = 130;
        [centros, radios] = find_circles(J,Rmin,Rmax,0.97);
        
        % Si se encontraron círculos:
        if ~isempty(centros);
            [iris_center, iris_radio] = compare_white_r (binaria, centros, radios);
            
            %figure      %% BlOQUE PARA EVALUAR DETECCION DE IRIS
            %imshow(J)   %% I -> Imagen RGB, gray, equailizada, binaria, J           
            %viscircles(centros, radios, 'EdgeColor','b');
            %viscircles(iris_center, iris_radio,'EdgeColor','r');
            
            % Reescalamiento para extraer iris con imagen de la resolución
            % original
            real_iris_center = iris_center / resize_constant;
            real_iris_radio = iris_radio / resize_constant;
            [iris, iris_square] = just_iris( I_original, real_iris_center, real_iris_radio);
            %figure
            %imshow(iris_square);   
            
            centros_pupila = finding_retina(iris_square, real_iris_radio);
        end
  
    end
end

