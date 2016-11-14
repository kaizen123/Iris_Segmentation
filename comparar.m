%Genera una lista de 9 imagenes; la original y otras 8 a las cuales se le
%han aplicado distintos umbrales entre inicio y fin equiespaciados entre
%sí.
function out = comparar(img,inicio,fin,modo)
    delta=(fin-inicio)/7; %7 saltos y 8 valores distintos
    umbrales=inicio:delta:fin;
    img2=umbral(img,umbrales(1),modo);
    img3=umbral(img,umbrales(2),modo);
    img4=umbral(img,umbrales(3),modo);
    img5=umbral(img,umbrales(4),modo);
    img6=umbral(img,umbrales(5),modo);
    img7=umbral(img,umbrales(6),modo);
    img8=umbral(img,umbrales(7),modo);
    img9=umbral(img,umbrales(8),modo);
    out=lista(img,img2,img3,img4,img5,img6,img7,img8,img9);
end