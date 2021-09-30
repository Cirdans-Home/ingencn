function f = fibonaccinonrecursive(n)
%FIBONACCINONRECURSIVE Implementazione non ricorsiva della successione 
% di Fibonacci. Prende in input il numero n e restituisce un vettore
% che contiene tutti i numeri di Fibonacci da F0 a Fn.
switch n
    case 0
        f = 1;
    case 1
        f = [1,1];
    otherwise
        f = ones(n+1,1);
        for i=3:n+1
            f(i) = f(i-1) + f(i-2);
        end
end
end