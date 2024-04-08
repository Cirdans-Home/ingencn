function [Bk] = nbernoulli(k)
%BERNOULLI Produce i numeri di Bernoulli B_{2j}(0) per j=0,...,k risolvendo
%un sistema triangolare inferiore.
%   INPUT:
%   k =  Numero di termini (-1) da calcolare
%   OUTPUT:
%   Bk = Vettore di lunghezza k+1 che contiene i numeri richiesti

A = zeros(k+1,k+1);
for j=0:k
    for i=0:j
       A(j+1,i+1) = nchoosek(2*(j+1),2*i); 
    end
end
b = (1:k+1)';
Bk = forwardsolve(A,b);

end

