function out = entornoblanco(img)
    fil=length(img(:,1));
    col=length(img(1,:));
    total=21;
    for i=20:fil-20
        for j=10:col-20
            blanco=sum(sum(img(i-3:i+3,j-3:j+3)));
            ratio=blanco/total;
            if ratio>0.7
                out(i,j)=1;
            else
                out(i,j)=0;
            end    
        end
    end
end