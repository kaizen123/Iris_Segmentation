%-----------------------------------------------------------------------------------------------------------------------------------------------------
%LECTURA IMAGEN

pc_folder = 'Koky';
carpeta = 'Iris_Segmentation';
directions = direcciones(pc_folder, carpeta);


for iteration=110:130
tic
resize = 0.2;
cancer = iteration;
I = lectura_2(directions, cancer, resize);
gray = rgb2gray(I);
I_original = lectura_2(directions, cancer, 1);
row=length(I(:,1,1));
col=length(I(1,:,1));
size = 7;
mitad = (size-1)/2;
for i=size:row-size
    for j=size:col-size
        suma = 0;
        prom = mean(mean(gray(i-mitad:i+mitad,j-mitad:j+mitad)));
        for k=-mitad:mitad
            for l=-mitad:mitad
                suma = suma + (gray(i+k,j+l)-prom)^2;
            end
        end
        suma = suma/(size^2);
        if suma < 0.1
            gray(i,j)=255;
        end    
    end
end    

toc
end
figure
imshow(rgb2gray(I))
figure
imshow(gray)