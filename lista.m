%Crea una lista de objetos. Tiene como salida la cantidad de inputs y
%outputs de la funci�n, as� como tambi�n dicha lista.
function varargout=lista(varargin)
    varargout{1}=varargin;
    varargout{2}=nargin;
    varargout{3}=nargout;    
end