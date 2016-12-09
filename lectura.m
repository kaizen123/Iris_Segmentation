function y = lectura(i,j,lado,resize_constant)
    if i<10
        carpeta=strcat(0,int2str(i));
    else
        carpeta = int2str(i);  
    end      
    Nimagen = int2str(j);
    direccion = strcat('RGB Images\0',carpeta,'\IMG_0',carpeta,'_',lado,'_',Nimagen,'.JPG');
    %Reescalamiento de imagen
    I_original = imread(direccion);
    I = imresize(I_original,resize_constant);
    y = I;
end