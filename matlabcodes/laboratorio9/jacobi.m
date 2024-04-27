function [x,res,it] = jacobi(A,b,x,itmax,eps)
%%JACOBI implementa il metodo di Jacobi per la soluzione del sistema A x = b
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

res = zeros(itmax,1);

% Controlliamo che la prima iterazione non abbia già soddisfatto la
% convergenza
res(1) = norm(A*x - b);
if res(1) < eps
    fprintf("Jacobi ha raggiunto la convergenza in %d iterazioni r(%d) = %1.2e\n",...
        1,1,res(1));
    it = 1;
    res = res(1);
    return
end

D = diag(A);
N = diag(D) - A;
q = b./D;
for it = 2:itmax
    x = (N*x)./D + q;
    res(it) = norm(A*x-b);
    fprintf("Jacobi iterazione %d residuo %1.2e\n",it,res(it));
    if res(it) < eps
        fprintf("\tJacobi ha raggiunto la convergenza in %d iterazioni r(%d) = %1.2e\n",...
            it,it,res(it));
        res = res(1:it);
        return
    end
end
fprintf("\tJacobi non ha raggiunto la convergenza in %d iterazioni, ultimo residuo è r(%d) = %1.2e\n",...
    it,it,res(it));


end