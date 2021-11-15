function [x] = backwardsolve(A,b)
%BACKWARDSOLVE Se A è una matrice triangolare superiore risolve sistema
%Ax=b tramite metodo di sostituzione all'indietro.
%   Input:
%   A = matrice triangolare inferiore
%   b = vettore del termine note
%   Output:
%   x = vettore della soluzione

if ~istriu(A)
    error("La matrice deve essere triangolare superiore");
end

[n,m] = size(A);
if n ~= m
    error("La matrice deve essere quadrata");
end

x = zeros(n,1);

if abs(A(n,n)) > eps
    x(n,1) = b(n,1)/A(n,n);
else
    warning("Elemento diagonale piccolo o nullo");
end

for i = n-1:-1:1
    if abs(A(i,i)) > eps
        x(i,1) = (b(i,1)-A(i,i+1:end)*x(i+1:end,1))/A(i,i);
    else
        warning("Elemento diagonale piccolo o nullo");
    end
end



end

