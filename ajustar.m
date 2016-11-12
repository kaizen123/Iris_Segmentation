%Reescala los valores de la imagen en base a máximo y mínimos para que sea
%visible en escala de grises
function out = ajustar(matriz)   
    matriz = (matriz-min(matriz(:)))./(max(matriz(:))-min(matriz(:)));    
    matriz = uint8(matriz.*255);
    out=matriz;
end
    