function [x,res,it] = forwardgs(A,b,x,itmax,eps)
%%FORWARDGS implementa il metodo di Gauss-Seidel in avanti per la soluzione del
% sistema A x = b
%    INPUT:
%     A matrice quadrata
%     b termine destro del sistema lineare da risolvere
%     x innesco della strategia iterativa
%     itmax massimo numero di iterazioni lineari consentito
%    OUTPUT
%     x ultima soluzione calcolata dal metodo
%     res vettore dei residui
%     it numero di iterazioni

[n,m] = size(A);
if n ~= m
    error("A deve essere quadrata");
end

% Controlliamo che la prima iterazione non abbia già soddisfatto la
% convergenza
res = zeros(itmax,1);
res(1) = norm(A*x - b,2);
if res(1) < eps
    fprintf("forwardgs ha raggiunto la convergenza in %d iterazioni r(%d) = %1.2e\n",...
        1,1,res(1));
    it = 1;
    res = res(1);
    return
end

L = tril(A);
N = L - A;
%bhat = forwardsolve(L,b);
bhat = L\b;
for it = 2:itmax
    %x = forwardsolve(L,N*x) + bhat;
    x = L\(N*x) + bhat;
    res(it) = norm(A*x-b);
    fprintf("forwardgs iterazione %d residuo %1.2e\n",it,res(it));
    if res(it) < eps*res(1)
        fprintf("\tforwardgs ha raggiunto la convergenza in %d iterazioni r(%d) = %1.2e\n",...
            it,it,res(it));
        res = res(1:it);
        return
    end
end
fprintf("\tforwardgs non ha raggiunto la convergenza in %d iterazioni, ultimo residuo è r(%d) = %1.2e\n",...
    it,it,res(it));



end