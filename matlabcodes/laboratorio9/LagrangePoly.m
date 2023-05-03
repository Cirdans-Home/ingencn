function L = LagrangePoly(x, z, j)
%%LAGRANGEPOLY costruisce il j-esimo polinomio di Lagrange dati i nodi
% di interpolazione x e lo valuta nei vettore z
%    INPUT:
%          x vettore riga degli n+1 nodi di interpolazione
%          z vettore riga dei punti di valutazione del polinomio
%          j indice the polinomio di Lagrange
%   OUTPUT:
%          L j-esimo polinomio di Lagrange valutato in z

n = length(x);
assert(j<=n);
idx = [1:j-1,j+1:n];
L = prod(repmat(z,n-1,1)-repmat(x(idx)',1,length(z)),1)/prod(x(j)-x(idx));

% Alternativa con loop for
% L = zeros(length(z),1);
% for k = 1:length(z)
%     L(k) = prod((z(k)-x(idx))./(x(j)-x(idx)));
% end


end