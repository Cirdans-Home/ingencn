function [x] = forwardsolve(A,b)
%FORWARDSOLVE Se A è una matrice triangolare inferiore risolve sistema
%Ax=b tramite metodo di sostituzione in avanti.
%   Input:
%   A = matrice triangolare inferiore
%   b = vettore del termine note
%   Output:
%   x = vettore della soluzione

if ~istril(A)
    error("La matrice deve essere triangolare inferiore");
end

[n,m] = size(A);
if n ~= m
    error("La matrice deve essere quadrata");
end

x = zeros(n,1);
x(1) = b(1)/A(1,1);
for i = 2:n
    x(i) = (b(i)-A(i,1:i-1)*x(1:i-1))/A(i,i);
    x(i) = (b(i)-sum(A(i,1:i-1).*x(1:i-1)'))/A(i,i);
end
end

