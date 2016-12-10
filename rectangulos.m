function y = rectangulos(I2,x_esc,y_esc,x_par,y_par,W,H)
    verde = [0,255,0];
    verdeW = zeros(1,W,3);
    verdeH = zeros(H,1,3);
    rojo = [255,0,0];
    rojoW = zeros(1,W,3);
    rojoH = zeros(H,1,3);
    for i=1:H
        verdeH(i,1,:)=verde;
        rojoH(i,1,:)=rojo;
    end
    for j=1:W
        verdeW(1,j,:) = verde;
        rojoW(1,j,:) = rojo;
    end
    I2(y_esc:y_esc+(H-1),x_esc,1:3) = verdeH;
    I2(y_esc:y_esc+(H-1),x_esc+W-1,1:3) = verdeH;
    I2(y_esc,x_esc:x_esc+W-1,1:3) = verdeW;
    I2(y_esc+(H-1),x_esc:x_esc+W-1,1:3) = verdeW;
    I2(y_par:y_par+(H-1),x_par,1:3) = rojoH;
    I2(y_par:y_par+(H-1),x_par+W-1,1:3) = rojoH;
    I2(y_par,x_par:x_par+W-1,1:3) = rojoW;
    I2(y_par+(H-1),x_par:x_par+W-1,1:3) = rojoW;
    y = I2;
end