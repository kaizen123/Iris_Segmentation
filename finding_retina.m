function [centros_pupila] = finding_retina(imagen, iris_radio)
    resize_constant = 0.3;
    I = imresize(imagen,resize_constant);
    
    gray = rgb2gray(I);
    rows = length(gray(:,1));
    cols = length(gray(1,:));
%     complemento = imcomplement(I);
%     gray = rgb2gray(complemento);
%     equalizada = histeq(gray);
%     binaria = imbinarize(gray);
    J=edge(gray, 'Canny', 0.05);
    
    new_radio = resize_constant*iris_radio;
    Rmin = floor(0.3*new_radio);
    Rmax = floor(0.7*new_radio);
    [centros_pupila, radios_pupila] = imfindcircles(J,[Rmin Rmax],'ObjectPolarity','bright', 'Sensitivity', 0.956);
    %%%%%%%%%%%%%%%%% BRIGHT O DARK %%%% ??
    if ~isempty(centros_pupila);
        [centro_out , radio_out] = best_pupila(rows, cols, centros_pupila, radios_pupila);
        figure
        imshow(I)
        viscircles(centros_pupila, radios_pupila, 'EdgeColor','g');
        viscircles(centro_out, radio_out, 'EdgeColor','r');
    end

end