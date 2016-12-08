function y=umbral_adaptivo(imagen)
    row=length(imagen());
    col=length(imagen());
    P=0.9;
    vector=reshape(matriz,1,row*col);
    [sort index]=sort(vector,'descend');
    Iprom=mean(vector);
    nmax=floor(row*col/10);
    max=vector(1:nmax);
    Imax=mean(max);
    umbral=Iprom+P*(Imax-Iprom);
    salida=im2bw(imagen,umbral);
    y=salida;
end