%Esta función tiene 4 modos de funcionamiento:
%El modo 1 lleva a blanco todos los pixeles con una intensidad MAYOR al umbral. 
%El modo 2 lleva a negro todos los pixeles cuya intensidad sea MENOR al umbral. 
%El modo 3 lleva a NaN todos los pixeles cuya intensidad sea MENOR al
%umbral.
%El modo 4 lleva a negro todos los pixeles con una intensidad MAYOR al
%umbral.
%El modo 5 lleva a blanco todos los pixeles con una intensidad MENOR al
%umbral.
function out = umbral(I,treshold,modo)
    fil=length(I(:,1));
    col=length(I(1,:));
    %Modo 1
    if modo==1
    for i=1:fil
        for j=1:col
            if I(i,j)>treshold
                I(i,j)=255;
            end    
        end            
    end
    %Modo 2
    elseif modo==2
        for i=1:fil
            for j=1:col
                if I(i,j)<treshold
                    I(i,j)=0;
                end
            end
        end 
    %Modo 3
    elseif modo==3
         for i=1:fil
            for j=1:col
                if I(i,j)<treshold
                    I(i,j)=NaN;
                end
            end
         end      
    %Modo 4
    elseif modo==4
         for i=1:fil
            for j=1:col
                if I(i,j)>treshold
                    I(i,j)=0;
                end
            end
         end
    %Modo 5
    else 
         for i=1:fil
            for j=1:col
                if I(i,j)<treshold
                    I(i,j)=255;
                end
            end
         end      
    end  
    out=I;
end