function [y,x] = expliciteuler(f,y0,a,b,h)
%%EXPLICITEULER implementa il metodo di Eulero esplicito per la soluzione
% di un sistema di equazioni differenziali del primo ordine.
%   INPUT: f function handle della dinamica del sistema f(x,y)
%          y0 vettore delle condizioni iniziali
%          a,b estremi dell'intervallo di integrazione
%          h ampiezza del passo di integrazione
%   OUTPUT: y vettore (matrice) che contiene le soluzioni calcolate nei
%           punti x(i),
%           x vettore dei nodi

x = a:h:b;
N = length(x);

y = zeros(length(y0),N);
y(:,1) = y0;
for n=2:N
    y(:,n) = y(:,n-1) + h*f(x(n-1),y(:,n-1));
end

end
