function [just_iris_2_image] = just_iris_2(square_image, centro_pupila, radio_pupila)
rows = length(square_image(:,1,1));
cols = length(square_image(1,:,1));
N = min(rows, cols);
center = N/2;
just_iris_2_image = square_image;

row_C = centro_pupila(2);        %% Coordenada fila del centro
col_C = centro_pupila(1);        %% Coordenada columna del centro
row1 = floor(row_C - radio_pupila);
row2 = floor(row_C + radio_pupila);
col1 = floor(col_C - radio_pupila);
col2 = floor(col_C + radio_pupila);
for i=1:N
    for j=1:N
        distance = sqrt((i-center)^2 + (j-center)^2);
        if distance >= center
            just_iris_2_image(i,j,1) = 0;
            just_iris_2_image(i,j,2) = 0;
            just_iris_2_image(i,j,3) = 0;
        end
        if (i>=row1 && i<=row2) && (j>=col1 && j<=col2)
            P_distance = sqrt((i-row_C)^2 + (j-col_C)^2);
            if P_distance <= radio_pupila
                just_iris_2_image(i,j,1) = 0;
                just_iris_2_image(i,j,2) = 0;
                just_iris_2_image(i,j,3) = 0;
            end
        end
    end
end
end
        
            