main_folder = 'RGB Images';
for i=12:12
    for j=2:2
        carpeta = int2str(i);  %% AÑADIR 1 ---> 01, 79 --->79
        Nimagen = int2str(j);
        direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_L_',Nimagen,'.JPG');

        I = imread(direccion);
        I = imresize(I,0.2);       

        gray = rgb2gray(I);
        equalizada = histeq(gray);
        binaria = imbinarize(equalizada);
        figure
        imshow(binaria)
        J=edge(binaria);

        Rmin = 35;
        Rmax = 60;
        [centers_small, radii_small] = find_circles(J,Rmin,Rmax,0.85);
        
        Rmin = 60;
        Rmax = 120;
        [centers_blue, radii_blue] = find_circles(J,Rmin,Rmax,0.965);
        
        center1 = centers_blue(1,:);
        center2 = centers_blue(2,:);
        radio1 = radii_blue(1);
        radio2 = radii_blue(2);
        
        radio_chico=get_white_r(binaria, center1, radio1)
        radio_grande=get_white_r(binaria, center2, radio2)
        
        Rmin = 120;
        Rmax = 130;
        [centers_big, radii_big] = find_circles(J,Rmin,Rmax,0.95);
        
        viscircles(centers_blue, radii_blue,'EdgeColor','b');
        viscircles(centers_big, radii_big,'EdgeColor','r');
        viscircles(centers_small, radii_small,'EdgeColor','g');
    end
end

