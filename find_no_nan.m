function [pix_r, pix_g, pix_b, distance] = find_no_nan(imagen, red, green, blue, i,j, direccion)
% direccion 1: left
% direccion 2: right
% direccion 3: up
% direccion 4: down

encontrar_no = 255;
morfo = 0;

if direccion==1
    not_found = true;
    counter = 1;
    while not_found==1
        try
            bound_pixel = imagen(i,j-counter);
            if (bound_pixel~=encontrar_no) 
                not_found = false;
                counter = counter + morfo;
                pix_r = red(i,j-counter);
                pix_g = green(i,j-counter);
                pix_b = blue(i,j-counter);
                distance = counter;
                break
            end
            counter = counter + 1;
        catch
            pix_r = 1;
            pix_g = 1;
            pix_b = 1;
            distance = 255;
            break
        end
    end
elseif direccion==2
    not_found = true;
    counter = 1;
    while not_found
        try
            bound_pixel = imagen(i,j+counter);
            if (bound_pixel~=encontrar_no) 
                not_found = false;
                counter = counter + morfo;
                pix_r = red(i,j+counter);
                pix_g = green(i,j+counter);
                pix_b = blue(i,j+counter);
                distance = counter;
                break
            end
            counter = counter + 1;
        catch
            pix_r = 1;
            pix_g = 1;
            pix_b = 1;
            distance = 255;
            break
        end
    end

            
elseif direccion==3
    not_found = true;
    counter = 1;
    while not_found
        try
            bound_pixel = imagen(i-counter,j);
            if (bound_pixel~=encontrar_no) 
                not_found = false;
                counter = counter + morfo;
                pix_r = red(i-counter,j);
                pix_g = green(i-counter,j);
                pix_b = blue(i-counter,j);
                distance = counter;
                break
            end
            counter = counter + 1;
        catch
            pix_r = 1;
            pix_g = 1;
            pix_b = 1;
            distance = 255;
            break
        end
    end

elseif direccion==4
    not_found = true;
    counter = 1;
    while not_found
        try
            bound_pixel = imagen(i+counter,j);
            if (bound_pixel~=encontrar_no) 
                not_found = false;
                counter = counter + morfo;
                pix_r = red(i+counter,j);
                pix_g = green(i+counter,j);
                pix_b = blue(i+counter,j);
                distance = counter;
                break
            end
            counter = counter + 1;
        catch
            pix_r = 1;
            pix_g = 1;
            pix_b = 1;
            distance = 255;
            break
        end
    end
end
end