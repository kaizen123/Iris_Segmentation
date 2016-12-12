function [valor] = primera_insterseccion(vector1, vector2, valores)
    %Vector 2 debiese ser el histograma del disco exterior 
    resta = vector1 - vector2;
       
    N = length(valores);
    lim_inferior = 50;  %limite para evitar una deteccion en el comienzo del hisograma
      
    for i = 1 : N
        if (i > lim_inferior) && (resta(i) < 0)
            valor = i;
            break
        end
    end  
    
end