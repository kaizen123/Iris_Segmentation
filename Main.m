
main_folder = 'RGB Images';
for i=40:42
    for j=1:4
        carpeta = int2str(i);  %% AÑADIR 1 ---> 01, 79 --->79
        Nimagen = int2str(j);
        direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_L_',Nimagen,'.JPG');
        
        I_original = imread(direccion);
        resize_constant = 0.2;
        I = imresize(I_original,resize_constant);       
        gray = rgb2gray(I);
        equalizada = histeq(gray);
        binaria = imbinarize(equalizada);
        
        complemento = imcomplement(I);
        J=edge(binaria, 'Canny', 0.05);
        %figure
        %imshow(J)
        
        Rmin = 60;
        Rmax = 130;
        [centros, radios] = find_circles(J,Rmin,Rmax,0.97);
        if ~isempty(centros);
            [iris_center, iris_radio] = compare_white_r (binaria, centros, radios);
            %viscircles(centros, radios, 'EdgeColor','b');
            %viscircles(iris_center, iris_radio,'EdgeColor','r');
            real_iris_center = iris_center / resize_constant;
            real_iris_radio = iris_radio / resize_constant;
            [iris, iris_square] = just_iris( I_original, real_iris_center, real_iris_radio);
            %figure
            %imshow(iris_square);   
            
            finding_retina(iris_square, real_iris_radio);
        end
  
    end
end

