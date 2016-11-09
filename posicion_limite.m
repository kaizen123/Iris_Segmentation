function [numero_out] = posicion_limite(numero, limite)
if numero<=0
    numero_out = 1;
elseif numero>0 && numero <= limite
    numero_out = numero;
else
    numero_out = limite;
end