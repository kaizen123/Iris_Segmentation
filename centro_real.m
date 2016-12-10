function [centro] = centro_real(centro_iris, radio_iris, centro_pupila)
centro = centro_iris-radio_iris + centro_pupila;
end