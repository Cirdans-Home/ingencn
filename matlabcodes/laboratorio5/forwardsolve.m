function [x] = forwardsolve(A,b)
%FORWARDSOLVE Se A è una matrice triangolare inferiore risolve sistema
%Ax=b tramite metodo di sostituzione in avanti.
%   Input:
%   A = matrice triangolare inferiore
%   b = vettore del termine note
%   Output:
%   x = vettore della soluzione

if ~norm(tril(A)-A) < eps
    error("La matrice deve essere triangolare superiore");
end

[n,m] = size(A);
if n ~= m
    error("La matrice deve essere quadrata");
end

x = zeros(n,1);

if abs(A(1,1)) > eps
    x(1,1) = b(1,1)/A(1,1);
else
    warning("Elemento diagonale piccolo o nullo");
end

for i = 2:n
    if abs(A(i,i)) > eps
        x(i,1) = (b(i,1)-A(i,1:i-1)*x(1:i-1,1))/A(i,i);
    else
        warning("Elemento diagonale piccolo o nullo");
    end
end



end

