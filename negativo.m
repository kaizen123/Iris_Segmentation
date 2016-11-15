function out = negativo(img)
    fil=length(img(:,1));
    col=length(img(1,:));
    for i=1:fil
        for j=1:col
            out(i,j)=1-img(i,j);
        end
    end    
end