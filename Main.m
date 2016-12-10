pc_folder = 'Nico';
carpeta = 'Iris_Segmentation';
directions = direcciones('Nico', 'Iris_Segmentation');

for j=11:11
    I_original = lectura_2(directions, j, 1);

    % Resizeando (vest verbo) para detección óptima
    resize_constant = 0.15; 
    I = imresize(I_original,resize_constant); 

    % Preprocesamiento de imagen
    gray = rgb2gray(I);
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

        % Reescalamiento para extraer iris con imagen de la resolución original
        real_iris_center = iris_center / resize_constant;
        real_iris_radio = iris_radio / resize_constant;
        % Mostrar Iris en imagen original
        %figure, imshow(I_original)
        %viscircles(real_iris_center, real_iris_radio, 'EdgeColor','b');

        % Mostrar imagen cuadrada solo con el iris circunscrito
        [iris, iris_square] = just_iris( I_original, real_iris_center, real_iris_radio);
        %figure, imshow(iris_square),

        % 
        [centros_pupila, radio_pupila] = finding_retina(iris_square, real_iris_radio);

        % Rellenado de la imagen
        %no_reflex = sin_reflejos(iris_square, 0.5, 7);
        
        % Aplicación de filtros medianos
%         no_reflex_original = no_reflex;       
%         med = [4 4];
%         no_reflex(:,:,1) = medfilt2(no_reflex(:,:,1), med);
%         no_reflex(:,:,2) = medfilt2(no_reflex(:,:,2), med);
%         no_reflex(:,:,3) = medfilt2(no_reflex(:,:,3), med);
%         % O gaussianos 
%         %no_reflex(:,:,1) = imgaussfilt(no_reflex(:,:,1), med);
%         %no_reflex(:,:,2) = imgaussfilt(no_reflex(:,:,2), med);
%         %no_reflex(:,:,3) = imgaussfilt(no_reflex(:,:,3), med);

%         figure(),imshowpair(no_reflex_original,no_reflex,'montage')

        % Refinamiento límite límbico
%         K = 0.5;
%         resized_original = imresize(I_original, K);
%         centro = real_iris_center*K;
%         radio = real_iris_radio*K;
%         prueba = refinamiento_limite(rgb2gray(I_original), real_iris_center, real_iris_radio);
        
    end
end


