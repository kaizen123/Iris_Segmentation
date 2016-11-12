main_folder = 'RGB Images';
for i=36:40
    for j=1:4
        carpeta = int2str(i);  %% AÑADIR 1 ---> 01, 79 --->79
        Nimagen = int2str(j);
        direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_L_',Nimagen,'.JPG');

        I = imread(direccion);
        I = imresize(I,0.2);       

        gray = rgb2gray(I);
        equalizada = histeq(gray);
        binaria = imbinarize(equalizada);
        figure
        imshow(I)
        J=edge(binaria);
        
        Rmin = 60;
        Rmax = 120;
        [centros, radios] = find_circles(J,Rmin,Rmax,0.97);
        if ~isempty(centros);
            [iris_center, iris_radio] = compare_white_r (binaria, centros, radios);
            viscircles(centros, radios, 'EdgeColor','b');
            viscircles(iris_center, iris_radio,'EdgeColor','r');
        end
        iris = just_iris(gray, iris_center, iris_radio);
        figure
        imshow(iris)
       
    end
end

