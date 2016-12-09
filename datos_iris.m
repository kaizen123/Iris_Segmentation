function [real_iris_center, real_iris_radio] = datos_iris(imagen)
  
            I_original = imagen

            % Resizeando (vest verbo) para detección óptima
            resize_constant = 0.15; 
            I = imresize(I_original,resize_constant); 

            % Preprocesamiento de imagen
            gray = rgb2gray(I);
            %gray = I;  %% Para infrarojas
            equalizada = histeq(gray);
            binaria = imbinarize(equalizada);
            J=edge(binaria, 'Canny', 0.05);

            % Radios mínimos y maximos para buscar circulos, encontrados a mano
            Rmin = floor(60*resize_constant/0.2);
            Rmax = floor(130*resize_constant/0.2);
            [centros, radios] = find_circles(J,Rmin,Rmax,0.97);

            % Si se encontraron círculos:
            if ~isempty(centros);
                [iris_center, iris_radio] = compare_white_r (binaria, centros, radios);

                %figure      %% BlOQUE PARA EVALUAR DETECCION DE IRIS
                %imshow(I)   %% I -> Imagen RGB, gray, equailizada, binaria, J           
                %viscircles(centros, radios, 'EdgeColor','b');
                %viscircles(iris_center, iris_radio,'EdgeColor','r');

                % Reescalamiento para extraer iris con imagen de la resolución
                % original
                real_iris_center = iris_center / resize_constant
                real_iris_radio = iris_radio / resize_constant
                %[iris, iris_square] = just_iris( I_original, real_iris_center, real_iris_radio);
                %figure
                %A = umbral(rgb2gray(iris_square),25 ,1);
                %imshow(A); 
                %figure, imshow(iris_square),

                %centros_pupila = finding_retina(iris_square, real_iris_radio);
            end
            toc;

    
end