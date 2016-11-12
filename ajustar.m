%Reescala los valores de la imagen en base a m�ximo y m�nimos para que sea
%visible en escala de grises
function out = ajustar(matriz)   
    matriz = (matriz-min(matriz(:)))./(max(matriz(:))-min(matriz(:)));    
    matriz = uint8(matriz.*255);
    out=matriz;
end
    