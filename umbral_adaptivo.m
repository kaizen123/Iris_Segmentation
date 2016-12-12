function [y] = umbral_adaptivo(imagen)
    row=length(imagen(:,1));
    col=length(imagen(1,:));
    P=0.9;
    factor = 1;
    vector=reshape(imagen,1,row*col);
    [vector , ~] = sort(vector,'descend');
    Iprom = mean(vector);
    nmax = floor(row*col/10);
    max = vector(1:nmax);
    Imax = mean(max);
    umbral_num = (Iprom+P*(Imax-Iprom))*factor;
    salida1 = im2bw(imagen,umbral_num/255);
    salida = umbral(imagen,umbral_num, 1);
    
%     figure()
%     subplot(1,2,1)
%     imshow(salida1)
%     subplot(1,2,2)
%     imshow(salida)
    
    y=salida;
end