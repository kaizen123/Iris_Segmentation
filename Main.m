main_folder = 'RGB Images';
for i=50:60
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
        [centers_blue, radii_blue] = find_circles(J,Rmin,Rmax,0.965);
        
        centros = centers_blue;
        radios = radii_blue;
        [iris_center, iris_radio] = compare_white_r (binaria, centros, radios);
        
        
        Rmin = 120;
        Rmax = 130;
        [centers_big, radii_big] = find_circles(J,Rmin,Rmax,0.95);
        
        viscircles(centers_blue, radii_blue, 'EdgeColor','b');
        viscircles(iris_center, iris_radio,'EdgeColor','r');
        viscircles(centers_big, radii_big,'EdgeColor','g');

    end
end

