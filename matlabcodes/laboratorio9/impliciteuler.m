function [y,x] = impliciteuler(f,y0,a,b,h)
%%IMPLICITEULER implementa il metodo di Eulero implicito per la soluzione
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
hbar = waitbar(1/N,"Integrazione in corso");
for i=2:N
    F = @(yn) yn - h*f(x(i),yn) - y(:,i-1);
    y(:,i) = fsolve(F,y(:,i-1),...
        optimoptions('fsolve','Display','none','FunctionTolerance',1e-9));
    waitbar((i/N),hbar,"Integrazione in corso");
end
close(hbar);

end