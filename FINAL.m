pc_folder = 'Nico';
carpeta = 'Iris_Segmentation';
directions = direcciones('Nico', 'Iris_Segmentation');


for j=100:110
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

        % Reescalamiento para extraer iris con imagen de la resolución original
        real_iris_center = iris_center / resize_constant;
        real_iris_radio = iris_radio / resize_constant;
        
        no_eyelid = parpado(I_original);
        % Mostrar imagen cuadrada solo con el iris circunscrito
        [iris, iris_square] = just_iris( no_eyelid, real_iris_center, real_iris_radio);
        %figure(), imhist(rgb2gray(iris_square));
        %figure, imshow(iris_square),

        % Búsqueda de pupila 
        [centro_pupila, radio_pupila] = finding_retina(iris_square, real_iris_radio);

        no_reflex = sin_reflejos(iris_square, 0.5, 5);
        
        
        
        solo_iris = just_iris_2(iris_square, centro_pupila, radio_pupila);
        figure(), imshow(solo_iris)
 
    end
end
