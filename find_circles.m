function [centros, radios] = find_circles(Image, Rmin, Rmax, sensitivity)
[centros, radios] =imfindcircles(Image,[Rmin Rmax],'ObjectPolarity','dark', 'Sensitivity', sensitivity);
end