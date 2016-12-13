function [centro_real, radio_real] = finding_retina(imagen, iris_radio)
    resize_constant = 0.3;
    I = imresize(imagen,resize_constant);
    %figure(), imshow(I);
    % Preprocesamiento
    gray = rgb2gray(I);
    %figure(), imshow(gray);
    
    gray = I(:,:,1);
    %figure(), imshow(gray);
    %complemento = imcomplement(I);
    %gray = rgb2gray(complemento);
    %equalizada = histeq(gray);
    %binaria = imbinarize(gray);
    J=edge(gray, 'Canny', 0.05);
    %figure(), imshow(J)
    
    % Longitudes de filas y columnas serán necesarias mas adelante
    rows = length(gray(:,1));
    cols = length(gray(1,:));
    
    new_radio = resize_constant*iris_radio;
    Rmin = floor(0.3*new_radio);
    Rmax = floor(0.6*new_radio);
    [centros_pupila, radios_pupila] = imfindcircles(J,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', 0.956);
    %%%%%%%%%%%%%%%%% BRIGHT O DARK %%%%
    
    % Si existió detección de círculos:
    if ~isempty(centros_pupila);
        [centro_out , radio_out] = best_pupila(rows, cols, centros_pupila, radios_pupila);
        
        % Bloque para evaluar funcionamiento del detector de pupilas
%         figure
%         imshow(gray)
%         viscircles(centros_pupila, radios_pupila, 'EdgeColor','g');
%         viscircles(centro_out, radio_out, 'EdgeColor','r');
        
        % Bloque para mostrar resultado definitivo
        centro_real = centro_out/resize_constant;
        radio_real = radio_out/resize_constant;
        solo_iris = just_iris_2(imagen, centro_real, radio_real);
        %figure 
        %imshow(solo_iris)
        %viscircles(centro_real, radio_real, 'EdgeColor','r');
       
    end

end
