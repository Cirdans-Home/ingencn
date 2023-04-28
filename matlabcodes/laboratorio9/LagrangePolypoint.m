function L = LagrangePolypoint(x, z, j)
%%LAGRANGEPOLY costruisce il k-esimo polinomio di Lagrange dati i nodi
% di interpolazione x e lo valuta nel punto z
%    INPUT:
%          x vettore degli n+1 nodi di interpolazione
%          z punto di valutazione del polinomio
%          j indice the polinomio di Lagrange
%   OUTPUT:
%          L j-esimo polinomio di Lagrange valutato nel punto z

assert(j<=length(x));
xv = setdiff(x,x(j));
L = prod(z-xv)/prod(x(j)-xv);

end
