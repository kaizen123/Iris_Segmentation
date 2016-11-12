%Permite subplottear una lista de imàgenes indicando columnas y filas
%deseadas para el subplot
function out = splot(row,col,lista)    
    N_img=length(lista);  
    for n=1:N_img
        subplot(row,col,n)
        imshow(lista{n})
    end           
end