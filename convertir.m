function image = convertir(color, gray)
row = length(gray(:,1));
col = length(gray(1,:));
image = color;

for i=1:row
    for j=1:col
        if gray(i,j) == 255
            image(i,j,1) = nan;
            image(i,j,2) = nan;
            image(i,j,3) = nan;
        end
    end
end
figure
imshow(image)
end