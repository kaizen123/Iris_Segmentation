%recibe una imagen con 255's en los lugares donde hay reflejos
%solo busca rellena reflejos dentro del radio del iris

function out = fill_in(mask, rgb)
fil = length(mask(:,1));
col = length(mask(1,:));

out = rgb;
just_red = rgb(:,:,1);
just_green = rgb(:,:,2);
just_blue = rgb(:,:,3);

radio = floor(fil/2);

for i=1:fil
    for j=1:col
        inside = 0;
        distance = sqrt((i-radio)^2 + (j-radio)^2);
        if distance < radio
            inside = 1;
        
        if (mask(i,j)==255 && inside ==1 )
            num_r = 0;
            num_g = 0;
            num_b = 0;
            den = 0;
            for k=1:4
                [r , g , b , d] = find_no_nan(mask, just_red, just_green, just_blue, i,j, k);
                add_r = (1/d)*r;
                add_g = (1/d)*g;
                add_b = (1/d)*b;
                add_den = (1/d);
                num_r = num_r + add_r;
                num_g = num_g + add_g;
                num_b = num_b + add_b;
                den = den + add_den;
            end
            out(i,j,1) = num_r/den;
            out(i,j,2) = num_g/den;
            out(i,j,3) = num_b/den;
        end
        
    end
end
end
             
            
            
            
