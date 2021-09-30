function f = fibonacci(n)
%FIBONACCI Implementazione ricorsiva della successione di Fibonacci. Prende
%in input il numero n e restituisce l'n-mo numoer di Fibonacci Fn.
switch n
    case 0
        f = 1;
    case 1
        f = 1;
    otherwise
        f = fibonacci(n-1) + fibonacci(n-2);
end
end